Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815133;
	b=tZICOeHMo0lmH2YxvUOQwXiZFtvkxxFJjTQ/SqXWsxxJyiCAonkI2ZKv9Fcor6rjszGN
	 z7O2omFsMhJhU5ESTKkZyC1mGXLFWyfmmQdLLkQsAwEZj8s2gYIjocULeM4nIMp5Zs6hB
	 hqlX+MsPMqnKiMbByhSWad4DxpBmksk9FnARnOVTAqVlRHzW5q5vDcOz5BLEOwO/xBiQw
	 7h4jS37wZob2fZCeuJ0MYQ6v68HcxpvOIfbipfd4PjnRZGmFarmQ0hNlJI+HUyGT54JU7
	 36FSgvQ/9667XsW3jaK0OqduincYGoirDKE8MsIRBwgTG9wr1oefdiYPIurKqjJXD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZM2jDaYOeBuF9UPrBNMtRS5yq9KRRPXKB7XJ5P8EAAE=;
	b=Mvsm3Mtm6NjqNo03zweSDLBbF+zjarg2clSqjdyWJhudyBu6ZHF53CCBCkURYrTOBuFV
	 tSoQNlsm/g33GtPsuB2zF7J5p6wbEbvqEN01+0gwPqbSj6zSmOiDUNlYY3p7xDYGKJAn3
	 7lCnt6ZJg5CmixBKu5MGqsLwjL7iMSz88U0anQ/OOfirOanGgFmg0NUVzAa8mdUxGm+rw
	 gJ5dU0zDtfQlaMONYLAXQs6fvRY61AupLJKBkOQivzPuzSg66MSzWDVA022VgPoCkzrBW
	 /ZPGdHcQqIttB/QbTBGOLhDPwnqkcLaJPMtGF3xvGdWOaevQZrXU+rioJpX2EenVxIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P1IXYa1u;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CC606A8BB
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A97CC606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P1IXYa1u
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36de26cb4b3so3916323eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815132; x=1795419932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZM2jDaYOeBuF9UPrBNMtRS5yq9KRRPXKB7XJ5P8EAAE=;
        b=P1IXYa1ujRbJI+6rZvh3bJausTTzaj4Gzu7AyrbrgdqYlmfFHG1meiZX++E8Lyan4n
         xJXLCGqKtxQ2Ywp13WXkXzxOkSWAL8zjoZCAnPbhmxdPC4CfdUq4UsTZvQNXkOBFb29m
         YT1kUMNeslplyPoznGfIUQKWMMxqa+3afp9D/BFfhZHYZDe14fS0xN841wppI6jZpo8G
         MdOWA0VMfQCuQtzkSdA22XA3uP6Qw5FLoXE3wKm9lYn14WBsCr0fdf0nAOt7KeGrbXoy
         QiBmQ1FgDVm9kICHZX+2B4bNKXIezEtNyCXUifL/v4KBTNQ5JE04T1E6O6jZVYHg5gAf
         DVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815132; x=1795419932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM2jDaYOeBuF9UPrBNMtRS5yq9KRRPXKB7XJ5P8EAAE=;
        b=wUvssB4I8QlhnT8fZnIxRNJKLRp+fX4IxQhCmnATpY8W6ykBgGDbnEwIMLqk1Wzn9z
         dL41pAluykz8jGGev8LeQk6UZ0D3G/GFm07A0oUtSwWQykX2ZUrni+JuAmaaSBpNKxhG
         LEcsrsudqC7L+6u0I7CB4bSmzvppSbkS+6aWtYuYKD7Tv8A+LdVb7TEPkiQFABMvT/2C
         5l27dATlX9AQNfWYB3uybiC2uP+dbl985Jzy8zb1utYiKikpJlxsGCPf1D2hnkz9M2/B
         G83zWqGo7aui+lrvSrh6+T2JE1pMZGeeUq7jthKI0gxoYWsXJcIJ+FSa0YX1QIAUedls
         ixDQ==
