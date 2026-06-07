Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E02E738C
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780812588; cv=none; b=MfGHWAV60e5cDA4lH2vw6sqJGTTzylQvsHeQXvONYy3Wyi6UqoFQePH6+HJ4aO9UVCNncEv49sUhWoQliExlWQ+2I+dCryezSnhdzVEDDbaoVV5z1oWe4LgcTjF1q/eF9To1Mpf1WzO8oo75Iv19kyNRvlSGP1kgipvtZJbT0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780812588; c=relaxed/simple;
	bh=UT1aZYk/ahmyE9pWo2aKnVHG2fyPvtlSC9gxzeDecGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivRkb33+xu9UzNKQCNlAo0wCXpG38Q8Rg/YXpjW3MunmFdXu9HLc5abUJzVL3raR9tyeMOC1KIPuKId3x/2vICabDcZfsiL86L86qiYOUKeulOZChm2ZDcOyhmGXCslZFZvJVX9tz+IEWp/+CWEfwfpGo01b3TLqPth5Qr6c+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvf9f257; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvf9f257"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304dd917645so3180118eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780812584; x=1781417384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz+nqq3mLoQAoqOt2FftP2jbSSaFGJpJGuBepyTv9jE=;
        b=hvf9f257iZODYb1x7okeeXCA0SxrbUhwL2wUadDS2ex7H/h3cpofgw4gE7C8xwbJqI
         /+kKqC9BelB3Z3h08G/DgwrRnFqgnmrVJkfWuf46Xi2mKiLBO5SXRd5mPvPso59RKbR7
         HHiWCJ6lHW0JoUUKgdext1Zu9hW6hCmejHwuPDAmU2lUlXk1fU0Vaz2DBfjtJSzUEEV8
         ppgSEb19wO+SRF/Id7KDUFxc10Sgh/YXkLFwM4Va9Hy3bOgG9ZQK1yy61IN9w7w0IhZ+
         gWz88jGF3Cz5BV3aDHUg2NkwylU/8CJmVEFdL4NmLOY6lrQaJeSzuEYIecURmh8CfdBV
         Zyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780812584; x=1781417384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz+nqq3mLoQAoqOt2FftP2jbSSaFGJpJGuBepyTv9jE=;
        b=SQsvWkQKQ8Q0o8S7IwwxCNbHc96vhucdjacXnL5km5Pate+sC3uXq6QuyerozPGzpT
         ZCh9HsPik84vvM9qTZsMuUsuUhEmZuLZktnhbLh+nHK/HQN8nX0e46M8qFrQi5CMqEUF
         QPSnnFn/ucd4wXSaLs1kvspdGOpJI6zJNTPaDyiuRRJXmbEQgElnih5x+kip/7r4vMUc
         fY51nLpDOJtDR0JWOtu1+vFD0CFcjrtRtyTbgOF+4eX4ueQPwXN3JD5zJ2+aD+SjlXhM
         Ztl59phq/CZCJZUT1U/aOtozap6Pi72pOfU0YvTBoR2vPIkKmROQupbGFXbn1S5TYA+m
         LgbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OnS7P2In1phHSreHDzW+UOOp22wYeiDYtA+h4hceVO9tKccHGeQONoDAm2trnAG4RjU/T5XdlrtoMtmRpYmCB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4O+u+d6fZSJnWQ7SvmN3Mo+W88zqz1FNwVYu2sEOlVVINv6/0
	sEs1WdAiBR7D4+4OFyLpY8z2hk74Kaef/RzCq4QrOYwyP0v3bAqITF65XHvhv1H6rfdqb0jfSWb
	aPKEbsMoa4A==
