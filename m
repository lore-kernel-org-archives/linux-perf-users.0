Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C291330675;
	Wed,  4 Feb 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196191; cv=none; b=PzvWXldMQjTqf9BCMo+8ZLmYCUwOnTjpfHS6cG0ktk5z3CEeMgTQedkQp9xFho5kdzi7nDV6todozTwawx791rdCrbfYdCZgef3hIFfD4keUBjOMcgVn6iNNyLYTqTEDUOpEc2j3cp/9Cc3n3yXU8XrksmibUmh8puNCcwm/n+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196191; c=relaxed/simple;
	bh=ZVLONaiMU024OvA5a6+na3eNc8tNcg264FT/5Lc/fv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX1o6etY708I5/Mp86ahZDnIq7IE/wndLj9fOxujFWXAEiWj4Q4+PqM35ElzDK/Kxaq7WDoD3fjH2GCFIayMGFtws5kGJy5Dv/01qJJu75bIbAdzaK+/Xu/oTO60hLZnU74BAK2xuPueCO30nbK1ldT30XrVmTyDabUbDIhGNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=N6fTIRfc; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="N6fTIRfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196159;
	bh=erpHfG1a0U1wKXe31VsJ1fGHCHur44BOyeFbxKPgRbM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=N6fTIRfcpscByIKh8KmH2eFgrppZ0cwQtT/iIHy/aIcSPvdva2ORoCjdXaZbiQ11E
	 f5UwyNDiqdqYePYs9o88f3w9uwy2kqUMEsUiBvLxzSu9sysowGUjRkzqfvSYP3VIIk
	 mm7FOfmDAsvOpZblunACYoGoQ/Kez3NAt5Wkbz4U=
X-QQ-mid: zesmtpsz6t1770196157tc4c53f38
X-QQ-Originating-IP: mHZUIACGk9YMLEZgm8p0NppNTHzVJmeF8HKgM+3ft8o=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:09:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12607342643688675040
EX-QQ-RecipientCnt: 19
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v3 4/8] dt-bindings: iommu: Add spacemit/t100 features
Date: Wed,  4 Feb 2026 17:09:12 +0800
Message-ID: <A0E91F323138E92F+a27d73b00f3324f0d3885128f5596230b3f1370b.1770195980.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770195980.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MyirvGjpKb1jkV4OeiUOuImdzoTdgM0AKY79FgAlHHVObFEWdEY+vd/F
	waVqBGQeCqMbLkRwOOlD8MOe6Uz4pO+xzDbPa/VLZoLmhpkqY2W1V0hsxBGtlJHGu8CIFLV
	fvXRFrSFSIX7AZVxoFeNSvOopjWGooIK/+wWNIDMR9utebG62Mp6kCHFk9vw+i89SZO/ghX
	d5hycLoPmwBT8LQRTdkyQDKJ/E4q/2tZjC78am/By2fD3CNwm5dkZWvntLuhfmXoSccG1m/
	Juz4AfVhyYTcjpUPUNw4YGZK+FXJu4j5V8eaLpOqnOMVQwj9mZTPk3IYUpBWy8bTB9+kIQ2
	+HF7h9xJ8LXe2Cgw2hXy6gnQ/BB4ZEmrt5QfqE0N+TU21hlPRgToYgYh27YKu3m2ldV09O+
	eYxd7pHjCRaEJdPlxvGVIHak+tfgNh6SACtILvABkqjVMnny05jH7IZj7MQ9wNhNy/aIQGJ
	H03d8lxnS6BWdFkPa9BmceFBWH4jV+pz/yr7h3FBoYwVCw7FsxSeQyxD8KI2eIOj6C3W6ET
	Ny5qNw1JTFK5mq6qmRqKtj/2+RcHXcbzTb7onCiGB3dcSWAhLDTRgsH9K7kySlozixRwGL4
	3LUiB8pCEEOZrc1vAh1M5kI1n2Rgx2QJ+YakbMgfi6gph/sALqBzxlV8ULBB0VxPu7TCDmS
	ajWDHme63Ro6CY+w2DsKELxIYSzpb7btq2sFSOq8oRz3ZPZ6ZNKOqmGtpNSQ2nfplg4QO59
	BEL31BLnI3/NbWyO1keTQl1vXDyXCUYLq3A6feltphY4TbYl28JnhTY2S2Rd50HX3yTeJfU
	VZq+wOk1DCywnt578+oWLiZqBqoNMEsrE1MtcizQj3GRIGDkw4k1H0mHrkgsUe2lnRd602Q
	kO7QDz9hl4CE3TMr58HNLKrY4X+EqgPaDMOES5eMg70iFtivmer6yI8+P+M6Qkxqacr2BfK
	/zrEWdP764UuKUZpPfRWUxj7BE2RnweyG01U96S+K+nmseQKuoMJ4EG/J0YCCl/3Ds/APiy
	fR4J7iCTebvVkVdRJ9XZU/jhXA+Mz1yrUKANuhJQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Adds device tree bindings for SpacemiT T100 specific features by
introducing spacemit,100 compatible. T100 contains distributed IOATCs,
each of which exposes pmiv interrupt.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 .../bindings/iommu/riscv,iommu.yaml           | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
index d4838c3b3741..2da3456e7402 100644
--- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -32,6 +32,12 @@ properties:
   # should be specified along with 'reg' property providing MMIO location.
   compatible:
     oneOf:
+      - description: SpacemiT distributed IOMMUs
+        items:
+          - enum:
+              - spacemit,t100
+          - const: spacemit,riscv-iommu
+          - const: riscv,iommu
       - items:
           - enum:
               - qemu,riscv-iommu
@@ -75,6 +81,23 @@ required:
 
 additionalProperties: false
 
+select: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,riscv-iommu
+    then:
+      properties:
+        interrupts:
+          maxItems: 68
+          description:
+            SpacemiT distributed IOMMU includes additional interrupts for
+            IOATCs. Each IOATC exposes pmiv wired vector as standalone
+            interrupt and the maximum number of IOATCs can be up to 64.
+
 examples:
   - |+
     /* Example 1 (IOMMU device with wired interrupts) */
@@ -145,3 +168,17 @@ examples:
             };
         };
     };
+
+  - |+
+    /* Example 5 (SpacemiT distributed IOMMU) */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu4: iommu@1bccd000 {
+        compatible = "spacemit,t100", "spacemit,riscv-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupts = <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH>,
+                     <58 IRQ_TYPE_LEVEL_HIGH>, <58 IRQ_TYPE_LEVEL_HIGH>,
+                     <62 IRQ_TYPE_LEVEL_HIGH>, <63 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&saplic>;
+        #iommu-cells = <0x01>;
+    };
-- 
2.43.0

