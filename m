Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92869192595;
	Tue, 17 Sep 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612125; cv=none; b=a7r23+JX+2fCxAdPopjwRe3D0E6QQIPU6PWQdvOf5UY1COBk7NZijVstjMZN5T5I61NtRm2VDfYxrrsUbpWMzR2+S6DvLZU0/5KDCpBWd3AiUmg1yTQAkWIdzsuKWi+HRFg16rgEr3nHvV3wudeMbbq+mWzDTzsyiu3pttP5LZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612125; c=relaxed/simple;
	bh=/QG97BY6YAFfDemurMlh1FepNL4wqyS+Q72zKPdbUnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSbOxouK7p0IFYMdcYl7jRr4iW/xIeuF2arWuxuAaGzbBmluJzQc3dQiUgHOUTFei3JxzcEGXbjLxI7u5h/059kDY12+NTUIdGS4M9P7qelsOyahHKRPxPHRkFz1hrCUWc5DKfXrgh7EWvnklHUGF6+K2yVM3upG59LuWHSBRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIaamC1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIaamC1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC33C4CED7;
	Tue, 17 Sep 2024 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612125;
	bh=/QG97BY6YAFfDemurMlh1FepNL4wqyS+Q72zKPdbUnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIaamC1chnaEC/RA6WvZdIha6eIxRtcDP18CVMa3/P84tYGIK3OwD0pxFUIIEDaOm
	 bugxC/NdJsaqlCNueXcPUSY8F+GgxUjD11JH1zmw31SpKnMh/82wxdGN13teb0v1sV
	 ZFofmMhDsn9FioJ/xqQwRy9JG2A+DUs5iuDk9otdqnfQunFnIsaEzgGxZn8gn3R+54
	 TyMDNJnhJV95ff0eWtGaA02vgWpaDlHSMawtd5YbMRlszwdT94WcQW8EbAkovf6TzF
	 vFQO036vJteM2hLZp91DxyiCtiyzASesz0KYDOZPxLI58s6t3O22P62wDtzJx+GHgx
	 ae5Y6GeCeWXxg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 5/5] perf tools: Merge deferred user callchains
Date: Tue, 17 Sep 2024 15:28:20 -0700
Message-ID: <20240917222820.197594-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240917222820.197594-1-namhyung@kernel.org>
References: <20240917222820.197594-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save samples with deferred callchains in a separate list and deliver
them after merging the user callchains.  If users don't want to merge
they can set tool->merge_deferred_callchains to false to prevent the
behavior.

With previous result, now perf script will show the merged callchains.

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
              7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
  ...

The old output can be get using --no-merge-callchain option.
Also perf report can get the user callchain entry at the end.

  $ perf report --no-children --percent-limit=0 --stdio -q -S __intel_pmu_enable_all.isra.0
  # symbol: __intel_pmu_enable_all.isra.0
       0.00%  perf     [kernel.kallsyms]
              |
              ---__intel_pmu_enable_all.isra.0
                 perf_ctx_enable
                 event_function
                 remote_function
                 generic_exec_single
                 smp_call_function_single
                 event_function_call
                 perf_event_for_each_child
                 _perf_ioctl
                 perf_ioctl
                 __x64_sys_ioctl
                 do_syscall_64
                 entry_SYSCALL_64
                 __GI___ioctl

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  5 ++
 tools/perf/builtin-script.c              |  5 +-
 tools/perf/util/callchain.c              | 24 +++++++++
 tools/perf/util/callchain.h              |  3 ++
 tools/perf/util/evlist.c                 |  1 +
 tools/perf/util/evlist.h                 |  1 +
 tools/perf/util/session.c                | 63 +++++++++++++++++++++++-
 tools/perf/util/tool.c                   |  1 +
 tools/perf/util/tool.h                   |  1 +
 9 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index b72866ef270b9068..69f018b3d1993716 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -518,6 +518,11 @@ include::itrace.txt[]
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
 
+--merge-callchains::
+	Enable merging deferred user callchains if available.  This is the
+	default behavior.  If you want to see separate CALLCHAIN_DEFERRED
+	records for some reason, use --no-merge-callchains explicitly.
+
 :GMEXAMPLECMD: script
 :GMEXAMPLESUBCMD:
 include::guest-files.txt[]
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 311580e25f5b2008..e3acf4979c36d902 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4031,6 +4031,7 @@ int cmd_script(int argc, const char **argv)
 	bool header_only = false;
 	bool script_started = false;
 	bool unsorted_dump = false;
+	bool merge_deferred_callchains = true;
 	char *rec_script_path = NULL;
 	char *rep_script_path = NULL;
 	struct perf_session *session;
@@ -4184,6 +4185,8 @@ int cmd_script(int argc, const char **argv)
 		    "Guest code can be found in hypervisor process"),
 	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
+	OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
+		    "Enable merge deferred user callchains"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
@@ -4439,7 +4442,7 @@ int cmd_script(int argc, const char **argv)
 	script.tool.throttle		 = process_throttle_event;
 	script.tool.unthrottle		 = process_throttle_event;
 	script.tool.ordering_requires_timestamps = true;
