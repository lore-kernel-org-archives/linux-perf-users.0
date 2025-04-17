Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61722E3E8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931307; cv=none; b=iAj/d2q4Sduui48rNZB27CyvM9AzQlPNvcF5Ab6goO2U0xGyIsJvSRn2c2PRVGLc3PF46MrMCD/rNXL0i2pEH6gEcCv3YclCQnJsjbI4yLgmoiu0GHLOkp1b65ukThmiMbKGzaDfEyWQwJt1yJxOBy8881sfhFAWxGl8w41arFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931307; c=relaxed/simple;
	bh=foSoET0IF18/f5J0V+ZIUsKXop/FvoFoqTKnlWhCxVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XVj7lsq/iQpJvzIBI1tGYAXFdCbCI2QEbnE42jr/t0ckwArmf9hVUxWGEMuv27nfgyQGPdhF+LsSUpYXZ4NURYyvR5eYUjH3FFvBav8lxW5X+StTP3ro+1SlU00zKTNeJiuA4ae0IkHiBlJVdIzXl4Q8IBSpHNuBCs1egSxEJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lg337xSK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lg337xSK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224192ff68bso12623605ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931306; x=1745536106; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ztzt+tF3nTRYCrcDqKNMajzSGAzjCJLiKGSSFxPrQ=;
        b=lg337xSK5nvTDG2CvM+95trPXVKmEFO8unl/6Yo1b50uYKtDUWywDiQD7MWqYj6+81
         r7nDO6RFRB6VOVcL7i41RYYxRudizFuoB7ZtpPA+Mt4hAUzMKDlaVCrMoDlrKqf3Q2xd
         zPdsNrV4c21g+z00IgB2RypGXwjc07XDyniJgZx18TyN5gU22AKHKXY0qrgbrrBge+Ny
         3Mw0zRv/HFid1oulzNk+5jSJZAyF/kGzCdq1mS9h8zmLsdp8pQZFepofHHhjeYswMPLu
         aHx0RmSt7WdvpFL8Ik+Y6VIQtEXNumKHjcudAuOTtEJkUW/1VvdZEox/AT2mddX8iUzT
         +3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931306; x=1745536106;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ztzt+tF3nTRYCrcDqKNMajzSGAzjCJLiKGSSFxPrQ=;
        b=IcFGxRQ3L00gW0RbiRZTYwMUvTQU5VFxgMDGtK5s7yVd9WCVsYxOK/GHTJch/HxsuS
         CKqQj4P2uB+/kqWCXecBWxDZSwketVo0a1uYS3FhJTiI9Ug/y2Xo019dmG8prZCsZqxH
         +ACvnGU9yEs5NXOC0USdXib0B5EqXRAh2CtCk3v1BCvoPjM4irKvJ94uQX8zFwcDGzrd
         VWdbyRwhQIFSbEvn4V2MdPhdMvIJxjQsJECJpVQgjxPhZh/FVnW6oQJMbSgo/OP3tDqa
         cbu9Ff7PeGNV20JT2WTaydbgokG5lO7CwtoQ+V3poFIRMAewq8kO9QHkpFzglA3bwxSN
         dPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUo0Wx4i75vUizbr6aSVus0XCLBrTYVnwAwiNSy3tfQrkT2Eq1wVaZrF/HTWQTgzZ1hRzgygR43XTOJIzk+Ajai@vger.kernel.org
X-Gm-Message-State: AOJu0Yzypae+omLv41CKMqZwuxhwvuBDGQ3ZBnUqOXhlT/VKnFaz3+eo
	PN10Cqfi/a/ersgnRmRe5vaVuRKtOyzpD9qQO9+iJToEZweh32lZWMqKPaxhFArEQH5ToxJPt6i
	dsw2zwQ==
X-Google-Smtp-Source: AGHT+IEWSA4fDbg0ibRFGPSZKCMBCSJeYgY5UAGASEYAWSOWOvfZ2A76/t8FmAXO8wa38rFjn6xU2QPybjdA
X-Received: from pfod7.prod.google.com ([2002:aa7:8687:0:b0:736:38af:afeb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1744:b0:224:249f:9723
 with SMTP id d9443c01a7336-22c536204c8mr9101135ad.51.1744931305689; Thu, 17
 Apr 2025 16:08:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:36 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-16-irogers@google.com>
Subject: [PATCH v4 15/19] perf build: Remove unused defines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

DISASM_FOUR_ARGS_SIGNATURE and DISASM_INIT_STYLED were used with
libbfd support. Remove now that libbfd support is removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3ed047ffb4f5..bb4d31b1e1df 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -320,9 +320,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
@@ -349,7 +346,7 @@ endif
 
 ifeq ($(FEATURES_DUMP),)
 # We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# As we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -1006,14 +1003,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
-ifeq ($(feature-disassembler-four-args), 1)
-    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-endif
-
-ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
-endif
-
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
@@ -1288,6 +1277,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.49.0.805.g082f7c87e0-goog

