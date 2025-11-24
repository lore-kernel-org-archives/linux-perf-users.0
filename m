Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57692D97B7
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969712; cv=none; b=bne8CbWMM3volC33cZ4W4NXXesk6aflMUFIWv75/ewJiPNKPqp5Pp9DRLdY9KmF3hz2d1p4AT2PH1mmIBdVS2U2/d5FcsFuYtbR/pJpu9z0J1cUA87jE+5tKltodL709AUovwolRNrbnZJUH1206pQJCM2LMLIG1I6Xc/eeJ1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969712; c=relaxed/simple;
	bh=7QiHuZeV5r2yU+G5T3ATaqJ/zgMmdpx7lq+m/qeYZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYSVeblqHrsYvKd9u+bD/AjBRrsGpsKBm1naOlcbfTOPkQ9IUDPyMUDTjApxAwLhyAyr6VWJMOTNhyyaFwiiClzCUvq9pZosi8CvmmSdrB3w1Gdd1sBuKhkt/RnsxtWZG+EXV3tavQY823MgpbrKtW2JTZdaCwNiGfg6MaNEwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Px2VVJ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Px2VVJ"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2984dfae043so35358335ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 23:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763969710; x=1764574510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q72IJ5DX3qY6f/ER1+NerJv7hM2y8TR6Mhxz2ScPDDA=;
        b=T2Px2VVJl1xrK5MyXZKb9Zss8E5GK5HQm14QEYQkl47OUBhFnEFFnPQ8/qdsWM9YTU
         rneb3W4GZEjmFfwCIANZ5kK8Nw3xDb8QG8URuILAi5//HzH7hTjYFni/y2vDc0aR5y0e
         tGJI9kAobe+jn3qXhKKSJCDnVhpbjq53JEE+AEH66t/aIUvFsF4RcMKDrjGAId5S4V2p
         Yegrm3S/LY7pJGmxUrGXqRVYorbpOZlHsVWDQ7d7hl9MDl4J0vl1AYoXdm8t0S/rZVuR
         1U2cV3YZR+8gBD60/SFMERGd9lDkROuB8zsywaA7SeEtTnXpaRTwBbA2wU92wjAuawgY
         xvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969710; x=1764574510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q72IJ5DX3qY6f/ER1+NerJv7hM2y8TR6Mhxz2ScPDDA=;
        b=cdhlyDrErGVV51VQPd/CSIXn0eJPSKCqyTNvn06JUaLZcTbIk2itUJLBPUYFV8aQ6/
         NdXgoLdtK85tUN9K+IqsqP+a1JzTMZyavTXtQHIHcxNQJ2vzW0v6J1LH7FE4ihTq+fH0
         rLxUky7A4tTb4upDLKMT7kG8nu9TWH/DyGz21Ozqghz5YbAykQJOMkFNIMsmiPiDcecm
         M2jQJymgIx+DK/1mo9JkT2vsGaTWeQUs1OoRi5RzkvZa2k6lrk37pgzFtPXR43XsiJZQ
         X4VQyXpHLaIQIrEeUe1AVDzDk04v3DGJKoZBKVW3bTF1u2dZAyVeyj9VdgLW+Pw/MPx/
         dhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0W+0IUpnBDnxNnGfJm+faWEQhpYQRvm9xzMO6rO7AqV0L+dXJj18I3d9IaHaFOLq/dIkZyjv3Ql74E0RsSIDP@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxP9VzMP6N8Mt33HXGXvn1gUtsuM21gkGaVwKZIL4/rCQhC19
	CrKuSLMp2ZzCmm8MUWsBk/gwT3g8zKWyzoBy91RPLyy4ncNAVOihpqRn
X-Gm-Gg: ASbGncu/IotkXsExmnT6cphO+GELpvznXahsF2EujWLbmZo44k1xmcJRzwTtASZLPrW
	jhjFJkRak5Kaxn9lITf4GvE3XaMTFDEIaIuc09AjQ+7WZKYxJYKLUeQh/3Ed40MwOk1WSZKoVic
	DHcpd9nQbcxSL7GpPitq/oBHBSBKHpiWVZ0lAdmzineknXgahZHUHjFkO8pATc93jotV14qNTcM
	i53VQmIRPeK+lhZnms9HEUnuRdk9QuBmk0BxlmyjscvKlzjVvf8g+4sYZH6NyJIaATR/HjYQKpK
	d8gc+pTKY9l+O/khCLRdusRDOs6aJXwNJaFoX5VaNUBTlSJfx+wiVoZ9TVDVFUTmhI/IyIV7zQZ
	ef+3kQpcxVF6QKN8w7h1+OsgUsd8wt48if3KQOA5EnBB8zZ22L65hSX6BYRUUJQ==
X-Google-Smtp-Source: AGHT+IEGHT+8XPQhA29IS+SW+RVYXFlp/LPFNgCOmMbCGBqwLiBFPFvjA1rtPT1Ca+k/HaPC0m8G5w==
X-Received: by 2002:a17:90b:1d0f:b0:33b:b020:5968 with SMTP id 98e67ed59e1d1-34733f30ecfmr11731089a91.21.1763969710073;
        Sun, 23 Nov 2025 23:35:10 -0800 (PST)
Received: from HUC.. ([2a09:bac5:398e:2646::3d0:37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472693c501sm12534837a91.16.2025.11.23.23.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:35:09 -0800 (PST)
From: hupu <hupu.gm@gmail.com>
To: namhyung@kernel.org,
	leo.yan@arm.com
Cc: hupu.gm@gmail.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
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
Subject: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
Date: Mon, 24 Nov 2025 15:34:45 +0800
Message-ID: <20251124073445.3709-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross-compiling perf with BPF enabled, Clang is invoked during the
build. Some cross-compilation environments require additional compiler
options, such as `--sysroot` or custom include paths.

This patch introduces a new Make variable, `EXTRA_BPF_FLAGS`. During BPF
skeleton builds, it appends user-provided options to `CLANG_OPTIONS`,
allowing extra Clang flags to be set without modifying Makefile.perf
directly.

Example usage:
    make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."

Change history:
  v3:
    - Move the variable description comment to the top of Makefile.perf
    - Update commit message
  v2:
    - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
    - Update commit message
  v1:
    - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..c1a66cf3d1a7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -35,6 +35,9 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for cross-builds.
 #
+# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
+# cross-compiling BPF skeletons
+#
 # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
 # EXTLIBS.
 #
@@ -1249,6 +1252,8 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
+CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-- 
2.43.0

