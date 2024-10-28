Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337AA206E82;
	Mon, 28 Oct 2024 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152130; cv=none; b=RDA3rXi1s2jX+uUJagLCC1jxTKmczZMgONS5hKvXOHu9I7V+093JD2SxsqY2MIkwtQIU5gxTJTUczPIjFHhKA2Emg2oYbRt7OaQew0NyQ++5GZQQNISW46l3vd6t0x6MLyiXISkDAin9lHym2iyY6U0KZlA1EDmpFPSQD3sfVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152130; c=relaxed/simple;
	bh=WyQ7upbPHHR2F6skLp0O6redGtIa3A+g4lv+tFWe+IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBabJLwmq8+bKP1r5jyjbnfkGPtn8O4MQNeRKI9xKk+bLKivPvic01fpgzCnKtf6zGuoJ8rb6QiHVpF7D+XB4VcTgEZT8kPypLZ5oCfPoQHvTaz5Nz/QV8M3sYe5wPGHYbkyykrtK7xEgqM9Yl4/A+9Dn/CfXSskPDOenpN0HOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQubj6yg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQubj6yg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0084C4CEE8;
	Mon, 28 Oct 2024 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152130;
	bh=WyQ7upbPHHR2F6skLp0O6redGtIa3A+g4lv+tFWe+IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQubj6yge79GGghc6covRoW+auFgMxtGwbFVp936vl7BCNt55EJPWz3RJBav5c40f
	 eV3oN1vRgT102B99uCFHlhRtHYrwQaD0QxTBvTHQc9wrTzx+w918ZovzDOLb5lr8j+
	 KiCLN6CA93bRaZ24AK2RCZn9TBKiDJ0sIJ71epCyAY0yEKm2mqJAtS2ee+yyRx+mep
	 /cTkSth2TvlR5nTrTVHzLN96vm4a1NZAWkIyDo3XOs3w4L9tlQVFwJ0kNm+4sivTyG
	 B+RycPnEvAdjqGot1dW4JJ73WciLylj7INZd1r6vk6ORrhhOUT33UpwoKiipDoiopj
	 q2X0MnoiATe7Q==
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
Subject: [PATCH v3 19/19] perf tools: Merge deferred user callchains
Date: Mon, 28 Oct 2024 14:48:06 -0700
Message-ID: <bf761da86e91c09e3d916a3f004101f4d4544407.1730150953.git.jpoimboe@kernel.org>
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
Message-ID: <20241028214806.fJm64CVK6GHpHsdt9dViGS4qXsSb0QGR5y4PZnAqRKU@z>

From: Namhyung Kim <namhyung@kernel.org>

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
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
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
index b72866ef270b..69f018b3d199 100644
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
index 311580e25f5b..e3acf4979c36 100644
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
index 0c7564747a14..d1114491c3da 100644
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
index 86ed9e4d04f9..89785125ed25 100644
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
index f14b7e6ff1dc..f27d8c4a22aa 100644
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
index bcc1c6984bb5..c26379366554 100644
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
index 1248a0317a2f..e0a21b896b57 100644
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
index e78f16de912e..385043e06627 100644
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
index 9987bbde6d5e..d06580478ab1 100644
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
2.47.0

