Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FD21C9F4
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Nov 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301470; cv=none; b=cCQGm71fEIaLXAyrq/EpFkXE1iINuy6YB0BPntXfDi/RJt8+nxIHZegi+45N/C71OWkwqvRXqz+9YXIRCDfifiYhzfxoKN8x/Aeg214Muj1m1S10paadJztdJaLcWDEvSWg8OQOtP2prfxk8yrstUtBE587Cdn3dpdU3hhEmqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301470; c=relaxed/simple;
	bh=82HpdubjRbvng0dUaO0TnvEv9RlyM2a5jrl3yGnWbZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VJv7euvo7FeDbc1eXmibr00Xtc7NIVsjgTUThXwFTSA+fC7Mn4IbuPg2szTp40OSuaiv7VvKfRz5TKI9KKcj+q29eJ8QVkhAVrZSoxzMxKepsN2uZaGXhuJosHY/wl5rItjEOObaHwOs5OFdWlJG5eeTga9PT7bo3NollaQ37no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dk220nfE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dk220nfE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781171fe1c5so5962709b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 16:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762301468; x=1762906268; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KTjPMbRZQ3d5S0Dvquxx8sKZAfkGkk1Qv4WANYVN+mA=;
        b=dk220nfEiJ9EyVtiuEBpm5ODO5u3G/rRtmNG8KJ0yGltENx5/UjV6iEel4AFno8WM7
         ePAuW3W5BC0xYOzitl/AN7Cv0N1RccBg4V+pkmeKV6B5FrLIrP3GIdPR+ewgR8C1K3fA
         i7cMN6QXOfGD2CHzYjfwayug3Y530v9ydmdmu9SCuzAC3BLGrnY7zI9AVfJSwW7Q8r8j
         smJCKZzVk+p4DNwtMDjIGzexpMSmRaDW6/Z90cD+1lYGqWv6iuRGKXvfEwetuuRUQ7DG
         9kSC5j9F4XjyFeof+OL5oHtJvgvlU9htnmmmHc06hqjIjcnpR4t7jdAW40Fj1WIu//Vk
         hy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301468; x=1762906268;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTjPMbRZQ3d5S0Dvquxx8sKZAfkGkk1Qv4WANYVN+mA=;
        b=AwRGmfjSM5FNHFIhhl3SWIE6iBebxLTVBQOqN51aDbx75ux74XYUgCBLwJgbM7hTIP
         GnQrxRx6zAhO8pHCAY26Tvgzqv7Pizmh6nnEmGNvZ69b6hKcw3XSjT82Ll8Slia8lIQT
         DYCxS61XHoW58wjkhi4nfuzEsOoy2tQ+ZMrWxl7G2pVrFpkZYUocta6VThbyttRTQ68A
         wC2KMU8SbF+PwwDAtS+fNPErmYzAYKuE3vP56p4qrMiFQkYUWwLKYQs7qgX7gkdP00+2
         V/pep07QJIFZXSAiEIWMNtLqwYYfhnhHIgicZqYQA2nS/xrtJ5MTqmL72kwQsqRzsE/C
         E4sg==
X-Forwarded-Encrypted: i=1; AJvYcCXlt4xOti6hHoropseB5ydbIxN5fo/bZ8ZZ2hzN6hk+oHN6qC0ujokE85ZScypv76zKCo0K0VHb02itT4i66ayQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3DYBPnZgIyrgg+sL/9wB51VPZYaJtYXCgx4Vo7kItT6nrXCy
	oOzrpLzTK+dk/FUO+8jQUbsj/+HPmCOWF8cHX0ekrUZzsAoY1lk9urSHmIWm7WNxwTGoeaVZQwF
	StowNu7+8+g==
