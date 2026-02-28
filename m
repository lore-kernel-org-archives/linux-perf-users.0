Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC75429825;
	Sat, 28 Feb 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290032; cv=none; b=nMvdvIbEfqzLLf3+NzIbt0CfFSGVE3SOYiI9VcWSlVD4AmfeC413+NZkoi3aMnB9h0VayuQS4IIb7kjzZvgU/1Ef1u8yjrIA2iodfjzwTaWOZONQTQxZ8AJeZId1Z2frbZm2Iftg7tcMx6pS5YFRVV74vRajZVrDSZAajpmnJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290032; c=relaxed/simple;
	bh=GGZI38/TL2DKZssx9oEiE7bFkv/gUwD+7OAwHv/qHr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbkU0PVhNxXryo5vPBb6YoBykT3RRuVItCUXCvGFif3d58+YsT3wYs0G1H44nlEDXjKoOFdy4FB979CjM1Ket8ywWYl48FRRnT7pfsZAH6tTUSPh1eSyT0aMm3xD/RhKvda7g1wguE7p21SvmGXp+7qFIXyjH2kCRonBqoED7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Z0LAxNWw; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Z0LAxNWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289897;
	bh=x+69HgmJtGInfh6Jk10mSryW8pzN/q5dwWeyhKTKJ1o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Z0LAxNWwlRC48jAXZN+BmElY9q+MuNEpg3INtEYsk5A0UJFviwHypE/9B6b9i80PC
	 3XOFikBnIYaQZySd4pizn02KE0IRZqvyyqFg/S+lKhg1w/QA4p8S5LromFCnVw3qEq
	 LF6bgj2FkY/f0h88DoyFkVYgDmEb6XHsBcVXp4gM=
X-QQ-mid: zesmtpgz5t1772289896t989197b7
X-QQ-Originating-IP: 8IVMek64InocOnU+Iu9yuEWvOFpdbTi9/W00pIgtkKk=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:44:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4239884396105137772
EX-QQ-RecipientCnt: 33
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
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] dt-bindings: iommu: Add spacemit/t100 features
Date: Sat, 28 Feb 2026 22:44:49 +0800
Message-ID: <D8CE6E5B1001D797+a6f36da0272ac18fff2a992976b1defc3bb01af6.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MSZecc01IPj5+ai+1g2rOwY/XJcOEIWsPPLkF5gCk6BUfgvbVJQnN56s
	q8j0vjfCxqxiyT0aWkJjgiajEd/nmxiDjNM/hT3h8dTENOUU3qu0bMx/QSLGWrzK2oaNp6+
	8vmYG5keQYdtfHuLWanXkjgw35oFZnXVVNE7wCMXkGQ+VfatBe9AYqNkOuRA8B0WDPMXiE4
	v96TDuutuTm+0MyNw41IqdASWlv6pV3TS9vt4uXsA04pTxIwH/V8er/QVKWN3eoOu88E5Ia
	3bqsmBsijtVzN7c4ujhat/U+ceTarKPiZSR0aLlbSixPFr8KGzYtIMnLb/JnljUArb7mnTh
	9lCDQkNNhTOR6PCZchP+7g/mP1PsiYgMsDFmmz15Re9laNf3lm6vws1jXA9AL6y/PdAKuvY
	At59MakAKaX769XCvez5BQZfa1pkXLT1NxiPlBtlzkw7EkRBD312x+dZwqC3+jS/iN3dXBh
	VkhE43/3dstpizFdeBqP/zQyzcEdFgDexA7ps9uaHZ0/n1c+lhKt0M0YV0c18VSuMLEpUci
	s2OkTfJ0FEVA2Wjie7roY+8fNt0Rj7IIC6fTO+Jp4c4+iEzchbZM5/lKDMJzxx70uxmzKWv
	2Mq9E+JnL4kKxpJXiFg5J+3UQ4V2nZ7dbQ17YeHfMjTlmilpJ5bMsfnf8tL4ciToU5c8HLP
	V6ls3xCnWp8qTRgoBsltAysNXTRvN296IFNN8pz3r9gInIaFh32lQOVPpvhJCQ6N6gFN4vv
	E3vnmtvm82PjAbI6exnDJowHqMnYBijL+3sg8QV3LPu98cevlZ3JmmH7tpnXvipdzeW1+RP
	dxrblTyhOZoCCKCzEHAXyVGLn6cdf3zvIHzj/rv1XcRwJkoIZlVOD00qhKIcJWNNMhM5a2q
	x11doY7wtPVxHSF2A/Whb7Z4zR4AS1GRrP41ZVxsGh7jZ2WG48DHFe/eqYp1fYUcalg1Pu3
	44ihEd3TpuxguycaV6F3eGqYym/zk5EtXfWCtWUHE+MJVvknmfZboXvR2am2SFDIqPLTTOQ
	ZGeLdRD5hpN14VyXcDw2GMAKMZN24H9cLa/dueDT/jWqXOO3aIbRQ1lko9h/foKNnGHr1e/
	TxELYrzTNQ9
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Adds device tree bindings for SpacemiT T100 specific features by
introducing spacemit,t100 compatible. T100 contains distributed IOATCs,
each of which exposes pmiv interrupt.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 .../bindings/iommu/riscv,iommu.yaml           | 58 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
index d4838c3b3741..6b775ebf7f42 100644
--- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -30,8 +30,19 @@ properties:
   # Since PCI provides built-in identification methods, compatible is not
   # actually required. For non-PCIe hardware implementations 'riscv,iommu'
   # should be specified along with 'reg' property providing MMIO location.
