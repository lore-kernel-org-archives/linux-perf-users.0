Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BD156C62
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303573; cv=none; b=ngGYkXkHqB6xobB4F+VhTSc4Prtf+OUGt3jEK3sL7UD285aiEmiPtwisbpPJgEznoUC4xHAr60zS26KYEYOWJenK1J0Z7LiqB5StzTcGEnEClN+3doUmNe4ocUjRmO76LCxp54Aq4CP5HNqm/+9ZDpKrlt4eOYqPACAcRDyyw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303573; c=relaxed/simple;
	bh=/ONs+RfIi9pLA0kZMRaJefFpcB8Apxh4eLPjFTsRe2k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rLYTkRCA0aOzq9Hu/gcI55ADhj4Vn8NYySQ/LY8enuNgEYV2CD37OZ88BjI13n4syLwrBNLX6yYwL+HEFND/6pGWwOGin7N7m3cLgCqlwMEspJuuqOYqCUL/E/NGdLMJphgM4t6LGou3ofWwJ7ZH5gDTaR3iK+aWllNfH4axYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEO2CNJA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEO2CNJA"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfdfe3d9fc8so2458401276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718303571; x=1718908371; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+L2y8W9nebELrh4jjwhLDqIvkQwPnsfqcpkdzoDYes=;
        b=hEO2CNJAvcrlwDrlDCWdHdQlJpSR6QLZZeIrYGoKOAoOVxz8KDLFnx9ctYVko3Gman
         NNgP4L8MztFV3ElCGGLcg7wj6twQ1MCORgUVT+4FTjKrtRYX1g6v+e7eTQoVbZQGcvOw
         5aoOd/Lv3zWENB3Ctu/k3D40tbO/jRYIX+fsZf3HzoiSBk4CTDBUHeGnS+VVsDhQohm7
         x3dYo/eM+wTHm0M7J5A4hTq08I8Nt5lNanQwX1MTdvgdXlTlztrq4BFUcvYkgNyEs3mE
         nw8Hgh29aitOej1fBpPN+bu811f3wrIORLjEXda9qTjU5QF5ZUzweT38VFgVh9bXUObS
         9UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303571; x=1718908371;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+L2y8W9nebELrh4jjwhLDqIvkQwPnsfqcpkdzoDYes=;
        b=QWWom+WjTietvTpR8FmIaTPqTC3Ve+bUycfPg1epCp4SiNC3yr4RChP97AacuaNaFO
         RyalCejMVtM15YZI5KRIVswyFspgn6oh/OnrJW+naiHYHNdsHjPRvKrpbc5cgq8sSDzM
         TfNf7YW81EpzSgvAL18KM1WUv1m3yJ4IiplJhQWlyGEzdfX+Dfua5ZU3QCYs5JQDbYNL
         cP8qu0rONsP5f6QX8gXDOiNpII4wAxpFzIYkV3hQ1BJ3X5drVZJYMF8mJ/R2bEehPMzc
         0bA/9QjBNBNixXoBKUhUNQ2XS1ucLthJCdc5pXnwNeENZP6dS1QtSoGCI47b/jb89ax9
         7iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUF+zIU01C+IozieTuZwLLiTw80rheAcIc10KIRzMdw2s4xX1AUqZuh4bCxKCBw0Oecj3GQZMcA8OxQfLzn/5kTv/aTfHc7Rw9praXTJlaNg==
X-Gm-Message-State: AOJu0Yz6jxO2K0Pq5AFukmp7fwRcZ2BZRJIi4Df/ha1/nQMCVfUb2iJt
	dM28pAcJqrNRjl/E+S2B/7Aqg0RwgNBmFpedon5rrxXyTFYm8kSoe8mfeq5un7utzvrOzNqAj5R
	bbMK8JQ==
X-Google-Smtp-Source: AGHT+IG80DNm/FDT+O5OUP8JFT4D2XNhLByUqwk2k3UfIObo7dkaLn3FPAjmCygWQ5MUqnfeOwJ1qGBNNewF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b90:b0:dfa:7278:b4c4 with SMTP
 id 3f1490d57ef6-dff1538dae8mr77808276.4.1718303570700; Thu, 13 Jun 2024
 11:32:50 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:32:24 -0700
In-Reply-To: <20240613183224.3399628-1-irogers@google.com>
Message-Id: <20240613183224.3399628-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613183224.3399628-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 8/8] perf python: Clean up build dependencies
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The python build now depends on libraries and doesn't use
python-ext-sources except for the util/python.c dependency. Switch to
just directly depending on that file and util/setup.py. This allows
the removal of python-ext-sources.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.perf           | 10 +-----
 tools/perf/util/python-ext-sources | 53 ------------------------------
 2 files changed, 1 insertion(+), 62 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4a1a9f09fa09..590081384882 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -380,14 +380,6 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
-ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
-else
-  PYTHON_EXT_SRCS := $(shell grep -v ^\#\\\|util/trace-event.c\\\|util/trace-event-parse.c util/python-ext-sources)
-endif
-
-PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
-
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
 
 PROGRAMS += $(OUTPUT)perf
@@ -715,7 +707,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(PERFLIBS)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
 	  $(PYTHON_WORD) util/setup.py \
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
deleted file mode 100644
index 1bec945f4838..000000000000
--- a/tools/perf/util/python-ext-sources
+++ /dev/null
@@ -1,53 +0,0 @@
-#
-# List of files needed by perf python extension
-#
-# Each source file must be placed on its own line so that it can be
-# processed by Makefile and util/setup.py accordingly.
-#
-
-util/python.c
-../lib/ctype.c
-util/cap.c
-util/evlist.c
-util/evsel.c
-util/evsel_fprintf.c
-util/perf_event_attr_fprintf.c
-util/cpumap.c
-util/memswap.c
-util/mmap.c
-util/namespaces.c
-../lib/bitmap.c
-../lib/find_bit.c
-../lib/list_sort.c
-../lib/hweight.c
-../lib/string.c
-../lib/vsprintf.c
-util/thread_map.c
-util/util.c
-util/cgroup.c
-util/parse-branch-options.c
-util/rblist.c
-util/counts.c
-util/print_binary.c
-util/strlist.c
-util/trace-event.c
-util/trace-event-parse.c
-../lib/rbtree.c
-util/string.c
-util/symbol_fprintf.c
-util/units.c
-util/affinity.c
-util/rwsem.c
-util/hashmap.c
-util/perf_regs.c
-util/fncache.c
-util/rlimit.c
-util/perf-regs-arch/perf_regs_aarch64.c
-util/perf-regs-arch/perf_regs_arm.c
-util/perf-regs-arch/perf_regs_csky.c
-util/perf-regs-arch/perf_regs_loongarch.c
-util/perf-regs-arch/perf_regs_mips.c
-util/perf-regs-arch/perf_regs_powerpc.c
-util/perf-regs-arch/perf_regs_riscv.c
-util/perf-regs-arch/perf_regs_s390.c
-util/perf-regs-arch/perf_regs_x86.c
-- 
2.45.2.627.g7a2c4fd464-goog

