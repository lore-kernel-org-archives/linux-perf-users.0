Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F029AB1A
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189778; cv=none; b=C2W6oTUPzdhUWQcnJ9GGjoZ7rNugm1biSFO5+Ld1tD5e7SytPC0r0yxTINFf8DQofmGIKVQ8TaIxDhh/yu/0fRRqY/hU9Umd+qWEepiRx5IYw3cC6BeZTjZAC5lHS+rOs/ysyvzT7aOVs8xcXjrGQqkGrkvmh3Zfm40QEJ78RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189778; c=relaxed/simple;
	bh=GsGocHcq/Q0vfetgMY4nWIE8g9RqWN7YqLOVtvPKOXE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kUgFvYfbeVLwiacCDw7bNqRTM3fNzu7+5daGP2GOGk1iUkEl3xsVOHAVBxKfwpck9bSPvi32SkiQtuNtOoYph6HPrUkPJJDLvKNpLGqj7v4DLNQvrV1onjtgJhTjgSOxrNend9fW4SdH2LZotxH0/rbL9FIVOvD20nENQe9E+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jog9q4zL; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jog9q4zL"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so8972461c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780189776; x=1780794576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OZnvWRalzD/CmOsCs1H78dHBBpbTxm9Yjlm+cCugng=;
        b=Jog9q4zLpt4GXUE61tG0yO5v0UPdmrSMZkLFSEZvgU+IyYwmVmoJNBWwumIDmRY1X+
         zI1NEDSxgUQyYdrNehv4t8U/627V4zQK3fxOvAGhwqFJfQw1hnW1EtmM+X3zp8ccM1q7
         vCMH8K4DwwcaXjc7dAvh+AtENl2LjjU+Qw4C7Ddd/jix0GwtJP154h2KEGJHCMYI491v
         N9JsX//Sr3F7OHX9IWvs6mQu2B9o4GOPUe+DnWrGErgDWPMde7s2nguvHU2yEZOpiMNH
         dz8GAc/p6n8tUU6//+nUlJD6kD7OQQGhbA3bpn72tNyd5eke4ODgRBCqrB8jq8KqfdhX
         8N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189776; x=1780794576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OZnvWRalzD/CmOsCs1H78dHBBpbTxm9Yjlm+cCugng=;
        b=Do5AWjQrWkPZM4DZ0LQ0bCvkdLnLaFMC0goLCr1vVhoENqLs6Tgd+NIBZ7bZc+J+qZ
         6emfUeLrcnpJV03kvELE7hD3nuLr6lURYq8Icrm2UcZXaVs1Eq6JcbnYPov/7zTS5Vgy
         5hBf0YbY5WWd1pbzsuTDBaduWDyEP2py6RoyjRaBMLnQjcJwOoxSx62ros/i7urmjYMx
         zSTwcZOCwvq7VLCDIG1VHRSE79k2LedFVwHmHOeKpIxf77Z/DV9XTqvOsPmegmnFnLpx
         ryVVLN8c7Oy3MeyO+tRgUgtxFl8PpCIMlU6M/MyQXraguAf+so/0cCdfztx6tfMtc2lR
         7cbw==
X-Gm-Message-State: AOJu0YyBsD67ul/UOi322rDvcUXo5Nk5we5de++iZ29NtWYY0H0xUf2l
	qipyt29TCZ8Ammvn5zkCJ7bPA4eXJ4vRuq9WMAXq5WmHDyPP49to2jayFda0nD4MevAinw9ZzIL
	wX2iIGz/oPg==
X-Received: from dlbrl27.prod.google.com ([2002:a05:7022:f51b:b0:136:9842:a8cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:421:b0:12d:de3f:d843
 with SMTP id a92af1059eb24-137d425071fmr2460172c88.38.1780189775362; Sat, 30
 May 2026 18:09:35 -0700 (PDT)
Date: Sat, 30 May 2026 18:09:24 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531010924.525824-1-irogers@google.com>
Subject: [PATCH v1] tools build: Fix feature checks to touch target files on success
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, Costa Shulyupin <costa.shul@redhat.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In tools/build/feature/Makefile, test-clang-bpf-co-re.bin and
test-bpftool-skeletons.bin redirected grep output but never touched or
created the $@ target file upon success.

Because the target file was never created on disk, Kbuild could never cache
the result of the check. Consequently, Make treated the prerequisite as
missing and continuously re-executed the Clang BPF backend and bpftool
feature checks on every single sub-make evaluation during build startup, or
on every incremental build.

Refactor both feature check recipes to touch $@ on success. For
test-clang-bpf-co-re.bin, group the shell pipeline within curly braces
and redirect both stdout and stderr to .make.output to allow errors to
be inspected and not appear in build output. List
test-clang-bpf-co-re.bin's input C file as a dependency so
modification triggers a rebuild. For test-bpftool-skeletons.bin, add
it to the FILES list so that it will be cleaned.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
This patch originally appeared in the now merged perf patch series:
https://lore.kernel.org/linux-perf-users/20260518154638.2798789-1-irogers@google.com/
---
 tools/build/feature/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 704c687ed3ad..5b4a984973c4 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -75,7 +75,8 @@ FILES=                                          \
          test-file-handle.bin			\
          test-libpfm4.bin			\
          test-rust.bin				\
-         test-libopenssl.bin
+         test-libopenssl.bin			\
+         test-bpftool-skeletons.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -383,9 +384,9 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
-$(OUTPUT)test-clang-bpf-co-re.bin:
-	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
-		grep BTF_KIND_VAR
+$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
+	{ $(CLANG) -S -g --target=bpf -o - $< |	\
+		grep BTF_KIND_VAR; } > $(@:.bin=.make.output) 2>&1 && touch $@
 
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
@@ -397,8 +398,8 @@ $(OUTPUT)test-libopenssl.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
 
 $(OUTPUT)test-bpftool-skeletons.bin:
-	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
-		> $(@:.bin=.make.output) 2>&1
+	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
+		> $(@:.bin=.make.output) 2>&1 && touch $@
 
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
-- 
2.54.0.823.g6e5bcc1fc9-goog

