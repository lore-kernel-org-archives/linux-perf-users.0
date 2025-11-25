Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869443019A2
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076063; cv=none; b=Z6MBNqFNnfD9r8McVHzcZjSEiIqh+TKCTWel/Yw0DoiLE4DK7Ml1WBIb/T17bHXT/PL2OFRGTGNRFAUwAko84vXB3eNkV5RJLT6pobnqANpRpk7wwpio1pO6O6oekaFue4aCpfEgLNmhNwARLSbmWMu27DJGaCyViaCJePFKMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076063; c=relaxed/simple;
	bh=AV2BiDsIV+WxXw8AqJKy6ZNuVHWfWccYPXr0ScS2pAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkucZx97V8SIm7m2Uy38OBwuQ7JME7J4v8iHOyL8y0YuASADk02+TodZRPKHP4tvgvS0f66Ui4GC662lR91zxw0tCOmE93pTJWMUq56ITQuvAc32vWDh2JTk9uCJTamJrxqLSxQKROEo4OqEoQi4M/8d9QpsP++VNVPT4tVB/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWGSvAR1; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWGSvAR1"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-59447ca49afso4733821e87.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764076060; x=1764680860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YYefMPifaOdtpN5djWVCxEX2DiBlWdD1afysHMS83js=;
        b=iWGSvAR1yTGe5fnx8MHwIn7N1DHC/hCRWhVAqdOCMSnuMcesxfU7da2IeIeDCs5CGD
         1JcE4zeg/qv4O9VOUDRYIrrX6mhOREBo1HKXMVWItYaKcR2Hxi6rt4MYIbX64/WOOfl+
         +nHRPgcjDCCBnaGdJGhV0LF4Oo+sUnRqwbLb1c/d6puQQuHOmzZmc7WWMHpwt0oAUOyD
         QxnXUfJVpl6zPbcPolR4BEIzYTQ2j/eUBgzNTQrCI0ig2xvYhRqqdU3RrIlfL9jV4eDy
         2rZ2+hrp3DjWEaitTClrgieZhtx2lUSk2Tpyn4g94ilZ09HCf/dC5dRZWFCf/y6Ktp/o
         0FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764076060; x=1764680860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYefMPifaOdtpN5djWVCxEX2DiBlWdD1afysHMS83js=;
        b=qYvQDJG4/7tnqMRGzgWytdaCblEy4I+y27MhO5CvwLYtjV3BENxAWDJSRwxGDTSdtq
         XLztZbtIpcktRkJwUa0g6cWUIlqKMzuO5UkevYr20okqjLZx2zuCPpQ+iuVIA4TIKCJ7
         XcAg9+ydSyQnV/wcIM/QA3QwanKWCcSbEvJyqWC0lsHTX07WixJ9MQov6Cp7q0vJ9EcB
         GUZ9+N65xirc9+AZjf60b0na5TFYQ/fYsyrHTFEe1n119vb94ty/+HJQGZ8C5xmXwjKp
         2DCBkKhEZgmsJuGI+ceGnzGwyN49nqrIJz85YU/VjrzeN/6OsyMIqrCP736Mrc67PlNZ
         7V3A==
X-Forwarded-Encrypted: i=1; AJvYcCVFf/Mln8T4E5meLOFkNFaZ9dqouM6AjXQycXxFJlq9K9C36O109y/Rhh8o7GKJoCBN6oIeB2OWXyu1RrbWlChB@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGpKwqZjHIcEF/jfi/bpJm4k/X35akvLyi7tmW9qIsjmQaAeV
	Pwvozg4uJJOap95hKed51tMMGLLlm4MtGxNFlkntkzH/kIVEeTsTSNmVpv3ollWqsJ6dK3W2R2b
	EKx2PP8MJqPTfJMxC4qtOLOZSOxeEnuI=
X-Gm-Gg: ASbGncsDXFutqcV9zkFcmCCZfzS65dzl9iYHo0tjwpLYy8DDCH3CppNu6KKRECqMZrq
	Jr6cUGAj0dl9Wu4SkJOdKRu/wD10GcplM13udB5Ru0IRivsbm5LgUGE6mpiQLxqbGjoVNdwaYbJ
	zAIBUF0S5A6ceBV4pKMzZECMs+O4lWWXKJ/UEVSqqBEQhQ0HInJ8G3r1PiLvlZoJS2mQhQqtbCQ
	0Tfx06cr2eWWwTPcLA6/YjHfI2ZyXXPEGYUvnzDc2FTeWx5vfk+cF6tXNCyrDcTTiGk/iFc0JIO
	Duxi/g==
X-Google-Smtp-Source: AGHT+IEro3T78ut5nQNAkr920XZLbfpOAtdv+3tMxosFi8hKasp22XyDlQ80yJyDizMEPP89Qk+lNZQL6wmKsMSR3nI=
X-Received: by 2002:a05:6512:3d08:b0:594:2c42:abaf with SMTP id
 2adb3069b0e04-596a3ed12fbmr5629295e87.34.1764076059349; Tue, 25 Nov 2025
 05:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com> <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
In-Reply-To: <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 25 Nov 2025 21:07:26 +0800
X-Gm-Features: AWmQ_bkpWq7wv4lSSSza0dCf6PYxKB3o6ch3jROC31xOuKpypdiQXAhZytJNfWg
Message-ID: <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>, leo.yan@arm.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

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
  v4:
    - Apply EXTRA_BPF_FLAGS directly to BPF skeleton build command
      instead of modifying CLANG_OPTIONS
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
 tools/perf/Makefile.perf | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..e1cf6accaa4c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -35,6 +35,9 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for
cross-builds.
 #
+# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
+# cross-compiling BPF skeletons
+#
 # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
 # EXTLIBS.
 #
@@ -1252,7 +1255,7 @@ endif
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
  $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-   $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+   $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
    -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
    -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@

-- 
2.43.0
