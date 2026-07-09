Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950613AFD0B;
	Thu,  9 Jul 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624946; cv=none; b=KE9ZgPbS4aw4Iu73gxyJ2K3i32YIr+yDiewWPeQuMWcWZv1LML1qFUn41oPN+9d+dOCG8yYVtNysQkSSrS6ulx8KU+aOehht2oJXTZjCqS4WW7WHqk2vzd7eR6LBd86+qt8aOWG/GjenIGZo65gsKgun8p2gJweJhZrle/8ui80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624946; c=relaxed/simple;
	bh=fA7WntxYo8pt73AeZhQw+cecHr8b/7c0M9AaviTUIYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRvmBkMCrVjQoRccuD0cJjjB4bCaAWkbE/3rdItM9n+cUahLDnoHFkTo8shBCU83PaKEiPeapphqrXSchws7qxM6TI4WFqb1xWpy16gjJMGvDERpuxsFRoa2Y69RYAt7RqyVIBffskJ2n6xTpGjn+Cb+KznhqKqOCtpTBosBIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kman3rO8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kman3rO8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B563125DE;
	Thu,  9 Jul 2026 12:22:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E0D93FC81;
	Thu,  9 Jul 2026 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783624944; bh=fA7WntxYo8pt73AeZhQw+cecHr8b/7c0M9AaviTUIYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kman3rO8JtbmNVM1EpGN0n19Kb/tZFz42FOWy+qWn0f4IfKLxD7reoDVz1YQw7oxz
	 Ronm+csMtfiKYjD+eGgpkcjQgfZKm+RYaDaIAD+oEtJtoz0EONAhvZJhYgZ4cuoaGP
	 ab3kmgorxj++oMrbtmCanfNguhahXWAvgHn8aJbQ=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: perf: Add Arm Bus Monitor Unit
Date: Thu,  9 Jul 2026 20:22:07 +0100
Message-ID: <1cd17d9c07e9695e1dffdeaa5409f0a1db8ccb81.1783439341.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1783439341.git.robin.murphy@arm.com>
References: <cover.1783439341.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm's Bus Monitor Unit is a low-level performance analysis tool for
matching and counting transactions at interconnect interfaces. Typical
platforms will have multiple BMUs each measuring multiple interfaces in
various parts of the system, hence for the sake of usability we make it
mandatory for the platform to label each instance such that the end user
can correlate with platform documentation to know what's what.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../bindings/perf/arm,bus-monitor-unit.yaml   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml

diff --git a/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml b/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
new file mode 100644
index 000000000000..3cdc3a05b9a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/arm,bus-monitor-unit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Bus Monitor Unit
+
+maintainers:
+  - Robin Murphy <robin.murphy@arm.com>
+
+properties:
+  compatible:
+    const: arm,bus-monitor-unit
+
+  reg:
+    items:
+      - description: Full BMU register space
+
+  interrupts:
+    items:
+      - description: PMU overflow interrupt
+
+  label:
+    description: BMU instance identifier (same as ACPI _UID), per the
+      platform optimisation guide
+
+required:
+  - compatible
+  - reg
+  - label
+
+additionalProperties: false
-- 
2.54.0.dirty

