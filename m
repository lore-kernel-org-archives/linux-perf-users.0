Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E792D3A79
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936776; cv=none; b=Ye6MShssVR6JPVYmnqF0VfetQjpttcq6dMu6ihqbRe06kMbSBFYOqw20RdN2PDcmZ7qVLanysbbNU8wSzCbyWWFLGL/44KVxWnpkhRWSDd4cnVB7epJOwqJFvAXHp/KUUhVj6vW663hs0TfV1P5oLJU8Vu4dLenBCS4cxv7y17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936776; c=relaxed/simple;
	bh=tB7/loLzLj9Ek5QQ1tIEhY+6tK+s52+u1vt2qFEYnkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OoHflqz85sY2EqLs3uA0ARM9p5jzrBnjCbSiYWtmjhiiZZkDU/rADNEuB6yuu936I8nVVDqSjpAyliuqtDuy8iA7vOqVAWlvD1LLb2mdwyHCP+GXNJPCBNht6Kz96KRbJMSM1NaN8zmEJI/fFxHu/qWkw9ni4SjrEp8M7WjRQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XIdt539Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIdt539Q"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe574976so42505955e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745936772; x=1746541572; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cc7LY54K4yJW7U5wYxUM6Alr8WN7qWZLxLYuvii4gnw=;
        b=XIdt539QcfQftnt9jSLEXlj/FbjTvYOGWQ29FX8NtCsAVg/8f19ABivhwX4cueBQtD
         MvER/i+qdrgV42snw8aUPuMz+pDGhX45+Y+OymuS8OIjZNtHWqBpa7rbc82yPiSCxEOh
         uepyzDDNjvMDDh86m/8x8t1+utrLFNp7m+FCO6zW/t/NhZq117qxmR/q6rwZLSx/FKpi
         GVy37b6LIbdFTvdwge5YeT4sFNK8HoZDD5Uo556Uzc8FikldKJh9RQp6ARWL9sHczbCi
         /9J74EEyE8L8RCmpfMcbhdWlsTLluBz+XS3H7ErdeJY/l7qeq488wqXn5xDgM4cCd/gV
         NatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936772; x=1746541572;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc7LY54K4yJW7U5wYxUM6Alr8WN7qWZLxLYuvii4gnw=;
        b=cUSLK5n7MsZ0xWPgld0fWeRNoLL2Et0BGrJbDe3uxuVrUUi9zhmlqMBtmuDYPkW85L
         Kllj3mtOoC4JHiQG+bRmse3OD8bNzi9wDNT71B9zeGCJHDjAcujAszCk8Pb8B0eAf0bV
         /pGuErcuFlP2dGD8EJocy4+TkrAh+owWF6uF3FjgaM8VRsAFtLdSg8ChNolJcwFkn7eT
         CITLJVAFNhrblgXxZa4Yw3zSGZhzYOtMzlCvDxVKdPOlU2Ac0NNmqrxyM+WPuoxv31uN
         Sp72+Y99tu6r3YWEwgpi6aSb29OkmXr34jVjpoEKPWa5GF9MD/c6q8aSCRkDi5q+aLXA
         EuHA==
X-Gm-Message-State: AOJu0YyV/2v69cnCaBGszjR37nvo1SJT5UvBt8S/QMkJ8sOc7WzrhSkS
	MPOUBB4l+n1TnDgxTU0wvfxsAFfmZpQFhSv66axexegdkSX2HywuDDoQHDZnDKk=
