Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3EEEC3
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928367; cv=none; b=Pb7dMkm4L1F8+ugW+oeqcbo51/7ONT1Rc9oxAdgCAiIMyEv1n5hqjQsae3xNMad8hiUk+FxLooDE5rVUIc+dStoN0lVx4i1REPcPwQOF6aQygBIvikdWzIw9d/FMQfZdANwJugpPhz2S8B82cBO83jCmqL6kT8S59WvR+zErhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928367; c=relaxed/simple;
	bh=UpRxe00P+c7+vyYZYzkM4qwGhgttHXs/vvOHzwK6E4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUVYu5eIt9F/qbNQ4deX8NMB23+u27RArR+iZZUr7qkbSe2PZ38hUlJjw+NcEfxBGQAdxZsiC2TyW4UErbGV40ohVTejpEQ08Hu/fFAMHNlwJb1S6M/D/SARsWhAk+CFippLdmjQbeW3PJdhidMoC9UKbckTGn4G1UBpbd7Lkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Con6+I6T; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Con6+I6T"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-789fb76b466so3210572b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760928365; x=1761533165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=Con6+I6TLzKyD4OMGKQPCd7Eo7ikjFqN6sn5MNdVHxLJKfbPGohiz/ylUAWA1ixFW2
         cxAwmvXNfHINVixAxnxqAug1ID9/cGEP7i7SLtEye8IybwxlQIe+I/LySjJSxGsLOR2h
         1OhusVum+58KgBI1gDxDj8neLeVZD1fatCK6oFcly2kV5rnnhGYE6TVo0uEzTS6ZhJbh
         E/hQDY6eZGLXfQHKKBWsmdBDydD3COecfKPA1A2ZOBXCr5g8Yl/oUagEaYlW42TSLnfk
         NWgnCc+3hu5pW4oTO08J7CCOjhJlsqZHISQn+4T64+/tz68DUvObQ6W+JF2KSoHPoVhJ
         FSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928365; x=1761533165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=Le+uCOc439xmq+LFIC7YcVjqsvrS8mzZ6WKUliB+rZyYYmCK/OWvI74bjXpVhi/t7q
         AMhNtoInrLOmH0imlobdN4hNAmc8CuLv/nitAR8sBAeIKl1uOu6mCfoGv07cfv2Uw4Cp
         CQnNot+KB4DR7hKLn2kp08AfshJIpiavHGiqyD/BY5irY9zZgbNYibyJbgj0r421ur9J
         60keXEKDe5odvl6Iphp79R1BMfH2/TGh0r5UbbF09NhReO9eT4Y54Ew1a3v/bx3x+Tw2
         9eOh1kFjaH+j8YK7hcosEGjjO7FZczmmD8o3YcNmyBDF+yWwQZ4qLY6QtenA4d02L+Cm
         mf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjDQg+4TlYK997mur4i+AiUpBhlovkb+t5ROmcXWgLIQCewUQ2jMhY5Gq5aAP12VpPpsW7KPHKsRc3cAOFPiWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxlY+EVNp/pHZtWhNKjaH45ty+EutBredWOtbsn9RgQodDlqU
	BEs6gfmkkKv7akdBT+esQUyN0Gfl0zEcCdkvRXv+izx5VeZWySF/NsdW
X-Gm-Gg: ASbGncsLb06M5f6FJsI8wXHkmqDVMOjqvdKoCEdZB63vrsRsIB04Zg9umOsX27tdojM
	bBHKQaK91dB5wkSK8dId2bldastqDkmXzQ2ewedwTyZDtTaIDbMWB/lf/cuMFD1jcR6FT62sFCa
	YBUItGGGMmxaAc674yNVpPnJPDN6tbhUSvWSHkDLguvGCgnI0CFCncEb0sOIAkkCNyTuXtfx9Sc
	PQhU7rWI4NqvgOGGPKDx54e2z8qLVXXmxlpAZVbGfbNkZx4TMW7HTD4Xs1AfLi1rMVu3jEy3rtt
	q6Fmd1lwJXpKoNs+aPfe38rPmW9LzPD5rZAI/EnQd+FAY7CdFnae4NvuO125BI9gXknNZvw+381
	5lhJlmtJR0CCKFxTkYzQGLy4Gq+CYAJR5kUZ8+PHIAjFAxxnb/wETsiXdv1XKUDW56BqB7e1Wb7
	SKpn3xsRLF
X-Google-Smtp-Source: AGHT+IGScCN8jrW6blCf1a5d5iFZipyC+xf9/0KOw00npZ7H8R0ddDTd3FLRDcxSXXxl0i+leZXodA==
X-Received: by 2002:a05:6a00:3696:b0:784:27cb:a2df with SMTP id d2e1a72fcca58-7a220a61ac4mr12878664b3a.1.1760928365026;
        Sun, 19 Oct 2025 19:46:05 -0700 (PDT)
Received: from HUC.. ([210.57.99.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301230a1sm6761277b3a.71.2025.10.19.19.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:46:04 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: namhyung@kernel.org
Cc: leo.yan@arm.com,
	irogers@google.com,
	hupu.gm@gmail.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
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
Date: Mon, 20 Oct 2025 10:45:31 +0800
Message-ID: <20251020024531.6900-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
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
    EXTRA_BPF_FLAGS="--sysroot=$SYSROOT"
    make perf ARCH="$ARCH" EXTRA_BPF_FLAGS="$EXTRA_BPF_FLAGS"

Change history:
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
index 47c906b807ef..f1f2efdbab8c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1249,6 +1249,11 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
+# Allow users to specify additional Clang options (e.g. --sysroot)
+# when cross-compiling BPF skeletons, enabling more flexible
+# build configurations.
+CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-- 
2.43.0

