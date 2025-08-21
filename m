Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758C343D87;
	Thu, 21 Aug 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803270; cv=none; b=d5Wpth6WrqxIPqV5fC6yVLEoHaz9Os6SHrFGAwLKA9YKyNrafqguSaJ8334Jkj/PVBgkmt0t1olgW8RB1QR6RHuMrqnyozx8iLpbOC1fr53HjCtfXPv26RjTTCu2NwKUTBRthjUBvYpnjtfdik+UqZs31CfypGaC8i5O0bzZgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803270; c=relaxed/simple;
	bh=RPmQF6mnQdnGp9QUWME/YW9qBlWrRt+tgOREDQtfpc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVf63pqtFZeA9TRdxqH1QAJJ7GkDzGS+2/3cuHcv2lJ2zbiK1kngeEvhZtYEkml9iLVKv4qC/KOKoZd97yRw7R41CO5I91AEa8dijMQdunrxVgk69fvNMPHFj6/K5utg05S662RV+vqUlUsjw79DqISPPe2Xf+XhStrkw6J6rwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EejnxMjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EejnxMjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9785C4CEEB;
	Thu, 21 Aug 2025 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755803269;
	bh=RPmQF6mnQdnGp9QUWME/YW9qBlWrRt+tgOREDQtfpc8=;
	h=From:To:Cc:Subject:Date:From;
	b=EejnxMjrf6zHCJbY0GiID8QPnHIO8b4KgoqIsLTY9/73yarfuaGo3QgLlgaLj6T77
	 nnAuJAJsMloUcjJyMn9g8TgcxoIWCiyOiVgAz+EDoJifDlfpl8DBbJpInlKtz69q7X
	 9XL/Q5hRjhpgcvh3r3wbXHRfr2JLkHWC3UeDEs5kWlMQOs8GN6W11OJKRkDVwacbIY
	 uJM9P7eOwe/PpmJC7ZmKRJ2vE8rAYmixHZznsIIRO8sx546cFXZORWlPNMPMZhbM0S
	 6Y+TmOfTjL5bRLb2eZ/LQCAzx4ZqONMbxYtt7fLmtjEbRFKriHAos3ZK4o8JJS8IqM
	 AT2O6HopIvc6A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Add Cortex-A320/A520AE/A720AE cores and PMU
Date: Thu, 21 Aug 2025 14:07:21 -0500
Message-ID: <20250821190722.417639-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the recently introduced Cortex-A320/A520AE/A720AE core and PMU
compatible strings.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 3 +++
 Documentation/devicetree/bindings/arm/pmu.yaml  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index bb1ab514924d..17dda753bd3b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -145,11 +145,14 @@ properties:
       - arm,cortex-a78
       - arm,cortex-a78ae
       - arm,cortex-a78c
+      - arm,cortex-a320
       - arm,cortex-a510
       - arm,cortex-a520
+      - arm,cortex-a520ae
       - arm,cortex-a710
       - arm,cortex-a715
       - arm,cortex-a720
+      - arm,cortex-a720ae
       - arm,cortex-a725
       - arm,cortex-m0
       - arm,cortex-m0+
diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 295963a3cae7..9bb109e947dd 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -48,11 +48,14 @@ properties:
           - arm,cortex-a76-pmu
           - arm,cortex-a77-pmu
           - arm,cortex-a78-pmu
+          - arm,cortex-a320-pmu
           - arm,cortex-a510-pmu
           - arm,cortex-a520-pmu
+          - arm,cortex-a520ae-pmu
           - arm,cortex-a710-pmu
           - arm,cortex-a715-pmu
           - arm,cortex-a720-pmu
+          - arm,cortex-a720ae-pmu
           - arm,cortex-a725-pmu
           - arm,cortex-x1-pmu
           - arm,cortex-x2-pmu
-- 
2.50.1

