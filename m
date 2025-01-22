Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D11C5F14
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527156; cv=none; b=dwdevmgsoVhRcQn5jBEZeDzNNMiJWTfH7jmQ7pLv3hKJTEMeh4dx5aVObn+9e9Q1hYaq/qc2xLOT8RKVB+MRTcFlzHm2vofu11fRAVHvHswRV9NY11UbUKtW1irCZEttoJMikvRR/SvstGdiKLfz9Ten6m7ZXOBVFVAIaIs0Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527156; c=relaxed/simple;
	bh=YkWOp6sBnU9ELov42ERsPm7Vngu6X+NP4toNn4LW5Oc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HEPERRBjcr5AYzodrS5E4w+d4ACNoaEnpb5wxp9X88H/xniWLNqqR3E+rOPhws04hjnIxg7CyngX1HBa28QOr5mqn3OcRS/VSpUq8e2dHk1iw7w9FGgiHhMFrntFsoIB3ngl3RUKMw8g0lJsko80/DFgNuLe0Rd0JkINFbO6e/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyUb5EqX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyUb5EqX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e549e7072fbso13596536276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527153; x=1738131953; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9hPyZ1Eqh7FkhnlmqyYPUb6W8XykQq6Ozx0wTDbMtQ=;
        b=AyUb5EqXwM+HhTGIaPtl/e5ly715nkUGyRXd9pppHJAMVbeKJIDzLphhXccre/gT45
         mhLbEkkiQEVrW0Mp7F7g/wSsHFn0FZYcb32g4bqxSwyJG0vaOMPLC2tlmtZhxQdyIG6a
         s3E3wCIcD1/QxKkAEPW8uLQ7evlJMj5GKkg/cG9srdSdgNO4+SZkea5qFg1ZmojRlxR8
         7Gja07D3t/WbPNM94nL6LUr7tTYjGLbexHb0Pkr067GdXXu0aGimWn0jBsny1F0qjENa
         lqJBkHGB0FFIB2sqgExZPH7FitiqJe1jjs8VQSvQtD5RABZO8ZCGwQT9ycwNUfDckXBU
         RQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527153; x=1738131953;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9hPyZ1Eqh7FkhnlmqyYPUb6W8XykQq6Ozx0wTDbMtQ=;
        b=E8wSSfHfD0OktkpgJnXbzZRW1rvf+y2wEnS3TIniBWSELsuc8KeATJcm0xdPkl28RF
         o4mLuyC7yNMsSxiU2VQm+7ykCIySwf7aIZaHb1gMYbvSTtnqoh0td8esr7b8O8ZiNzuF
         21I3tXupnYVaYmAkK+LZetVT7naDl1riOjl00vjtM+Z5aiWXadPFr/Kym6sS5qYYMDZ8
         s2t61ryF9FWmTVFAnN8NdNKesDvRv7JxtwWyunA6Ol07gdupb58ZreEyxvDy344uN7e8
         mQITj5Xb6kcibi9/Zh3yLJCtiBECoO7qfgIrJ5g9+4yMFuKK0CJfKvgchYVB5TO1Olh5
         XkQg==
X-Forwarded-Encrypted: i=1; AJvYcCVSZp/oDQiM2CTsr17Xye/Ae6XPQ5focYTahdJiLo9JlSI302T05SLgFG2tZnD7ZbntjROL0Q8g4kVMFtjDSE9u@vger.kernel.org
X-Gm-Message-State: AOJu0YxwgDanP1UXMb8YFZop8ekRKavpS47yuLi4hV1LJoFu0jLbInUl
	e95iYJbHVTUyJTyAetS6CGT4uSsU8zOucKo4fvWPTSL3lWCXi0tTH8inpi3NafiAbyr+0esSQe4
	Tf8+pWg==
X-Google-Smtp-Source: AGHT+IENajIP32nGxFM0VFkKXqErBuQpYWc46Ni8szy3vhHn4bDuMStRS5BfINva+xTIFK/Nmc3Oq8aYUx+T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a81:c807:0:b0:6f2:8819:2318 with SMTP id
 00721157ae682-6f6eb93c63emr362427b3.5.1737527153324; Tue, 21 Jan 2025
 22:25:53 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:30 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 15/17] perf build: Remove unused defines
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
2.48.0.rc2.279.g1de40edade-goog

