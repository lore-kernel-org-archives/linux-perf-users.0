Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6A17C7B8
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340970; cv=none; b=epHcquNOZVYdJZB3zZ7oe7mhj09kUf+gom0jEAzSaVEC6a8c6no81OIOoLsMqaXv0P3c1bMqJd+idlvh0QEKuSwhHxatsY2HwLOgtGcyKS6nYouO9KNAzwfA7IGayeT3u75y7JKrqRDlPSCVrYedxGNK5V4azWJyidskVW30px8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340970; c=relaxed/simple;
	bh=3L4VCPu5Gi0E3loQZRfPWXHSalpI7X3sqJEW5i53YJ0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pxszntPmETtwDKT2jPnCTUdee7VhyBSRM2QTnso+RRCJmP6gzyfzHTHrN896PhE+IJJ6VwuXHqMq3qE/fDT6ZF08TkYOeLRuimaDjc1peqY/XCtkiUW7nH48gWqfGfD9f37VCRh4rXge07YmCFN6xRrninm6yP3BDKuArPJRNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8mGwibu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8mGwibu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfe71fc2ab1so13417913276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719340967; x=1719945767; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5WhEzrAKR6etY4+8+J3I2144onDLe33a/pW/pB3BVA=;
        b=q8mGwibuW8iWsMKlvrXpfpjeM0MKVNYTH+6Se3SvqH0tC7qKEjcjbLXQyzMI8o/l4F
         40NXPt9tb0djKakV6qxx2l8DNJ3tJlteKQxnKOJznXRKURkTil6S8+yFYENNVeC7Vly9
         GYk535HU1t+M9tVh9qXahQbvTeIvsX57aA8CpauxqaEqVWoYFYrcVZ+z22KDpsA7+z3X
         ndmG+fpYcI6df5JrK1CAP+LrEu20h6QB3PR7TtasLzuC3At6+G8dd5sGpWfQD0J61fj7
         IKfVmqg916COVbHoAAjNtXHyKnOKr3umMIEj4v3DTVDnbqD7zMRe8CMPg5GEGkb6owuZ
         y1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340967; x=1719945767;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5WhEzrAKR6etY4+8+J3I2144onDLe33a/pW/pB3BVA=;
        b=PeEx2AyVFALIU1ij1lzoxlWVO25V6tS+w5XtEg4J9qv8XZuzbieX+Ek+D/n8/drsYe
         UlwLjr21Ic758R4VnFfRf0vLNZrXOfsoyukW2tKEuRv80BhObHa1BNJlU3e3VK6zltlJ
         exqO6ilU/ZVru2lnv5X7HiDnfCAM3+cQWZ/JhVd5y8sKF4mwo5wfiXAopUlxB52jjZz4
         Kw2zIlk4wVq/GbxUe3FRMf4tHmEiiKtlpoDYlbadEux8T+P2HIhRJuHPvjF73/Z50wAn
         tSeH2wgohny8Qx548D9J5g9ZHdZe9VhxjUhkKi9nuAwVgTjC6hQ8GsOR1N2UbX68H6f7
         KLfA==
X-Forwarded-Encrypted: i=1; AJvYcCW6fAy5rBb6rbFdNWGXxLRPj9hHbv7wpXjT7REYbZyEXWFiKFzcqp3zeTH2xsjBTH9jv0W2A1yEgR6ggZieYDIRaaTrePdKw113Tr4S5cRkMQ==
X-Gm-Message-State: AOJu0Yz83FNPokWK4rrOQhmgVbM+BEruALN8Awgaiefa51ghJ3kGQ/6Z
	e1oGerGkV5kvr9/itZI9jC9oNsvasRi3geHoB7QKaUtomzdvSRMA7Aw1Z30AxLD0T/Lu3HER8iB
	ttoBjtQ==
X-Google-Smtp-Source: AGHT+IHFfDudTcZpYBJ7DaBhhH5rSWVcGGVlqxAdq4qgt3qZon/zWZ6TMzj+Mka5n/0q6UdKITjOTlDeHHoG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:188a:b0:e02:b7b3:94c4 with SMTP
 id 3f1490d57ef6-e0303ecc8f1mr355061276.3.1719340967268; Tue, 25 Jun 2024
 11:42:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:42:24 -0700
In-Reply-To: <20240625184224.929018-1-irogers@google.com>
Message-Id: <20240625184224.929018-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625184224.929018-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v4 7/7] perf python: Switch module to linking libraries from
 building source
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

setup.py was building most perf sources causing setup.py to mimic the
Makefile logic as well as flex/bison code to be stubbed out, due to
complexity building. By using libraries fewer functions are stubbed
out, the build is faster and the Makefile logic is reused which should
simplify updating. The libraries are passed through LDFLAGS to avoid
complexity in python.

