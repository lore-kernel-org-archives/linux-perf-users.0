Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110705;
	b=j9QzhWrYpUBVG8XUGMFLv3Br/m06jKOHQJtnLwkYbRxrlykRrSLLs9ispbPwkwPEIZJS
	 x+/a9J5VHgTQfLXoLsWTsnfVDGKn9crLxdrEMeY+n6AuF8w86TGG1pPVHF0X5aQ2Hyl2W
	 2iZcu3E6XvnlzbBY4cgugq/HTui+wJZqAE34STiQ92ZgVMhFpCy2vx/RpZbLb0aKpZcqz
	 aVyYLFAq7Hnz2DpGB7LdbPIStJAjq70MD0gSulqziR3P77pJUWr6sevqHVAyXHHoQy6Ih
	 K4uklNoEBuTDH/22LD8gjHaza3PMaq9jwe6/Jy1p+8XY92YfjoA5gRle0Lel3pD7cdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110705;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=PRm3Wwq9NQlmuKonGVqXdDDW70eXnhOzZHSNpZOZBag=;
	b=jVxlYJZAxGWQ3yI/BvuSNz98f8A43tG7QNY1Mjs0j3wWBWCZaC97ga4ee2u0oFJdGy8/
	 E2AN9SqjfOZJvC91+j/n9C79JbLR5mh4zFLQY61fmz8OZH+tgP3iZ/tMMlOZp1kYRyvvY
	 Gp//LSi+YbRJpduWDfPER11jmoc6G98GWIxaaZFB/ihLKmi3Ggak/wvpxFP8aJ9Z7Oi0f
	 CcIjMTw9qQt59h2p5X7A/3+PPDqs+jWb41lFf49nchh5TwXivDwlGfioNTvJOaQxLrkqW
	 iQqrYGsNVEiJy8+ml7haA0x3h71F39Prl+eCjYpzRzNXzEs6FjWP35PHFp5ExPkpRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66260A261A;
	Thu, 19 Nov 2026 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A66260A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110704; x=1826646704;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tbxgL7ZsrTWsrmUOa0vRK78LFkh+IqmpmHZmgai13Hk=;
  b=bI//jBwUNCxEq1DvxVH1A36sfmTiAJ0Eh0fCQsS+2j5kyPHKBi1zzJpW
   OIl+qOGkNh/1s1H7HR/rjkITyYuDm4fLw0E+gVSEipE5AuSwISxnll/qm
   pNt0O1Ykism7MJ2/jVa2WvAOdht7cXOeGeWLTvkXIQXd32UbUz3c5sPDQ
   cVUffrFs8/P6DjdXLhxkV1SYbpWfxBXdq5EeLnk/l7awJXCQReeCz+y3D
   dJLjS0E57fBfNHyOO9nfejb+3y49O/CB5OVxfd9tCu7qQXxF19I/CqwyC
   oPbvWdgu0ZvR+8v2M23R97TE6hn4v4xAbwgUboiDFQ+Xbu7kSgy70x/MD
   Q==;
X-CSE-ConnectionGUID: C8YvExW3Q6K29GCLnfFzRA==
X-CSE-MsgGUID: AgTXoSOuTr6Un1xfpk5wZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:36 +0200
X-CSE-ConnectionGUID: NaK7sfVUSV+oJLsBsBliBA==
X-CSE-MsgGUID: ZLMV7MkCQwq8KSRROYyWWA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 19 Nov 2026 19:59:42 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:30 +0200
Subject: [PATCH v3 4/7] dt-bindings: mips: mti,mips-cm: add performance
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
Message-Id: <20261119-i6500-cm3-pmu-v3-4-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
In-Reply-To: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
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
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
overflows. Whether that output is connected to an interrupt controller
input is up to the SoC integrator, so describe it as an optional
'interrupts' property of the coherency-manager node. When absent, the
counters have to be polled by software.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

