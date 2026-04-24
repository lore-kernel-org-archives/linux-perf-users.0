Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F92349AF6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068336; cv=none; b=VXjRhUhfmtDh+tbAo5o9DeE3AkXe0QSdLbQw6aADeqMyMF0+frMfar/4PuKOHkcdvOp4Wbu06tb2V9jJ5NT1HAFFULDKGBCuQa3z+p4qNeAipoO5GmZNYqtsqPpImLsdi4hbntBulxo5+yUlW9wHducZ+/+/AUiU+7CSvhiVt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068336; c=relaxed/simple;
	bh=0auYcSHiFu1nwu0TaukaSorrFweIhqSQTMdP4IEkvjc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hBTaNX0RhwPNI5TqYvzR2UaDfFvxbTcqM/XnyECENX6/LPKJowBeWf5nnKSeDxw8vsClIrk5mhfx6z9BN7NhiPFDOYZ6Vit89LlPwnSvMZrA474Y1XGI0GrMC/EzVYqfpOQTrthAtAkpFE12sQNFeGQAIYtl8YkuJToNba6A8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fczt6eCY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fczt6eCY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8ccc7593so9515669c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777068332; x=1777673132; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azmgCemCK8Xwqe/44mIBMUFPHRwckw2cSrOaSLiv3RU=;
        b=fczt6eCYXPMdC44tsUuAXctGN4T8yDHD3dvSaawoK+Lyf+e5IkZ30fGROBtCdu+31v
         Olqe+QeOqmxn8+n+6fUvBeEsF1LltqS/YJaATNc3v7ps/2PSyYp+pluuLdh5DDRwOi23
         cCI3yVLfI84IqOzu6PAz68ILkdbSFQPjkMBtUx0QHev0ZgQAn3IU09A3Jfp/P8hup/S1
         C8lT5OL0FXaHWyxEr/l1yTbNR2bTF+QBtvBuV0u2UEFmPniAilz0m2Lt1HUkBwT/kX11
         s2UFH7SIqys/pdNqmt0udThS9lK0npqp4R5D+MlfcRODRBP0W8HxdYavFMyZ1zRAl4t6
         coZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068332; x=1777673132;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azmgCemCK8Xwqe/44mIBMUFPHRwckw2cSrOaSLiv3RU=;
        b=LGnflfaUQo9xFExucz+gwLa24oTWyeFRjpBbhtOfQiOIUu2htBjw/GvkdkkBAI6uev
         0g1TWX9DZnOFh3XBHKUv4v1QBSR8Yae339lg5D5iJuhAC2TQzW0DQHNTAnHnJQ0PcdLG
         BfOmtdNq7pFJGGgMlrAu/6X74Fmk2+AU/cVpUU/ZSGfbWFyFlQ0jSiSaSsnOjHoZW3nf
         MDSO6Nd+ZPe2I4dk7NcbCIxFD8d5+jnTjLiO9VXAnmBr/LGfpvrONRfV9UPs2x/FSk92
         oOkYDbvdb9KdBb70NiC69ruDUBEN/Bz2XsWPofng2P5GgFU+X8RKcAq4mP1V9g/5MnVS
         L2nQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DepIB1B0rcortdNcz8UTwCh7OxtPz29Kv1Eg/Dn8mFY8A/1Ne6M9H92IuALfioL+xG61se2DgPguYzp/YgMX2@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeOOdsgK8Yi8NQgoExyzXJ68MJj3By7zT9LE/1BxDQDiP82BB
	36xWJ1iawlGUMtC2qXoC71p2mUplVFhO+gCm2VCA49yF7zMWFbjqrGbWoFV5OLk7yBqRYjFNg4j
	Q0P/9fZ5F2g==