Force the -fPIC flag for libbpf.a to ensure it is suitable for linking
into the perf python module.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.config |   5 +
 tools/perf/Makefile.perf   |   6 +-
 tools/perf/util/python.c   | 274 +++++++++++++------------------------
 tools/perf/util/setup.py   |  33 +----
 4 files changed, 110 insertions(+), 208 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 81f73f68d256..5271a4c1d2b3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -908,6 +908,11 @@ else
          endif
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
+         ifeq ($(filter -fPIC,$(CFLAGS)),)
+           # Building a shared library requires position independent code.
+           CFLAGS += -fPIC
+           CXXFLAGS += -fPIC
+         endif
       endif
     endif
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ff03f0431013..4a1a9f09fa09 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -715,9 +715,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(PERFLIBS)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
-        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
+        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
@@ -933,7 +933,7 @@ $(LIBAPI)-clean:
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
-		$@ install_headers
+		EXTRA_CFLAGS="-fPIC" $@ install_headers
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 88f98f2772fb..3be882b2e845 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,22 +10,19 @@
 #endif
 #include <perf/mmap.h>
 #include "evlist.h"
-#include "callchain.h"
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "stat.h"
-#include "metricgroup.h"
 #include "util/bpf-filter.h"
 #include "util/env.h"
-#include "util/pmu.h"
-#include "util/pmus.h"
-#include "util/symbol_conf.h"
+#include "util/kvm-stat.h"
+#include "util/kwork.h"
+#include "util/lock-contention.h"
 #include <internal/lib.h>
-#include "util.h"
+#include "../builtin.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -51,168 +48,6 @@
 #define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
 #endif
 
-struct symbol_conf symbol_conf;
-
-/*
- * Avoid bringing in event parsing.
- */
-int parse_event(struct evlist *evlist __maybe_unused, const char *str __maybe_unused)
-{
-	return 0;
-}
-
-/*
- * Provide these two so that we don't have to link against callchain.c and
- * start dragging hist.c, etc.
- */
-struct callchain_param callchain_param;
-
-int parse_callchain_record(const char *arg __maybe_unused,
-			   struct callchain_param *param __maybe_unused)
-{
-	return 0;
-}
-
-/*
- * Add these not to drag util/env.c
- */
-struct perf_env perf_env;
-
-const char *perf_env__cpuid(struct perf_env *env __maybe_unused)
-{
-	return NULL;
-}
-
-// This one is a bit easier, wouldn't drag too much, but leave it as a stub we need it here
-const char *perf_env__arch(struct perf_env *env __maybe_unused)
-{
-	return NULL;
-}
-
-/*
- * These ones are needed not to drag the PMU bandwagon, jevents generated
- * pmu_sys_event_tables, etc and evsel__find_pmu() is used so far just for
- * doing per PMU perf_event_attr.exclude_guest handling, not really needed, so
- * far, for the perf python binding known usecases, revisit if this become
- * necessary.
- */
-struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
-{
-	return NULL;
-}
-
-int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
-{
-	return EOF;
-}
-
-const char *perf_pmu__name_from_config(struct perf_pmu *pmu __maybe_unused, u64 config __maybe_unused)
-{
-	return NULL;
-}
-
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type __maybe_unused)
-{
-	return NULL;
-}
-
-int perf_pmus__num_core_pmus(void)
-{
-	return 1;
-}
-
-bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
-{
-	return false;
-}
-
-bool perf_pmus__supports_extended_type(void)
-{
-	return false;
-}
-
-/*
- * Add this one here not to drag util/metricgroup.c
- */
-int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
-				    struct rblist *new_metric_events,
-				    struct rblist *old_metric_events)
-{
-	return 0;
-}
-
-/*
- * Add this one here not to drag util/trace-event-info.c
- */
-char *tracepoint_id_to_name(u64 config)
-{
-	return NULL;
-}
-
-/*
- * XXX: All these evsel destructors need some better mechanism, like a linked
- * list of destructors registered when the relevant code indeed is used instead
- * of having more and more calls in perf_evsel__delete(). -- acme
- *
- * For now, add some more:
- *
- * Not to drag the BPF bandwagon...
- */
-void bpf_counter__destroy(struct evsel *evsel);
-int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
-int bpf_counter__disable(struct evsel *evsel);
-
-void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
-{
-}
-
-int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu __maybe_unused, int fd __maybe_unused)
-{
-	return 0;
-}
-
-int bpf_counter__disable(struct evsel *evsel __maybe_unused)
-{
-	return 0;
-}
-
-// not to drag util/bpf-filter.c
-#ifdef HAVE_BPF_SKEL
-int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
-{
-	return 0;
-}
-
-int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
-{
-	return 0;
-}
-#endif
-
-/*
- * Support debug printing even though util/debug.c is not linked.  That means
- * implementing 'verbose' and 'eprintf'.
- */
-int verbose;
-int debug_kmaps;
-int debug_peo_args;
-
-int eprintf(int level, int var, const char *fmt, ...);
-
-int eprintf(int level, int var, const char *fmt, ...)
-{
-	va_list args;
-	int ret = 0;
-
-	if (var >= level) {
-		va_start(args, fmt);
-		ret = vfprintf(stderr, fmt, args);
-		va_end(args);
-	}
-
-	return ret;
-}
-
 /* Define PyVarObject_HEAD_INIT for python 2.5 */
 #ifndef PyVarObject_HEAD_INIT
 # define PyVarObject_HEAD_INIT(type, size) PyObject_HEAD_INIT(type) size,