X-Google-Smtp-Source: AGHT+IG93lcOPNOddhFnI2Wvi/Wo6FULk/amTonZDas9w3OP02Hd7e1pDqx2MSdHfALGANv8dYJWZ1+s3vaa
X-Received: from dlbvv4.prod.google.com ([2002:a05:7022:5f04:b0:119:49ca:6b93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a6:b0:34e:e0ba:7c4
 with SMTP id adf61e73a8af0-34f811bd29bmr1662913637.0.1762301467656; Tue, 04
 Nov 2025 16:11:07 -0800 (PST)
Date: Tue,  4 Nov 2025 16:11:02 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251105001103.1296863-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf tool: Add the perf_tool argument to all callbacks
From: Ian Rogers <irogers@google.com>
To: Gabriel Marin <gmx@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Blake Jones <blakejones@google.com>, Anubhav Shelat <ashelat@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Getting context for what a tool is doing, such as the perf_inject
instance, using container_of the tool is a common pattern in the
code. This isn't possible event_op2, event_op3 and event_op4 callbacks
as the tool isn't passed. Add the argument and then fix function
signatures to match. As tools maybe reading a tool from somewhere
else, change that code to use the passed in tool.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c |  3 ++-
 tools/perf/builtin-evlist.c   |  3 ++-
 tools/perf/builtin-inject.c   | 33 +++++++++++++------------
 tools/perf/builtin-report.c   |  5 ++--
 tools/perf/builtin-script.c   | 31 +++++++++++++----------
 tools/perf/builtin-stat.c     | 15 ++++++------
 tools/perf/util/auxtrace.c    |  9 ++++---
 tools/perf/util/auxtrace.h    |  9 ++++---
 tools/perf/util/header.c      |  6 +++--
 tools/perf/util/header.h      |  6 +++--
 tools/perf/util/intel-tpebs.c |  3 ++-
 tools/perf/util/session.c     | 35 +++++++++++++-------------
 tools/perf/util/session.h     |  3 ++-
 tools/perf/util/stat.c        |  3 ++-
 tools/perf/util/stat.h        |  3 ++-
 tools/perf/util/tool.c        | 46 ++++++++++++++++++++---------------
 tools/perf/util/tool.h        | 10 +++++---
 17 files changed, 130 insertions(+), 93 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 112b15952016..9c27bb30b708 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -313,7 +313,8 @@ static int process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
-static int process_feature_event(struct perf_session *session,
+static int process_feature_event(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index a9bd7bbef5a9..fb6e2c3c24c8 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -19,7 +19,8 @@
 #include "util/tool.h"
 #include "util/util.h"
 
-static int process_header_feature(struct perf_session *session __maybe_unused,
+static int process_header_feature(const struct perf_tool *tool __maybe_unused,
+				  struct perf_session *session __maybe_unused,
 				  union perf_event *event __maybe_unused)
 {
 	session_done = 1;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a114b3fa1bea..430be6022cb0 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -197,18 +197,20 @@ static int perf_event__drop_oe(const struct perf_tool *tool __maybe_unused,
 }
 #endif
 
-static int perf_event__repipe_op2_synth(struct perf_session *session,
+static int perf_event__repipe_op2_synth(const struct perf_tool *tool,
+					struct perf_session *session __maybe_unused,
 					union perf_event *event)
 {
-	return perf_event__repipe_synth(session->tool, event);
+	return perf_event__repipe_synth(tool, event);
 }
 
-static int perf_event__repipe_op4_synth(struct perf_session *session,
+static int perf_event__repipe_op4_synth(const struct perf_tool *tool,
+					struct perf_session *session __maybe_unused,
 					union perf_event *event,
 					u64 data __maybe_unused,
 					const char *str __maybe_unused)
 {
-	return perf_event__repipe_synth(session->tool, event);
+	return perf_event__repipe_synth(tool, event);
 }
 
 static int perf_event__repipe_attr(const struct perf_tool *tool,
@@ -258,12 +260,11 @@ static int copy_bytes(struct perf_inject *inject, struct perf_data *data, off_t
 	return 0;
 }
 
-static s64 perf_event__repipe_auxtrace(struct perf_session *session,
+static s64 perf_event__repipe_auxtrace(const struct perf_tool *tool,
+				       struct perf_session *session,
 				       union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
-	struct perf_inject *inject = container_of(tool, struct perf_inject,
-						  tool);
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	int ret;
 
 	inject->have_auxtrace = true;
@@ -661,12 +662,13 @@ static int perf_event__repipe_exit(const struct perf_tool *tool,
 }
 
 #ifdef HAVE_LIBTRACEEVENT
-static int perf_event__repipe_tracing_data(struct perf_session *session,
+static int perf_event__repipe_tracing_data(const struct perf_tool *tool,
+					   struct perf_session *session,
 					   union perf_event *event)
 {
-	perf_event__repipe_synth(session->tool, event);
+	perf_event__repipe_synth(tool, event);
 
-	return perf_event__process_tracing_data(session, event);
+	return perf_event__process_tracing_data(tool, session, event);
 }
 #endif
 
@@ -1348,7 +1350,7 @@ static int process_build_id(const struct perf_tool *tool,
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 
-	return perf_event__process_build_id(inject->session, event);
+	return perf_event__process_build_id(tool, inject->session, event);
 }
 
 static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_t machine_pid)
@@ -1780,9 +1782,10 @@ static int host__repipe(const struct perf_tool *tool,
 	return perf_event__repipe(tool, event, sample, machine);
 }
 
-static int host__finished_init(struct perf_session *session, union perf_event *event)
+static int host__finished_init(const struct perf_tool *tool, struct perf_session *session,
+			       union perf_event *event)
 {
-	struct perf_inject *inject = container_of(session->tool, struct perf_inject, tool);
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct guest_session *gs = &inject->guest_session;
 	int ret;
 
@@ -1829,7 +1832,7 @@ static int host__finished_init(struct perf_session *session, union perf_event *e
 	if (ret)
 		return ret;
 
-	return perf_event__repipe_op2_synth(session, event);
+	return perf_event__repipe_op2_synth(tool, session, event);
 }
 
 /*
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 35df04dad2fd..2bc269f5fcef 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -240,10 +240,11 @@ static void setup_forced_leader(struct report *report,
 		evlist__force_leader(evlist);
 }
 
-static int process_feature_event(struct perf_session *session,
+static int process_feature_event(const struct perf_tool *tool,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
-	struct report *rep = container_of(session->tool, struct report, tool);
+	struct report *rep = container_of(tool, struct report, tool);
 
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
 		return perf_event__process_feature(session, event);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8124fcb51da9..d813adbf9889 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2729,7 +2729,8 @@ static int process_switch_event(const struct perf_tool *tool,
 			   sample->tid);
 }
 
-static int process_auxtrace_error(struct perf_session *session,
+static int process_auxtrace_error(const struct perf_tool *tool,
+				  struct perf_session *session,
 				  union perf_event *event)
 {
 	if (scripting_ops && scripting_ops->process_auxtrace_error) {
@@ -2737,7 +2738,7 @@ static int process_auxtrace_error(struct perf_session *session,
 		return 0;
 	}
 
-	return perf_event__process_auxtrace_error(session, event);
+	return perf_event__process_auxtrace_error(tool, session, event);
 }
 
 static int
@@ -2785,7 +2786,8 @@ process_bpf_events(const struct perf_tool *tool __maybe_unused,
 }
 
 static int
-process_bpf_metadata_event(struct perf_session *session __maybe_unused,
+process_bpf_metadata_event(const struct perf_tool *tool __maybe_unused,
+			   struct perf_session *session __maybe_unused,
 			   union perf_event *event)
 {
 	perf_event__fprintf(event, NULL, stdout);
@@ -3544,7 +3546,8 @@ static void script__setup_sample_type(struct perf_script *script)
 	}
 }
 
-static int process_stat_round_event(struct perf_session *session,
+static int process_stat_round_event(const struct perf_tool *tool __maybe_unused,
+				    struct perf_session *session,
 				    union perf_event *event)
 {
 	struct perf_record_stat_round *round = &event->stat_round;
@@ -3559,7 +3562,8 @@ static int process_stat_round_event(struct perf_session *session,
 	return 0;
 }
 
-static int process_stat_config_event(struct perf_session *session __maybe_unused,
+static int process_stat_config_event(const struct perf_tool *tool __maybe_unused,
+				     struct perf_session *session __maybe_unused,
 				     union perf_event *event)
 {
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
@@ -3593,10 +3597,10 @@ static int set_maps(struct perf_script *script)
 }
 
 static
-int process_thread_map_event(struct perf_session *session,
+int process_thread_map_event(const struct perf_tool *tool,
+			     struct perf_session *session __maybe_unused,
 			     union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 	if (dump_trace)
@@ -3615,10 +3619,10 @@ int process_thread_map_event(struct perf_session *session,
 }
 
 static
-int process_cpu_map_event(struct perf_session *session,
+int process_cpu_map_event(const struct perf_tool *tool,
+			  struct perf_session *session __maybe_unused,
 			  union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 	if (dump_trace)
@@ -3636,7 +3640,8 @@ int process_cpu_map_event(struct perf_session *session,
 	return set_maps(script);
 }
 
-static int process_feature_event(struct perf_session *session,
+static int process_feature_event(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
@@ -3645,13 +3650,13 @@ static int process_feature_event(struct perf_session *session,
 }
 
 #ifdef HAVE_AUXTRACE_SUPPORT
-static int perf_script__process_auxtrace_info(struct perf_session *session,
+static int perf_script__process_auxtrace_info(const struct perf_tool *tool,
+					      struct perf_session *session,
 					      union perf_event *event)
 {
-	int ret = perf_event__process_auxtrace_info(session, event);
+	int ret = perf_event__process_auxtrace_info(tool, session, event);
 
 	if (ret == 0) {
-		const struct perf_tool *tool = session->tool;
 		struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 		ret = perf_script__setup_per_event_dump(script);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 886727ae8529..3c46b92a53ab 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2197,7 +2197,8 @@ static int __cmd_record(const struct option stat_options[], struct opt_aggr_mode
 	return argc;
 }
 
-static int process_stat_round_event(struct perf_session *session,
+static int process_stat_round_event(const struct perf_tool *tool __maybe_unused,
+				    struct perf_session *session,
 				    union perf_event *event)
 {
 	struct perf_record_stat_round *stat_round = &event->stat_round;
@@ -2222,10 +2223,10 @@ static int process_stat_round_event(struct perf_session *session,
 }
 
 static
-int process_stat_config_event(struct perf_session *session,
+int process_stat_config_event(const struct perf_tool *tool,
+			      struct perf_session *session,
 			      union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
@@ -2271,10 +2272,10 @@ static int set_maps(struct perf_stat *st)
 }
 
 static
-int process_thread_map_event(struct perf_session *session,
+int process_thread_map_event(const struct perf_tool *tool,
+			     struct perf_session *session __maybe_unused,
 			     union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 
 	if (st->threads) {
@@ -2290,10 +2291,10 @@ int process_thread_map_event(struct perf_session *session,
 }
 
 static
-int process_cpu_map_event(struct perf_session *session,
+int process_cpu_map_event(const struct perf_tool *tool,
+			  struct perf_session *session __maybe_unused,
 			  union perf_event *event)
 {
-	const struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 	struct perf_cpu_map *cpus;
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 35f4745f6b2b..a224687ffbc1 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1379,7 +1379,8 @@ static void unleader_auxtrace(struct perf_session *session)
 	}
 }
 
-int perf_event__process_auxtrace_info(struct perf_session *session,
+int perf_event__process_auxtrace_info(const struct perf_tool *tool __maybe_unused,
+				      struct perf_session *session,
 				      union perf_event *event)
 {
 	enum auxtrace_type type = event->auxtrace_info.type;
@@ -1423,7 +1424,8 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	return 0;
 }
 
-s64 perf_event__process_auxtrace(struct perf_session *session,
+s64 perf_event__process_auxtrace(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
 	s64 err;
@@ -1820,7 +1822,8 @@ void events_stats__auxtrace_error_warn(const struct events_stats *stats)
 	}
 }
 
-int perf_event__process_auxtrace_error(struct perf_session *session,
+int perf_event__process_auxtrace_error(const struct perf_tool *tool __maybe_unused,
+				       struct perf_session *session,
 				       union perf_event *event)
 {
 	if (auxtrace__dont_decode(session))
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index ed3a1aaaf5d9..bcf326d69b7e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -615,11 +615,14 @@ void auxtrace_synth_error(struct perf_record_auxtrace_error *auxtrace_error, int
 			  int code, int cpu, pid_t pid, pid_t tid, u64 ip,
 			  const char *msg, u64 timestamp);
 
-int perf_event__process_auxtrace_info(struct perf_session *session,
+int perf_event__process_auxtrace_info(const struct perf_tool *tool,
+				      struct perf_session *session,
 				      union perf_event *event);
-s64 perf_event__process_auxtrace(struct perf_session *session,
+s64 perf_event__process_auxtrace(const struct perf_tool *tool,
+				 struct perf_session *session,
 				 union perf_event *event);
-int perf_event__process_auxtrace_error(struct perf_session *session,
+int perf_event__process_auxtrace_error(const struct perf_tool *tool,
+				       struct perf_session *session,
 				       union perf_event *event);
 int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 			       const char *str, int unset);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4f2a6e10ed5c..7b83037290d1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4541,7 +4541,8 @@ int perf_event__process_event_update(const struct perf_tool *tool __maybe_unused
 }
 
 #ifdef HAVE_LIBTRACEEVENT
-int perf_event__process_tracing_data(struct perf_session *session,
+int perf_event__process_tracing_data(const struct perf_tool *tool __maybe_unused,
+				     struct perf_session *session,
 				     union perf_event *event)
 {
 	ssize_t size_read, padding, size = event->tracing_data.size;
@@ -4589,7 +4590,8 @@ int perf_event__process_tracing_data(struct perf_session *session,
 }
 #endif
 
-int perf_event__process_build_id(struct perf_session *session,
+int perf_event__process_build_id(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
 	__event_process_build_id(&event->build_id,
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d16dfceccd74..c058021c3150 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -178,10 +178,12 @@ int perf_event__process_event_update(const struct perf_tool *tool,
 size_t perf_event__fprintf_attr(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp);
 #ifdef HAVE_LIBTRACEEVENT
-int perf_event__process_tracing_data(struct perf_session *session,
+int perf_event__process_tracing_data(const struct perf_tool *tool,
+				     struct perf_session *session,
 				     union perf_event *event);
 #endif
-int perf_event__process_build_id(struct perf_session *session,
+int perf_event__process_build_id(const struct perf_tool *tool,
+				 struct perf_session *session,
 				 union perf_event *event);
 bool is_perf_magic(u64 magic);
 
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 8c9aee157ec4..21359155f2a0 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -216,7 +216,8 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int process_feature_event(struct perf_session *session,
+static int process_feature_event(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 09af486c83e4..4b0236b2df29 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1437,19 +1437,19 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 */
 		if (!perf_data__is_pipe(session->data))
 			lseek(fd, file_offset, SEEK_SET);
-		err = tool->tracing_data(session, event);
+		err = tool->tracing_data(tool, session, event);
 		break;
 	case PERF_RECORD_HEADER_BUILD_ID:
-		err = tool->build_id(session, event);
+		err = tool->build_id(tool, session, event);
 		break;
 	case PERF_RECORD_FINISHED_ROUND:
 		err = tool->finished_round(tool, event, oe);
 		break;
 	case PERF_RECORD_ID_INDEX:
-		err = tool->id_index(session, event);
+		err = tool->id_index(tool, session, event);
 		break;
 	case PERF_RECORD_AUXTRACE_INFO:
-		err = tool->auxtrace_info(session, event);
+		err = tool->auxtrace_info(tool, session, event);
 		break;
 	case PERF_RECORD_AUXTRACE:
 		/*
@@ -1459,45 +1459,45 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 */
 		if (!perf_data__is_pipe(session->data))
 			lseek(fd, file_offset + event->header.size, SEEK_SET);
-		err = tool->auxtrace(session, event);
+		err = tool->auxtrace(tool, session, event);
 		break;
 	case PERF_RECORD_AUXTRACE_ERROR:
 		perf_session__auxtrace_error_inc(session, event);
-		err = tool->auxtrace_error(session, event);
+		err = tool->auxtrace_error(tool, session, event);
 		break;
 	case PERF_RECORD_THREAD_MAP:
-		err = tool->thread_map(session, event);
+		err = tool->thread_map(tool, session, event);
 		break;
 	case PERF_RECORD_CPU_MAP:
-		err = tool->cpu_map(session, event);
+		err = tool->cpu_map(tool, session, event);
 		break;
 	case PERF_RECORD_STAT_CONFIG:
-		err = tool->stat_config(session, event);
+		err = tool->stat_config(tool, session, event);
 		break;
 	case PERF_RECORD_STAT:
-		err = tool->stat(session, event);
+		err = tool->stat(tool, session, event);
 		break;
 	case PERF_RECORD_STAT_ROUND:
-		err = tool->stat_round(session, event);
+		err = tool->stat_round(tool, session, event);
 		break;
 	case PERF_RECORD_TIME_CONV:
 		session->time_conv = event->time_conv;
-		err = tool->time_conv(session, event);
+		err = tool->time_conv(tool, session, event);
 		break;
 	case PERF_RECORD_HEADER_FEATURE:
-		err = tool->feature(session, event);
+		err = tool->feature(tool, session, event);
 		break;
 	case PERF_RECORD_COMPRESSED:
 	case PERF_RECORD_COMPRESSED2:
-		err = tool->compressed(session, event, file_offset, file_path);
+		err = tool->compressed(tool, session, event, file_offset, file_path);
 		if (err)
 			dump_event(session->evlist, event, file_offset, &sample, file_path);
 		break;
 	case PERF_RECORD_FINISHED_INIT:
-		err = tool->finished_init(session, event);
+		err = tool->finished_init(tool, session, event);
 		break;
 	case PERF_RECORD_BPF_METADATA:
-		err = tool->bpf_metadata(session, event);
+		err = tool->bpf_metadata(tool, session, event);
 		break;
 	default:
 		err = -EINVAL;
@@ -2647,7 +2647,8 @@ static int perf_session__set_guest_cpu(struct perf_session *session, pid_t pid,
 	return 0;
 }
 
-int perf_event__process_id_index(struct perf_session *session,
+int perf_event__process_id_index(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
 				 union perf_event *event)
 {
 	struct evlist *evlist = session->evlist;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index cf88d65a25cb..22d3ff877e83 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -202,7 +202,8 @@ int perf_session__deliver_synth_attr_event(struct perf_session *session,
 
 int perf_session__dsos_hit_all(struct perf_session *session);
 
-int perf_event__process_id_index(struct perf_session *session,
+int perf_event__process_id_index(const struct perf_tool *tool,
+				 struct perf_session *session,
 				 union perf_event *event);
 
 int perf_event__process_finished_round(const struct perf_tool *tool,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 101ed6c497bc..976a06e63252 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -645,7 +645,8 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
 		evsel__process_percore(evsel);
 }
 
-int perf_event__process_stat_event(struct perf_session *session,
+int perf_event__process_stat_event(const struct perf_tool *tool __maybe_unused,
+				   struct perf_session *session,
 				   union perf_event *event)
 {
 	struct perf_counts_values count, *ptr;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 34f30a295f89..230474f49315 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -216,7 +216,8 @@ union perf_event;
 struct perf_session;
 struct target;
 
-int perf_event__process_stat_event(struct perf_session *session,
+int perf_event__process_stat_event(const struct perf_tool *tool,
+				   struct perf_session *session,
 				   union perf_event *event);
 
 size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index e83c7ababc2a..c983b526b30d 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -13,7 +13,8 @@
 #include <unistd.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
-static int perf_session__process_compressed_event(struct perf_session *session,
+static int perf_session__process_compressed_event(const struct perf_tool *tool __maybe_unused,
+						  struct perf_session *session,
 						  union perf_event *event, u64 file_offset,
 						  const char *file_path)
 {
@@ -79,10 +80,9 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 }
 #endif
 
-static int process_event_synth_tracing_data_stub(struct perf_session *session
-						 __maybe_unused,
-						 union perf_event *event
-						 __maybe_unused)
+static int process_event_synth_tracing_data_stub(const struct perf_tool *tool __maybe_unused,
+						 struct perf_session *session __maybe_unused,
+						 union perf_event *event __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
@@ -90,8 +90,7 @@ static int process_event_synth_tracing_data_stub(struct perf_session *session
 
 static int process_event_synth_attr_stub(const struct perf_tool *tool __maybe_unused,
 					 union perf_event *event __maybe_unused,
-					 struct evlist **pevlist
-					 __maybe_unused)
+					 struct evlist **pevlist __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
@@ -99,8 +98,7 @@ static int process_event_synth_attr_stub(const struct perf_tool *tool __maybe_un
 
 static int process_event_synth_event_update_stub(const struct perf_tool *tool __maybe_unused,
 						 union perf_event *event __maybe_unused,
-						 struct evlist **pevlist
-						 __maybe_unused)
+						 struct evlist **pevlist __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_event_update(event, stdout);
@@ -151,7 +149,8 @@ static int skipn(int fd, off_t n)
 	return 0;
 }
 
-static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
+static s64 process_event_auxtrace_stub(const struct perf_tool *tool __maybe_unused,
+				       struct perf_session *session __maybe_unused,
 				       union perf_event *event)
 {
 	dump_printf(": unhandled!\n");
@@ -160,7 +159,8 @@ static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unus
 	return event->auxtrace.size;
 }
 
-static int process_event_op2_stub(struct perf_session *session __maybe_unused,
+static int process_event_op2_stub(const struct perf_tool *tool __maybe_unused,
+				  struct perf_session *session __maybe_unused,
 				  union perf_event *event __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
@@ -169,7 +169,8 @@ static int process_event_op2_stub(struct perf_session *session __maybe_unused,
 
 
 static
-int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
+int process_event_thread_map_stub(const struct perf_tool *tool __maybe_unused,
+				  struct perf_session *session __maybe_unused,
 				  union perf_event *event __maybe_unused)
 {
 	if (dump_trace)
@@ -180,7 +181,8 @@ int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
 }
 
 static
-int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
+int process_event_cpu_map_stub(const struct perf_tool *tool __maybe_unused,
+			       struct perf_session *session __maybe_unused,
 			       union perf_event *event __maybe_unused)
 {
 	if (dump_trace)
@@ -191,7 +193,8 @@ int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
 }
 
 static
-int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
+int process_event_stat_config_stub(const struct perf_tool *tool __maybe_unused,
+				   struct perf_session *session __maybe_unused,
 				   union perf_event *event __maybe_unused)
 {
 	if (dump_trace)
@@ -201,7 +204,8 @@ int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
-static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
+static int process_stat_stub(const struct perf_tool *tool __maybe_unused,
+			     struct perf_session *perf_session __maybe_unused,
 			     union perf_event *event)
 {
 	if (dump_trace)
@@ -211,7 +215,8 @@ static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
 	return 0;
 }
 
-static int process_stat_round_stub(struct perf_session *perf_session __maybe_unused,
+static int process_stat_round_stub(const struct perf_tool *tool __maybe_unused,
+				   struct perf_session *perf_session __maybe_unused,
 				   union perf_event *event)
 {
 	if (dump_trace)
@@ -221,7 +226,8 @@ static int process_stat_round_stub(struct perf_session *perf_session __maybe_unu
 	return 0;
 }
 
-static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
+static int process_event_time_conv_stub(const struct perf_tool *tool __maybe_unused,
+					struct perf_session *perf_session __maybe_unused,
 					union perf_event *event)
 {
 	if (dump_trace)
@@ -231,7 +237,8 @@ static int process_event_time_conv_stub(struct perf_session *perf_session __mayb
 	return 0;
 }
 
-static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
+static int perf_session__process_compressed_event_stub(const struct perf_tool *tool __maybe_unused,
+						       struct perf_session *session __maybe_unused,
 						       union perf_event *event __maybe_unused,
 						       u64 file_offset __maybe_unused,
 						       const char *file_path __maybe_unused)
@@ -240,7 +247,8 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
 	return 0;
 }
 
-static int perf_event__process_bpf_metadata_stub(struct perf_session *perf_session __maybe_unused,
+static int perf_event__process_bpf_metadata_stub(const struct perf_tool *tool __maybe_unused,
+						 struct perf_session *perf_session __maybe_unused,
 						 union perf_event *event)
 {
 	if (dump_trace)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 18b76ff0f26a..1f1461808371 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -26,10 +26,12 @@ typedef int (*event_attr_op)(const struct perf_tool *tool,
 			     union perf_event *event,
 			     struct evlist **pevlist);
 
-typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
-typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
-typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data,
-			 const char *str);
+typedef int (*event_op2)(const struct perf_tool *tool, struct perf_session *session,
+			 union perf_event *event);
+typedef s64 (*event_op3)(const struct perf_tool *tool, struct perf_session *session,
+			 union perf_event *event);
+typedef int (*event_op4)(const struct perf_tool *tool, struct perf_session *session,
+			 union perf_event *event, u64 data, const char *str);
 
 typedef int (*event_oe)(const struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
-- 
2.51.2.1006.ga50a493c49-goog

