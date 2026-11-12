Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486575;
	b=g9KZo3mehwjfeBdRZPm4j91brYd19ttRamKVWN7mW9h+i+CRz7Cxk8lOx6QTZLkAKhGM
	 ik+8GEMvJQvsSgcmNMm6eyNx0dQAhap1qRIokGASyyFZ9H+H31o/R/TIqoX1NmeXBUHPo
	 sohtqVwBguaFXL3800Nb63kubKb5IUA6N6pLcwd8lXgWOydfmKhUrDVflccXqg0cNfGPV
	 oL9ytc7JoWt++iU1uhd2zrK82kME48rbA5WSkHWC7YG4xibUNlsmnOEoZfd8srbuP6d1i
	 8lCcyE7rZ9Cwy8Jx8JoEupHaBNbNB2wYw87ltO14OxWanUpsT/LI50vOjFLxOvloFRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486575;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=E3uK4ToIL2mUz3Svln8sWa7foOIYRKuRK6T5m3vJSVY=;
	b=OtKF/d8zCoyLzm+Ed1363eiIFfilAwb7a1Qka4Z4eUEAG96eQjmf2wyO7HZFN5nHutjS
	 dfY6VIjlbVRVvaP4ELjkz1JZM5USV4cCwLfbTzSsySQCU4NzUnH9K7sRC7rpnSwDadkY7
	 UPUdmmvjk2VBfD/XwGKawFTJ6V5RyDT5owbjTA5kCKpwgqVsrj+LhP8QzWihtTkZryStr
	 8YCmSZFgLjBBJS+CP2E3I08O1RrfZ/7fa9YjmfFvOqILMnMoGSH/8nuRejDWP1w27LU2K
	 PRX44Z2CVMkF/aLKH8UwHI/plhIciw/Ac+pwpmLbFxNgPZCvDEletIJq7heHC3CfLIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA5606A894;
	Thu, 12 Nov 2026 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FAA5606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794486581; x=1826022581;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVPab+eqiu3Puch8ckhPaA7dUxIgv7j+PTZCvvIA2cs=;
  b=CDfZ3H0QaFmRAQDEpTLrzuNHQc7g/zasEBIXDJ7b4ruPUUjQocSpTgX4
   h4sMKYijD1UxKGuX9ZFAaNMZEi0O/4BnByChmanbPi5Xkrz7iqgHBjyVp
   nqYaLKndkTl49nxgEQK8dKH3LAIKOrL5uBVpX64M3MQPiReq5IMg/tSia
   /RycTBOuQw6UZzRitP1HJ5lzmvsXdg77ArSOFCHtcABYqpzS6lBNVTalJ
   WFRDTKe5huSZX6rK0orDEa8T7dfdmWT7z5FWYfQvJdec3c4FC/J8ay3Aw
   jhcxQOArhpWuAlWhv6Y95rpT0OlPY7XFfF5GSXFQDwlPIZN+D4k7kkUOM
   g==;
X-CSE-ConnectionGUID: Onf6UB9YRtWDDtYrsJWD9A==
X-CSE-MsgGUID: QOon83Y6Tom8tCX4zAk+gQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:29:31 +0200
X-CSE-ConnectionGUID: zrfLJ32aT/e9A3NIpkHx5Q==
X-CSE-MsgGUID: eQ1Chy+aQ7SpgWhbo53KEQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 12 Nov 2026 14:37:36 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 14:29:22 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 14:29:03 +0200
Subject: [PATCH v2 6/6] MIPS: eyeq6_defconfig: enable the CM3 PMU
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
Message-Id: <20261112-i6500-cm3-pmu-v2-6-cd2569571819@mobileye.com>
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

