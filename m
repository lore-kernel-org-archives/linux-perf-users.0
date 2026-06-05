Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123B4071C2
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687482; cv=none; b=GDaVcfDXSY2Xlg2sn2sPv8gloLsNhJmMNKVA5gKELJy04Kks7x/bzu3FXmwu0d0gsoAeFmXaqkkg2Z2dl5aeZR91nRPXCtspMyhaEGt++SZ3akw/JQvb+2GsBhhui7207G5UH1Ar5t3Rh8S2jxzAeE0EV0ak3TKRW3WkssGR5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687482; c=relaxed/simple;
	bh=ZcrTGsKPLrbYzmTnls7Dk3z8GNMOUwFEXrbUMruvI2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qw8MANUf861F1OoGyrdwNKTeKTMmnRjDIMAFvM/0V702D/9oHRCEdJGQXJxh3rbcthPUfbQHH6x3EAjWdla0uB2YVqvFf2LwSzpi2QGiGfFey29f9jx0HO95hoXpIV7XJwsNQYvim9K8jhp4xSCmccR+Arf4H0B1GqwsjMQgOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2bj83vk; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2bj83vk"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30761ab3483so8371492eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780687479; x=1781292279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUoJjGR7hVSbLJgzp8LyuLtPZFax0BImq42SFTxLN6Y=;
        b=D2bj83vk6ze4UcGhTabAfBXv9OW71sncc3Xvw94/zhvURGTET7UdI4yezZshW1XlHt
         9c6oD8Kuw+KygF7yTH9vCSYlf4cAn/zy5b3vC1gzUzQ34rjdLz752hJOD8PwWBwuBKhe
         qSet81sZSls2GQE1eIUByfXmWFvffN2e9cuPm7lFkr1DrGXTgxNoXJnNwIekqoJqYAAX
         gi9xIFSdzOXD3d2Ba46ITPVC7q/jYfgG2vm63lyMiPL82s+iSup5cASVqFfrelA1PY9T
         QuGLM+J2zWbP96j8Q4lqxSobMzvoc7K/xsnKERWS6w/hsuSQgNtmsfV167BckVFgfcmi
         xF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687479; x=1781292279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUoJjGR7hVSbLJgzp8LyuLtPZFax0BImq42SFTxLN6Y=;
        b=p39GoGv+Es2hhpXq+2YXxYk7+GvBOLQWdhX5oP9qQvNQzccmJagwVVg+unV0iFMDjk
         MgVyGWQ9Yy8ijRpl9ePFwP0/FiESicxUQpCy+iu1p8rb1EKmKudELHCpD29FyI4BVPoC
         3bknC0q0FGO9Uf3UHZV8mgEIu+Wc4/ud/1ymnKgShQx3e1Ytv9hwzHHAHjSAs9eljuhW
         WzdWAV93pstxYpB3aR5JywyS8hlxnRATOY+F/FMbbf5HcGzuPkQ2hRmv26Iaultg9VZ3
         8SAHgm94ceJwcGbGZ4zGA4IqcYWOjMTtDAxjCOWqShSQngB+5fqcHfePyFAnohESOWEt
         NKqA==
X-Forwarded-Encrypted: i=1; AFNElJ+HRNbKxnRrxAbqBYA8lSyA4/cvKeIODud8LY8t7/a3btjaiQ8dJNE23DgIJByvi9fRlq96sFmLTqRDXqNANHiI@vger.kernel.org
X-Gm-Message-State: AOJu0YzvySP17bPPnOV1BplFOgG7uMnuJBE2sLLMduoH2IgpQjeWvW2n
	TaWnzEsd90c3WYulIdb/k+52er91F4vrqthEhiXV8wF2X2Trvi+tyHClG5nCg4ezcP9TwxJ8qfp
	HTSS7z1dErQ==
