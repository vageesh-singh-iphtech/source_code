//
//  MarvelVC.swift
//  ListingDemo
//
//  Created by iPHTech 35 on 26/02/25.
//

import UIKit

class MarvelVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var avengersList :[[String:String]] = [[String:String]]()
    
    @IBOutlet weak var tblAvengers: UITableView!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        marvel_list()
        setUpTableView()
    }
    
     func marvel_list(){
         
         avengersList = [
             ["name": "Tony Stark",
              "power": "Genius intellect, advanced technology armor, energy projection.",
              "weakness": "Overconfidence",
              "agility": "High",
              "xFactor": "Resourcefulness"],
             
             ["name": "Steve Rogers",
              "power": "Superhuman strength, speed, agility, and endurance; Vibranium shield mastery.",
              "weakness": "Morality",
              "agility": "Very High",
              "xFactor": "Leadership"],
             
             ["name": "Thor Odinson",
              "power": "Superhuman strength, speed, durability, and longevity; control over lightning; Mjolnir.",
              "weakness": "Arrogance",
              "agility": "High",
              "xFactor": "Nobility"],
             
             ["name": "Bruce Banner",
              "power": "Superhuman strength, durability, and regeneration; gamma-radiated transformation.",
              "weakness": "Control",
              "agility": "Varies",
              "xFactor": "Unpredictability"],
             
             ["name": "Natasha Romanoff",
              "power": "Expert martial artist, skilled spy, peak human conditioning, utilizes advanced technology.",
              "weakness": "Vulnerability",
              "agility": "Extremely High",
              "xFactor": "Espionage"],
             
             ["name": "Clint Barton",
              "power": "Master archer, expert marksman, skilled martial artist, peak human conditioning.",
              "weakness": "Vulnerability",
              "agility": "High",
              "xFactor": "Precision"],
             
             ["name": "Wanda Maximoff",
              "power": "Chaos magic, reality manipulation, telekinesis, telepathy.",
              "weakness": "Instability",
              "agility": "Moderate",
              "xFactor": "Potential"],
             
             ["name": "Vision",
              "power": "Density control, flight, energy projection, superhuman strength and intelligence.",
              "weakness": "Disruption",
              "agility": "High",
              "xFactor": "Introspection"],
             
             ["name": "Peter Parker",
              "power": "Superhuman strength, speed, agility, and reflexes; web-shooters; spider-sense.",
              "weakness": "Inexperience",
              "agility": "Extremely High",
              "xFactor": "Inspiration"],
             
             ["name": "Stephen Strange",
              "power": "Master of the Mystic Arts, sorcery, spellcasting, dimensional travel, mystical artifacts.",
              "weakness": "Vulnerability",
              "agility": "Moderate",
              "xFactor": "Preparation"]
         ]
         
     }
    
    func setUpTableView(){
        
        self.tblAvengers.delegate = self
        self.tblAvengers.dataSource = self
        self.tblAvengers.backgroundColor = UIColor.clear
        self.tblAvengers.separatorStyle = .none
        
        self.tblAvengers.register(UINib(nibName:"MarvelCellInfo", bundle: nil), forCellReuseIdentifier: "MarvelCellInfo")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        avengersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "MarvelCellInfo", for: indexPath) as? MarvelCellInfo else{return
            UITableViewCell()
        }
        
        cell.name.text = self.avengersList[indexPath.row]["name"]
        cell.power.text = self.avengersList[indexPath.row]["power"]
        cell.weakness.text = self.avengersList[indexPath.row]["weakness"]
        cell.agility.text = self.avengersList[indexPath.row]["agility"]
        cell.xFactor.text = self.avengersList[indexPath.row]["xFactor"]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 160
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