X-Forwarded-Encrypted: i=1; AL+hErEYkEoiWPs85xU1R9B5H6fEggcJ/JpcHBo9/iXI83RhnfxM21VrQ2TPtC2p+jnUdM4sHHIAV1irx8V5gcNsyS0V@vger.kernel.org
X-Gm-Message-State: APuU4Z8pwEVef7h2rByQGzP7wa6JskWhRwIEHX8cJg4KrUjOJWzGaZfX
	KFnbUDnXwb9A3n9YVhWdU90hnAEUxXghp2zPp69Zqy1m8CQZpyKQS/Cpy+y648qta/GgryRFx8M
	byP0/OJJKOw==
X-Received: from dycmq7.prod.google.com ([2002:a05:7301:787:b0:376:583a:e72a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:da09:b0:36a:1434:c691
 with SMTP id 5a478bee46e88-37967506836mr10198505eec.14.1794815131281; Sun, 15
 Nov 2026 23:45:31 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:07 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-13-irogers@google.com>
Subject: [PATCH v3 12/19] perf: Refactor thread map and symbol APIs to take perf_sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor thread__find_map and thread__find_symbol family of APIs to
take a struct perf_sample * instead of cpumode and addr. This prepares
for looking up symbols using build ID and offset, which is contained in
the sample payload instead of the address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/powerpc/util/skip-callchain-idx.c    |  4 +-
 tools/perf/builtin-inject.c                   |  2 +-
 tools/perf/builtin-script.c                   | 48 +++++++++++++----
 tools/perf/builtin-timechart.c                |  5 +-
 tools/perf/builtin-trace.c                    | 10 ++--
 tools/perf/tests/code-reading.c               |  6 ++-
 tools/perf/tests/mmap-thread-lookup.c         |  9 +++-
 tools/perf/util/annotate-data.c               |  5 +-
 tools/perf/util/aslr.c                        | 46 +++++++++++------
 tools/perf/util/build-id.c                    |  2 +-
 tools/perf/util/capstone.c                    |  4 +-
 tools/perf/util/cs-etm.c                      | 10 +++-
 tools/perf/util/data-convert-json.c           |  4 +-
 tools/perf/util/debug.c                       |  6 ++-
 tools/perf/util/dlfilter.c                    |  8 ++-
 tools/perf/util/event.c                       | 51 ++++++++++---------
 tools/perf/util/intel-pt.c                    | 24 +++++++--
 tools/perf/util/machine.c                     | 18 +++++--
 tools/perf/util/python.c                      | 18 +++++--
 tools/perf/util/thread.c                      | 11 ++--
 tools/perf/util/thread.h                      | 14 ++---
 tools/perf/util/unwind-libdw.c                |  7 ++-
 tools/perf/util/unwind-libunwind.c            |  8 ++-
 23 files changed, 224 insertions(+), 96 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 472714cfad38..cb29d9eafa89 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -225,7 +225,9 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	addr_location__init(&al);
 	ip = chain->ips[1];
 
-	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			    &al);
 
 	if (al.map)
 		dso = map__dso(al.map);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a278c360b058..f59f3005899c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1167,7 +1167,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 		goto repipe;
 	}
 
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
+	if (thread__find_map(thread, sample, &al)) {
 		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
 			     /*sample_in_dso=*/true);
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6691ebb1b4e..376a4e0d7b0c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1063,6 +1063,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct perf_sample br_sample = {};
 	u64 i, from, to;
 	int printed = 0;
 
@@ -1079,8 +1080,12 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 
 			addr_location__init(&alf);
 			addr_location__init(&alt);
-			thread__find_map_fb(thread, sample->cpumode, from, &alf);
-			thread__find_map_fb(thread, sample->cpumode, to, &alt);
+			br_sample.cpumode = sample->cpumode;
+			br_sample.ip = from;
+			thread__find_map_fb(thread, &br_sample, &alf);
+			br_sample.cpumode = sample->cpumode;
+			br_sample.ip = to;
+			thread__find_map_fb(thread, &br_sample, &alt);
 
 			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
 			printed += fprintf(fp, "/0x%"PRIx64, to);
@@ -1102,6 +1107,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct perf_sample br_sample = {};
 	u64 i, from, to;
 	int printed = 0;
 
@@ -1116,8 +1122,12 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = entries[i].from;
 		to   = entries[i].to;
 
