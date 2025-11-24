Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14902E762E
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969014; cv=none; b=IeIzpjht3uhkM2FvE+TgKD7I0U9LT3uhdj85p738hzW4l7gWgwLoHeshy9dgJ3AytDKSnN2rf5+apGchH9H7HvuxnVoaXZMnOgheT+EHLI4cwwN1lcbiiEte8P3ZYoAAD6ik+IfuVAOTlNGjwjQt8Bm/hnVJF4P/OsppvZYOzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969014; c=relaxed/simple;
	bh=yEeeeYkSOmkING90Rv0+aMDEeZDitJZhK+kJBONj280=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHNV1hZePafi4hmGP/PSck+nChgZHh+IUp/Pxn6EC3o78Loc/wXExrAQtGO3Z9uLqXA/+2SAKS6Nd8FA/CJ0C3Y1xAJ7x44kxqW4dIx7OUrgP/4gBMh+HQjtMTbDfR+L7Fy1/irDR7iKSTB1aUDa1FFlCB67JYhmqnmAi35nSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4MaZYkN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4MaZYkN"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2984dfae043so35266835ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 23:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763969002; x=1764573802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfowLXnFtigLtG5UT3GT3dhYSI0rp/WwAdLCaoMNk3U=;
        b=F4MaZYkNYmfMroq76u8gVGtUSJSauL1H1DGRXP78H+GD2/kWwosfoQAeZt4LeUtnOZ
         QJqDFtEPEJ84Ch1+diHmifbAhll4ZPlHAs+2cdMWc8Arb5ClmeYRjm6y+OasDvSNXQ1X
         4venCBnhvDFlph1e5Cx+Cyo2JI2POvTCLGR/PCMxEd9uI1wLgAcfu+v9LCTMu9+npsDo
         I/JTyHVxtn4Khw0CyxMAsss7RGnV+ap9lYrlN/ead0B4aQ4Yi3cPJWFY6XBMqpG93DOJ
         Z+OVHRWaj8FU+IVkiBlcuLQO+AJuw4dWTYVjYvF25zG4AlokVpqWY2efxU58YWcTlQMp
         W5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969002; x=1764573802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfowLXnFtigLtG5UT3GT3dhYSI0rp/WwAdLCaoMNk3U=;
        b=OWxGo3nFxjaTh8QQ0YwWvoixBZWRX1hu57958a04xzv3ofv90LakxD3+KrNAiVb/ib
         RkuvJPE7apNLOW3Kk74dGWbC09l8DscSbb0+KxijJ409jKYua+Uzx7ApViqKitXehuGz
         2V3Em8THvzo620cq2G+Ww0kTT7X/MfDDRCZRCuUUsTK0sYAZrxzx3hlflaa7Fr5VYsZy
         A2euICji0cjpPiOPWx5S3uONAI5c7wF6+uKOAeRKCAIf/x9jibH4rbBdQDMAeD56wOOn
         MMgjz1L/5NuvL/xSAM0lZ5q01g1n3IEl+oenm16jhZr2/SGyHc0DMH3Ocgr96JOp1wTq
         allQ==
X-Forwarded-Encrypted: i=1; AJvYcCXunSYW0WtolvRU62Unt7JKm0BMjonrz6y5PhzqdsQiGQiORXvkA8ZOZJezpOAcag8+0Sz544GgdXIzxIM5m5AG@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8y8j6fRQr47tgQn/CyTV1rgf5gyupDyR6dZfskrav7g4KFxX
	Ti0eQ2UGz6C2BbzWebo5szobdAnxzJigjVnk4eQeu/lE0NVOigEGOWAN
X-Gm-Gg: ASbGncspCE3zqTEX1snBSBoCUSWxKc4upm81bREEKVreoRK6NIlPt99oU294EBqvfxJ
	xf+ory+0d90H29kTvGQYJMVyrVMH8jdEcpmvsJ/IOPZx6H4uCaWL7N4YTrYu4SNMCsjNSSxsFkZ
	AH2Y34fFAfAKHDEDIoFAnj0uUlTY59RcQN9JvIdgOzpEbjIPgCLliJ3DMRo1Jp2Ej2OnVwUlrht
	PJp3HRG95Otp9Vo4HdFXdQk09dpw1Iavrh+/nnOBJxQwvxM2T4rJznCC7qjF6p51fRLSOT1l50O
	1Tql2X6vqm1p+If59fk2RBDrrrCJGKJS918gYaOpk67arMjCl/sZI2ZJkvBrFrxbMWQ78X9KWi6
	L9Kp9LoxA7RYKgPQZ2npZxX3JTCk2+WLWKZC6ihC3WEbABS9LC6P/iooBlbDIEDQW64l10+8mnX
	FdvxPENAMSmfYIBin/
X-Google-Smtp-Source: AGHT+IEUt/DH8BZDc75Ua8c3ajyqaI0mEkryWF1bCX35T9HiNR1LcAucKsxtchP7xQV/MhK4v0vpBw==
X-Received: by 2002:a17:903:1b03:b0:295:20c5:5453 with SMTP id d9443c01a7336-29b6c572526mr106274445ad.29.1763969002124;
        Sun, 23 Nov 2025 23:23:22 -0800 (PST)
Received: from HUC.. ([61.171.236.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b00e1fasm124836095ad.0.2025.11.23.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:23:21 -0800 (PST)
From: hupu <hupu.gm@gmail.com>
To: namhyung@kernel.org,
	leo.yan@arm.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	hupu.gm@gmail.com,
	irogers@google.com,
	jolsa@kernel.org,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: [RFC] perf build: Use self-contained headers from kernel source when compiling
Date: Mon, 24 Nov 2025 15:23:10 +0800
Message-ID: <20251124072310.3592-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building perf, switch to using the self-contained headers provided
in the kernel source tree to avoid build failures caused by missing
architecture-specific headers. For example, the build may fail with
errors like:

/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not
found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~

This issue may occur because system-installed headers are incomplete,
incompatible with the kernel version being built, or the corresponding
architecture-specific headers are not installed at all. Using the
self-contained headers from the kernel source ensures a consistent and
compatible build environment.

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..eaccaae87e3c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1202,7 +1202,9 @@ endif
 
 CLANG_OPTIONS = -Wall
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
+KHDR_INCLUDES := $(abspath $(OUTPUT)/../../usr/include)
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) \
+		-I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
 
 ifneq ($(WERROR),0)
-- 
2.43.0

