Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE342BEBE;
	Thu, 16 Jul 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214774; cv=none; b=TwGkm/dYos56IjWF3NhnyMlmw73Smf1+DgGdGC1U8Y1Cwhmw8EZcpIFuI9h4ianNCRQyFN6858dMkcSGowQ6iW5QiQ4K/X3XUzmHE9pHApsPFO+vWNRYG5lSaFEFsURZxTyY1ZAL6CdFmnCniDR6YQUW4hJBcWOvsFcLvOQziZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214774; c=relaxed/simple;
	bh=C+2y21SzSSI5bBBMqUfgCI72tsdvLF0AoiYIAGFmQUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Npo71p0b9SbEbjfPpcPRjrXbBu0VDolxfuAIt2XuFpnQUPWI6MRMpM6HVa7zUicOR8ux3Bbq6v4XM2c4xh4KeuZIPgdpbtzJe05puq+SdkTomDHvxnBVjS4cX4YzlGBgg9qwdtadvFwD13wmgbhKX7X+HPZ8TM9JsMp7PTK3w1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lh3ErWbL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lh3ErWbL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C14168F;
	Thu, 16 Jul 2026 08:12:45 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6D3E3F66F;
	Thu, 16 Jul 2026 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784214769; bh=C+2y21SzSSI5bBBMqUfgCI72tsdvLF0AoiYIAGFmQUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lh3ErWbLEzySaVWygtLPcmV0OBEGWZ0bhFlNFIfPV8qqZVYvlurv1sNu0sCjhNl6E
	 iEgSkfdBzch5XNzreg5MVcMn16WOzoAkd9veVTcNBZfoM2hqqRdi6RGgSjMpSggyvq
	 DsiUkofZLzE8tOExzVIwW1XRg+MUIcAMTlX6AnC4=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: perf: Add Arm Bus Monitor Unit
Date: Thu, 16 Jul 2026 16:12:40 +0100
Message-ID: <1cc6acae06fb4910e27cc89e2270a52e80e310ef.1784214112.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1784214112.git.robin.murphy@arm.com>
References: <cover.1784214112.git.robin.murphy@arm.com>
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
v2: Invent example
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