-		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
-		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = from;
+		thread__find_symbol_fb(thread, &br_sample, &alf);
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = to;
+		thread__find_symbol_fb(thread, &br_sample, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO))
@@ -1140,6 +1150,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct perf_sample br_sample = {};
 	u64 i, from, to;
 	int printed = 0;
 
@@ -1154,11 +1165,15 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = entries[i].from;
 		to   = entries[i].to;
 
-		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = from;
+		if (thread__find_map_fb(thread, &br_sample, &alf) &&
 		    !dso__adjust_symbols(map__dso(alf.map)))
 			from = map__dso_map_ip(alf.map, from);
 
-		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = to;
+		if (thread__find_map_fb(thread, &br_sample, &alt) &&
 		    !dso__adjust_symbols(map__dso(alt.map)))
 			to = map__dso_map_ip(alt.map, to);
 
@@ -1216,7 +1231,18 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	}
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, *cpumode, start, &al) || (dso = map__dso(al.map)) == NULL) {
+	{
+		struct perf_sample sample = {
+			.cpumode = *cpumode,
+			.ip = start,
+		};
+
+		if (!thread__find_map(thread, &sample, &al))
+			dso = NULL;
+		else
+			dso = map__dso(al.map);
+	}
+	if (!dso) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		goto out;
 	}
@@ -1291,7 +1317,7 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 	int ret = 0;
 
 	addr_location__init(&al);
-	thread__find_map(thread, cpumode, addr, &al);
+	thread__find_map(thread, &(struct perf_sample){.cpumode = cpumode, .ip = addr}, &al);
 	if (!al.map)
 		goto out;
 	ret = map__fprintf_srccode(al.map, al.addr, stdout,
@@ -1346,7 +1372,9 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 		struct addr_location al;
 
 		addr_location__init(&al);
-		thread__find_map(thread, x->cpumode, ip, &al);
+		thread__find_map(thread,
+			 &(struct perf_sample){.cpumode = x->cpumode,
+					       .ip = ip}, &al);
 		printed += map__fprintf_srcline(al.map, al.addr, " srcline: ", fp);
 		printed += fprintf(fp, "\t");
 		addr_location__exit(&al);
@@ -1406,7 +1434,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	int off, printed = 0, ret = 0;
 
 	addr_location__init(&al);
-	thread__find_map(thread, cpumode, addr, &al);
+	thread__find_map(thread, &(struct perf_sample){.cpumode = cpumode, .ip = addr}, &al);
 
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
 		goto out;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 69cc89232d6c..16cf964f1f73 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -517,6 +517,7 @@ static char *cat_backtrace(struct perf_sample *sample,
 	size_t p_len;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	struct ip_callchain *chain = sample->callchain;
+	struct perf_sample ip_sample = {};
 	FILE *f = open_memstream(&p, &p_len);
 	bool corrupted = false;
 
@@ -565,7 +566,9 @@ static char *cat_backtrace(struct perf_sample *sample,
 
 		addr_location__init(&tal);
 		tal.filtered = 0;
-		if (thread__find_symbol(al.thread, cpumode, ip, &tal))
+		ip_sample.cpumode = cpumode;
+		ip_sample.ip = ip;
+		if (thread__find_symbol(al.thread, &ip_sample, &tal))
 			fprintf(f, "..... %016" PRIx64 " %s\n", ip, tal.sym->name);
 		else
 			fprintf(f, "..... %016" PRIx64 "\n", ip);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f9..a6df1633bd13 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3718,7 +3718,7 @@ static int trace__pgfault(struct trace *trace,
 	if (trace->summary_only)
 		goto out;
 
-	thread__find_symbol(thread, sample->cpumode, sample->ip, &al);
+	thread__find_symbol(thread, sample, &al);
 
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time,
 				  sample->cpu, trace->output);
@@ -3731,10 +3731,14 @@ static int trace__pgfault(struct trace *trace,
 
 	fprintf(trace->output, "] => ");
 
-	thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
+	thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->addr}, &al);
 
 	if (!al.map) {
-		thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
+		thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->addr}, &al);
 
 		if (al.map)
 			map_type = 'x';
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 7b80c4ab6916..50565c1e0cd0 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -387,6 +387,10 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	u64 skip_addr;
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
+	struct perf_sample sample = {
+		.cpumode = cpumode,
+		.ip = addr,
+	};
 	bool decomp = false;
 	int ret, err = 0;
 	struct dso *dso;
@@ -394,7 +398,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, addr, &al) || !map__dso(al.map)) {
+	if (!thread__find_map(thread, &sample, &al) || !map__dso(al.map)) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
 			goto out;
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 0c5619c6e6e9..dca8bbfe780a 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -195,8 +195,10 @@ static int mmap_events(synth_cb synth)
 
 		pr_debug("looking for map %p\n", td->map);
 
-		thread__find_map(thread, PERF_RECORD_MISC_USER,
-				 (unsigned long) (td->map + 1), &al);
+		thread__find_map(thread, &(struct perf_sample){
+					.cpumode = PERF_RECORD_MISC_USER,
+					.ip = (unsigned long) (td->map + 1),
+				 }, &al);
 
 		thread__put(thread);
 
@@ -208,7 +210,10 @@ static int mmap_events(synth_cb synth)
 		}
 
 		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