X-Received: from dybqg7.prod.google.com ([2002:a05:7301:6207:b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5b88:b0:304:bce8:fa30
 with SMTP id 5a478bee46e88-3077af0e978mr5579313eec.5.1780812583737; Sat, 06
 Jun 2026 23:09:43 -0700 (PDT)
Date: Sat,  6 Jun 2026 23:09:30 -0700
In-Reply-To: <20260607060933.3274263-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260606151451.2913860-1-irogers@google.com> <20260607060933.3274263-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260607060933.3274263-3-irogers@google.com>
Subject: [PATCH v17 2/5] perf inject/aslr: Add ASLR tool infrastructure and
 MMAP tracking
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

If perf.data files are taken from one machine to another they may
leak virtual addresses and so weaken ASLR on the machine they are
coming from. Add an aslr option for perf inject that remaps all
virtual addresses, or drops data/events, so that the virtual address
information isn't leaked.

This patch introduces the core ASLR remapping tool infrastructure and
implements remapping/tracking for metadata events (MMAP, MMAP2, COMM,
FORK, EXIT, KSYMBOL, TEXT_POKE). Sample events are delegated without
remapping for now.

Signed-off-by: Ian Rogers <irogers@google.com>
Co-developed-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Gabriel Marin <gmx@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/builtin-inject.c |  29 +-
 tools/perf/util/Build       |   1 +
 tools/perf/util/aslr.c      | 822 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/aslr.h      |  41 ++
 4 files changed, 891 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 75ffe31d03fe..6cc9c6dbf608 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -8,6 +8,7 @@
  */
 #include "builtin.h"
 
+#include "util/aslr.h"
 #include "util/color.h"
 #include "util/dso.h"
 #include "util/vdso.h"
@@ -24,6 +25,7 @@
 #include "util/string2.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
+#include "util/pmus.h"
 #include "util/thread.h"
 #include "util/namespaces.h"
 #include "util/unwind.h"
@@ -124,6 +126,7 @@ struct perf_inject {
 	bool			in_place_update_dry_run;
 	bool			copy_kcore_dir;
 	bool			convert_callchain;
+	bool			aslr;
 	const char		*input_name;
 	struct perf_data	output;
 	u64			bytes_written;
@@ -276,6 +279,8 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 
 	attr.size = sizeof(struct perf_event_attr);
 	attr.sample_type &= ~PERF_SAMPLE_AUX;
+	if (inject->aslr)
+		aslr_tool__strip_attr_event(event, pevlist);
 
 	if (inject->itrace_synth_opts.add_last_branch) {
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
@@ -2594,7 +2599,6 @@ static int __cmd_inject(struct perf_inject *inject)
 				evsel->core.attr.exclude_callchain_user = 0;
 			}
 		}
-
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
 		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc,
@@ -2704,6 +2708,8 @@ int cmd_inject(int argc, const char **argv)
 			     unwind__option),
 		OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callchain,
 			    "Generate callchains using DWARF and drop register/stack data"),
+		OPT_BOOLEAN(0, "aslr", &inject.aslr,
+			    "Remap virtual memory addresses similar to ASLR"),
 		OPT_END()
 	};
 	const char * const inject_usage[] = {
@@ -2711,6 +2717,7 @@ int cmd_inject(int argc, const char **argv)
 		NULL
 	};
 	bool ordered_events;
