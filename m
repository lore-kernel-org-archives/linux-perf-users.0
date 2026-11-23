Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433862;
	b=3sC9vRRYBPJAS8dx+xI5ahzLlWC36yqgowYR9NoYkr355b1TBptVUURr/eMjEhyLkenv
	 IXDUOPjm6H7u22NF2BuOmzv39bLR7LXCXMmkakPYmLD4vh4tCPk8ZQztf2T1RAKks6vwx
	 NYIm/IN1VYPR70bzxPwpvcBHfqncByzIL1asF8mAUGVrhUHO5pEVpSD8H8296UZ4RokoA
	 HBwOXopNWpW9xiQbAVZ/HlJVQXF60fD7NSxrYJZzGHPkZsivWK8vDJJRAcw+H7UBMJ3sl
	 W7rK+LOSUqCBgg74fimz+Y6wVT1SiVyYjr2+l0NDvSpKUQx7nOZE1q1xvFz8+u/IwYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433862;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lyATTZSpPwfe+0tTFDl9okuYREBYcyzOpR8HimDcF54=;
	b=h/EVgci3IsfWdvy94Mc7HdJ5m20Bmpqp6Bc/wjZLg4RsMLXgarL3eK+1V+4pLXR8FO+c
	 6+L2RiMJDUfKBVnRD09zfXHF9yfcQTg8iDfuym13uLlYmZFlkvRKcPArwWQ9KPHLl/fNp
	 t0CNIk5fEAVBoC2Y4Y7T6vJp2047ZTMEKrWQtWaBFaYFx8anhtf4/PM+9/zoow4ryEFQ+
	 +WYnjg4XltXd54m4p2EqsLZENWfqx9D9zLRUIedGpiIlFMSY6/jkiO0J8nHK7lBzMGQEo
	 pL8nuK24xGlxIfnrIBLKRkMldwzIF9ZI2zK4LZxnDxaDDETiS5LVYPdojDigHX2Y+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662D606A69E;
	Mon, 23 Nov 2026 11:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A662D606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433862; x=1826969862;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=huVfTbErH6adnt9mw42pnrtw5P+Ckl7UHBlLJGXkTlo=;
  b=dB9ffdfOSF1nvZPOXC9283ZGXs/S9u3uLy6OYTmC1JvjGpoZVk4GYX/1
   Z36pQsCD7JfBz6NLGPjk+kqN6uKmDP0KRTQhJJLPxhYsS8ECsdtoRPSy/
   TrI4VdUOZ0o4kdFZ29jUyycMAlvSXZIYhhgNN95dP37oUF0MlgjsjCzVo
   nPTfXrT0fxfBtIVUP1xZC6gicbc5VWjXcxUyqtJdzX+Ea/UIluXuRKyz8
   1KoUpxGidVhL009Zkf2AFjESAZhPKnm5Qow2EqPVRIiOFGXNfobBbSBR3
   Gff1T0gzjVP0pEBo4GSXHlihsw33egTRc1PZuHGtUxJZ9ncO/eD7gI/3D
   g==;
X-CSE-ConnectionGUID: zqschISKQgqNy5/VgtTxQw==
X-CSE-MsgGUID: 7SLCgFc1TzSddOtrfMDIrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:35 +0200
X-CSE-ConnectionGUID: T/+ivEZMSnequjDciurdfg==
X-CSE-MsgGUID: HzNCZGvDT7KSUg+TBTkCEQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 23 Nov 2026 13:46:01 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 23 Nov 2026 13:37:16 +0200
Subject: [PATCH v4 6/6] MAINTAINERS: Add entry for MIPS CM3 PMU
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
Message-Id: <20261123-i6500-cm3-pmu-v4-6-5a9f5351688f@mobileye.com>
References: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
In-Reply-To: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
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
 linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.16.0

Add a MAINTAINERS entry covering the driver for the MIPS CM3 PMU

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..e9a02076017b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18227,6 +18227,12 @@ F:	arch/mips/configs/generic/board-boston.config
 F:	drivers/clk/imgtec/clk-boston.c
 F:	include/dt-bindings/clock/boston-clock.h
 
+MIPS CM3 PMU
+M:	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+S:	Maintained
+F:	Documentation/admin-guide/perf/mips_cm3_pmu.rst
+F:	drivers/perf/mips_cm3_pmu.c
+
 MIPS CORE DRIVERS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org

-- 
2.43.0