X-Received: from dlbcf24.prod.google.com ([2002:a05:7022:4598:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6714:b0:12c:8e7f:1b11
 with SMTP id a92af1059eb24-12c8e7f1d18mr11938239c88.7.1777068332348; Fri, 24
 Apr 2026 15:05:32 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:05:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424220519.2743472-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf inject/aslr: Add aslr tool to remap/obfuscate
 virtual addresses
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Gabriel Marin <gmx@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If perf.data files are taken from one machine to another they make
leak virtual addresses and so weaken ASLR on the machine they are
coming from. Add a '--aslr' option for perf inject that remaps all
virtual addresses, or drops data/events, so that the virtual address
information isn't leaked.

When events are not known/handled by the tool they are dropped. This
makes the tool conservative and it should never leak ASLR information,
but it means virtual address remapping is needed for cases like
auxtrace.

Signed-off-by: Ian Rogers <irogers@google.com>
Co-developed-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Gabriel Marin <gmx@google.com>
---
 tools/perf/builtin-inject.c |  11 +-
 tools/perf/util/Build       |   1 +
 tools/perf/util/aslr.c      | 752 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/aslr.h      |  10 +
 4 files changed, 773 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f174bc69cec4..fa3a71e23f1b 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -8,6 +8,7 @@
  */
 #include "builtin.h"
 
+#include "util/aslr.h"
 #include "util/color.h"
 #include "util/dso.h"
 #include "util/vdso.h"
@@ -123,6 +124,7 @@ struct perf_inject {
 	bool			in_place_update_dry_run;
 	bool			copy_kcore_dir;
 	bool			convert_callchain;
+	bool			aslr;
 	const char		*input_name;
 	struct perf_data	output;
 	u64			bytes_written;
@@ -2564,6 +2566,8 @@ int cmd_inject(int argc, const char **argv)
 			   " instance has a subdir"),
 		OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callchain,
 			    "Generate callchains using DWARF and drop register/stack data"),
+		OPT_BOOLEAN(0, "aslr", &inject.aslr,
+			    "Remap virtual memory addresses similar to ASLR"),
 		OPT_END()
 	};
 	const char * const inject_usage[] = {
@@ -2571,6 +2575,7 @@ int cmd_inject(int argc, const char **argv)
 		NULL
 	};
 	bool ordered_events;
