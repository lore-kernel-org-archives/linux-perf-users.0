Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837417A2F0
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928062; cv=none; b=gpyBlAjeCeD9p+Z7zMOPUiaJMpmRV2IOQOLUVM9PnDzJ6xrruq5uj348oCiYkcyBsXodrqcn5xUErBy/mGUdapTlZWkNUzbqFvN0gPyaZi5sPJoC6eky/1DUpF9ZL6CpnbBJn5EBhrnm/b38PGcrMWOCPJSDjlYZI8VEqKNcZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928062; c=relaxed/simple;
	bh=UpRxe00P+c7+vyYZYzkM4qwGhgttHXs/vvOHzwK6E4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIwN+f6zHilm3GadmFQnxMJgac9/3N2e58NxGt0zgL0/s2MFkRaAa3o9a5f40NL+2N9p2yd+EL9/pNjNkirWfXulxpaiwhYTlxYRo6sSAx26AEpqMQU60lUSRU2Tfcl84E6H5n2D26NxnHEqkc+IUUAGkS9moeZ3NObQ8I6rynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzu7zjRg; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzu7zjRg"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso3395970a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760928060; x=1761532860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=Dzu7zjRgYaeJiSV4kL2RQgeNMYs9lBfL34V/gtT+z8DEVd+Vey1tETnopzNUO164hj
         ZWfqkq2NifdhFBmMqkt8b2MwJxRj/qRVc8DWiZ3mHpXG/s7VM4/oCxz0mokyptBW0VaJ
         w3dQHr8q9kzmAtuoJIP/YmhpsxD1CtH6xigLmgIdtmoqogS+LN2isa9yR88SJWZWHoPY
         77adrQ8S0cCuQOHex7JmxUbxHXTLabVuTuQqAX3t4tp+ib/Y/EB9xuIasU6h/Ix1C3wp
         95niGEKjiJ4KXbeHfpnQ84qSAcoHr0yXP06DC7QMoeJID/Gzrw5x1kDyqy7xn9nsMIrZ
         76FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928060; x=1761532860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=cBm5Y6H5EK9YdVuYfyqVmcJtwh6FXlMRI1akT+hQpbwBRG/9GwWzYhURmMzjKZdiN0
         Pa/N2Nfd6PAcQ6a7BpkcNAgZvVDX9qAYhNY95CY+xfgoSgQ1iEA32aLVakIffdAmAySh
         c70yGgOkXQ+jJKhhPWjjueBSnAURqCX/C6C6JmayxIJ2bWg8/t8EmBX+Hw4g+kVMGAMz
         8SnUC5disNX8ID8DzvWdV2f/gaDq5SCAQd5H5vjRiCZhcaaQDN0NqILSC95Qgh4XZvY1
         D+lVXPFg+VN8uehDc7r47fh0rbgE/W07tyNDjTk1xx1r+25NWnQRXHXUFz8E+xYvaiCx
         Aiyw==
X-Forwarded-Encrypted: i=1; AJvYcCWUMHDVw562aG5emQytRHr07E2JNLfOwp5rbguAjlR3RtizPIv2hBQwFLT7jzdWY21AuE5kv1/Ha9/ZMg4B4wNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTgQuMf4nEYWuvH1mszTGxHs9hWLM/f/BffDipcLP/jnG3oXK
	8X2LXWnzdlvwa2t+4PockTYosVQBNgWf3LFd0OAQgOZ+0oUC0XnEP8k7Gsx8bm9k
X-Gm-Gg: ASbGnctmiDzDFZOLljGIGqGZV683Vb3quv0ofkVT/dz7iwsCjWReUv0YgrqThQtnjxP
	d52s+9pDmZJvP1vIPHB0sDXB8xT8jlfIQzUsbn5eKYkifGwvimRqFXkfTBKrG1I8NDW/XzHWd1x
	4GeiQc7jWwEfSUOfsMnvP39oNO8fHiXF3i+Mbo8BhWqd0FX3kyQ+/9T5V4yY+nlHaGASgTIEt6O
	zp5r0Prz2NkeS7KYIX2z8oasAtj0HC3RuNlhcyLSFdXJaxMUZ9XxfFpzHd/n5bvpdyDPWg/xH7K
	D8Vlza36wh9Nft1iP0AugIj+zMJGe9Jle4CO+gnYLIa/3I+LXTQFCqo85LRL3FP9ySLO8aEZn1F
	3JICeVFgp7A6SlrA4ksoVufHXuJqwIKTTZpmNbHz0Oa8IWzwdElBarLTXSevn9mQ2CKNa7NBT+u
	OVTzI4lxCo
X-Google-Smtp-Source: AGHT+IFt0GDoRx9gJXuSFEkLE1HjOlhETzFdQe+hDtnu+sHRGQW2KotFg7OOFFY+3KrIiMsrBK4qyA==
X-Received: by 2002:a17:90b:388a:b0:32e:b36b:3711 with SMTP id 98e67ed59e1d1-33bcf90c00emr15314358a91.28.1760928059800;
        Sun, 19 Oct 2025 19:40:59 -0700 (PDT)
Received: from HUC.. ([210.57.99.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de30555sm6603334a91.12.2025.10.19.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:40:59 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: hupu.gm@gmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	justinstitt@google.com,
	leo.yan@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
Date: Mon, 20 Oct 2025 10:40:49 +0800
Message-ID: <20251020024049.6877-1-hupu.gm@gmail.com>
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

