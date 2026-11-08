Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144043;
	b=47CAhEQESlsN158NJ7WtbmRKiAUFY8+LjKif0QivY21f+3kwzL6EN5kS0nXAgsbFq6U6
	 D1KgJTe4GBHDbMDwOY37TLSB/ZTcA6POAJ6yYXgfI/M90WX64/m9ik2fxe6LAOZrv/eku
	 MBjxin1+Li9/Wgw7OORa023yZHAMojGfYCV0RTXnha2lHHTglHJX5gVAbTLWKCOioD9yJ
	 7U1V9TGGO10cdCxlmr8hfIyStwJKAwlHVnofCmRkvoPT51AP7FOskHlMDRiSuvYjMuaAi
	 mDwLSPXPPndNqMs16p4eoatmJsNDNFkEfY1ZAD0vVd3dl2gnYxkErTQgLPSHB5WRAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144043;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=E3uK4ToIL2mUz3Svln8sWa7foOIYRKuRK6T5m3vJSVY=;
	b=aPdpoCWDPjMUHg7ymarBsJXp84aErxYcBy9XcEmKZ2ya5iyxv5vzUhmv9Hdfnl8hPDDi
	 +CxLxGfmZRBjXsTxzvC1Fnx3U8vg0+Cp+JsxMA4DnlR2OVb/n1MTHtNkZzVAvoJ0uJq85
	 SJwuW008ebD9GG5xeWi6a3DR+7Sv2ix9L1qULywunBxbDzRpu6F4/fCOox2JQ3wt7x13C
	 ludIW4qqCU5Tdgbx3BcqwwzjAkk0oUmYhhn4NERYVaJtvHm/Nu4kvbOCV1BSLJ4YvHF/J
	 VSzTBmk1uDqW3lkLZL1CBJGlbhCfM3zP4wLWOTGUH/ql/oaubMmXsdOx6INN33aOJ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF46606A33D;
	Sun,  8 Nov 2026 13:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF46606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794144041; x=1825680041;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVPab+eqiu3Puch8ckhPaA7dUxIgv7j+PTZCvvIA2cs=;
  b=CecyKS6XKAXcS/VGJyftO2DJ9egVK6djJTbVyg0pA72uADgSLViEeiU1
   19jFAfrTeV+1rHlqKGA7lIZtFeODu8ry4Ctd/tHhj/4/fZQWAiigIvmkf
   l095abY1V5+OXB8g2S+AqULWNqJyQuxeMHQfLL2jON5ZUkIlRE2uluN3p
   70/XRdrtE2dObUEjEe54Md3yGue4A4mUdjiBOzdw/MBRbXH8+A+UcLYWn
   qgLBR+cW8XJc9Xt1WX5qpP0UHQ5ucox4qDw04gK8RQeIPpPzLnBBXmkTC
   BgxOCHMxchIz5WE89TMtW8JBzTSAYMC3LlV7K2QS2qbEfOj8bzVPi7x9z
   w==;
X-CSE-ConnectionGUID: MHGRpWrvQ26WAoe2XmE0rQ==
X-CSE-MsgGUID: 5VSBpGSLQ5iT6LNaAwTaTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 15:20:31 +0200
X-CSE-ConnectionGUID: kIVhbG17Tb6TDfj/1RjtSQ==
X-CSE-MsgGUID: b8fvuy/nSUu7glftSj8A0A==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 08 Nov 2026 15:28:31 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 08 Nov 2026 15:20:30 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Sun, 08 Nov 2026 15:20:14 +0200
Subject: [PATCH 5/5] MIPS: eyeq6_defconfig: enable the CM3 PMU
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
Message-Id: <20261108-i6500-cm3-pmu-v1-5-bd119584891a@mobileye.com>
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

