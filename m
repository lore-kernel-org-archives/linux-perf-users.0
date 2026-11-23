Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433864;
	b=1hPVoYkJp93B30pfPAf+Y6wWApKN+OtZtYIB96qr8/9Ip/B0oNI1iqqgZDiLG+QUdxHc
	 b7l1vZkIe7uXuMymZV/j97hcx0kJkqEuqzXsmdTBO+UeL+GWVF/dawZeiHzxIrMjT3gYw
	 U4QlkCX/ddrRSHR/AMYqAAn/ip8/XMcZsAeofwGseDWnsrT1ahm+o0HpekQKJe7bhdzYb
	 shb43fIMkYG9mon57tDCwJiuoAZnleiJLHd6v0/Q6bhf5WvvCkRNKkFIvABLAwoPXOYdN
	 KzTig6az4ZJUvgIpGt4u1oX2n+/8TQYH5u/dvz2874Aky8Oea8NnoqrjTTviq9kXJkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433864;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=E3uK4ToIL2mUz3Svln8sWa7foOIYRKuRK6T5m3vJSVY=;
	b=LM8yOlWjxDMEIHWUtD06V1kbQDUSQeqU9v+S0xQbZaZWYqKcItNgEQrOAaAW2LFEJW0i
	 KS4lngq344LqlqdqbIS7Ykvt8krykwIpJyDOLHpxSPAtCBrfvh2cxV3fGIq0oQpZxNdp5
	 vdXvjqXKU4rNgaUuDrjWCXqQDGM0ysWFd0MEsh+rSd7lc/TUO1p3+r0kZjFqtgde3DDca
	 u/TfYFnJiKYhcF2aN2Ev+EBq5B6I/EGoz5EEZASmARJAdcGinuqL4eigUiWrMBWp4+Gcr
	 vr+uEZya/0Ipds6gsp6I+P3+c1jPHxCvh9oIqgP9S3RD7OV5KsZvgK2rkGOuTxqSMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE060A2605;
	Mon, 23 Nov 2026 11:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEDE060A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433863; x=1826969863;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVPab+eqiu3Puch8ckhPaA7dUxIgv7j+PTZCvvIA2cs=;
  b=W8i2ceHE13OkrDXw/GrNVWt/TVh0i1h+JWa9e5ZjWv8Zq4Y6HEpN+W0N
   YFb1Ejpm1WIK4jVS/jaK0sODYi6LaMXTXVoSD3PS7eubjP2EyJpP+lu/j
   SUt0s7X24+tjEjR3I7WxhYStLblOUhTy0T8DZg0Te0NOa3nqdW0nM/S3n
   v03+jjSoiM84RIoPJekg5Kx0weVIitAOgxWCzWkP5SWxE0XHi5YVm/sZ/
   7J4V7L8Bjil+0ivQW+RhSXceh30WHyvyj9TLPuK+Jhgc113BI37RzhncD
   Uhd0hcXs5R/Q8KVVIpKfzKC6gwWylYm1i8NXfBEhlssOaxRQB4stazAoy
   Q==;
X-CSE-ConnectionGUID: PNZgGUvaR0O6cZ7vvRzY1A==
X-CSE-MsgGUID: D1LKSmW/S26e49c+iEHHtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:33 +0200
X-CSE-ConnectionGUID: ZNX9Ay/VSMu6OR/oF7HPcQ==
X-CSE-MsgGUID: hyqSjWXXRm2C+ZdHMiz/Ew==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 23 Nov 2026 13:45:54 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:33 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 23 Nov 2026 13:37:15 +0200
Subject: [PATCH v4 5/6] MIPS: eyeq6_defconfig: enable the CM3 PMU
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
Message-Id: <20261123-i6500-cm3-pmu-v4-5-5a9f5351688f@mobileye.com>
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

Enable perf events and build the Coherence Manager 3 PMU driver as a
module.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/configs/eyeq6_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/eyeq6_defconfig b/arch/mips/configs/eyeq6_defconfig
index 0a00a201937b..2d06d9ed6526 100644
--- a/arch/mips/configs/eyeq6_defconfig
+++ b/arch/mips/configs/eyeq6_defconfig
@@ -19,6 +19,7 @@ CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+CONFIG_PERF_EVENTS=y
 CONFIG_EYEQ=y
 CONFIG_MACH_EYEQ6H=y
 CONFIG_MIPS_CPS=y
@@ -86,6 +87,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RESET_CONTROLLER=y
+CONFIG_MIPS_CM3_PMU=m
 # CONFIG_NVMEM is not set
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y

-- 
2.43.0