+  # SpacemiT T100 (distributed IOMMU with split IOATCs placed in adjacent
+  # to the DMA masters) can be seen in SpacemiT SoCs. It is integerated in
+  # V100 (server SoC) with coherent page table walk supported and in K3
+  # (client SoC) without coherent page table walk supported.
   compatible:
     oneOf:
+      - description: SpacemiT distributed IOMMUs
+        items:
+          - enum:
+              - spacemit,k3-t100
+              - spacemit,v100-t100
+          - const: spacemit,t100
+          - const: riscv,iommu
       - items:
           - enum:
               - qemu,riscv-iommu
@@ -57,11 +68,21 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 4
+    maxItems: 68
     description:
       Wired interrupt vectors available for RISC-V IOMMU to notify the
       RISC-V HARTS. The cause to interrupt vector is software defined
-      using IVEC IOMMU register.
+      using ICVEC IOMMU register. For WSI only mode, the number of the
+      interrupt vectors should be 1 while for MSI possible mode, the
+      maximum of the interrupt vectors should be 4 with the cause indexed
+      as "CIV=0, FIV=1, PIV=2, PMIV=3".
+      SpacemiT distributed IOMMU includes additional interrupts for
+      IOATCs. Each IOATC exposes PMIV wired vector as standalone
+      interrupt and the maximum number of IOATCs can be up to 64. Thus for
+      WSI only mode, the maximum number of the interrupt vectors should be
+      65 while for MSI possible mode, the maximum number of the interrupt
+      vectors should be 68 with the cause indexed as "IOATS CIV=0,
+      IOATS FIV=1, IOATS PIV=2, IOATS PMIV=3, IOATC0..n PMIV=4..4+n".
 
   msi-parent: true
 
@@ -75,6 +96,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: spacemit,t100
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+
 examples:
   - |+
     /* Example 1 (IOMMU device with wired interrupts) */
@@ -145,3 +178,24 @@ examples:
             };
         };
     };
+
+  - |+
+    /* Example 5 (SpacemiT distributed IOMMU) */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu4: iommu@1bccd000 {
+        compatible = "spacemit,k3-t100", "spacemit,t100", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupts = <58 IRQ_TYPE_LEVEL_HIGH>,
+                     <62 IRQ_TYPE_LEVEL_HIGH>, <63 IRQ_TYPE_LEVEL_HIGH>,
+                     <62 IRQ_TYPE_LEVEL_HIGH>, <63 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&saplic>;
+        #iommu-cells = <0x01>;
+    };
+
+    /* Device with four IOMMU device IDs */
+    master2 {
+        #iommu-cells = <1>;
+        iommus = <&iommu4 0xc0010>, <&iommu4 0xc0011>,
+                 <&iommu4 0xc0012>, <&iommu4 0xc0013>;
+    };
-- 
2.43.0