+	struct perf_tool *tool = &inject.tool;
 
 	if (!inject.itrace_synth_opts.set) {
 		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
@@ -2731,6 +2738,11 @@ int cmd_inject(int argc, const char **argv)
 	if (argc)
 		usage_with_options(inject_usage, options);
 
+	if (inject.aslr && inject.convert_callchain) {
+		pr_err("Error: --aslr and --convert-callchain are mutually exclusive features.\n");
+		return -EINVAL;
+	}
+
 	if (inject.strip && !inject.itrace_synth_opts.set) {
 		pr_err("--strip option requires --itrace option\n");
 		return -1;
@@ -2824,12 +2836,21 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
-	inject.session = __perf_session__new(&data, &inject.tool,
+	if (inject.aslr) {
+		tool = aslr_tool__new(&inject.tool);
+		if (!tool) {
+			ret = -ENOMEM;
+			goto out_close_output;
+		}
+	}
+	inject.session = __perf_session__new(&data, tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe,
 					     /*host_env=*/NULL);
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
+		if (inject.aslr)
+			aslr_tool__delete(tool);
 		goto out_close_output;
 	}
 
@@ -2922,6 +2943,8 @@ int cmd_inject(int argc, const char **argv)
 		goto out_delete;
 
 	ret = __cmd_inject(&inject);
+	if (inject.aslr)
+		aslr_tool__strip_evlist(tool, inject.session->evlist);
 
 	guest_session__exit(&inject.guest_session);
 
@@ -2929,6 +2952,8 @@ int cmd_inject(int argc, const char **argv)
 	strlist__delete(inject.known_build_ids);
 	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
+	if (inject.aslr)
+		aslr_tool__delete(tool);
 out_close_output:
 	if (!inject.in_place_update)
 		perf_data__close(&inject.output);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4bbc78b1f741..19994e026ae5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -6,6 +6,7 @@ perf-util-y += arm64-frame-pointer-unwind-support.o
 perf-util-y += addr2line.o
 perf-util-y += addr_location.o
 perf-util-y += annotate.o
+perf-util-y += aslr.o
 perf-util-y += blake2s.o
 perf-util-y += block-info.o
 perf-util-y += block-range.o
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
new file mode 100644
index 000000000000..2c5fafbe5d84
--- /dev/null
+++ b/tools/perf/util/aslr.c
@@ -0,0 +1,822 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "aslr.h"
+
+#include "addr_location.h"
+#include "debug.h"
+#include "event.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "machine.h"
+#include "map.h"
+#include "thread.h"
+#include "tool.h"
+#include "session.h"
+#include "data.h"
+#include "dso.h"
+#include "pmus.h"
+
+#include <internal/lib.h>  /* page_size */
+#include <linux/compiler.h>
+#include <linux/zalloc.h>
+#include <inttypes.h>
+#include <unistd.h>
+
+/**
+ * struct remap_addresses_key - Key for mapping original addresses to remapped ones.
+ * @dso: Pointer to the DSO (Dynamic Shared Object) associated with the mapping.
+ * @invariant: Unique offset invariant within the VMA (Virtual Memory Area).
+ *             Calculated as `start - pgoff`. This value remains constant when
+ *             perf's internal `maps__fixup_overlap_and_insert` splits a map into
+ *             fragmented VMA pieces due to overlapping events, allowing us to
+ *             resolve split maps consistently back to the original VMA.
+ * @pid: Process ID associated with the mapping.
+ */
+struct remap_addresses_key {
+	struct machine *machine;
+	struct dso *dso;
+	u64 invariant;
+	pid_t pid;
+};
+
+struct aslr_mapping {
+	struct list_head node;
+	u64 orig_start;
+	u64 len;
+	u64 remap_start;
+};
+
+struct process_top_address {
+	u64 remapped_max;
+};
+struct aslr_tool {
+	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
+	struct delegate_tool tool;
+	/** @machines: The machines with the input, not remapped, virtual address layout. */
+	struct machines machines;
+	/** @event_copy: Buffer used to create an event to pass to the delegate. */
+	char event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	/** @remap_addresses: mapping from remap_addresses_key to remapped address. */
+	struct hashmap remap_addresses;
+	/** @top_addresses: mapping from process to max remapped address. */
+	struct hashmap top_addresses;
+};
+
+static const pid_t kernel_pid = -1;
+
+/* Start remapping user processes from a small non-zero offset. */
+static const u64 user_space_start = 0x200000;
+static const u64 kernel_space_start_64 = 0xffff800010000000ULL;
+static const u64 kernel_space_start_32 = 0x80000000ULL;
+
+static size_t remap_addresses__hash(long _key, void *ctx __maybe_unused)
+{
+	struct remap_addresses_key *key = (struct remap_addresses_key *)_key;
+	void *dso_ptr = key->dso ? RC_CHK_ACCESS(key->dso) : NULL;
+
+	return (size_t)key->machine ^ (size_t)dso_ptr ^ key->invariant ^ key->pid;
+}
+
+static bool remap_addresses__equal(long _key1, long _key2, void *ctx __maybe_unused)
+{
+	struct remap_addresses_key *key1 = (struct remap_addresses_key *)_key1;
+	struct remap_addresses_key *key2 = (struct remap_addresses_key *)_key2;
+
+	return key1->machine == key2->machine &&
+	       RC_CHK_EQUAL(key1->dso, key2->dso) &&
+	       key1->invariant == key2->invariant &&
+	       key1->pid == key2->pid;
+}
+
+struct top_addresses_key {
+	struct machine *machine;
+	pid_t pid;
+};
+
+static size_t top_addresses__hash(long _key, void *ctx __maybe_unused)
+{
+	struct top_addresses_key *key = (struct top_addresses_key *)_key;
+
+	return (size_t)key->machine ^ key->pid;
+}
+
+static bool top_addresses__equal(long _key1, long _key2, void *ctx __maybe_unused)
+{
+	struct top_addresses_key *key1 = (struct top_addresses_key *)_key1;
+	struct top_addresses_key *key2 = (struct top_addresses_key *)_key2;
+
+	return key1->machine == key2->machine && key1->pid == key2->pid;
+}
+
+static u64 round_up_to_page_size(u64 addr)
+{
+	return (addr + page_size - 1) & ~((u64)page_size - 1);
+}
+
+struct aslr_machine_priv {
+	bool kernel_maps_loaded;
+};
+
+static int aslr_tool__preload_kernel_maps(struct machine *machine)
+{
+	struct aslr_machine_priv *mpriv = machine->priv;
+
+	if (!mpriv) {
+		mpriv = zalloc(sizeof(*mpriv));
+		if (!mpriv)
+			return -ENOMEM;
+		machine->priv = mpriv;
+	}
+
+	if (!mpriv->kernel_maps_loaded) {
+		struct maps *kmaps = machine__kernel_maps(machine);
+
+		if (kmaps) {
+			int err = maps__load_maps(kmaps);
+
+			if (err < 0) {
+				pr_err("ASLR: Failed to preload kernel maps for machine pid %d\n",
+				       machine->pid);
+				return err;
+			}
+		}
+		mpriv->kernel_maps_loaded = true;
+	}
+	return 0;
+}
+
+static void aslr_tool__free_machine_priv(struct machine *machine)
+{
+	free(machine->priv);
+	machine->priv = NULL;
+}
+
+static void aslr_tool__destroy_machines_priv(struct machines *machines)
+{
+	struct rb_node *nd;
+
+	aslr_tool__free_machine_priv(&machines->host);
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
+		struct machine *machine = rb_entry(nd, struct machine, rb_node);
+
+		aslr_tool__free_machine_priv(machine);
+	}
+}
+
+static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
+				      struct machine *session_machine,
+				      struct thread *aslr_thread,
+				      u8 cpumode, u64 start,
+				      u64 len, u64 pgoff)
+{
+	/* Address location for dso lookup. */
+	struct addr_location al;
+	/* Original ASLR address based key for the remap table. */
+	struct remap_addresses_key remap_key;
+	/* The address in the ASLR sanitized address space less pg_off. */
+	u64 *remapped_invariant_ptr;
+	/* Key for the maximum address in a process. */
+	struct top_addresses_key top_addr_key;
+	/* Value in top address table. */
+	struct process_top_address *top = NULL;
+	/* Address in ASLR sanitized address space. */
+	u64 remap_addr;
+	/* Potentially allocated remap table key. */
+	struct remap_addresses_key *new_remap_key = NULL;
+	/*
+	 * Potentially allocated remap table key.
+	 * TODO: Avoid allocation necessary for perf 32-bit binary support.
+	 */
+	u64 *new_remap_val = NULL;
+	int err;
+
+	if (!aslr_thread)
+		return 0;
+
+	/* The key to look up an incoming address to the outgoing value. */
+	addr_location__init(&al);
+	remap_key.machine = maps__machine(thread__maps(aslr_thread));
+	remap_key.pid = (cpumode == PERF_RECORD_MISC_KERNEL ||
+			 cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
+			kernel_pid : thread__pid(aslr_thread);
+	if (thread__find_map(aslr_thread, cpumode, start, &al)) {
+		struct dso *dso = map__dso(al.map);
+		const char *dso_name = dso ? dso__long_name(dso) : NULL;
+
+		remap_key.dso = dso;
+		if (dso && !is_anon_memory(dso_name) && !is_no_dso_memory(dso_name))
+			remap_key.invariant = map__start(al.map) - map__pgoff(al.map);
+		else
+			remap_key.invariant = map__start(al.map);
+	} else {
+		remap_key.dso = NULL;
+		remap_key.invariant = start;
+	}
+
+	/* The key to look up top allocated address. */
+	top_addr_key.machine = remap_key.machine;
+	top_addr_key.pid = remap_key.pid;
+
+	if (hashmap__find(&aslr->remap_addresses, &remap_key, &remapped_invariant_ptr)) {
+		/* Mmap already exists. */
+		u64 calculated_max;
+
+		if (al.map) {
+			/*
+			 * The cached value is the base of the invariant. We add the
+			 * offset into the VMA (start - map__start), plus the map's
+			 * pgoff, to get the precise virtual address within this chunk.
+			 */
+			remap_addr = *remapped_invariant_ptr + map__pgoff(al.map) +
+				     (start - map__start(al.map));
+		} else {
+			/*
+			 * For unmapped memory (e.g. kernel anonymous), the cached value
+			 * was stored offset by pgoff. Adding pgoff yields the true remap_addr.
+			 */
+			remap_addr = *remapped_invariant_ptr + pgoff;
+		}
+
+		calculated_max = remap_addr + len;
+
+		/* See if top mapping was expanded. */
+		if (hashmap__find(&aslr->top_addresses, &top_addr_key, &top)) {
+			if (calculated_max > top->remapped_max)
+				top->remapped_max = calculated_max;
+		}
+		addr_location__exit(&al);
+		return remap_addr;
+	}
+	/* No mmap, create an entry from the top address. */
+	if (hashmap__find(&aslr->top_addresses, &top_addr_key, &top)) {
+		struct addr_location prev_al;
+		bool is_contiguous = false;
+
+		/* Current max allocated mmap address within the process. */
+		remap_addr = top->remapped_max;
+
+		addr_location__init(&prev_al);
+		if (thread__find_map(aslr_thread, cpumode, start - 1, &prev_al)) {
+			if (map__end(prev_al.map) == start)
+				is_contiguous = true;
+		}
+		addr_location__exit(&prev_al);
+
+		if (is_contiguous) {
+			/* Contiguous mapping, do not add 1 page gap! */
+			remap_addr = round_up_to_page_size(remap_addr);
+		} else {
+			/* Give 1 page gap from current max page. */
+			remap_addr = round_up_to_page_size(remap_addr);
+			remap_addr += page_size;
+		}
+		if (remap_addr + len > top->remapped_max)
+			top->remapped_max = remap_addr + len;
+	} else {
+		/* First address of the process, allocate key and first top address. */
+		struct top_addresses_key *tk;
+		struct process_top_address *top_val;
+		struct perf_env *env = session_machine ? session_machine->env : NULL;
+		bool is_64 = env ? perf_env__kernel_is_64_bit(env) : (sizeof(void *) == 8);
+		u64 kernel_start_addr = is_64 ? kernel_space_start_64 : kernel_space_start_32;
+
+		remap_addr = (cpumode == PERF_RECORD_MISC_KERNEL ||
+			      cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
+			     kernel_start_addr : user_space_start;
+		remap_addr = round_up_to_page_size(remap_addr);
+
+		tk = malloc(sizeof(*tk));
+		top_val = malloc(sizeof(*top_val));
+		if (!tk || !top_val) {
+			err = -ENOMEM;
+		} else {
+			*tk = top_addr_key;
+			top_val->remapped_max = remap_addr + len;
+			err = hashmap__insert(&aslr->top_addresses, tk, top_val,
+					      HASHMAP_ADD, NULL, NULL);
+		}
+		if (err) {
+			errno = -err;
+			pr_err("Failure to add ASLR process top address %m\n");
+			free(tk);
+			free(top_val);
+			addr_location__exit(&al);
+			return 0;
+		}
+	}
+	/* Create rmeapping entry. */
+	new_remap_key = malloc(sizeof(*new_remap_key));
+	new_remap_val = malloc(sizeof(u64));
+	if (!new_remap_key || !new_remap_val) {
+		err = -ENOMEM;
+	} else {
+		*new_remap_key = remap_key;
+		new_remap_key->dso = dso__get(remap_key.dso);
+		if (cpumode == PERF_RECORD_MISC_KERNEL ||
+		    cpumode == PERF_RECORD_MISC_GUEST_KERNEL) {
+			if (al.map) {
+				*new_remap_val = remap_addr -
+						 (start - map__start(al.map)) -
+						 map__pgoff(al.map);
+			} else {
+				/*
+				 * Subtract pgoff from the base virtual address so that
+				 * when the lookup path adds pgoff back, it perfectly
+				 * cancels out and returns remap_addr.
+				 */
+				*new_remap_val = remap_addr - pgoff;
+			}
+		} else {
+			*new_remap_val = remap_addr - (al.map ? map__pgoff(al.map) : pgoff);
+		}
+		err = hashmap__add(&aslr->remap_addresses, new_remap_key, new_remap_val);
+		if (err)
+			dso__put(new_remap_key->dso);
+	}
+	if (err) {
+		errno = -err;
+		pr_err("Failure to add ASLR remapping %m\n");
+		free(new_remap_key);
+		free(new_remap_val);
+		addr_location__exit(&al);
+		return 0;
+	}
+	addr_location__exit(&al);
+	return remap_addr;
+}
+
+static int aslr_tool__process_mmap(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample,
+				   struct machine *machine)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	union perf_event *new_event;
+	u8 cpumode;
+	struct thread *thread;
+	struct machine *aslr_machine;
+	int err;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+	new_event = (union perf_event *)aslr->event_copy;
+	cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_mmap(tool, event, sample, aslr_machine);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(aslr_machine, event->mmap.pid, event->mmap.tid);
+	if (!thread)
+		return -ENOMEM;
+	memcpy(&new_event->mmap, &event->mmap, event->mmap.header.size);
+	/* Remaps the mmap.start. */
+	new_event->mmap.start = aslr_tool__findnew_mapping(aslr, machine, thread, cpumode,
+							   event->mmap.start,
+							   event->mmap.len,
+							   event->mmap.pgoff);
+	/*
+	 * For anonymous memory (and kernel maps), the kernel populates the
+	 * event's pgoff field with the original un-obfuscated virtual address
+	 * in bytes (i.e. (addr >> PAGE_SHIFT) << PAGE_SHIFT).
+	 * We must overwrite pgoff with the new remapped byte address to prevent
+	 * leaking the original ASLR layout.
+	 */
+	if (cpumode == PERF_RECORD_MISC_KERNEL || cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
+	    is_anon_memory(event->mmap.filename) || is_no_dso_memory(event->mmap.filename))
+		new_event->mmap.pgoff = new_event->mmap.start;
+	err = delegate->mmap(delegate, new_event, sample, machine);
+	thread__put(thread);
+	return err;
+}
+
+static int aslr_tool__process_mmap2(const struct perf_tool *tool,
+				    union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	union perf_event *new_event;
+	u8 cpumode;
+	struct thread *thread;
+	struct machine *aslr_machine;
+	int err;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+	new_event = (union perf_event *)aslr->event_copy;
+	cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_mmap2(tool, event, sample, aslr_machine);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(aslr_machine, event->mmap2.pid, event->mmap2.tid);
+	if (!thread)
+		return -ENOMEM;
+	memcpy(&new_event->mmap2, &event->mmap2, event->mmap2.header.size);
+	/* Remaps the mmap.start. */
+	new_event->mmap2.start = aslr_tool__findnew_mapping(aslr, machine, thread, cpumode,
+							    event->mmap2.start,
+							    event->mmap2.len,
+							    event->mmap2.pgoff);
+	/*
+	 * For anonymous memory (and kernel maps), the kernel populates the
+	 * event's pgoff field with the original un-obfuscated virtual address
+	 * in bytes (i.e. (addr >> PAGE_SHIFT) << PAGE_SHIFT).
+	 * We must overwrite pgoff with the new remapped byte address to prevent
+	 * leaking the original ASLR layout.
+	 */
+	if (cpumode == PERF_RECORD_MISC_KERNEL || cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
+	    is_anon_memory(event->mmap2.filename) || is_no_dso_memory(event->mmap2.filename))
+		new_event->mmap2.pgoff = new_event->mmap2.start;
+	err = delegate->mmap2(delegate, new_event, sample, machine);
+	thread__put(thread);
+	return err;
+}
+
+static int aslr_tool__process_comm(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample,
+				   struct machine *machine)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	struct machine *aslr_machine;
+	int err;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_comm(tool, event, sample, aslr_machine);
+	if (err)
+		return err;
+
+	return delegate->comm(delegate, event, sample, machine);
+}
+
+static int aslr_tool__process_fork(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample,
+				   struct machine *machine)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	struct machine *aslr_machine;
+	int err;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_fork(tool, event, sample, aslr_machine);
+	if (err)
+		return err;
+
+	return delegate->fork(delegate, event, sample, machine);
+}
+
+static int aslr_tool__process_exit(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample,
+				   struct machine *machine)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	struct machine *aslr_machine;
+	int err;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_exit(tool, event, sample, aslr_machine);
+	if (err)
+		return err;
+
+	return delegate->exit(delegate, event, sample, machine);
+}
+
+static int aslr_tool__process_text_poke(const struct perf_tool *tool __maybe_unused,
+					union perf_event *event __maybe_unused,
+					struct perf_sample *sample __maybe_unused,
+					struct machine *machine __maybe_unused)
+{
+	/* Drop in case the instruction encodes an ASLR revealing address. */
+	return 0;
+}
+
+static int aslr_tool__process_ksymbol(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	union perf_event *new_event;
+	struct thread *thread;
+	struct machine *aslr_machine;
+	int err;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+	new_event = (union perf_event *)aslr->event_copy;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	err = perf_event__process_ksymbol(tool, event, sample, aslr_machine);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(aslr_machine, kernel_pid, 0);
+	if (!thread)
+		return -ENOMEM;
+	memcpy(&new_event->ksymbol, &event->ksymbol, event->ksymbol.header.size);
+	/* Remaps the ksymbol.start */
+	new_event->ksymbol.addr = aslr_tool__findnew_mapping(aslr, machine, thread,
+							     PERF_RECORD_MISC_KERNEL,
+							     event->ksymbol.addr,
+							     event->ksymbol.len,
+							     /*pgoff=*/0);
+
+	err = delegate->ksymbol(delegate, new_event, sample, machine);
+	thread__put(thread);
+	return err;
+}
+
+static int aslr_tool__process_sample(const struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
+				     struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+
+	return delegate->sample(delegate, event, sample, machine);
+}
+
+static int skipn(int fd, off_t n)
+{
+	char buf[4096];
+	ssize_t ret;
+
+	while (n > 0) {
+		ret = read(fd, buf, min_t(off_t, n, (off_t)sizeof(buf)));
+		if (ret <= 0)
+			return ret;
+		n -= ret;
+	}
+
+	return 0;
+}
+
+static s64 aslr_tool__process_auxtrace(const struct perf_tool *tool __maybe_unused,
+				       struct perf_session *session,
+				       union perf_event *event)
+{
+	pr_warning_once("ASLR: Dropping auxtrace data as it cannot be obfuscated.\n");
+	if (perf_data__is_pipe(session->data)) {
+		/* Copy behavior of the stub by reading all pipe data. */
+		int err = skipn(perf_data__fd(session->data), event->auxtrace.size);
+
+		if (err < 0)
+			return err;
+	}
+	return event->auxtrace.size;
+}
+
+static int aslr_tool__process_auxtrace_info(const struct perf_tool *tool __maybe_unused,
+					    struct perf_session *session __maybe_unused,
+					    union perf_event *event __maybe_unused)
+{
+	return 0;
+}
+
+static int aslr_tool__process_auxtrace_error(const struct perf_tool *tool __maybe_unused,
+					     struct perf_session *session __maybe_unused,
+					     union perf_event *event __maybe_unused)
+{
+	return 0;
+}
+
+
+void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlist)
+{
+	struct evsel *evsel;
+	bool needs_swap = false;
+
+	if (pevlist && *pevlist) {
+		evsel = evlist__last(*pevlist);
+		if (evsel)
+			needs_swap = evsel->needs_swap;
+	}
+
+	if (event->header.size >= (offsetof(struct perf_record_header_attr,
+					    attr.sample_type) + sizeof(u64))) {
+		u64 st = event->attr.attr.sample_type;
+
+		if (needs_swap)
+			st = bswap_64(st);
+
+		st &= ASLR_SUPPORTED_SAMPLE_TYPE;
+
+		if (needs_swap)
+			st = bswap_64(st);
+
+		event->attr.attr.sample_type = st;
+	}
+
+	if (event->header.size >= (offsetof(struct perf_record_header_attr,
+					    attr.type) + sizeof(u32))) {
+		u32 type = event->attr.attr.type;
+
+		if (needs_swap)
+			type = bswap_32(type);
+
+		if (type == PERF_TYPE_BREAKPOINT &&
+		    event->header.size >= (offsetof(struct perf_record_header_attr,
+						    attr.bp_addr) + sizeof(u64))) {
+			event->attr.attr.bp_addr = 0;
+		} else if (type >= PERF_TYPE_MAX) {
+			struct perf_pmu *pmu;
+
+			pmu = perf_pmus__find_by_type(type);
+			if (pmu && (!strcmp(pmu->name, "kprobe") ||
+				    !strcmp(pmu->name, "uprobe"))) {
+				if (event->header.size >=
+				    (offsetof(struct perf_record_header_attr,
+					      attr.config1) + sizeof(u64)))
+					event->attr.attr.config1 = 0;
+				if (event->header.size >=
+				    (offsetof(struct perf_record_header_attr,
+					      attr.config2) + sizeof(u64)))
+					event->attr.attr.config2 = 0;
+			}
+		}
+	}
+}
+
+void aslr_tool__strip_evlist(struct perf_tool *tool __maybe_unused,
+			     struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->core.attr.sample_type &= ASLR_SUPPORTED_SAMPLE_TYPE;
+
+		if (evsel->core.attr.type == PERF_TYPE_BREAKPOINT)
+			evsel->core.attr.bp_addr = 0;
+		else if (evsel->core.attr.type >= PERF_TYPE_MAX) {
+			struct perf_pmu *pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+
+			if (pmu && (!strcmp(pmu->name, "kprobe") ||
+				    !strcmp(pmu->name, "uprobe"))) {
+				evsel->core.attr.config1 = 0;
+				evsel->core.attr.config2 = 0;
+			}
+		}
+	}
+}
+
+static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
+{
+	delegate_tool__init(&aslr->tool, delegate);
+	aslr->tool.tool.ordered_events = true;
+
+	machines__init(&aslr->machines);
+
+	hashmap__init(&aslr->remap_addresses,
+		      remap_addresses__hash, remap_addresses__equal,
+		      /*ctx=*/NULL);
+	hashmap__init(&aslr->top_addresses,
+		      top_addresses__hash, top_addresses__equal,
+		      /*ctx=*/NULL);
+
+	aslr->tool.tool.sample	= aslr_tool__process_sample;
+	/* read - reads a counter, okay to delegate. */
+	aslr->tool.tool.mmap	= aslr_tool__process_mmap;
+	aslr->tool.tool.mmap2	= aslr_tool__process_mmap2;
+	aslr->tool.tool.comm	= aslr_tool__process_comm;
+	aslr->tool.tool.fork	= aslr_tool__process_fork;
+	aslr->tool.tool.exit	= aslr_tool__process_exit;
+	/* namesspaces, cgroup, lost, lost_sample, aux, */
+	/* itrace_start, aux_output_hw_id, context_switch, throttle, unthrottle */
+	/* - no virtual addresses. */
+	aslr->tool.tool.ksymbol	= aslr_tool__process_ksymbol;
+	/* bpf - no virtual address. */
+	aslr->tool.tool.text_poke = aslr_tool__process_text_poke;
+	/*
+	 * event_update, tracing_data, finished_round, build_id, id_index,
+	 * auxtrace_info, auxtrace_error, time_conv, thread_map, cpu_map,
+	 * stat_config, stat, feature, finished_init, bpf_metadata, compressed,
+	 * auxtrace - no virtual addresses.
+	 */
+	aslr->tool.tool.auxtrace = aslr_tool__process_auxtrace;
+	aslr->tool.tool.auxtrace_info = aslr_tool__process_auxtrace_info;
+	aslr->tool.tool.auxtrace_error = aslr_tool__process_auxtrace_error;
+}
+
+struct perf_tool *aslr_tool__new(struct perf_tool *delegate)
+{
+	struct aslr_tool *aslr = zalloc(sizeof(*aslr));
+
+	if (!aslr)
+		return NULL;
+
+	aslr_tool__init(aslr, delegate);
+	return &aslr->tool.tool;
+}
+
+void aslr_tool__delete(struct perf_tool *tool)
+{
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct hashmap_entry *cur;
+	size_t bkt;
+	struct rb_node *nd;
+
+	if (!tool)
+		return;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+
+	hashmap__for_each_entry(&aslr->remap_addresses, cur, bkt) {
+		struct remap_addresses_key *key = (struct remap_addresses_key *)cur->pkey;
+
+		if (key)
+			dso__put(key->dso);
+		zfree(&cur->pkey);
+		zfree(&cur->pvalue);
+	}
+	hashmap__for_each_entry(&aslr->top_addresses, cur, bkt) {
+		zfree(&cur->pkey);
+		zfree(&cur->pvalue);
+	}
+
+	hashmap__clear(&aslr->remap_addresses);
+	hashmap__clear(&aslr->top_addresses);
+	aslr_tool__destroy_machines_priv(&aslr->machines);
+	machines__destroy_kernel_maps(&aslr->machines);
+
+	while ((nd = rb_first_cached(&aslr->machines.guests)) != NULL) {
+		struct machine *machine = rb_entry(nd, struct machine, rb_node);
+
+		rb_erase_cached(nd, &aslr->machines.guests);
+		machine__delete(machine);
+	}
+
+	machines__exit(&aslr->machines);
+	free(aslr);
+}
diff --git a/tools/perf/util/aslr.h b/tools/perf/util/aslr.h
new file mode 100644
index 000000000000..2b82f711bc67
--- /dev/null
+++ b/tools/perf/util/aslr.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_ASLR_H
+#define __PERF_ASLR_H
+
+#include <linux/perf_event.h>
+
+#define ASLR_SUPPORTED_SAMPLE_TYPE ( \
+	PERF_SAMPLE_IDENTIFIER | \
+	PERF_SAMPLE_IP | \
+	PERF_SAMPLE_TID | \
+	PERF_SAMPLE_TIME | \
+	PERF_SAMPLE_ADDR | \
+	PERF_SAMPLE_ID | \
+	PERF_SAMPLE_STREAM_ID | \
+	PERF_SAMPLE_CPU | \
+	PERF_SAMPLE_PERIOD | \
+	PERF_SAMPLE_READ | \
+	PERF_SAMPLE_CALLCHAIN | \
+	PERF_SAMPLE_RAW | \
+	PERF_SAMPLE_BRANCH_STACK | \
+	PERF_SAMPLE_STACK_USER | \
+	PERF_SAMPLE_WEIGHT_TYPE | \
+	PERF_SAMPLE_DATA_SRC | \
+	PERF_SAMPLE_TRANSACTION | \
+	PERF_SAMPLE_PHYS_ADDR | \
+	PERF_SAMPLE_CGROUP | \
+	PERF_SAMPLE_DATA_PAGE_SIZE | \
+	PERF_SAMPLE_CODE_PAGE_SIZE | \
+	PERF_SAMPLE_AUX)
+
+struct perf_tool;
+struct evsel;
+struct evlist;
+union perf_event;
+
+struct perf_tool *aslr_tool__new(struct perf_tool *delegate);
+void aslr_tool__delete(struct perf_tool *aslr);
+void aslr_tool__strip_attr_event(union perf_event *event, struct evlist **pevlist);
+void aslr_tool__strip_evlist(struct perf_tool *tool, struct evlist *evlist);
+
+#endif /* __PERF_ASLR_H */
-- 
2.54.0.1032.g2f8565e1d1-goog