X-Gm-Gg: ASbGncugmB/Ajs5nIO8lQtVzOj+qhi4bQ4w3g8D4YzsK5YhwV49Uib55lkDVTX4mfse
	PaoruQmTuA0pl156EGUs2Fxoc3Tp2qIyga0/QSGDiCMMOFa0qrkVvgMHM4lFzV9c+r05o0Bifcl
	0u8SQdN70/CB1ZRzNmD85xsrg5RXgBlhypOabxq4LiDhCKL3KCEWJEpu01wRZxDzDGFYF6PaLQ3
	XMIa9vEbP0pf7kypeadm9fYXwqoO+KybBFsfbY63BCeVatkcMoehqu8iTabLi9NGPZMypxf+Cku
	SFST4GiP06Nlme9nK3sbmeCW3HZ9IMmna9uetG06t1KbzeE=
X-Google-Smtp-Source: AGHT+IHTa4dQspGAilQgnI1Rsq4mem9tVKEBYTiYbLMCHi8QW4B9v2n1Jb9lnZPY/Osg2Q72p116qg==
X-Received: by 2002:a05:6000:40df:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-3a08a3baa71mr2933824f8f.41.1745936772106;
        Tue, 29 Apr 2025 07:26:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ccb8e1sm14275192f8f.59.2025.04.29.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:26:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 29 Apr 2025 15:22:18 +0100
Subject: [PATCH] perf tools: Fix in-source libperf build
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-james-perf-fix-libperf-in-source-build-v1-1-a1a827ac15e5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJngEGgC/x2N0QqDMAxFf0XyvEAbptD9iuyh1nRmaJUEZSD++
 4pv58Dh3hOMVdjg1ZygfIjJWqr4RwNpiuXDKGN1IEete1LAb1zYcGPNmOWHsww3S0Fbd02Mwy7
 ziL7tXEiJPMUIdWxTrvl91L+v6w/JRAXaeAAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, linux@leemhuis.info
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

When libperf is built alone in-source, $(OUTPUT) isn't set. This causes
the generated uapi path to resolve to '/../arch' which results in a
permissions error:

  mkdir: cannot create directory '/../arch': Permission denied

Fix it by removing the preceding '/..' which means that it gets
generated either in the tools/lib/perf part of the tree or the OUTPUT
folder. Some other rules that rely on OUTPUT further refine this
conditionally depending on whether it's an in-source or out-of-source
build, but I don't think we need the extra complexity here. And this
rule is slightly different to others because the header is needed by
both libperf and Perf. This is further complicated by the fact that Perf
always passes O=... to libperf even for in source builds, meaning that
OUTPUT isn't set consistently between projects.

Because we're no longer going one level up to try to generate the file
in the tools/ folder, Perf's include rule needs to descend into libperf.
Also fix the clean rule while we're here.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/linux-perf-users/7703f88e-ccb7-4c98-9da4-8aad224e780f@leemhuis.info/
Fixes: bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/Makefile    | 6 +++---
 tools/perf/Makefile.config | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 1a19b5013f45..7fbb50b74c00 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -42,7 +42,7 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 TEST_ARGS := $(if $(V),-v)
 
 INCLUDES = \
--I$(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi \
+-I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi \
 -I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -100,7 +100,7 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
 
-uapi-asm := $(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi/asm
+uapi-asm := $(OUTPUT)arch/$(SRCARCH)/include/generated/uapi/asm
 ifeq ($(SRCARCH),arm64)
 	syscall-y := $(uapi-asm)/unistd_64.h
 endif
@@ -130,7 +130,7 @@ all: fixdep
 clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
-                $(TESTS_STATIC) $(TESTS_SHARED)
+                $(TESTS_STATIC) $(TESTS_SHARED) $(syscall-y)
 
 TESTS_IN = tests-in.o
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a52482654d4b..b7769a22fe1a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -29,7 +29,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,SRCARCH)
 
 CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
-CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi
+CFLAGS += -I$(OUTPUT)libperf/arch/$(SRCARCH)/include/generated/uapi
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)

---
base-commit: bfb713ea53c746b07ae69fe97fa9b5388e4f34f9
change-id: 20250429-james-perf-fix-libperf-in-source-build-15609cc212aa

Best regards,
-- 
James Clark <james.clark@linaro.org>

