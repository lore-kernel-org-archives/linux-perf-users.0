Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9E1F1932
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091178; cv=none; b=XdvvUmhfe1oLCedPDXIUbrBeCj095Tm6UrnSZ24BC1Y4DkhB/71yTXTJOrFSpe7Kz743UIbscORYMuxABwbQpjuQoqDpaONBGvbpHAllHeZMo/wLqYwZZG7MTfyJy8PPtBcqOGGpZowJI6cBbP+cSdd1wrhSH9jJ2X683b5qAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091178; c=relaxed/simple;
	bh=Q7Utk2oyA9qQKBYA5rZ00kHTted5NcWV8wa24b65yDE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iInjrRLhR+agHtMkibuGl30xFsXa8vX7pxNi7dYJDX9Jzu8oCrLyCVXzwPs7Lp9R4LVMTOmGyaMk2E9zBkIB7pQvjKlbh9+fkjjelR3OfAO0QvgbJM5EOF7I9pX5VuCJjVYbH5qMsyLIUPJFvRc/DS6ZGP03N3mIOmBw2mD5dNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Cg/6a5H/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Cg/6a5H/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29568d93e87so13846065ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 19:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763091176; x=1763695976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0EvqPeJi6T9EhMrf7hciYw+vw65L+NWEWIHdZpt+kU=;
        b=Cg/6a5H/nIfUMIHxG+8+m/tSYHiGl1W8y/wpfzgqmzBnJ8ISrDlkA9qaY2acp5sTer
         OyDDLNtmC5w8HRQvwgTAkDyY6eepqADHIEQH4VtMp6mT/YRWPgxDXN0IBskbTR6AmnAG
         Oa9o5LyD9gLACdKwMeLsru2PNO/Sh4ZDDbfnibdicIO+3wSLkfI2qmIvpx04EhLgYo8N
         2poyiClfZ58tAkBXs0PObSRqhP9esy8/stI4S6iaVDFGnGBpsxOldiwxHsGoj44RQNHx
         49Hgxytc2HQbJ4ERZIrfpq5Yphiaj2QuMpS71klddHPZpU6yI7thNxn7pNT8Re/S2FDm
         UVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091176; x=1763695976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0EvqPeJi6T9EhMrf7hciYw+vw65L+NWEWIHdZpt+kU=;
        b=uMfoRxyNzcnRJ/GRlfRa/mdB7XWpoTZC+wSK7iHERtxKidiIjD77RY9K8jHYM8FsX7
         yuA3Ytk57zPuHXsfs8Su4wQ7xDbWat9pvAwQ5ijUOFoNwjQ1E51G/dRd1dq6aqjviYMM
         FyuoiZX3DaD4qdqlquZx+AkOUPedbi/DBgaMD4cSpG7Gz3xpOLX8hsbN142Np6mE6Ewi
         7jQfwqN7+8zS7Al2XqyRE3tRdhyLFAVmcdu1+wgUDU3pLRERQ4n7QOaC73sa+0Ium8ba
         WN0hqga/sfiIU2tZRG0TV4hcQrRrXY6oqdbEfx0gjMjSctPBPCyTrcAV+hy7l0WuY/Bi
         8Wjg==
X-Forwarded-Encrypted: i=1; AJvYcCXZEmrk5YDjJWnXmrpI9ysWSx4I0UyItYVMFA4zCcAGM3gz56jIHXf3CdbnwxVoo0+rVwMZvs8UL3KInveM4ZL5@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwi5AK1JtiD+vs+3Mlxei/89tetDS1iFRHGSr1btFJw2uL0+j
	xyO3acQhGCUsGjafLLSPs4QFrPP2t9BojPa7S5R/igdTxtDiD/QCWuW5Nfz9WqyX33s=
X-Gm-Gg: ASbGnctZTEeQIAfizPGr+4re201RZqFavawGHFYB0s1SUjSggHu5Q8bWPwYWGtQ+lds
	ad+UIVRmY9xKPQmQAUcRBxbhBlooo3AsiPwI0LfMcx87kOwP+Q9tfTsDOM69i5eO+n6LgcNIL0S
	t0EgRTO83cis05Q0+wo/OAB9dnlwJKfOoF18Dg13sTDJ/IsJweRrYsfKFyqbZkaYz8Gf2ucn7ww
	hSGsB+KRNnytLu1mlxrNeXehNkLK7kmxWYD8D7W99i/9GHWPjsKX+SqynA13CryFNHlpw7/RlFK
	E2rYeVpePc65+W5nF4P9bi9antHsatizck7MF1zuCERbDoHb+ymqS6hgHjlvMUSZu4tliEgJlwI
	Q36o0piN6XR2AnW7ZO0tLiQUHJIrq04U7Q9e8jvN9oc4d+AjafFP69j/3/2zCx0a9Tf1I0eRzOU
	MFpwcW+Bemk4NEBWpIZSQAaDnSlbkP4w==
X-Google-Smtp-Source: AGHT+IFgJTRQ7xhSR++kStNbtiooekBhUGzXh05nMzsKi6A8JpRQnDiAWjcWk8uPZ/4vspiiDNwAUw==
X-Received: by 2002:a17:902:f687:b0:295:59ef:df96 with SMTP id d9443c01a7336-2986a6ceb2dmr16755445ad.13.1763091176214;
        Thu, 13 Nov 2025 19:32:56 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0bf0sm40334405ad.71.2025.11.13.19.32.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 19:32:55 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	catalin.marinas@arm.com,
	cuiyunhui@bytedance.com,
	dianders@chromium.org,
	johannes@sipsolutions.net,
	lihuafei1@huawei.com,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	mingo@kernel.org,
	nicolas.schier@linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	suzuki.poulose@arm.com,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Fri, 14 Nov 2025 11:32:41 +0800
Message-Id: <20251114033243.76509-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion [1],[2], hardlockup_perf cannot be completely replaced by
the hardlockup_buddy approach, so this patch is still being submitted.

v1->v2:
The contents of arch/arm64/watchdog_hld.c are directly consolidated into
kernel/watchdog_perf.c.


v2->v3:
Add CONFIG_WATCHDOG_PERF_ADJUST_PERIOD to enclose the period update logic,
select it by default on arm64 and riscv, without affecting other arches
like x86 and PPC.

v3->v4:
Place the line "select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && CPU_FREQ"
in the Kconfig files for arm64 and riscv in one line, with no line breaks.

v4->v5:
Remove __weak from hw_nmi_get_sample_period()

v5->v6:
Removed the dependency on CPU_FREQ for WATCHDOG_PERF_ADJUST_PERIOD in Kconfig, which fixes the
issue reported at: https://lore.kernel.org/oe-kbuild-all/202510240701.eB6r97V3-lkp@intel.com/

Link: https://lore.kernel.org/all/CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@gmail.com/ [2]

Yunhui Cui (2):
  watchdog: move arm64 watchdog_hld into common code
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 arch/riscv/Kconfig               |  3 +
 drivers/perf/arm_pmu.c           | 10 +++-
 drivers/perf/riscv_pmu_sbi.c     | 10 ++++
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                |  8 +++
 9 files changed, 114 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.39.5

