Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D820696D;
	Mon, 28 Oct 2024 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152129; cv=none; b=fGoutQNgwHSJdSY/q6vXE3G1DnebwsJdl+QoBwjOCQct2qTj3OAXuw0359nZUgKs5YC+PCrcg/46jTsrrdl1gQ6gJokjsUkk1So1octYvrAFIwzxY25TTxgPeCzFTPoSRdVka1S07ryvxZvWbG1P8fJ6TqNesJQYYra7XPRIszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152129; c=relaxed/simple;
	bh=ypsDBvSscFTP4kYetsVF+YmFMPEp+IMuIsyncuhHNwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLWGj4BTuUQN14Oui/lMLtdjMlWwXWDlYUq1pfyy7xIyray0PTcR6WNqzJFy26+OPoPoviAIg0jwTWhxC6dGgugrmEnumMsTBISbbrE0d2S7U/xvj4SaOTmtMN0Vw5sERmxII9uz2EgW/6yNiwAU7nA0a20DdLbcXstAg2F5aIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS/p3ecb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS/p3ecb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F6CC4CEE7;
	Mon, 28 Oct 2024 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152128;
	bh=ypsDBvSscFTP4kYetsVF+YmFMPEp+IMuIsyncuhHNwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oS/p3ecbY8bkbTkk72fAOKRXh0icpyiesDzlgJy3UyUeDsU8kxP81hSLpNoMnDuZb
	 2a12LJ97JVbiWJj9oEXj7rkhb3i9YpXnFe8dBe5QSI93jBbEvbMzClx2Ysg8F32WH5
	 ZFZFixyQ7vbFeZOexl9wiG3ZiifkDA/YzsfikB4GSPVW+danbHKIKJBWyEZIrkLpIO
	 WoSz/sj1bpKq5NjykP3OBw7M1lj+57nGHAUbaS35Ktn/tOc9qkMv389FFgvW7/iPr0
	 MG3DG4Tdsq6Npr3gbVRnr0V7yFizTgOqKd0E5bKhp/R86LLEQmbhjCwAScDHtHTxZC
	 ebX3b0vwHkviw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 18/19] perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
Date: Mon, 28 Oct 2024 14:48:05 -0700
Message-ID: <f78f657c8343d1c7286fda9dd4aa7c684592c7c9.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241028214805.Vee-N4IzTOwoiqRzl8miM3-CG6fOL6LjDmI0K871JTk@z>

From: Namhyung Kim <namhyung@kernel.org>

Handle the deferred callchains in the script output.

  $ perf script
  perf     801 [000]    18.031793:          1 cycles:P:
          ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
          ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
          ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
          ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
          ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
          ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
          ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
          ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
          ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
          ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
          ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
          ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
          ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])

  perf     801 [000]    18.031814: DEFERRED CALLCHAIN
              7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/perf/builtin-script.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a644787fa9e1..311580e25f5b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2540,6 +2540,93 @@ static int process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
+static int process_deferred_sample_event(const struct perf_tool *tool,
+					 union perf_event *event,
+					 struct perf_sample *sample,
+					 struct evsel *evsel,
+					 struct machine *machine)
+{
+	struct perf_script *scr = container_of(tool, struct perf_script, tool);
+	struct perf_event_attr *attr = &evsel->core.attr;
+	struct evsel_script *es = evsel->priv;
+	unsigned int type = output_type(attr->type);
+	struct addr_location al;
+	FILE *fp = es->fp;
+	int ret = 0;
+
+	if (output[type].fields == 0)
+		return 0;
+
+	/* Set thread to NULL to indicate addr_al and al are not initialized */
+	addr_location__init(&al);
+
+	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
+					  sample->time)) {
+		goto out_put;
+	}
+
+	if (debug_mode) {
+		if (sample->time < last_timestamp) {
+			pr_err("Samples misordered, previous: %" PRIu64
+				" this: %" PRIu64 "\n", last_timestamp,
+				sample->time);
+			nr_unordered++;
+		}
+		last_timestamp = sample->time;
+		goto out_put;
+	}
+
+	if (filter_cpu(sample))
+		goto out_put;
+
+	if (machine__resolve(machine, &al, sample) < 0) {
+		pr_err("problem processing %d event, skipping it.\n",
+		       event->header.type);
+		ret = -1;
+		goto out_put;
+	}
+
+	if (al.filtered)
+		goto out_put;
+
+	if (!show_event(sample, evsel, al.thread, &al, NULL))
+		goto out_put;
+
+	if (evswitch__discard(&scr->evswitch, evsel))
+		goto out_put;
+
+	perf_sample__fprintf_start(scr, sample, al.thread, evsel,
+				   PERF_RECORD_CALLCHAIN_DEFERRED, fp);
+	fprintf(fp, "DEFERRED CALLCHAIN");
+
+	if (PRINT_FIELD(IP)) {
+		struct callchain_cursor *cursor = NULL;
+
+		if (symbol_conf.use_callchain && sample->callchain) {
+			cursor = get_tls_callchain_cursor();
+			if (thread__resolve_callchain(al.thread, cursor, evsel,
+						      sample, NULL, NULL,
+						      scripting_max_stack)) {
+				pr_info("cannot resolve deferred callchains\n");
+				cursor = NULL;
+			}
+		}
+
+		fputc(cursor ? '\n' : ' ', fp);
+		sample__fprintf_sym(sample, &al, 0, output[type].print_ip_opts,
+				    cursor, symbol_conf.bt_stop_list, fp);
+	}
+
+	fprintf(fp, "\n");
+
+	if (verbose > 0)
+		fflush(fp);
+
+out_put:
+	addr_location__exit(&al);
+	return ret;
+}
+
 // Used when scr->per_event_dump is not set
 static struct evsel_script es_stdout;
 
@@ -4325,6 +4412,7 @@ int cmd_script(int argc, const char **argv)
 
 	perf_tool__init(&script.tool, !unsorted_dump);
 	script.tool.sample		 = process_sample_event;
+	script.tool.callchain_deferred	 = process_deferred_sample_event;
 	script.tool.mmap		 = perf_event__process_mmap;
 	script.tool.mmap2		 = perf_event__process_mmap2;
 	script.tool.comm		 = perf_event__process_comm;
@@ -4351,6 +4439,7 @@ int cmd_script(int argc, const char **argv)
 	script.tool.throttle		 = process_throttle_event;
 	script.tool.unthrottle		 = process_throttle_event;
 	script.tool.ordering_requires_timestamps = true;
+	script.tool.merge_deferred_callchains = false;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.47.0

