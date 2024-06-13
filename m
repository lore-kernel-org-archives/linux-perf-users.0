Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD5156F36
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321520; cv=none; b=XDfxcMvSGlJDnFmVeX5t0/x8KgCCiKkjFo+w5QfpWxuJ64MOXnYaTKJfVXN51wwOmyPRJEBVytDO/lcsZFVuhPuQtziRy9H7+lDxjVoftqZGcVjMqXoR4A+WpQ/025iGYcHrg8B9scMILbVlXiMcm1WiRrbjpFpi0aNj4RYE22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321520; c=relaxed/simple;
	bh=/ONs+RfIi9pLA0kZMRaJefFpcB8Apxh4eLPjFTsRe2k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WYIsJzymNjfxQsGO1qwxwnR4BE33yhRhugAiVGmrHjdaGYFhBRp7jxFZQpvsu1MTHCyt51mnITravOE2riiEAv7kWbI8dLrmhuE2/aJ60FU9jHCKp+P98OVXALtoCHPsAgzIk8cP2wIBd0l+39fsNx8BPyNZf1g6vedn+5+9UZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJjVVOL1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJjVVOL1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfe4d67ed8eso2447475276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321518; x=1718926318; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+L2y8W9nebELrh4jjwhLDqIvkQwPnsfqcpkdzoDYes=;
        b=LJjVVOL1W7z8ariv5eRv9Oc6qcqSdVDidnv8bkp3K2wOzpZfTOLJVFmBqT9PRObT5z
         QXlNHk7ECb3QA/P9QyevKRSD21n8+RB3q6fRoW15Lni86MpU+MZcFOLOoZjxffImjaO5
         LQyc/rILhpO3s/RwLj7aDZON71WIc9/bk91gebnxiO3kVRsJxQxUZ2zWUWR245RQtKbi
         qloZLDGq8vM9znddDkZiZia6VXCYlfD5tbAMhRTOUcDYUtgnvaKQBRof5aTfZZkuqZfp
         FfQRTUvRtoFKHpFQKXXNSoNonGdt8SO23oMIG7a17eYQDp5Y3zbDOEdnrCE1ARzR9pAx
         aH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321518; x=1718926318;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+L2y8W9nebELrh4jjwhLDqIvkQwPnsfqcpkdzoDYes=;
        b=bYEAHmVMeK1s+U0MdQkv53HiekcICM/TVPjS0y4BHVCCxMomleJSzo2sSgybz0EN2I
         gL6xD6Luad83rx3Ycm/UHuqnAnbmKTkOrEjbVvLCdF75vgiRmuMGM72iwjAtJH/Ui/i+
         R4va4b/UI1hYUC2CQ1hWhCujUCB8QCzKiFQkMMHADuAea3ByWyXvLgYts0tD/UujPq0X
         TggB3MvV50Px6U9A/Lv7tB71RvJmqwKRmBcIOO2rz5n/sdjTn7tY/pt1omzaQtqFsoR7
         tbAKBgTslxXH3QKTTNVzftYABxU8oblGOuCW3/DSuN0oR2W4Kem8mUsp57AvvHpm3Gpw
         Il0w==
X-Forwarded-Encrypted: i=1; AJvYcCV7QvlQTnbbemvbqFBaYdhAizD2vyj9gNxelVgvyOcyWs/qfJxUohHhwFQHbI3+Es2dnl4sH94/rECPnDHSZPF8Q5yoDdTmjf2wt8N8BTH2sg==
X-Gm-Message-State: AOJu0YyKk++qVtfRa46wjPrdRhMsXSI5PRk1PlUKqw04s4T/lN/MDLJ8
	LTl4DserxSMcWMOaSwuRxvqhcj+BCUcYRKT6/2Im6ej0oO3SDnYKupdPn6Qg8XOon6ORuwK/eE9
	dAnxgig==
X-Google-Smtp-Source: AGHT+IEPh6V7sGbFHR3+mSLnMHVnCNCyXK9wRdgNwAVEtM+jm7kOCyEDIINjZOrKiPFf8Nvnv9P0x6gU6Ikz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:1204:b0:dfa:ff27:db1 with SMTP id
 3f1490d57ef6-dff15412181mr135767276.4.1718321517470; Thu, 13 Jun 2024
 16:31:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:22 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 8/8] perf python: Clean up build dependencies
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

