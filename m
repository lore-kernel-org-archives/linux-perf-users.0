Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988484;
	b=R5qFN9hsDYybwdDoogdBpXiJyOI3Byf3I0m8WlrsUy9gIvVQplkHzE2D/zU2xvxTYOd8
	 O9atiVY/K1y4SpwQv3IeZoPvsjbN8gx28SiEA+4SdC9pOiFTkvB4RHDFPzqEh23VvE/rr
	 adv3AfvoiWgp8s0NqJquOl6HjHk45tITENMaEtTPu//KqRDcblgbdpStM2S9EEktn6Bt7
	 tTwol6MFdP9nVSB3glwP1u9JBLoJNX9AtV2DJrSda1jl/OUGQKDo1wG7d8ADTTGVjN/6/
	 FUlrpbgbzuC0hcJ0Cj4z1E7M2tMAotR3aW1qw2OZ1v+lD2Vauloiik53Cp06AN0YQ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988484;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N8fkAzHTMmXQK5kkCqSvxK9vSLYdjWOlTgVwabwGWQs=;
	b=jQMuKccxsEmvgDbvbck6HlnRazvj7Fo3sFKvCnTYVgn8TIcb+YRrmUuhyDJmcL6pNH+/
	 e2JE66qfWGxKnh3lD6udz+x69rBBMYj5OyBBc+2zZi9RmzaIx8XeQbaoDxWIX+WOEVwV3
	 syoTj5QcGIVjl6+w/rcRHn2uvsf8R10WPC9w4SrUZjEvIGnmIw1GbH4ZVVTAuy7VG/sra
	 RshRYMgRB1940xgNo7qvs4Zh4AtUFWOmJYL3aB7ljSTkwskuD/BSl192YfZ6CiGJCBjzG
	 TNRZ8I4JuDosF76YM1hx0CBw6V1QPBq84kyt4EHNIU7pb04Q2lfnhHYuH+kswGy0DdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cLuxjmkw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C986082BFB
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C986082BFB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cLuxjmkw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4F891682;
	Fri,  6 Nov 2026 10:07:59 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 229B73F673;
	Fri,  6 Nov 2026 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793988482; bh=0sQyUBmWBpYRJ12TUOeZeZAxa6t3iC1IRmwLSvpeT3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLuxjmkwBMAhPVjdWAmknQbUVcaMKFx0ras2eQEN1e9H+GsR/Sz4cUK+bMEwsDE99
	 WMv5TQLyaonGL8NKOUaZdXcmVV/wqiZlqVYe+lRejV9Xh0X1ww4U2WemLSRQYdCczY
	 T+W8AvsVe5lNR3RJPRp/YYE0dfvvDNnzcHWr/jVY=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 3/4] dt-bindings: perf: Add Arm Bus Monitor Unit
Date: Fri,  6 Nov 2026 18:07:45 +0000
Message-ID: <2df5b5c0185b94602429674826e058b9687e476e.1793986672.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm's Bus Monitor Unit is a low-level performance analysis tool for
matching and counting transactions at interconnect interfaces. Typical
platforms will have multiple BMUs each measuring multiple interfaces in
various parts of the system, hence for the sake of usability we make it
mandatory for the platform to label each instance such that the end user
can correlate with platform documentation to know what's what.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../bindings/perf/arm,bus-monitor-unit.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml

diff --git a/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml b/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
new file mode 100644
index 000000000000..3da59e5447e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
@@ -0,0 +1,41 @@
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
+
+examples:
+  - |
+    pmu@12340000 {
+        compatible = "arm,bus-monitor-unit";
+        reg = <0x12340000 0x40000>;
+        label = "ddr_ch_1_2";
+    };
-- 
2.54.0.dirty

