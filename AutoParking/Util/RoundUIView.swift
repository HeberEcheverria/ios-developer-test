//
//  RoundUIView.swift
//  BuyBack
//
//  Created by Mauricio Portal on 11/17/17.
//  Copyright © 2017 Grupo GD. All rights reserved.
//

import UIKit

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    /**
     * Method name: rasterize
     * Description: Indica si se debe rasterizar la vista
     * Parameters: No aplica
     * Return: No aplica
     */
    @IBInspectable public var rasterize: Bool = false{
        didSet{
            self.layer.shouldRasterize = rasterize
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    /**
     * Method name: shadowOpacity
     * Description: Indica el grado de transparencia de la sombra
     * Parameters: No aplica
     * Return: No aplica
     */
    @IBInspectable public var shadowOpacity: Float = 1.0{
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    /**
     * Method name: shadowColor
     * Description: Indica el color de la sombra sobre la vista
     * Parameters: No aplica
     * Return: No aplica
     */
    @IBInspectable public var shadowColor: UIColor = UIColor.clear{
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    /**
     * Method name: shadowOffset
     * Description: Indica cuanto debe desplazarse la sombra
     * Parameters: No aplica
     * Return: No aplica
     */
    @IBInspectable public var shadowOffset: CGSize = CGSize.zero{
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    
    /**
     * Method name: shadowRadius
     * Description: Indica cuanto es el radio de la sombra
     * Parameters: No aplica
     * Return: No aplica
     */
    @IBInspectable public var shadowRadius: CGFloat = 0.0{
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    
}

