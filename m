Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF919A2A3;
	Mon, 15 Sep 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945141; cv=none; b=X004aXuc+pAQ8CaolII/kWQ37vmKLnahYGG6xNLW0n3Jf2O/VxwWJDdzNEMMzPyLCtBwmpFT7t2dRTEH14FSXTFpk1ehxoUv6sS2H7p5OB1hXU+Me24cSddkgpvQsBT7UoR8qwc21N54/DfpKEbxJpmvMoCKJfUvEtBuB53alYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945141; c=relaxed/simple;
	bh=d29ukCE4QThVN5wqs6kQsMhVNWS9bKwxuOT+pfkPa/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4+Q+/0gpN6bHfdFPCLbF65nH0vSWCkDpuSaFMJwvOsr4iPGf5dPDs4oB36CJDxkX3cFJrcU9FdG3u1oFOrKjq4AvUuBA0LXX0jULars7zqDtF8mdvFRyMFVKLN4R7VXJbqeO43mJrHS896DFcDO5+WlprmmObhfFI5x+/edWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emR704H7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emR704H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D39CC4CEF1;
	Mon, 15 Sep 2025 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945141;
	bh=d29ukCE4QThVN5wqs6kQsMhVNWS9bKwxuOT+pfkPa/E=;
	h=From:To:Cc:Subject:Date:From;
	b=emR704H7wiOC0i4kJa0Gl4umVfevA+UpDjb8NJ0bWQS9DNwqfTXOyDtNWb9tmnDEM
	 uWXV2iUUE/cYYX6ozNavUkD76SYFrhxr5XNDR7hQMAdiuScUZuY69WwtkaE6pw27o8
	 ENfy4oZBR6HRxEXs4N/o5mZZbm1N6BqJtHJL+7eBt/eoNqtm2XHqK/IosH+yxZ3YMK
	 tTO8ddycoQyZehJ8luBirqR+vm/sp0CEZHKZ/EA0c4jhntuHpILMMSvF3BNvXtSy1t
	 i4XchAOiXJw4W8CtY1QkkZmkPXBgLDsDiJjyJGiitTU41g82sW4GOLh0ExCWwdT4q/
	 I+reakSJiouVQ==
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
Subject: [PATCH] dt-bindings: arm: Add Arm C1 cores and PMUs
Date: Mon, 15 Sep 2025 09:05:07 -0500
Message-ID: <20250915140508.2806590-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the newly introduced Arm C1-Nano/Pro/Premium/Ultra core and PMU
compatible strings. These cores are part of the Lumex CSS. The new names
are replacing the long lived Cortex-A/X branding going forward.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 4 ++++
 Documentation/devicetree/bindings/arm/pmu.yaml  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 41ad4ed0e74c..c1036dcfc912 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -123,6 +123,10 @@ properties:
       - arm,arm1176jzf-s
       - arm,arm11mpcore
       - arm,armv8 # Only for s/w models
+      - arm,c1-nano
+      - arm,c1-premium
+      - arm,c1-pro
+      - arm,c1-ultra
       - arm,cortex-a5
       - arm,cortex-a7
       - arm,cortex-a8
diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 9bb109e947dd..f47baaefcdac 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -28,6 +28,10 @@ properties:
           - arm,arm1136-pmu
           - arm,arm1176-pmu
           - arm,arm11mpcore-pmu
+          - arm,c1-nano-pmu
+          - arm,c1-premium-pmu
+          - arm,c1-pro-pmu
+          - arm,c1-ultra-pmu
           - arm,cortex-a5-pmu
           - arm,cortex-a7-pmu
           - arm,cortex-a8-pmu
-- 
2.51.0

