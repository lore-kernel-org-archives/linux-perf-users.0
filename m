Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144042;
	b=Y0rc/Pa6xDEBnlQSWnaJFS18+hhPa7HNh6fe9rJZ5e/Ji0YL884j8eiLP4JSb4x2gQvP
	 8rB6d/82xgp2ci+gVL9vgHqKUHebckjLfRP/fwbb077WNFdgGwttlkcqEUtvm3QqRjmu/
	 37NNLSE+wG6gtcI1PiG8X6xke1Tan2yzNgUjawueyel3xBcJw5nebOkpRJv1Pf9QzNts2
	 CjyM/qT0JTVXMY7Lqv2yjHzgicqt8HE8vobqvTBWxGeXiFOjzKQ4OOjpzaRf81+MnHf6p
	 d/juNd7llyvyzTnrnjmJkgLSibmPunry/h15YeBUmHPdhiEMMwFBNfX3XOLqVRCJCKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144042;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=sFHPBhyxEeqzI/mLr3+tgL1IHWLq7an7I5T8KPeBRhc=;
	b=RDZfpJouqYjz+bO9F6Er4JYpmUAxAyZmchwfQ/LS/d18MG+W5I0voZ12IU4N+1LVd0dS
	 ZgIAmIHsCB/GTq8l9L3meWCfRElMrIS+DmYDgEa8zNCBXdSyP4DithkiUnZSWzfX+6N4g
	 5sOj3oezy2v1/AnXk06g/K2Ar9ch1b/4LS0ORCo6EYp00oVPp9kDfmY6vQXklusymU/WX
	 ThwoMMIyMJQ4TZ85WuY9jvnezt17pGX3Q7xipWKYrcRf082aRLaexrSNfo7R1MzcULoxV
	 x1Luj7UpPs91wrCLoLkdoeKfcPU9QSe3sYT6YYQCxRwJZNDRDqwF9oiwZ4gJZvNYDBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBD606A33A;
	Sun,  8 Nov 2026 13:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BEBD606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794144040; x=1825680040;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=upY+Mz2RBSTRetbNF/wY4CRuGU76bONdjwh7Q0RZt1g=;
  b=sFXdUjVzLH7VuKFJZBSYvhQZBbU31rBh+a2INQ0VuJzZFFPCzI0C4Tbq
   47siAPflrc95NgX6DQSpwIyniNoGLnT4XvfhiTxcIj33NQJZVR40hNbue
   l6CVf8BrXH1YOZV4acs+cXuueECy3rK17iC4dnwp5OSj4UZr1DqsMXvdG
   bPrUuiFWYDamLRrdDAGfKyFHg8FJJT9pf81vuZpV4C7MFQFV4VuigtmQ6
   Xxj4hdiBIPNsjjHxHBMu6EhL1mmg74hkSakV6cw5R6ZUSEP+5AY53IjUm
   cH1uppVd3C3mQzC3fHblNaq4ucG3q1q4ycDv0MpnECK2CMz13TvBd02E1
   A==;
X-CSE-ConnectionGUID: dlHp/XFyReq/v4grtaLunQ==
X-CSE-MsgGUID: NIEHP6gIR2Wcx6hPifXqTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 15:20:29 +0200
X-CSE-ConnectionGUID: WSxVgLy6RN2kmPh+/ozyhA==
X-CSE-MsgGUID: sNbE+X9kS8+AS8m5znFH4A==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 08 Nov 2026 15:28:36 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 08 Nov 2026 15:20:27 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Sun, 08 Nov 2026 15:20:12 +0200
Subject: [PATCH 3/5] dt-bindings: mips: mti,mips-cm: add performance
 counter interrupt
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-i6500-cm3-pmu-v1-3-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
In-Reply-To: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
overflows. Whether that output is connected to an interrupt controller
input is up to the SoC integrator, so describe it as an optional
'interrupts' property of the coherency-manager node. When absent, the
counters have to be polled by software.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 Documentation/devicetree/bindings/mips/mti,mips-cm.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml b/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml
index d129d6382847..ca7a6717ecdf 100644
--- a/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml
+++ b/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml
@@ -38,6 +38,12 @@ properties:
 
     maxItems: 1
 
+  interrupts:
+    description:
+      Performance counter overflow interrupt of the CM (so_cm_perf_cnt_int).
+      When absent, the performance counters are polled by software.
+    maxItems: 1
+
 required:
   - compatible
 

-- 
2.43.0