X-Received: from dyem11.prod.google.com ([2002:a05:7300:818b:b0:2ed:8f25:961b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5f0f:b0:304:997c:d43b
 with SMTP id 5a478bee46e88-3077b84564bmr2643303eec.34.1780687478864; Fri, 05
 Jun 2026 12:24:38 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:24:23 -0700
In-Reply-To: <20260605192425.2523260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605185215.2359881-1-irogers@google.com> <20260605192425.2523260-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605192425.2523260-4-irogers@google.com>
Subject: [PATCH v12 3/5] perf inject/aslr: Implement sample address remapping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add the sample address remapping logic to the ASLR tool. This patch
implements aslr_tool__process_sample, which parses sample events,
remaps IPs, ADDRs, callchains, and branch stacks using the mappings
collected from metadata events, and drops potentially leaking raw,
register, stack, physical address, and aux samples.

Also adds the aslr_tool__remap_address helper function.

Co-developed-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c  | 449 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c |   6 +-
 tools/perf/util/evsel.h |  10 +-
 3 files changed, 456 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index ac24fda658a5..dece5fb43dd8 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -109,6 +109,60 @@ static u64 round_up_to_page_size(u64 addr)
 	return (addr + page_size - 1) & ~((u64)page_size - 1);
 }
 
+static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
+				    struct thread *aslr_thread,
+				    u8 cpumode,
+				    u64 addr)
+{
+	struct addr_location al;
+	struct remap_addresses_key key;
+	u64 *remapped_invariant_ptr = NULL;
+	u64 remap_addr = 0;
+	u8 effective_cpumode = cpumode;
+
+	if (!aslr_thread)
+		return 0; /* No thread. */
+
+	addr_location__init(&al);
+	if (!thread__find_map(aslr_thread, cpumode, addr, &al)) {
+		/*
+		 * If lookup fails with specified cpumode, try fallback to the other space
+		 * to be robust against bad cpumode in samples.
+		 */
+		if (cpumode == PERF_RECORD_MISC_KERNEL)
+			effective_cpumode = PERF_RECORD_MISC_USER;
+		else if (cpumode == PERF_RECORD_MISC_USER)
+			effective_cpumode = PERF_RECORD_MISC_KERNEL;
+		else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL)
+			effective_cpumode = PERF_RECORD_MISC_GUEST_USER;
+		else if (cpumode == PERF_RECORD_MISC_GUEST_USER)
+			effective_cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
+
+		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
+			addr_location__exit(&al);
+			return 0; /* No mmap. */
+		}
+	}
+
+	key.machine = maps__machine(thread__maps(aslr_thread));
+	key.dso = map__dso(al.map);
+	key.invariant = map__start(al.map) - map__pgoff(al.map);
+	key.pid = (effective_cpumode == PERF_RECORD_MISC_KERNEL ||
+		   effective_cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
+		  kernel_pid : thread__pid(aslr_thread);
+
+	if (hashmap__find(&aslr->remap_addresses, &key, &remapped_invariant_ptr)) {
+		remap_addr = *remapped_invariant_ptr + map__pgoff(al.map) +
+			     (addr - map__start(al.map));
+	} else {
+		pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
+			 addr, map__start(al.map), map__size(al.map), key.pid);
+	}
+
+	addr_location__exit(&al);
+	return remap_addr;
+}
+
 struct aslr_machine_priv {
 	bool kernel_maps_loaded;
 };
