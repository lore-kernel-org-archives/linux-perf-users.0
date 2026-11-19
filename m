Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110706;
	b=4tuuft/r7+AGhnhmvhdOGWN0cntwj95OgXOz5XjtNqK26RFoASYbPODNdksFlUFCV/ah
	 OOCIbPqMU5GLxuJoQOdPMFC+DObxrSAo3WitU7h4O+cD6SldDlAqd7R/2aFR+EEzLQ1B0
	 UeO/FAERNeXc6lgwYdHe/91YDuOO3YWEOJjgwX80iOni+Agntd5m0x3eRpFohN8vaSYjH
	 vD3l3wnfglIbSL9X/2sLm9mXK0FOlQAhRhQVGMaM6LY4F4KSi6lUbwaEwY9y/thTo/nHU
	 rBYxYLXwHvMSPOHRRGXQRQd3VQdm5wfb04KPVR6S5w+415t2GsiA5f9GDTx1K3wWmbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lyATTZSpPwfe+0tTFDl9okuYREBYcyzOpR8HimDcF54=;
	b=4ompWlQPGdNsKqiiq9N1PetYrxwZD99DrrHVCFwH27obQJG+jtklKVxUyg+rVT4wnW5l
	 m6WJMPKELZ5akwS2SofrfLCxNh6T3phmf8U9U6OtE5MHbfbenex63e8JAu300qagmk/P9
	 fRgB+I+lwuYzPzDgnqwrWh+bg33FRlFyGvgzKUkYtPEQq1tD6W/nQoM12j+3T5h9zV069
	 OZTwiNnmsc+GM+SuM7aTa0xPbvjjHCi5KeQ67PlU+vJ1I8Yfn5nbB3uQIdc7JJVjKUEuC
	 8bK6dXh2dpbwzpFkjqmVTjvth+8PPworhRU22J8JsD8GhC0aXavWvZVUGfGiO5yeDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3660A380B;
	Thu, 19 Nov 2026 17:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D3660A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110706; x=1826646706;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=huVfTbErH6adnt9mw42pnrtw5P+Ckl7UHBlLJGXkTlo=;
  b=NTJY4MouyMSvMjumD8gyDbcmFdeA5QHuEd7zWp0mQB3chOqOHbMwk7ko
   AM3GzLt1z2pyZkPuo9Xa9XQ2IdVNsEUxdnCKcDh4CZcN1q+U22P5w4S2w
   pQzC1qYyWtuE9YbHnV2VlSBUMs1OHy1poEGTIQzKC6CFuppaQKKPgkuzK
   PnEzocM0QeSkrEuE3ypQMzDEJ6Jp8tmr+l2wWU2TXdb8IPaN7Lt3ZV63J
   jKJJKNgCZ2ZvN4hsa6D4Sbd4RrSkym5KCH6eWTPd4hrJK9T0NygSpKdxG
   YojW1aqxgzBER2MLj4oz++893sBR5jm9VhijjgMXfkrvAMICLnCTvNReT
   w==;
X-CSE-ConnectionGUID: e81Wokr5REapb9E2EZOrfw==
X-CSE-MsgGUID: w2S8m7ojTT6pRmKM229Fww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:39 +0200
X-CSE-ConnectionGUID: ri2IGrxzQdOPJsIu1/kODA==
X-CSE-MsgGUID: ODobeq1NQgavWhZ8D8UMoQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 19 Nov 2026 19:59:53 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:37 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:33 +0200
Subject: [PATCH v3 7/7] MAINTAINERS: Add entry for MIPS CM3 PMU
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
Message-Id: <20261119-i6500-cm3-pmu-v3-7-c86410934b51@mobileye.com>
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
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
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