+
 		addr_location__exit(&al);
+		if (err)
+			break;
 	}
 
 	machine__delete(machine);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2332d465f975..d226c92be21c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -882,8 +882,9 @@ bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 	mem_addr = addr + map__reloc(dloc->ms->map);
 
 	addr_location__init(&al);
-	sym = thread__find_symbol_fb(dloc->thread, dloc->cpumode,
-				     mem_addr, &al);
+	sym = thread__find_symbol_fb(dloc->thread,
+				     &(struct perf_sample){.cpumode = dloc->cpumode,
+							   .ip = mem_addr}, &al);
 	if (sym) {
 		*var_name = sym->name;
 		/* Calculate type offset from the start of variable */
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index e236d5287043..4466e55f1286 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -148,6 +148,10 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 	struct remap_addresses_key key;
 	u64 *remapped_invariant_ptr = NULL;
 	u64 remap_addr = 0;
+	struct perf_sample sample = {
+		.cpumode = cpumode,
+		.ip = addr,
+	};
 	u8 effective_cpumode = cpumode;
 	struct dso *dso;
 	const char *dso_name;
@@ -156,7 +160,7 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		return 0; /* No thread. */
 
 	addr_location__init(&al);
-	if (!thread__find_map(aslr_thread, cpumode, addr, &al)) {
+	if (!thread__find_map(aslr_thread, &sample, &al)) {
 		/*
 		 * If lookup fails with specified cpumode, try fallback to the other space
 		 * to be robust against bad cpumode in samples.
@@ -170,7 +174,8 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		else if (cpumode == PERF_RECORD_MISC_GUEST_USER)
 			effective_cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
+		sample.cpumode = effective_cpumode;
+		if (!thread__find_map(aslr_thread, &sample, &al)) {
 			addr_location__exit(&al);
 			return 0; /* No mmap. */
 		}
@@ -287,18 +292,25 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
 	remap_key.pid = (cpumode == PERF_RECORD_MISC_KERNEL ||
 			 cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
 			kernel_pid : thread__pid(aslr_thread);
-	if (thread__find_map(aslr_thread, cpumode, start, &al)) {
-		struct dso *dso = map__dso(al.map);
-		const char *dso_name = dso ? dso__long_name(dso) : NULL;
-
-		remap_key.dso = dso;
-		if (dso && !is_anon_memory(dso_name) && !is_no_dso_memory(dso_name))
-			remap_key.invariant = map__start(al.map) - map__pgoff(al.map);
-		else
-			remap_key.invariant = map__start(al.map);
-	} else {
-		remap_key.dso = NULL;
-		remap_key.invariant = start;
+	{
+		struct perf_sample sample = {
+			.cpumode = cpumode,
+			.ip = start,
+		};
+
+		if (thread__find_map(aslr_thread, &sample, &al)) {
+			struct dso *dso = map__dso(al.map);
+			const char *dso_name = dso ? dso__long_name(dso) : NULL;
+
+			remap_key.dso = dso;
+			if (dso && !is_anon_memory(dso_name) && !is_no_dso_memory(dso_name))
+				remap_key.invariant = map__start(al.map) - map__pgoff(al.map);
+			else
+				remap_key.invariant = map__start(al.map);
+		} else {
+			remap_key.dso = NULL;
+			remap_key.invariant = start;
+		}
 	}
 
 	/* The key to look up top allocated address. */
@@ -338,13 +350,17 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
 	/* No mmap, create an entry from the top address. */
 	if (hashmap__find(&aslr->top_addresses, &top_addr_key, &top)) {
 		struct addr_location prev_al;
+		struct perf_sample prev_sample = {
+			.cpumode = cpumode,
+			.ip = start - 1,
+		};
 		bool is_contiguous = false;
 
 		/* Current max allocated mmap address within the process. */
 		remap_addr = top->remapped_max;
 
 		addr_location__init(&prev_al);
-		if (thread__find_map(aslr_thread, cpumode, start - 1, &prev_al)) {
+		if (thread__find_map(aslr_thread, &prev_sample, &prev_al)) {
 			if (map__end(prev_al.map) == start)
 				is_contiguous = true;
 		}
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 02233ef0eaff..6c0d33b1609d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -69,7 +69,7 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	}
 
 	addr_location__init(&al);
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
+	if (thread__find_map(thread, sample, &al))
 		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 95881f15324a..fbad96e1e6a9 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -252,7 +252,9 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *
 
 		addr_location__init(&al);
 		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
+		    thread__find_symbol(thread,
+					&(struct perf_sample){.cpumode = cpumode,
+							      .ip = op->imm}, &al)) {
 			printed += fprintf(fp, "%s ", insn[0].mnemonic);
 			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
 			if (print_opts & PRINT_INSN_IMM_HEX)
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3e01b401ca6f..f04157620ccc 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1182,9 +1182,15 @@ static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq,
 	}
 
 	cpumode = cs_etm__cpu_mode(etmq, address, el);
+	{
+		struct perf_sample sample = {
+			.cpumode = cpumode,
+			.ip = address,
+		};
 
-	if (!thread__find_map(thread, cpumode, address, &al))
-		goto out;
+		if (!thread__find_map(thread, &sample, &al))
+			goto out;
+	}
 
 	dso = map__dso(al.map);
 	if (!dso)
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 40888b7c4467..8fa7bfdaadff 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -235,7 +235,9 @@ static int process_sample_event(const struct perf_tool *tool,
 				fputc(',', out);
 
 			addr_location__init(&tal);
-			ok = thread__find_symbol(al.thread, cpumode, ip, &tal);
+			ok = thread__find_symbol(al.thread,
+						 &(struct perf_sample){.cpumode = cpumode,
+								       .ip = ip}, &tal);
 			output_sample_callchain_entry(tool, ip, ok ? &tal : NULL);
 			addr_location__exit(&tal);
 		}
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index b7095519419e..31ae1c318d2f 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -336,10 +336,14 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 	for (size_t i = 0; i < stackdump_size; i++) {
 		struct addr_location al;
 		u64 addr = (u64)(uintptr_t)stackdump[i];
+		struct perf_sample sample = {
+			.cpumode = PERF_RECORD_MISC_USER,
+			.ip = addr,
+		};
 		bool printed = false;
 
 		addr_location__init(&al);
-		if (thread && thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
+		if (thread && thread__find_map(thread, &sample, &al)) {
 			al.sym = map__find_symbol(al.map, al.addr);
 			if (al.sym) {
 				fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 7e179d1d84d7..c0c8e13d007e 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -177,7 +177,9 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 		return -1;
 
 	addr_location__init(&al);
-	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
+	thread__find_symbol_fb(thread,
+			       &(struct perf_sample){.cpumode = d->sample->cpumode,
+						     .ip = address}, &al);
 
 	al_to_d_al(&al, &d_al);
 
@@ -313,7 +315,9 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 
 	addr_location__init(&a);
 
-	thread__find_map_fb(al->thread, d->sample->cpumode, ip, &a);
+	thread__find_map_fb(al->thread,
+			    &(struct perf_sample){.cpumode = d->sample->cpumode,
+						  .ip = ip}, &a);
 	ret = a.map ? code_read(ip, a.map, d->machine, buf, len) : -1;
 
 	addr_location__exit(&a);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index cefb32833da8..4a6b59fa9d82 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -691,7 +691,7 @@ int perf_event__process(const struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 			     struct addr_location *al)
 {
 	struct maps *maps = thread__maps(thread);
@@ -702,31 +702,31 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
 
-	al->addr = addr;
-	al->cpumode = cpumode;
+	al->addr = sample->ip;
+	al->cpumode = sample->cpumode;
 	al->filtered = 0;
 
-	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
+	if (sample->cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
 		maps = machine__kernel_maps(machine);
 		load_map = !symbol_conf.lazy_load_kernel_maps;
-	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
+	} else if (sample->cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
-	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
+	} else if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
 		maps = machine__kernel_maps(machine);
 		load_map = !symbol_conf.lazy_load_kernel_maps;
-	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
+	} else if (sample->cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
 	} else {
 		al->level = 'H';
 
-		if ((cpumode == PERF_RECORD_MISC_GUEST_USER ||
-			cpumode == PERF_RECORD_MISC_GUEST_KERNEL) &&
+		if ((sample->cpumode == PERF_RECORD_MISC_GUEST_USER ||
+			sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL) &&
 			!perf_guest)
 			al->filtered |= (1 << HIST_FILTER__GUEST);
-		if ((cpumode == PERF_RECORD_MISC_USER ||
-			cpumode == PERF_RECORD_MISC_KERNEL) &&
+		if ((sample->cpumode == PERF_RECORD_MISC_USER ||
+			sample->cpumode == PERF_RECORD_MISC_KERNEL) &&
 			!perf_host)
 			al->filtered |= (1 << HIST_FILTER__HOST);
 
@@ -751,33 +751,34 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
  * because it applies only to the sample 'ip' and not necessary to 'addr' or
  * branch stack addresses. If possible, use a fallback to deal with those cases.
  */
-struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map_fb(struct thread *thread, struct perf_sample *sample,
 				struct addr_location *al)
 {
-	struct map *map = thread__find_map(thread, cpumode, addr, al);
+	struct map *map = thread__find_map(thread, sample, al);
 	struct machine *machine = maps__machine(thread__maps(thread));
-	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
+	u8 addr_cpumode = machine__addr_cpumode(machine, sample->cpumode, sample->ip);
 
-	if (map || addr_cpumode == cpumode)
+	if (map || addr_cpumode == sample->cpumode)
 		return map;
 
-	return thread__find_map(thread, addr_cpumode, addr, al);
+	sample->cpumode = addr_cpumode;
+	return thread__find_map(thread, sample, al);
 }
 
-struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
-				   u64 addr, struct addr_location *al)
+struct symbol *thread__find_symbol(struct thread *thread, struct perf_sample *sample,
+				   struct addr_location *al)
 {
 	al->sym = NULL;
-	if (thread__find_map(thread, cpumode, addr, al))
+	if (thread__find_map(thread, sample, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
 
-struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
-				      u64 addr, struct addr_location *al)
+struct symbol *thread__find_symbol_fb(struct thread *thread, struct perf_sample *sample,
+				      struct addr_location *al)
 {
 	al->sym = NULL;
-	if (thread__find_map_fb(thread, cpumode, addr, al))
+	if (thread__find_map_fb(thread, sample, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
@@ -813,7 +814,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		return -1;
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__tid(thread));
-	thread__find_map(thread, sample->cpumode, sample->ip, al);
+	thread__find_map(thread, sample, al);
 	dso = al->map ? map__dso(al->map) : NULL;
 	dump_printf(" ...... dso: %s\n",
 		dso
@@ -931,7 +932,9 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map_fb(thread, sample->cpumode, sample->addr, al);
+	thread__find_map_fb(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->addr}, al);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e8b9c8a67b0a..62d8ac4a913c 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -752,6 +752,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 {
 	struct intel_pt_queue *ptq = data;
 	struct machine *machine = ptq->pt->machine;
+	struct perf_sample sample = {};
 	struct thread *thread;
 	struct addr_location al;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
@@ -809,10 +810,13 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		}
 	}
 
+	sample.cpumode = cpumode;
+
 	while (1) {
 		struct dso *dso;
 
-		if (!thread__find_map(thread, cpumode, *ip, &al) || !map__dso(al.map)) {
+		sample.ip = *ip;
+		if (!thread__find_map(thread, &sample, &al) || !map__dso(al.map)) {
 			if (al.map)
 				intel_pt_log("ERROR: thread has no dso for %#" PRIx64 "\n", *ip);
 			else
@@ -1007,8 +1011,15 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 		return -EINVAL;
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map))
-		return -EINVAL;
+	{
+		struct perf_sample sample = {
+			.cpumode = cpumode,
+			.ip = ip,
+		};
+
+		if (!thread__find_map(thread, &sample, &al) || !map__dso(al.map))
+			return -EINVAL;
+	}
 
 	offset = map__map_ip(al.map, ip);
 
@@ -3663,7 +3674,12 @@ static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
 	if (!al->map || addr < map__start(al->map) || addr >= map__end(al->map)) {
-		if (!thread__find_map(thread, cpumode, addr, al))
+		struct perf_sample sample = {
+			.cpumode = cpumode,
+			.ip = addr,
+		};
+
+		if (!thread__find_map(thread, &sample, al))
 			return -1;
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c7f5ef32d5bd..a228361a8490 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2093,6 +2093,7 @@ static void ip__resolve_ams(struct thread *thread,
 			    struct addr_map_symbol *ams,
 			    u64 ip)
 {
+	static __thread struct perf_sample sample;
 	struct addr_location al;
 
 	addr_location__init(&al);
@@ -2103,7 +2104,8 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
+	sample.ip = ip;
+	thread__find_cpumode_addr_location(thread, &sample, /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2120,11 +2122,14 @@ static void ip__resolve_data(struct thread *thread,
 			     u8 m, struct addr_map_symbol *ams,
 			     u64 addr, u64 phys_addr, u64 daddr_page_size)
 {
+	static __thread struct perf_sample sample;
 	struct addr_location al;
 
 	addr_location__init(&al);
 
-	thread__find_symbol(thread, m, addr, &al);
+	sample.cpumode = m;
+	sample.ip = addr;
+	thread__find_symbol(thread, &sample, &al);
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
@@ -2247,6 +2252,7 @@ static int add_callchain_ip(struct thread *thread,
 			    u64 branch_from,
 			    bool symbols)
 {
+	static __thread struct perf_sample sample;
 	struct map_symbol ms = {};
 	struct addr_location al;
 	int nr_loop_iter = 0, err = 0;
@@ -2257,8 +2263,9 @@ static int add_callchain_ip(struct thread *thread,
 	al.filtered = 0;
 	al.sym = NULL;
 	al.srcline = NULL;
+	sample.ip = ip;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
+		thread__find_cpumode_addr_location(thread, &sample, symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2287,10 +2294,11 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			goto out;
 		}
+		sample.cpumode = *cpumode;
 		if (symbols)
-			thread__find_symbol(thread, *cpumode, ip, &al);
+			thread__find_symbol(thread, &sample, &al);
 		else
-			thread__find_map(thread, *cpumode, ip, &al);
+			thread__find_map(thread, &sample, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1efbe5bb26b1..f5d9e7152ef4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -877,7 +877,10 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 
 	if (addr != pevent->sample->ip) {
 		addr_location__init(&al);
-		thread__find_symbol_fb(pevent->al.thread, pevent->sample->cpumode, addr, &al);
+		thread__find_symbol_fb(pevent->al.thread,
+			       &(struct perf_sample){
+				       .cpumode = pevent->sample->cpumode,
+				       .ip = addr}, &al);
 	} else {
 		addr_location__init(&al);
 		al.thread = thread__get(pevent->al.thread);
@@ -1303,8 +1306,12 @@ static int pyrf_sample_event__resolve_addr_al(struct pyrf_event *pevent,
 	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.thread)
 		return -1;
 
-	thread__find_symbol_fb(pevent->al.thread, pevent->sample->cpumode,
-			       pevent->sample->addr, addr_al);
+	thread__find_symbol_fb(pevent->al.thread,
+			       &(struct perf_sample){
+				       .cpumode = pevent->sample->cpumode,
+				       .ip = pevent->sample->addr,
+			       },
+			       addr_al);
 	return 0;
 }
 
@@ -4481,6 +4488,7 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 					      struct thread *thread)
 {
 	struct pyrf_callchain *pchain;
+	struct perf_sample sample = {};
 	const struct call_path *pos;
 	u64 nr_frames = 0;
 
@@ -4513,7 +4521,9 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 						    : PERF_RECORD_MISC_USER;
 
 			addr_location__init(&al);
-			thread__find_map(thread, cpumode, pos->ip, &al);
+			sample.cpumode = cpumode;
+			sample.ip = pos->ip;
+			thread__find_map(thread, &sample, &al);
 			frame->map = map__get(al.map);
 			if (frame->map)
 				frame->sym = pos->sym;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 91118c301913..ad3f1ae8a92e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -413,7 +413,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 	return thread__clone_maps(thread, parent, do_maps_clone);
 }
 
-void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
+void thread__find_cpumode_addr_location(struct thread *thread, struct perf_sample *sample,
 					bool symbols, struct addr_location *al)
 {
 	size_t i;
@@ -425,10 +425,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
+		sample->cpumode = cpumodes[i];
 		if (symbols)
-			thread__find_symbol(thread, cpumodes[i], addr, al);
+			thread__find_symbol(thread, sample, al);
 		else
-			thread__find_map(thread, cpumodes[i], addr, al);
+			thread__find_map(thread, sample, al);
 
 		if (al->map)
 			break;
@@ -579,6 +580,7 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit)
 {
 	u8 cpumode = PERF_RECORD_MISC_USER;
+	struct perf_sample sample = { .ip = ip };
 	struct addr_location al;
 	struct dso *dso;
 	long offset;
@@ -587,7 +589,8 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 		cpumode = PERF_RECORD_MISC_KERNEL;
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, ip, &al)) {
+	sample.cpumode = cpumode;
+	if (!thread__find_map(thread, &sample, &al)) {
 		addr_location__exit(&al);
 		return -1;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d82fce8173ae..f0c50eafeee5 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -124,17 +124,17 @@ size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
 
-struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 			     struct addr_location *al);
-struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map_fb(struct thread *thread, struct perf_sample *sample,
 				struct addr_location *al);
 
-struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
-				   u64 addr, struct addr_location *al);
-struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
-				      u64 addr, struct addr_location *al);
+struct symbol *thread__find_symbol(struct thread *thread, struct perf_sample *sample,
+				   struct addr_location *al);
+struct symbol *thread__find_symbol_fb(struct thread *thread, struct perf_sample *sample,
+				      struct addr_location *al);
 
-void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
+void thread__find_cpumode_addr_location(struct thread *thread, struct perf_sample *sample,
 					bool symbols, struct addr_location *al);
 
 int thread__memcpy(struct thread *thread, struct machine *machine,
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index d49901b1571e..855faa54c0cf 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -82,7 +82,9 @@ static int __report_module(struct addr_location *al, u64 ip,
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
 	 */
-	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
+	thread__find_symbol(ui->thread,
+			    &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			    al);
 
 	if (al->map)
 		dso = map__dso(al->map);
@@ -208,13 +210,14 @@ static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
 static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 			  Dwarf_Word *data, size_t len)
 {
+	struct perf_sample sample = { .cpumode = PERF_RECORD_MISC_USER, .ip = addr };
 	struct addr_location al;
 	union u64_swap u;
 	ssize_t size;
 	struct dso *dso;
 
 	addr_location__init(&al);
-	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
+	if (!thread__find_map(ui->thread, &sample, &al)) {
 		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
 		goto out_fail;
 	}
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 6052383e862b..83f043f266da 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -370,7 +370,9 @@ static struct map *find_map(uint64_t ip, struct unwind_info *ui)
 	struct map *ret;
 
 	addr_location__init(&al);
-	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_map(ui->thread,
+			 &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			 &al);
 	ret = map__get(al.map);
 	addr_location__exit(&al);
 	return ret;
@@ -626,7 +628,9 @@ static int entry(uint64_t ip, struct thread *thread, unwind_entry_cb_t cb, void
 	int ret;
 
 	addr_location__init(&al);
-	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	e.ms.sym = thread__find_symbol(thread,
+				       &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER,
+							     .ip = ip}, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
 	e.ms.thread = thread__get(al.thread);
-- 
2.56.1.703.gf848ed807c-goog

