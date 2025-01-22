Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44D21ADA9
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567828; cv=none; b=VAtf/RNkhCMFyqvih3W4b1i3bWtRe17613zba6SNAlWksl2uoVkWQyFRoTdr64Tg/hJr+L8bGAPiRoO3PIZxy2f5HqhMfKZOOqcFwe1FsQSBBov8PCNyJ0RYKbPUTa7p9FCP3Ut+BPsjyNHMY1ajobA+HVcd7NzAzd77neajbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567828; c=relaxed/simple;
	bh=9GHPNHyvRxxMxBGIIob8u2neND2k/95QMi/45gOynCo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EqtdAwX896Ng5bTxRGIalNwWqy+YW+i3KC7eL9v5ltANqKSe4lJJp/t0gqq3xx0CIlyGEDK+OkdMCreIXFmklhFh+oullndqKHaQpUszUMlgG/gX8PhYgoyBxf9hVbIAW6VkC0KrOTmfd19Cq7gQX/LR9TiixoB45FtyXX6hfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgY3Yvnc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgY3Yvnc"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e48beea5778so17574642276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567826; x=1738172626; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKH3yiTdGj08fSShzNsREAUyrrSH2fL/PhPrqngZihY=;
        b=mgY3YvncBGUZC5O+sw41ruzcDUEbmheiaHRXN6rYBs9irV7oqdc795NEAHw3lNnyTF
         QKu67URIZ7obZHIkJCFrhuT9PbJBHYV5A+5t8EyLrpqvEUFUjiEtvOvos0pV5HTYnrKv
         WUB6b4v62JnUxXg1auxfmbauhgUu+MuieHM0LVRCysy4X7xsh7yNkVt94jIlQvvIww74
         rxDkqGD7a99D89ZycUgF8fpYU+dIEDLJDll9YzPHCLvZigZYUFJQ6ZD268T/TCQ5KUlu
         ZMncigLLakebvv1xicwMt5rDxqtg77R/O+GnZgLK5TNs2431vAb/oGGWNLJ7bllpHHwc
         oCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567826; x=1738172626;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKH3yiTdGj08fSShzNsREAUyrrSH2fL/PhPrqngZihY=;
        b=edDEZDnmGJOcC2YwhxUe3aWInAXHctRdmXS4wvfRcdcjnHw73pe2Uvw+kIPBGWuaZt
         9JW9NfPZtURIf5PSj3bX4OUgShmsamBFjxX4z1PRVWuiHWjbtNrifVk+/OGfNM7SRZ1P
         QtW4YeKGCdFhxbxiuBpKxS6TXUj444ZyVXfNWDc+YEcbPum0LZf/mLG1uDSUgB79eS5h
         Zo7hDbmdYV/EFoYBEjxS7JpjrbXCI5o3RQdtso7ZDcq2PBrAe5+XgNusAG1ip5Ct8U7r
         WH6CJeBk8LdRMLLDoFoPDQN61JY3dg7GCt42MWX0JmgA0qsMZXHlFBb/h5RHXixtW4wg
         /p0g==
X-Forwarded-Encrypted: i=1; AJvYcCVxkfDRas67cn7Sv3bg/tWgkDeHpIIV8PbvxTasJhJLKfW7DEwau7GCeI35ZCgcAr/1Nr5R4k35gv8rFiNpsrlO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv15r2xuDbtY+RlhJVaoQ979xW4jZJSwRQrGkWjbI5x2u3QAxo
	OWnFCXHcFAirmOTU8n4RV6AqwiYL9Npn+sjZuQgbaxQ9tOYRNM8V/HgQyTvZLdNacek5fNxN7qv
	yecOF5g==
X-Google-Smtp-Source: AGHT+IGkgldheuVJupTzX6Fn2FVkqpNrVggcg4lpMEETVTUUw5th46LrdjZLruG7yN68AX8sRQNCtrYz2Dr0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:61c5:b0:6f3:d334:b7e5 with SMTP
 id 00721157ae682-6f6eb92efbfmr570387b3.5.1737567826016; Wed, 22 Jan 2025
 09:43:46 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:05 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 15/18] perf build: Remove unused defines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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
index 513dd5cab605..ba60a5b47be7 100644
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
@@ -1001,14 +998,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
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
@@ -1286,6 +1275,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.48.1.262.g85cc9f2d1e-goog

