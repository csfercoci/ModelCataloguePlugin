import org.modelcatalogue.core.ElementStatus
import org.modelcatalogue.core.security.User

fixture {
    U_David(User, name: "David", username: "David", password: "password", status: ElementStatus.FINALIZED)
}