@@ -554,13 +608,400 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
 				     struct perf_sample *sample,
 				     struct machine *machine)
 {
-	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
-	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
-	struct perf_tool *delegate = aslr->tool.delegate;
+	struct evsel *evsel = sample->evsel;
+	struct delegate_tool *del_tool;
+	struct aslr_tool *aslr;
+	struct perf_tool *delegate;
+	int ret;
+	u64 sample_type;
+	struct thread *thread;
+	struct machine *aslr_machine;
+	__u64 max_i;
+	__u64 max_j;
+	union perf_event *new_event;
+	struct perf_sample new_sample;
+	__u64 *in_array, *out_array;
+	u8 cpumode;
+	u64 addr;
+	size_t i;
+	size_t j;
+
+	del_tool = container_of(tool, struct delegate_tool, tool);
+	aslr = container_of(del_tool, struct aslr_tool, tool);
+	delegate = aslr->tool.delegate;
+
+	if (evsel__is_dummy_event(evsel))
+		return delegate->sample(delegate, event, sample, machine);
+
+	ret = -EFAULT;
+	sample_type = evsel->core.attr.sample_type;
+	max_i = (event->header.size - sizeof(struct perf_event_header)) / sizeof(__u64);
+	max_j = (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / sizeof(__u64);
+	new_event = (union perf_event *)aslr->event_copy;
+	cpumode = sample->cpumode;
+	i = 0;
+	j = 0;
+
+	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
+	if (!aslr_machine)
+		return -ENOMEM;
+	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
+		return -ENOMEM;
+
+	thread = machine__findnew_thread(aslr_machine, sample->pid, sample->tid);
+
+	if (!thread)
+		return -ENOMEM;
 
-	return delegate->sample(delegate, event, sample, machine);
+	if (max_i > PERF_SAMPLE_MAX_SIZE / sizeof(u64))
+		goto out_put;
+
+	new_event->sample.header = event->sample.header;
+
+	in_array = &event->sample.array[0];
+	out_array = &new_event->sample.array[0];
+
+#define CHECK_BOUNDS(required_i, required_j) \
+	(i + (required_i) > max_i || j + (required_j) > max_j)
+
+#define COPY_U64() \
+	do { \
+		if (CHECK_BOUNDS(1, 1)) { \
+			ret = -EFAULT; \
+			goto out_put; \
+		} \
+		out_array[j++] = in_array[i++]; \
+	} while (0)
+
+#define REMAP_U64(addr_field) \
+	do { \
+		if (CHECK_BOUNDS(1, 1)) { \
+			ret = -EFAULT; \
+			goto out_put; \
+		} \
+		out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode, addr_field); \
+		i++; \
+	} while (0)
+
+	if (sample_type & PERF_SAMPLE_IDENTIFIER)
+		COPY_U64(); /* id */
+	if (sample_type & PERF_SAMPLE_IP)
+		REMAP_U64(sample->ip);
+	if (sample_type & PERF_SAMPLE_TID)
+		COPY_U64(); /* pid, tid */
+	if (sample_type & PERF_SAMPLE_TIME)
+		COPY_U64(); /* time */
+	if (sample_type & PERF_SAMPLE_ADDR)
+		REMAP_U64(sample->addr);
+	if (sample_type & PERF_SAMPLE_ID)
+		COPY_U64(); /* id */
+	if (sample_type & PERF_SAMPLE_STREAM_ID)
+		COPY_U64(); /* stream_id */
+	if (sample_type & PERF_SAMPLE_CPU)
+		COPY_U64(); /* cpu, res */
+	if (sample_type & PERF_SAMPLE_PERIOD)
+		COPY_U64(); /* period */
+	if (sample_type & PERF_SAMPLE_READ) {
+		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
+			COPY_U64(); /* value */
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+				COPY_U64(); /* time_enabled */
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+				COPY_U64(); /* time_running */
+			if (evsel->core.attr.read_format & PERF_FORMAT_ID)
+				COPY_U64(); /* id */
+			if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
+				COPY_U64(); /* lost */
+		} else {
+			u64 nr;
+
+			if (CHECK_BOUNDS(1, 1)) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			out_array[j] = in_array[i];
+			nr = out_array[j++];
+			i++;
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+				COPY_U64(); /* time_enabled */
+			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+				COPY_U64(); /* time_running */
+			for (u64 cntr = 0; cntr < nr; cntr++) {
+				COPY_U64(); /* value */
+				if (evsel->core.attr.read_format & PERF_FORMAT_ID)
+					COPY_U64(); /* id */
+				if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
+					COPY_U64(); /* lost */
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		u64 nr;
+
+		if (CHECK_BOUNDS(1, 1)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		out_array[j] = in_array[i];
+		nr = out_array[j++];
+		i++;
+
+		for (u64 cntr = 0; cntr < nr; cntr++) {
+			if (CHECK_BOUNDS(1, 1)) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			addr = in_array[i++];
+			if (addr >= PERF_CONTEXT_MAX) {
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
+				case PERF_CONTEXT_GUEST:
+					cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
+					break;
+				case PERF_CONTEXT_GUEST_KERNEL:
+					cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
+					break;
+				case PERF_CONTEXT_GUEST_USER:
+					cpumode = PERF_RECORD_MISC_GUEST_USER;
+					break;
+				case PERF_CONTEXT_USER_DEFERRED:
+					if (cntr + 1 >= nr) {
+						pr_debug("Truncated callchain deferred cookie context\n");
+						ret = 0;
+						goto out_put;
+					}
+					/*
+					 * Immediately followed by a 64-bit
+					 * stitching cookie. Skip/Copy it!
+					 */
+					if (CHECK_BOUNDS(1, 1)) {
+						ret = -EFAULT;
+						goto out_put;
+					}
+					out_array[j++] = in_array[i++];
+					cntr++;
+					cpumode = PERF_RECORD_MISC_USER;
+					break;
+				default:
+					pr_debug("invalid callchain context: %"PRIx64"\n", addr);
+					ret = 0;
+					goto out_put;
+				}
+				continue;
+			}
+			out_array[j++] = aslr_tool__remap_address(aslr, thread, cpumode, addr);
+		}
+	}
+	if (sample_type & PERF_SAMPLE_RAW) {
+		size_t bytes = sizeof(u32) + sample->raw_size;
+		size_t u64_words = (bytes + 7) / 8;
+
+		if (i + u64_words > max_i || j + u64_words > max_j) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		memcpy(&out_array[j], &in_array[i], bytes);
+		i += u64_words;
+		j += u64_words;
+		/*
+		 * TODO: certain raw samples can be remapped, such as
+		 * tracepoints by examining their fields.
+		 */
+		pr_debug("Dropping raw samples as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		u64 nr;
+
+		if (CHECK_BOUNDS(1, 1)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		out_array[j] = in_array[i];
+		nr = out_array[j++];
+		i++;
+
+		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
+			COPY_U64(); /* hw_idx */
+
+		if (nr > (ULLONG_MAX / 3)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		if (nr * 3 > max_i - i || nr * 3 > max_j - j) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		for (u64 cntr = 0; cntr < nr; cntr++) {
+			out_array[j++] = aslr_tool__remap_address(aslr, thread,
+								  sample->cpumode,
+								  in_array[i++]); /* from */
+			out_array[j++] = aslr_tool__remap_address(aslr, thread,
+								  sample->cpumode,
+								  in_array[i++]); /* to */
+			out_array[j++] = in_array[i++]; /* flags */
+		}
+		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
+			if (nr > max_i - i || nr > max_j - j) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+			/* TODO: confirm branch counters don't leak ASLR information. */
+			pr_debug("Dropping sample branch counters as possible ASLR leak\n");
+			ret = 0;
+			goto out_put;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (CHECK_BOUNDS(1, 0)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		/* abi */
+		COPY_U64();
+		/* TODO: can this be less conservative? */
+		pr_debug("Dropping regs user sample as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_STACK_USER) {
+		u64 size;
+
+		if (CHECK_BOUNDS(1, 1)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		out_array[j] = in_array[i];
+		size = out_array[j++];
+		i++;
+		if (size > 0) {
+			size_t u64_words = size / 8 + (size % 8 ? 1 : 0);
+
+			if (u64_words > max_i - i || u64_words > max_j - j) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			memcpy(&out_array[j], &in_array[i], size);
+			if (size % 8) {
+				size_t pad = 8 - (size % 8);
+
+				memset(((char *)&out_array[j]) + size, 0, pad);
+			}
+			i += u64_words;
+			j += u64_words;
+		}
+		/* TODO: can this be less conservative? */
+		pr_debug("Dropping stack user sample as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		COPY_U64(); /* perf_sample_weight */
+	if (sample_type & PERF_SAMPLE_DATA_SRC)
+		COPY_U64(); /* data_src */
+	if (sample_type & PERF_SAMPLE_TRANSACTION)
+		COPY_U64(); /* transaction */
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (CHECK_BOUNDS(1, 0)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		/* abi */
+		COPY_U64();
+		/* TODO: can this be less conservative? */
+		pr_debug("Dropping interrupt register sample as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
+		COPY_U64(); /* phys_addr */
+		/* TODO: can this be less conservative? */
+		pr_debug("Dropping physical address sample as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		COPY_U64(); /* cgroup */
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		COPY_U64(); /* data_page_size */
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		COPY_U64(); /* code_page_size */
+
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 size;
+
+		if (CHECK_BOUNDS(1, 1)) {
+			ret = -EFAULT;
+			goto out_put;
+		}
+		out_array[j] = in_array[i];
+		size = out_array[j++];
+		i++;
+		if (size > 0) {
+			size_t u64_words = size / 8 + (size % 8 ? 1 : 0);
+
+			if (u64_words > max_i - i || u64_words > max_j - j) {
+				ret = -EFAULT;
+				goto out_put;
+			}
+			memcpy(&out_array[j], &in_array[i], size);
+			if (size % 8) {
+				size_t pad = 8 - (size % 8);
+
+				memset(((char *)&out_array[j]) + size, 0, pad);
+			}
+			i += u64_words;
+			j += u64_words;
+		}
+		/* TODO: can this be less conservative? */
+		pr_debug("Dropping aux sample as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+
+	if (evsel__is_offcpu_event(evsel)) {
+		/* TODO: can this be less conservative? */
+		pr_debug("Dropping off-CPU sample as possible ASLR leak\n");
+		ret = 0;
+		goto out_put;
+	}
+
+	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
+
+	perf_sample__init(&new_sample, /*all=*/ true);
+	ret = evsel__parse_sample(evsel, new_event, &new_sample);
+
+	if (ret) {
+		perf_sample__exit(&new_sample);
+		goto out_put;
+	}
+
+	new_sample.evsel = evsel;
+	ret = delegate->sample(delegate, new_event, &new_sample, machine);
+	perf_sample__exit(&new_sample);
+
+out_put:
+	thread__put(thread);
+	return ret;
 }
 
+#undef CHECK_BOUNDS
+#undef COPY_U64
+#undef REMAP_U64
+
 static int skipn(int fd, off_t n)
 {
 	char buf[4096];
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 34c03f47a913..05fa0010c858 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3337,11 +3337,11 @@ static int __set_offcpu_sample(struct perf_sample *data)
 	return -EFAULT;
 }
 
-int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
-			struct perf_sample *data)
+int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
+			  struct perf_sample *data, bool needs_swap)
 {
 	u64 type = evsel->core.attr.sample_type;
-	bool swapped = evsel->needs_swap;
+	bool swapped = needs_swap;
 	const __u64 *array;
 	u16 max_size = event->header.size;
 	const void *endp = (void *)event + max_size;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8178858d168a..8009be22cc3f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -432,8 +432,14 @@ static inline int evsel__read_on_cpu_scaled(struct evsel *evsel, int cpu_map_idx
 	return __evsel__read_on_cpu(evsel, cpu_map_idx, thread, true);
 }
 
-int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
-			struct perf_sample *sample);
+int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
+			  struct perf_sample *data, bool needs_swap);
+
+static inline int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
+				      struct perf_sample *data)
+{
+	return __evsel__parse_sample(evsel, event, data, evsel->needs_swap);
+}
 
 int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 				  u64 *timestamp);
-- 
2.54.0.1032.g2f8565e1d1-goog