-	script.tool.merge_deferred_callchains = false;
+	script.tool.merge_deferred_callchains = merge_deferred_callchains;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0c7564747a14e539..d1114491c3da5d0a 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1832,3 +1832,27 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 	}
 	return 0;
 }
+
+int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
+				     struct perf_sample *sample_callchain)
+{
+	u64 nr_orig = sample_orig->callchain->nr - 1;
+	u64 nr_deferred = sample_callchain->callchain->nr;
+	struct ip_callchain *callchain;
+
+	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
+	if (callchain == NULL) {
+		sample_orig->deferred_callchain = false;
+		return -ENOMEM;
+	}
+
+	callchain->nr = nr_orig + nr_deferred;
+	/* copy except for the last PERF_CONTEXT_USER_DEFERRED */
+	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
+	/* copy deferred use callchains */
+	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
+	       nr_deferred * sizeof(u64));
+
+	sample_orig->callchain = callchain;
+	return 0;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86ed9e4d04f9ee7b..89785125ed25783d 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -317,4 +317,7 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 				    struct perf_sample *sample, int max_stack,
 				    bool symbols, callchain_iter_fn cb, void *data);
 
+int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
+				     struct perf_sample *sample_callchain);
+
 #endif	/* __PERF_CALLCHAIN_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f14b7e6ff1dcc2cd..f27d8c4a22aadde9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -81,6 +81,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->ctl_fd.ack = -1;
 	evlist->ctl_fd.pos = -1;
 	evlist->nr_br_cntr = -1;
+	INIT_LIST_HEAD(&evlist->deferred_samples);
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bcc1c6984bb58a9d..c26379366554cf09 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -84,6 +84,7 @@ struct evlist {
 		int	pos;	/* index at evlist core object to check signals */
 	} ctl_fd;
 	struct event_enable_timer *eet;
+	struct list_head deferred_samples;
 };
 
 struct evsel_str_handler {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1248a0317a2f164a..e0a21b896b5784f3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1256,6 +1256,56 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 					    &sample->read.one, machine);
 }
 
+struct deferred_event {
+	struct list_head list;
+	union perf_event *event;
+};
+
+static int evlist__deliver_deferred_samples(struct evlist *evlist,
+					    const struct perf_tool *tool,
+					    union  perf_event *event,
+					    struct perf_sample *sample,
+					    struct machine *machine)
+{
+	struct deferred_event *de, *tmp;
+	struct evsel *evsel;
+	int ret = 0;
+
+	if (!tool->merge_deferred_callchains) {
+		evsel = evlist__id2evsel(evlist, sample->id);
+		return tool->callchain_deferred(tool, event, sample,
+						evsel, machine);
+	}
+
+	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
+		struct perf_sample orig_sample;
+
+		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
+		if (ret < 0) {
+			pr_err("failed to parse original sample\n");
+			break;
+		}
+
+		if (sample->tid != orig_sample.tid)
+			continue;
+
+		evsel = evlist__id2evsel(evlist, orig_sample.id);
+		sample__merge_deferred_callchain(&orig_sample, sample);
+		ret = evlist__deliver_sample(evlist, tool, de->event,
+					     &orig_sample, evsel, machine);
+
+		if (orig_sample.deferred_callchain)
+			free(orig_sample.callchain);
+
+		list_del(&de->list);
+		free(de);
+
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 static int machines__deliver_event(struct machines *machines,
 				   struct evlist *evlist,
 				   union perf_event *event,
@@ -1284,6 +1334,16 @@ static int machines__deliver_event(struct machines *machines,
 			return 0;
 		}
 		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
+		if (sample->deferred_callchain && tool->merge_deferred_callchains) {
+			struct deferred_event *de = malloc(sizeof(*de));
+
+			if (de == NULL)
+				return -ENOMEM;
+
+			de->event = event;
+			list_add_tail(&de->list, &evlist->deferred_samples);
+			return 0;
+		}
 		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
@@ -1343,7 +1403,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->aux_output_hw_id(tool, event, sample, machine);
 	case PERF_RECORD_CALLCHAIN_DEFERRED:
 		dump_deferred_callchain(evsel, event, sample);
-		return tool->callchain_deferred(tool, event, sample, evsel, machine);
+		return evlist__deliver_deferred_samples(evlist, tool, event,
+							sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index e78f16de912ed9e2..385043e06627d269 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -238,6 +238,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->cgroup_events = false;
 	tool->no_warn = false;
 	tool->show_feat_hdr = SHOW_FEAT_NO_HEADER;
+	tool->merge_deferred_callchains = true;
 
 	tool->sample = process_event_sample_stub;
 	tool->mmap = process_event_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9987bbde6d5e0565..d06580478ab17a88 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -87,6 +87,7 @@ struct perf_tool {
 	bool		cgroup_events;
 	bool		no_warn;
 	bool		dont_split_sample_group;
+	bool		merge_deferred_callchains;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
2.46.0.792.g87dc391469-goog