+	struct perf_tool *tool = &inject.tool;
 
 	if (!inject.itrace_synth_opts.set) {
 		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
@@ -2684,7 +2689,9 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
-	inject.session = __perf_session__new(&data, &inject.tool,
+	if (inject.aslr)
+		tool = aslr_tool__new(&inject.tool);
+	inject.session = __perf_session__new(&data, tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe,
 					     /*host_env=*/NULL);
 
@@ -2789,6 +2796,8 @@ int cmd_inject(int argc, const char **argv)
 	strlist__delete(inject.known_build_ids);
 	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
+	if (inject.aslr)
+		aslr_tool__delete(tool);
 out_close_output:
 	if (!inject.in_place_update)
 		perf_data__close(&inject.output);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..65b96f3b87e2 100644
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
index 000000000000..23ef7b68896c
--- /dev/null
+++ b/tools/perf/util/aslr.c
@@ -0,0 +1,752 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "aslr.h"
+
+#include "addr_location.h"
+#include "debug.h"
+#include "event.h"
+#include "evsel.h"
+#include "machine.h"
+#include "map.h"
+#include "thread.h"
+#include "tool.h"
+
+#include <internal/lib.h>  // page_size
+#include <linux/compiler.h>
+#include <errno.h>
+#include <inttypes.h>
+
+struct remap_addresses_key {
+	u64 start_addr;
+	pid_t pid;
+};
+
+struct aslr_tool {
+	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
+	struct delegate_tool tool;
+	/** @machine: The machine with the input, not remapped, virtual address layout. */
+	struct machine machine;
+	/** @event_copy: Buffer used to create an event to pass to the delegate. */
+	char event_copy[PERF_SAMPLE_MAX_SIZE];
+	/** @remap_addresses: mapping from remap_addresses_key to remapped address. */
+	struct hashmap remap_addresses;
+	/** @top_addresses: mapping from process to max remapped address. */
+	struct hashmap top_addresses;
+	/** @first_kernel_mapping: flag indicating if we are still to process any kernel mapping. */
+	bool first_kernel_mapping;
+};
+
+static const pid_t kernel_pid = -1;
+
+/* Start remapping user processes from a small non-zero offset. */
+static const u64 user_space_start = 0x200000;
+static const u64 kernel_space_start = 0xffff800010000000;
+
+static size_t remap_addresses__hash(long _key, void *ctx __maybe_unused)
+{
+	struct remap_addresses_key *key = (struct remap_addresses_key *)_key;
+
+	return key->start_addr ^ (key->start_addr >> 12) ^ key->pid;
+}
+
+static bool remap_addresses__equal(long _key1, long _key2, void *ctx __maybe_unused)
+{
+	struct remap_addresses_key *key1 = (struct remap_addresses_key *)_key1;
+	struct remap_addresses_key *key2 = (struct remap_addresses_key *)_key2;
+
+	return key1->pid == key2->pid && key1->start_addr == key2->start_addr;
+}
+
+static size_t top_addresses__hash(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool top_addresses__equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
+static u64 round_up_to_page_size(u64 addr)
+{
+	return (addr + page_size - 1) & ~((u64)page_size - 1);
+}
+
+static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
+				    struct thread *aslr_thread,
+				    u8 cpumode,
+				    u64 addr)
+{
+	struct addr_location al;
+	struct remap_addresses_key key;
+	u64 remap_addr = 0;
+	u8 effective_cpumode = cpumode;
+
+	if (!aslr_thread)
+		return 0; // No thread.
+
+	addr_location__init(&al);
+	if (!thread__find_map(aslr_thread, cpumode, addr, &al)) {
+		/*
+		 * If lookup fails with specified cpumode, try fallback to the other space
+		 * to be robust against bad cpumode in samples.
+		 */
+		effective_cpumode = (cpumode == PERF_RECORD_MISC_KERNEL) ?
+				    PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL;
+		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
+			pr_debug("Cannot find mmap for address %lx in either space, pid=%d\n",
+				 addr, aslr_thread->pid_);
+			addr_location__exit(&al);
+			return 0; // No mmap.
+		}
+	}
+
+	key.pid = effective_cpumode == PERF_RECORD_MISC_KERNEL ? kernel_pid : aslr_thread->pid_;
+	key.start_addr = map__start(al.map);
+	if (!hashmap__find(&aslr->remap_addresses, &key, &remap_addr)) {
+		pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
+			 addr, map__start(al.map), map__size(al.map), key.pid);
+		addr_location__exit(&al);
+		return 0;
+	}
+	remap_addr += addr - map__start(al.map);
+	addr_location__exit(&al);
+	return remap_addr;
+}
+
+static u64 aslr_tool__remap_mapping(struct aslr_tool *aslr,
+				    struct thread *aslr_thread,
+				    u8 cpumode,
+				    u64 start, u64 len)
+{
+	struct addr_location prev_al;
+	struct remap_addresses_key key;
+	u64 remap_addr = 0;
+	/* If mapping is contiguous to the previous process mapping. */
+	bool is_contiguous = false;
+	bool first_mapping = false; // first process mapping.
+
+	if (!aslr_thread)
+		return 0; // No thread.
+
+	addr_location__init(&prev_al);
+	if (thread__find_map(aslr_thread, cpumode, start-1, &prev_al)) {
+		if (map__start(prev_al.map) + map__size(prev_al.map) == start) {
+			is_contiguous = true;
+		} else  {
+			pr_debug("Previous mmap [%lx, %lx] overlaps current map [%lx, %lx]\n",
+				 map__start(prev_al.map),
+				 map__start(prev_al.map) + map__size(prev_al.map),
+				 start, start+len);
+		}
+	}
+	addr_location__exit(&prev_al);
+
+	key.pid = cpumode == PERF_RECORD_MISC_KERNEL ? kernel_pid : aslr_thread->pid_;
+	key.start_addr = start;
+	if (hashmap__find(&aslr->remap_addresses, &key, &remap_addr))
+		return remap_addr;
+
+	if (!hashmap__find(&aslr->top_addresses, key.pid, &remap_addr)) {
+		/* First mapping in this process. Don't add a page gap. */
+		first_mapping = true;
+		remap_addr = (cpumode == PERF_RECORD_MISC_KERNEL ?
+			      kernel_space_start : user_space_start);
+	}
+
+	remap_addr = round_up_to_page_size(remap_addr);
+	if (!is_contiguous && !first_mapping)
+		remap_addr += page_size;
+
+	{
+		struct remap_addresses_key *new_key = malloc(sizeof(*new_key));
+
+		if (!new_key)
+			return 0;
+		*new_key = key;
+		if (hashmap__add(&aslr->remap_addresses, new_key, remap_addr) != 0) {
+			pr_debug("Failed to add remap_addresses entry for pid=%d, mapping start=%lx, remapped start=%lx",
+					key.pid, start, remap_addr);
+			free(new_key);
+			return 0;
+		}
+	}
+
+	hashmap__insert(&aslr->top_addresses, key.pid, remap_addr+len,
+				first_mapping ? HASHMAP_ADD : HASHMAP_UPDATE, NULL, NULL);
+	return remap_addr;
+}
+
+static u64 aslr_tool__remap_ksymbol(struct aslr_tool *aslr,
+				    struct thread *aslr_thread,
+				    u64 addr, u32 len)
+{
+	struct remap_addresses_key key;
+	u64 remap_addr = 0;
+	bool first_mapping = false;
+
+	if (!aslr_thread)
+		return 0; // No thread.
+
+	key.pid = aslr_thread->pid_;
+	key.start_addr = addr;
+	if (hashmap__find(&aslr->remap_addresses, &key, &remap_addr))
+		return remap_addr;
+
+	first_mapping = !hashmap__find(&aslr->top_addresses, key.pid, &remap_addr);
+	if (first_mapping)
+		remap_addr = kernel_space_start;
+	remap_addr = round_up_to_page_size(remap_addr) + page_size;
+
+	{
+		struct remap_addresses_key *new_key = malloc(sizeof(*new_key));
+
+		if (!new_key)
+			return 0;
+		*new_key = key;
+		if (hashmap__add(&aslr->remap_addresses, new_key, remap_addr) < 0) {
+			pr_debug("Failed to add remap_addresses entry for pid=%d, ksymbol=%lx, remapped address=%lx",
+					key.pid, addr, remap_addr);
+			free(new_key);
+			return 0;
+		}
+	}
+
+	hashmap__insert(&aslr->top_addresses, key.pid, remap_addr+len,
+			first_mapping ? HASHMAP_ADD : HASHMAP_UPDATE, NULL, NULL);
+	return remap_addr;
+}
+
+
+static int aslr_tool__process_mmap(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	union perf_event *new_event = (union perf_event *)aslr->event_copy;
+	u8 cpumode   = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	struct thread *thread;
+	int err;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_mmap(tool, event, sample, &aslr->machine);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(&aslr->machine, event->mmap.pid, event->mmap.tid);
+	memcpy(&new_event->mmap, &event->mmap, event->mmap.header.size);
+	/* Remaps the mmap.start. */
+	new_event->mmap.start = aslr_tool__remap_mapping(aslr, thread, cpumode,
+							   event->mmap.start, event->mmap.len);
+	if (aslr->first_kernel_mapping && cpumode == PERF_RECORD_MISC_KERNEL) {
+		/* If this is the first kernel image, we need to adjust the pgoff by a
+		 * similar delta.
+		 */
+		new_event->mmap.pgoff = event->mmap.pgoff - event->mmap.start +
+					new_event->mmap.start;
+		aslr->first_kernel_mapping = false;
+	}
+	return delegate->mmap(delegate, new_event, sample, machine);
+}
+
+static int aslr_tool__process_mmap2(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	union perf_event *new_event = (union perf_event *)aslr->event_copy;
+	u8 cpumode   = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	struct thread *thread;
+	int err;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_mmap2(tool, event, sample, &aslr->machine);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(&aslr->machine, event->mmap2.pid, event->mmap2.tid);
+	memcpy(&new_event->mmap2, &event->mmap2, event->mmap2.header.size);
+	/* Remaps the mmap.start. */
+	new_event->mmap2.start = aslr_tool__remap_mapping(aslr, thread, cpumode,
+							   event->mmap2.start, event->mmap2.len);
+	if (aslr->first_kernel_mapping && cpumode == PERF_RECORD_MISC_KERNEL) {
+		/* If this is the first kernel image, we need to adjust the pgoff by a
+		 * similar delta.
+		 */
+		new_event->mmap2.pgoff = event->mmap2.pgoff - event->mmap2.start +
+					 new_event->mmap2.start;
+		aslr->first_kernel_mapping = false;
+	}
+	return delegate->mmap2(delegate, new_event, sample, machine);
+}
+
+static int aslr_tool__process_comm(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	int err;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_comm(tool, event, sample, &aslr->machine);
+	if (err)
+		return err;
+
+	return delegate->comm(delegate, event, sample, machine);
+}
+
+static int aslr_tool__process_fork(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	int err;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_fork(tool, event, sample, &aslr->machine);
+	if (err)
+		return err;
+
+	return delegate->fork(delegate, event, sample, machine);
+}
+
+static int aslr_tool__process_exit(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	int err;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_exit(tool, event, sample, &aslr->machine);
+	if (err)
+		return err;
+
+	return delegate->exit(delegate, event, sample, machine);
+}
+
+static int aslr_tool__process_text_poke(const struct perf_tool *tool,
+					union perf_event *event,
+					struct perf_sample *sample,
+					struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	union perf_event *new_event = (union perf_event *)aslr->event_copy;
+	u8 cpumode   = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	struct thread *thread;
+
+	thread = machine__findnew_thread(&aslr->machine, sample->pid, sample->tid);
+	memcpy(&new_event->text_poke, &event->text_poke, event->text_poke.header.size);
+	new_event->text_poke.addr = aslr_tool__remap_address(aslr, thread, cpumode,
+							     event->text_poke.addr);
+
+	return delegate->text_poke(delegate, new_event, sample, machine);
+}
+
+static int aslr_tool__process_ksymbol(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	union perf_event *new_event = (union perf_event *)aslr->event_copy;
+	struct thread *thread;
+	int err;
+
+	/* Create the thread, map, etc. in the ASLR before virtual address space. */
+	err = perf_event__process_ksymbol(tool, event, sample, &aslr->machine);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(&aslr->machine, kernel_pid, 0);
+	memcpy(&new_event->ksymbol, &event->ksymbol, event->ksymbol.header.size);
+	/* Remaps the ksymbol.start */
+	new_event->ksymbol.addr = aslr_tool__remap_ksymbol(aslr, thread,
+							   event->ksymbol.addr, event->ksymbol.len);
+
+	return delegate->ksymbol(delegate, new_event, sample, machine);
+}
+
+static inline int copy_u64(__u64 *in_array, __u64 *out_array,
+			   size_t *i, size_t *j, const __u64 max_i)
+{
+	if (*i > max_i)
+		return -EFAULT;
+	out_array[(*j)++] = in_array[(*i)++];
+	return 0;
+}
+
+static int aslr_tool__process_sample(const struct perf_tool *tool, union perf_event *event,
+				struct perf_sample *sample,
+				struct evsel *evsel, struct machine *machine)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	int ret;
+	u64 sample_type = evsel->core.attr.sample_type;
+	struct thread *thread = machine__findnew_thread(&aslr->machine, sample->pid, sample->tid);
+	const __u64 max_i = event->header.size / sizeof(__u64);
+	union perf_event *new_event = (union perf_event *)aslr->event_copy;
+	struct perf_sample new_sample;
+	__u64 *in_array, *out_array;
+	u8 cpumode = sample->cpumode;
+	u64 addr;
+	size_t i = 0, j = 0;
+
+	new_event->sample.header = event->sample.header;
+
+	in_array = &event->sample.array[0];
+	out_array = &new_event->sample.array[0];
+
+
+
+	if (sample_type & PERF_SAMPLE_IDENTIFIER)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // id
+	if (sample_type & PERF_SAMPLE_IP) {
+		i++;
+		out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode,
+							  sample->ip);
+	}
+	if (sample_type & PERF_SAMPLE_TID)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // pid, tid
+	if (sample_type & PERF_SAMPLE_TIME)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // time
+	if (sample_type & PERF_SAMPLE_ADDR) {
+		i++; // addr
+		out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode,
+							  sample->addr);
+	}
+	if (sample_type & PERF_SAMPLE_ID)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // id
+	if (sample_type & PERF_SAMPLE_STREAM_ID)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // stream_id
+	if (sample_type & PERF_SAMPLE_CPU)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // cpu, res
+	if (sample_type & PERF_SAMPLE_PERIOD)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // period
+	if (sample_type & PERF_SAMPLE_READ) {
+		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
+			if (copy_u64(in_array, out_array, &i, &j, max_i))
+				return -EFAULT; // value
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // time_enabled
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // time_running
+			if (evsel->core.attr.read_format & PERF_FORMAT_ID)
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // id
+			if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // lost
+		} else {
+			u64 nr;
+
+			if (i > max_i)
+				return -EFAULT;
+			nr = out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // time_enabled
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // time_running
+			for (u64 cntr = 0; cntr < nr; cntr++) {
+				if (copy_u64(in_array, out_array, &i, &j, max_i))
+					return -EFAULT; // value
+				if (evsel->core.attr.read_format & PERF_FORMAT_ID)
+					if (copy_u64(in_array, out_array, &i, &j, max_i))
+						return -EFAULT; // id
+				if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
+					if (copy_u64(in_array, out_array, &i, &j, max_i))
+						return -EFAULT; // lost
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // nr
+
+		for (u64 cntr = 0; cntr < sample->callchain->nr; cntr++) {
+			if (i > max_i)
+				return -EFAULT;
+			i++;
+			addr = sample->callchain->ips[cntr];
+			if (addr >= PERF_CONTEXT_MAX) {
+				// Copy context values as is.
+				out_array[j++] = addr;
+				switch (addr) {
+				case PERF_CONTEXT_HV:
+					cpumode = PERF_RECORD_MISC_HYPERVISOR;
+					break;
+				case PERF_CONTEXT_KERNEL:
+					cpumode = PERF_RECORD_MISC_KERNEL;
+					break;
+				case PERF_CONTEXT_USER:
+					cpumode = PERF_RECORD_MISC_USER;
+					break;
+				default:
+					pr_debug("invalid callchain context: %"PRIx64"\n", addr);
+					/*
+					 * It seems the callchain is corrupted.
+					 * Discard sample.
+					 */
+					return 0;
+				}
+				continue;
+			}
+			out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode,
+								  sample->callchain->ips[cntr]);
+		}
+	}
+	if (sample_type & PERF_SAMPLE_RAW) {
+		size_t bytes = sizeof(u32) + sample->raw_size;
+
+		if ((i + (bytes / sizeof(u64))) > max_i)
+			return -EFAULT;
+		memcpy(&out_array[j], &in_array[i], bytes);
+		i += bytes / sizeof(u64);
+		j += bytes / sizeof(u64);
+		// TODO: certain raw samples can be remapped, such as
+		// tracepoints by examining their fields.
+		pr_debug("Dropping raw samples as possible ASLR leak\n");
+		return 0;
+	}
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // nr
+		if (sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
+			if (copy_u64(in_array, out_array, &i, &j, max_i))
+				return -EFAULT; // hw_idx
+		if (i + (sample->branch_stack->nr * 3) > max_i)
+			return -EFAULT;
+		for (u64 cntr = 0; cntr < sample->branch_stack->nr; cntr++) {
+			out_array[j++] = aslr_tool__remap_address(aslr, thread, sample->cpumode,
+								  in_array[i++]); // from
+			out_array[j++] = aslr_tool__remap_address(aslr, thread, sample->cpumode,
+								  in_array[i++]); // to
+			if (copy_u64(in_array, out_array, &i, &j, max_i))
+				return -EFAULT; // flags
+		}
+		if (sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
+			if (i + sample->branch_stack->nr > max_i)
+				return -EFAULT;
+			memcpy(&out_array[j], &in_array[i], sample->branch_stack->nr * sizeof(u64));
+			i += sample->branch_stack->nr;
+			j += sample->branch_stack->nr;
+			// TODO: confirm branch counters don't leak ASLR information.
+			pr_debug("Dropping sample branch counters as possible ASLR leak\n");
+			return 0;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // abi
+		if (sample->user_regs->abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(evsel->core.attr.sample_regs_user);
+
+			if (i + nr > max_i)
+				return -EFAULT;
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+		}
+		// TODO: can this be less conservative?
+		pr_debug("Dropping regs user sample as possible ASLR leak\n");
+		return 0;
+	}
+	if (sample_type & PERF_SAMPLE_STACK_USER) {
+		u64 size;
+
+		if (i > max_i)
+			return -EFAULT;
+		size = out_array[j++] = in_array[i++];
+		if (size > 0) {
+			memcpy(&out_array[j], &in_array[i], size);
+			i += size / sizeof(u64);
+			j += size / sizeof(u64);
+			if (copy_u64(in_array, out_array, &i, &j, max_i))
+				return -EFAULT; // dyn_size
+		}
+		// TODO: can this be less conservative?
+		pr_debug("Dropping stack user sample as possible ASLR leak\n");
+		return 0;
+	}
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // perf_sample_weight
+	if (sample_type & PERF_SAMPLE_DATA_SRC)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // data_src
+	if (sample_type & PERF_SAMPLE_TRANSACTION)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // transaction
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // abi
+		if (sample->intr_regs->abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(evsel->core.attr.sample_regs_intr);
+
+			if (i + nr > max_i)
+				return -EFAULT;
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+		}
+		// TODO: can this be less conservative?
+		pr_debug("Dropping interrupt register sample as possible ASLR leak\n");
+		return 0;
+	}
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // phys_addr
+		// TODO: can this be less conservative?
+		pr_debug("Dropping physical address sample as possible ASLR leak\n");
+		return 0;
+	}
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // cgroup
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // data_page_size
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		if (copy_u64(in_array, out_array, &i, &j, max_i))
+			return -EFAULT; // code_page_size
+
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 size;
+
+		if (i > max_i)
+			return -EFAULT;
+		size = out_array[j++] = in_array[i++];
+		if (i + (size / sizeof(u64)) > max_i)
+			return -EFAULT;
+		memcpy(&out_array[j], &in_array[i], size);
+		i += size / sizeof(u64);
+		j += size / sizeof(u64);
+		// TODO: can this be less conservative?
+		pr_debug("Dropping aux sample as possible ASLR leak\n");
+		return 0;
+	}
+
+	if (evsel__is_offcpu_event(evsel)) {
+		// TODO: can this be less conservative?
+		pr_debug("Dropping off-CPU sample as possible ASLR leak\n");
+		return 0;
+	}
+
+	perf_sample__init(&new_sample, /*all=*/ true);
+	ret = evsel__parse_sample(evsel, new_event, &new_sample);
+	if (ret)
+		return ret;
+
+	ret = delegate->sample(delegate, new_event, &new_sample, evsel, machine);
+	perf_sample__exit(&new_sample);
+	return ret;
+}
+
+static int aslr_tool__process_attr(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct evlist **pevlist)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct perf_tool *delegate = aslr->tool.delegate;
+	union perf_event *new_event = (union perf_event *)aslr->event_copy;
+
+	memcpy(&new_event->attr, &event->attr, event->attr.header.size);
+	new_event->attr.attr.bp_addr = 0;  // Conservatively remove addresses.
+	new_event->attr.attr.kprobe_addr = 0;  // Conservatively remove addresses.
+
+	return delegate->attr(delegate, new_event, pevlist);
+}
+
+static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
+{
+	delegate_tool__init(&aslr->tool, delegate);
+	aslr->tool.tool.ordered_events = true;
+
+	machine__init(&aslr->machine, "", HOST_KERNEL_ID);
+
+	hashmap__init(&aslr->remap_addresses,
+		      remap_addresses__hash, remap_addresses__equal,
+		      /*ctx=*/NULL);
+	hashmap__init(&aslr->top_addresses,
+		      top_addresses__hash, top_addresses__equal,
+		      /*ctx=*/NULL);
+	aslr->first_kernel_mapping = true;
+
+	aslr->tool.tool.sample	= aslr_tool__process_sample;
+	// read - reads a counter, okay to delegate.
+	aslr->tool.tool.mmap	= aslr_tool__process_mmap;
+	aslr->tool.tool.mmap2	= aslr_tool__process_mmap2;
+	aslr->tool.tool.comm	= aslr_tool__process_comm;
+	aslr->tool.tool.fork	= aslr_tool__process_fork;
+	aslr->tool.tool.exit	= aslr_tool__process_exit;
+	// namesspaces, cgroup, lost, lost_sample, aux,
+	// itrace_start, aux_output_hw_id, context_switch, throttle, unthrottle
+	// - no virtual addresses.
+	aslr->tool.tool.ksymbol	= aslr_tool__process_ksymbol;
+	// bpf - no virtual address.
+	aslr->tool.tool.text_poke = aslr_tool__process_text_poke;
+	aslr->tool.tool.attr = aslr_tool__process_attr;
+	// event_update, tracing_data, finished_round, build_id, id_index,
+	// auxtrace_info, auxtrace_error, time_conv, thread_map, cpu_map,
+	// stat_config, stat, feature, finished_init, bpf_metadata, compressed,
+	// auxtrace - no virtual addresses.
+}
+
+struct perf_tool *aslr_tool__new(struct perf_tool *delegate)
+{
+	struct aslr_tool *aslr = malloc(sizeof(*aslr));
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
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	hashmap__for_each_entry(&aslr->remap_addresses, cur, bkt)
+		zfree(&cur->pkey);
+
+	hashmap__clear(&aslr->remap_addresses);
+	hashmap__clear(&aslr->top_addresses);
+	machine__exit(&aslr->machine);
+	free(aslr);
+}
diff --git a/tools/perf/util/aslr.h b/tools/perf/util/aslr.h
new file mode 100644
index 000000000000..ea984d82681f
--- /dev/null
+++ b/tools/perf/util/aslr.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_ASLR_H
+#define __PERF_ASLR_H
+
+struct perf_tool;
+
+struct perf_tool *aslr_tool__new(struct perf_tool *delegate);
+void aslr_tool__delete(struct perf_tool *aslr);
+
+#endif /* __PERF_ASLR_H */
-- 
2.54.0.545.g6539524ca2-goog

