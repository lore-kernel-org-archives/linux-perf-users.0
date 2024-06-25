Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14017E45D
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351701; cv=none; b=nbVkBJ1sSa5IrbwBZVlRxveO/rCI8IUdmcl/hEceD5Hspa23OKuQ5w9yGklrlGSmRI59T1Bpy6F3mUXvRe01ezZmX1Et+QhMb0wJqJxWrDF4JjabgEVrr3hyWGrDV11pBRu767imLVVP76UU2ZjEnB66BqiQpQVx4197juj7nEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351701; c=relaxed/simple;
	bh=CETWFSp62XKm8QsosO88QfPlj5Apj8qlAZlMiQJxdG8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fXHEiFmGp+iiCc0+5U9eCvPZU/LQj1wn04XLHcnvK3wfYbl1OTE+jf63ZIBr1cIIV19X5kQ59yygdQDiK88szgjXgaucHWOmUoB1S1YxuW8VTgL9cYONX0RFRmCvzKW8pcQRH1G36auPQLeOsKRO6FrOIAy42iH7g07elImzWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3RW6/TX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3RW6/TX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bab20b9f4so109579227b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351699; x=1719956499; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNiHPl//Lsoc2p9Fy12YXW9IZoRAXfYV1fymis0TYVQ=;
        b=p3RW6/TXOOIARDXQ8GBokjGqF/bi3WptCHEnzNgRd0tDZjW2TDRynJ9+kCeYJjAXVZ
         WGOml0P211ZCtWHW/dOA+6pMX9/BsyDIKsZriSuDc13qyuFjp23vtlhXQqM7KM4iDoJ2
         tcmvEsRAC4JJzlvHIRrGQkuvtZnu23nm+F9pT3igaHz6pTaVEWc1vg4kCgzSxYUaRSXC
         otmdTy4IznIVr9IEPnAcjZg+AgpVaSaq7wAeg0GcuPAlHucaprd+4mYcRKBhulMgzo5B
         2r3bGZ+ie49FtpmG0WAcdtqMV2WvXoFuB6aIcZEU6xeib9HJ3lhiChZMDQ9AZuvL+T/m
         2/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351699; x=1719956499;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNiHPl//Lsoc2p9Fy12YXW9IZoRAXfYV1fymis0TYVQ=;
        b=etTl6dYBKMGNCM1HwkSsgW1mwdnlZzo4/EZa4B5YgnLKo96lwDllzlgQ1KvVjMq8m2
         aVnA8RwnYWFYAufQKI5sAeN/nIasvghnXBEsEi260MSWRNsCBEK03ck5W2dYlQPKJvjy
         g9zox2a7IwwLL5qub7hEIROYpg1yMqa96jZNwcqMwlllV973Hn5wsi7Lvd5hxA8ksf7A
         UPZGFxkajqeRFrMXbsXXkWhrXBR/T6WoRd+zVJUR0BLuRXo/7TnrHJMeRUbvnsBM7jjB
         xQ/uBhKQraN9L3S2GDJOpcztuevxq3vBlvCljicDONSAVzmDrV/jZRWNdTbbL3ScXqa+
         UPzA==
X-Forwarded-Encrypted: i=1; AJvYcCXEHQ4rWkZlCxVPpiCNBF4IQKodEjOTPcloCV6/0MrL/B3QV0+bsUYiBmOcND5Q6zSr0+KZ+SaZaU/60b8Ie7YSPazEA8H5UZKAcAKsfXixzg==
X-Gm-Message-State: AOJu0Yz3QbXHOpGCv54L/AkwkkGxr5QDLoannfvEHO5AUFPEDJIQbdW5
	JbDVy2w5bbYke4pGqjR7a03dkni9SJQ0Qncg2y21aQYiLSEu6M6pl2GtS9sWVROJb2iVwoo1LsU
	6Ca1dCA==
X-Google-Smtp-Source: AGHT+IFf6QjCAadJ64QWN4oknaimKg8PZx1SVSDc+jL/zM435Qhp/FAtzNAZRfPH43WJkSqiC7EzuQKOhPB7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:e1e:b0:62f:f535:f41 with SMTP id
 00721157ae682-643ae731fb3mr2924307b3.9.1719351699321; Tue, 25 Jun 2024
 14:41:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:17 -0700
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
Message-Id: <20240625214117.953777-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625214117.953777-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 8/8] perf python: Clean up build dependencies
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
	Nick Terrell <terrelln@fb.com>, Andrei Vagin <avagin@google.com>, Kees Cook <keescook@chromium.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.45.2.741.gdbec12cfda-goog