@@ -1513,15 +1348,102 @@ PyMODINIT_FUNC PyInit_perf(void)
 #endif
 }
 
-/*
- * Dummy, to avoid dragging all the test_attr infrastructure in the python
- * binding.
- */
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
-                     int fd, int group_fd, unsigned long flags)
+
+/* The following are stubs to avoid dragging in builtin-* objects. */
+/* TODO: move the code out of the builtin-* file into util. */
+
+unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
+
+bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
+	return false;
+}
+
+bool kvm_exit_event(struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+bool exit_event_begin(struct evsel *evsel __maybe_unused,
+		      struct perf_sample *sample  __maybe_unused,
+		      struct event_key *key  __maybe_unused)
+{
+	return false;
+}
+
+bool exit_event_end(struct evsel *evsel __maybe_unused,
+		    struct perf_sample *sample __maybe_unused,
+		    struct event_key *key __maybe_unused)
+{
+	return false;
+}
+
+void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
+			   struct event_key *key __maybe_unused,
+			   char *decode __maybe_unused)
+{
+}
+
+int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
+		int num  __maybe_unused, int pathlen __maybe_unused)
+{
+	return -1;
+}
+
+void perf_stat__set_no_csv_summary(int set __maybe_unused)
+{
+}
+
+void perf_stat__set_big_num(int set __maybe_unused)
+{
+}
+
+int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
+{
+	return -1;
+}
+
+arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
+{
+	return NULL;
+}
+
+struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
+				       struct kwork_class *class __maybe_unused,
+				       struct kwork_work *key  __maybe_unused)
+{
+	return NULL;
+}
+
+void script_fetch_insn(struct perf_sample *sample __maybe_unused,
+		struct thread *thread __maybe_unused,
+		struct machine *machine __maybe_unused)
+{
+}
+
+int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
+			size_t sz __maybe_unused)
+{
+	return -1;
+}
+
+bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
+{
+	return false;
+}
+
+struct lock_stat *lock_stat_find(u64 addr __maybe_unused)
+{
+	return NULL;
+}
+
+struct lock_stat *lock_stat_findnew(u64 addr __maybe_unused, const char *name __maybe_unused,
+				int flags __maybe_unused)
+{
+	return NULL;
 }
 
-void evlist__free_stats(struct evlist *evlist)
+int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
 {
+	return -1;
 }
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 3107f5aa8c9a..142e9d447ce7 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -60,7 +60,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc_is_clang:
     cflags += ["-Wno-unused-command-line-argument" ]
 else:
@@ -72,36 +72,11 @@ cflags += [ "-Wno-declaration-after-statement" ]
 src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
-libtraceevent = getenv('LIBTRACEEVENT')
-libapikfs = getenv('LIBAPI')
-libperf = getenv('LIBPERF')
-
-ext_sources = [f.strip() for f in open('util/python-ext-sources')
-				if len(f.strip()) > 0 and f[0] != '#']
-
-extra_libraries = []
-
-if '-DHAVE_LIBTRACEEVENT' in cflags:
-    extra_libraries += [ 'traceevent' ]
-else:
-    ext_sources.remove('util/trace-event.c')
-    ext_sources.remove('util/trace-event-parse.c')
-
-# use full paths with source files
-ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
-
-if '-DHAVE_LIBNUMA_SUPPORT' in cflags:
-    extra_libraries += [ 'numa' ]
-if '-DHAVE_LIBCAP_SUPPORT' in cflags:
-    extra_libraries += [ 'cap' ]
 
 perf = Extension('perf',
-		  sources = ext_sources,
-		  include_dirs = ['util/include'],
-		  libraries = extra_libraries,
-		  extra_compile_args = cflags,
-		  extra_objects = [ x for x in [libtraceevent, libapikfs, libperf]
-                                    if x is not None],
+                 sources = [ src_perf + '/util/python.c' ],
+		         include_dirs = ['util/include'],
+		         extra_compile_args = cflags,
                  )
 
 setup(name='perf',
-- 
2.45.2.741.gdbec12cfda-goog

