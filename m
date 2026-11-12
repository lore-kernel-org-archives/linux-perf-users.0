Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486564;
	b=EyBc626TbNGlV76GsH3Mi3cg2ZO64SWOW0eQHFY4QluaT99BjJ1lR+qIk/dNGCBP9JsS
	 Pjr2iLOc9DcQDC2nqJj0+Ge5hIoJ7c+qnhKi0sA0GJp9a7YhRwaqFzKmKyFZ/ehg/QDrn
	 sTjnocZ4Zwc15HIu7pH4vV6yv9usVC2OqdiPvwqmdbWhsdjhGqjtxWplPb53Cz1tpNR3o
	 ZrWvGwBP0/t9c3/WdIuUJGCJRVe56suxAAQ9eahrShQXtQgkSobPFUcC+PNMr6kQ/n87G
	 7hq7kDKxllgEtvcZhbSpq68O92hGIQ5ZDFZksqkxmaCpr42uhrvMhszQ7cgxrV8qfKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486564;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=sFHPBhyxEeqzI/mLr3+tgL1IHWLq7an7I5T8KPeBRhc=;
	b=pDhGT4fY0gW7bkRWDJpEyxpqK7ZjHDiL1XklQgVnFhzdSmDK4ZmZxyFnuXIN0hkEj5m9
	 fvwe4k6PtKEmNQCZ4my21QnDF/ha+e69Hz70kMi4srMViEwRTBBdn7WktVPli1dbtnmB0
	 PQzZN2KsDjjKZ5Fl4wlxYyQlm+Xb2aOn5ManiIown8ktkwWWqtV4hSCoyk0Ne02ZtiKQH
	 QqwQ17Cq8lnQDjT8zaMCO7LgJD2zjPBzWg6ByRXdduVTETAs6w9+7l8Eoiz4k2LAcNt51
	 R3Pv+u9VfX0LH9R+BNbUCAGrAQD60EGDNRa6mrydFLBdXHpCHbWl72MEraadPaN/LaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ABC606A89F;
	Thu, 12 Nov 2026 12:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80ABC606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794486564; x=1826022564;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=upY+Mz2RBSTRetbNF/wY4CRuGU76bONdjwh7Q0RZt1g=;
  b=SwGGvKShP6l4hFbhRiYsQzrtGzsHqiWSdHuXBOT7kpQ7FnTCT38C+0oK
   VdDS5kAAN957QU6+msOfuLpL95pMlti5Vl8YPkx0qrL4LYkqFF1XrtmqL
   gFUFNeHEYKGT6I2eItN3duJWXsOnoblpEGCcZiX5XVbm8Ojhc673Ou/9B
   yf3V/HhuoaKZQNpiRwthI5KlXOIkiqXs47pxHjzLYHJobGkfSeoZ24FEi
   U+kfTj5ihw7JS/CpxXUubWaAaVbZZemXlbQPmfWRKTxBDWrnJIGeZ+ymd
   fVvpXn9u7rYxhM6QK88e4Kx0inJE/8iEcJZO0P3l3xmgaJqIeHNa27Y9G
   g==;
X-CSE-ConnectionGUID: 17Jg97HdQH6H9ZG49LVN+g==
X-CSE-MsgGUID: X3qPJe/dQ6Gm5z0Bcxp6tA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:29:21 +0200
X-CSE-ConnectionGUID: lQy6LFkCQWWNJrPd7fLgaw==
X-CSE-MsgGUID: F3m/1ulwTZiUE3VjOeK+8A==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 12 Nov 2026 14:37:18 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 14:29:20 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 14:29:01 +0200
Subject: [PATCH v2 4/6] dt-bindings: mips: mti,mips-cm: add performance
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
Message-Id: <20261112-i6500-cm3-pmu-v2-4-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
In-Reply-To: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
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

