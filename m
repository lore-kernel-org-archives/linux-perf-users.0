Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22D1B3B0D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943748; cv=none; b=S5OX4t8XpvuWA6oSRr7J1nYG+CKDb+0BLA1JJE/kgjYPuBg7vnuidOKito8c8YCnf+XI8PwNUdYdrrEgUcZgyEcoi2SVAoUnvRQuV4sqTvdrJZtlOv7gvPKqgzys+kslQat5qTMQoAYSVLYUXY5DXrGkYpvE/y+ILcIK9RP0EkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943748; c=relaxed/simple;
	bh=XEt4LkPY8g7kYpF4m+pCtB85oOCHt9StmaLcp91SEtw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kvJERM31tvvY39Wz43+tqN1Om7AkuBpcV7fuieK2TUniAB8aeG1++UJ9l+YV57xVJwMZ03zi4bxno+F9PZBlUUGVlt+oBuFhCa8QQpx/YNJECYSAQ0wZMVzMYrxD2xB8k8XM4SjXPp3SMRREr3CWOGmdsKGut9s4BqAxkjbABgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yIZjmTqL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yIZjmTqL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so12857317b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943745; x=1725548545; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDNxrcM0EUMB3Iw+/h0y6gDA4czLmrnPsI6Mf401mUY=;
        b=yIZjmTqLY+aZKn03nS5iQwGqA3JizPMHZKfaYHcybzS2iaKrwge0aC+7tLSOIQ6S3e
         8qhVoaasNj/s+1wSNMUZUEqwHeMqaqU/8z4IM2D9cYbikQe8R9EBgDx5ulOAOYNVQY2t
         98rZC2n1P4I5Qvk9YZ6nnLs/4AvqE4+Dx3LYT90l1ISY0Sb68Yew1MGvSQqwixZuvQT0
         0mxIut1BpN+o1wpq+I4BpOOGwA0hM8CSbMwcUchM4xnvi58vdmNTXCBKSjkt52AqsbY/
         dUYUrlgYNBqDcE0oxTf9JxQDxioJgg2/6Q8zZXfHB7a2ERSEwdC5nYOsy2eo/u90LR01
         klXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943745; x=1725548545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDNxrcM0EUMB3Iw+/h0y6gDA4czLmrnPsI6Mf401mUY=;
        b=MuWN81eS/E1jywyNcXFNX+yRz58rskJpZ8ShGGjcvUggHp/KAQo935QLb2E6Ps2aqg
         ob6BiLF8PJeEl5K9PfuJjaYCAiQBoTdKGdhCm65WQEPQ8rtCYeGUPaGj0t9nrW4qm70F
         8lXAByLAUmwrNG3FSIrhbaQ4PdbdRxWDP6dpNfSfsBY6AlJZK3VIr9oGlXTdmVk42x1C
         8Ny0fAE5tEQvc0NYOie+hUR9MikSjHL4Le/XSdAeDA0ITaGTkFxZmaVaD3V6kE+vFPOz
         3bppbx6hm2O5REhYuu1oh8ZjrdXz0EfhPqvtE/Acn/My7v1pFu6mCy5UqfmkwJtGqGf8
         RiOA==
X-Forwarded-Encrypted: i=1; AJvYcCV5/e86auVD+rgOdVLQriC0cqCOihNVAXRKByjmY5prSqmbAKo3P+XiFXiMRM17lOccgk9LZNFIFLVfpIsYEjU9@vger.kernel.org
X-Gm-Message-State: AOJu0Yweb9p57YETYfPFh+cs1mSC1QipRJAy64lb2m4GnB4tbYwF82Ix
	0ETy504WEyM4HWWGRuFpD/eZ2PUDMqDX9SeHIJbH0u4a9D76wKrrAmokkig4SPw41HRM/TbBsQ8
	9sN+V4A==
X-Google-Smtp-Source: AGHT+IFi/0lV0K5vG/SObdV0BxBNjai9T/mcyyzfKgNXUXkyczFL7DKJTH4orXG7YDc2Z+USGMFzQXrORDDf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a0d:f3c1:0:b0:68d:52a1:be9 with SMTP id
 00721157ae682-6d2e6d839bbmr191697b3.1.1724943745481; Thu, 29 Aug 2024
 08:02:25 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:52 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 6/8] perf inject: Overhaul handling of pipe files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously inject->is_pipe was set if the input or output were a
pipe. Determining the input was a pipe had to be done prior to
starting the session and opening the file. This was done by comparing
the input file name with '-' but it fails if the pipe file is written
to disk. Opening a pipe file from disk will correcrtly set
perf_data.is_pipe, but this is too late for perf inject and results in
a broken file. A workaround is 'cat pipe_perf|perf inject -i - ...'.

This change removes inject->is_pipe and changes the dependent
conditions to use the is_pipe flag on the input
(inject->session->data) and output files (inject->output). This
ensures the is_pipe condition reflects things like the header being
read.

The change removes the use of perf file header repiping, that is
writing the file header out while reading it in. The case of input
pipe and output file cannot repipe as the attributes for the file are
unknown. To resolve this, write the file header when writing to disk
and as the attributes may be unknown, write them after the data.

Update sessions repipe variable to be trace_event_repipe as those are
the only events now impacted by it. Update __perf_session__new as the
repipe_fd no longer needs passing. Fully removing repipe from session
header reading will be done in a later change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 60 +++++++++++++++++++------------------
 tools/perf/util/header.c    | 12 ++++----
 tools/perf/util/header.h    |  3 +-
 tools/perf/util/session.c   |  8 ++---
 tools/perf/util/session.h   | 14 ++++-----
 5 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a7c859db2e15..0ccf80fe8399 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -119,7 +119,6 @@ struct perf_inject {
 	bool			jit_mode;
 	bool			in_place_update;
 	bool			in_place_update_dry_run;
-	bool			is_pipe;
 	bool			copy_kcore_dir;
 	const char		*input_name;
 	struct perf_data	output;
@@ -205,7 +204,8 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (ret)
 		return ret;
 
-	if (!inject->is_pipe)
+	/* If the output isn't a pipe then the attributes will be written as part of the header. */
+	if (!inject->output.is_pipe)
 		return 0;
 
 	return perf_event__repipe_synth(tool, event);
@@ -1966,7 +1966,13 @@ static int __cmd_inject(struct perf_inject *inject)
 	struct guest_session *gs = &inject->guest_session;
 	struct perf_session *session = inject->session;
 	int fd = output_fd(inject);
-	u64 output_data_offset;
+	u64 output_data_offset = perf_session__data_offset(session->evlist);
+	/*
+	 * Pipe input hasn't loaded the attributes and will handle them as
+	 * events. So that the attributes don't overlap the data, write the
+	 * attributes after the data.
+	 */
+	bool write_attrs_after_data = !inject->output.is_pipe && inject->session->data->is_pipe;
 
 	signal(SIGINT, sig_handler);
 
@@ -1980,8 +1986,6 @@ static int __cmd_inject(struct perf_inject *inject)
 #endif
 	}
 
-	output_data_offset = perf_session__data_offset(session->evlist);
-
 	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
@@ -2075,7 +2079,7 @@ static int __cmd_inject(struct perf_inject *inject)
 	if (!inject->itrace_synth_opts.set)
 		auxtrace_index__free(&session->auxtrace_index);
 
-	if (!inject->is_pipe && !inject->in_place_update)
+	if (!inject->output.is_pipe && !inject->in_place_update)
 		lseek(fd, output_data_offset, SEEK_SET);
 
 	ret = perf_session__process_events(session);
@@ -2094,7 +2098,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		}
 	}
 
-	if (!inject->is_pipe && !inject->in_place_update) {
+	if (!inject->output.is_pipe && !inject->in_place_update) {
 		struct inject_fc inj_fc = {
 			.fc.copy = feat_copy_cb,
 			.inject = inject,
@@ -2124,7 +2128,8 @@ static int __cmd_inject(struct perf_inject *inject)
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
-		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc);
+		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc,
+					    write_attrs_after_data);
 
 		if (inject->copy_kcore_dir) {
 			ret = copy_kcore_dir(inject);
@@ -2161,7 +2166,6 @@ int cmd_inject(int argc, const char **argv)
 		.use_stdio = true,
 	};
 	int ret;
-	bool repipe = true;
 	const char *known_build_ids = NULL;
 	bool build_ids;
 	bool build_id_all;
@@ -2273,16 +2277,7 @@ int cmd_inject(int argc, const char **argv)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_ALL;
 
 	data.path = inject.input_name;
-	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe) {
-		inject.is_pipe = true;
-		/*
-		 * Do not repipe header when input is a regular file
-		 * since either it can rewrite the header at the end
-		 * or write a new pipe header.
-		 */
-		if (strcmp(inject.input_name, "-"))
-			repipe = false;
-	}
+
 	ordered_events = inject.jit_mode || inject.sched_stat ||
 		(inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY);
 	perf_tool__init(&inject.tool, ordered_events);
@@ -2325,9 +2320,9 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.compressed		= perf_event__repipe_op4_synth;
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.tool.dont_split_sample_group = true;
-	inject.session = __perf_session__new(&data, repipe,
-					     output_fd(&inject),
-					     &inject.tool);
+	inject.session = __perf_session__new(&data, &inject.tool,
+					     /*trace_event_repipe=*/inject.output.is_pipe);
+
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
 		goto out_close_output;
@@ -2341,19 +2336,26 @@ int cmd_inject(int argc, const char **argv)
 	if (ret)
 		goto out_delete;
 
-	if (!data.is_pipe && inject.output.is_pipe) {
+	if (inject.output.is_pipe) {
 		ret = perf_header__write_pipe(perf_data__fd(&inject.output));
 		if (ret < 0) {
 			pr_err("Couldn't write a new pipe header.\n");
 			goto out_delete;
 		}
 
-		ret = perf_event__synthesize_for_pipe(&inject.tool,
-						      inject.session,
-						      &inject.output,
-						      perf_event__repipe);
-		if (ret < 0)
-			goto out_delete;
+		/*
+		 * If the input is already a pipe then the features and
+		 * attributes don't need synthesizing, they will be present in
+		 * the input.
+		 */
+		if (!data.is_pipe) {
+			ret = perf_event__synthesize_for_pipe(&inject.tool,
+							      inject.session,
+							      &inject.output,
+							      perf_event__repipe);
+			if (ret < 0)
+				goto out_delete;
+		}
 	}
 
 	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4eb39463067e..59e2f37c1cb4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3818,10 +3818,11 @@ size_t perf_session__data_offset(const struct evlist *evlist)
 int perf_session__inject_header(struct perf_session *session,
 				struct evlist *evlist,
 				int fd,
-				struct feat_copier *fc)
+				struct feat_copier *fc,
+				bool write_attrs_after_data)
 {
 	return perf_session__do_write_header(session, evlist, fd, true, fc,
-					     /*write_attrs_after_data=*/false);
+					     write_attrs_after_data);
 }
 
 static int perf_header__getbuffer64(struct perf_header *header,
@@ -4145,7 +4146,7 @@ static int perf_header__read_pipe(struct perf_session *session, int repipe_fd)
 	struct perf_pipe_file_header f_header;
 
 	if (perf_file_header__read_pipe(&f_header, header, session->data,
-					session->repipe, repipe_fd) < 0) {
+					/*repipe=*/false, repipe_fd) < 0) {
 		pr_debug("incompatible file format\n");
 		return -EINVAL;
 	}
@@ -4560,15 +4561,14 @@ int perf_event__process_tracing_data(struct perf_session *session,
 		      SEEK_SET);
 	}
 
-	size_read = trace_report(fd, &session->tevent,
-				 session->repipe);
+	size_read = trace_report(fd, &session->tevent, session->trace_event_repipe);
 	padding = PERF_ALIGN(size_read, sizeof(u64)) - size_read;
 
 	if (readn(fd, buf, padding) < 0) {
 		pr_err("%s: reading input file", __func__);
 		return -1;
 	}
-	if (session->repipe) {
+	if (session->trace_event_repipe) {
 		int retw = write(STDOUT_FILENO, buf, padding);
 		if (retw <= 0 || retw != padding) {
 			pr_err("%s: repiping tracing data padding", __func__);
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 3285981948d7..7137509cf6d8 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -150,7 +150,8 @@ struct feat_copier {
 int perf_session__inject_header(struct perf_session *session,
 				struct evlist *evlist,
 				int fd,
-				struct feat_copier *fc);
+				struct feat_copier *fc,
+				bool write_attrs_after_data);
 
 size_t perf_session__data_offset(const struct evlist *evlist);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d2bd563119bc..23449d01093a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -135,8 +135,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 }
 
 struct perf_session *__perf_session__new(struct perf_data *data,
-					 bool repipe, int repipe_fd,
-					 struct perf_tool *tool)
+					 struct perf_tool *tool,
+					 bool trace_event_repipe)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
@@ -144,7 +144,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	if (!session)
 		goto out;
 
-	session->repipe = repipe;
+	session->trace_event_repipe = trace_event_repipe;
 	session->tool   = tool;
 	session->decomp_data.zstd_decomp = &session->zstd_data;
 	session->active_decomp = &session->decomp_data;
@@ -162,7 +162,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 		session->data = data;
 
 		if (perf_data__is_read(data)) {
-			ret = perf_session__open(session, repipe_fd);
+			ret = perf_session__open(session, /*repipe_fd=*/-1);
 			if (ret < 0)
 				goto out_delete;
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index e56518639711..bcf1bcf06959 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -59,12 +59,8 @@ struct perf_session {
 #endif
 	/** @time_conv: Holds contents of last PERF_RECORD_TIME_CONV event. */
 	struct perf_record_time_conv	time_conv;
-	/**
-	 * @repipe: When set causes certain reading (header and trace events) to
-	 * also write events. The written file descriptor must be provided for
-	 * the header but is implicitly stdout for trace events.
-	 */
-	bool			repipe;
+	/** @trace_event_repipe: When set causes read trace events to be written to stdout. */
+	bool			trace_event_repipe;
 	/**
 	 * @one_mmap: The reader will use a single mmap by default. There may be
 	 * multiple data files in particular for aux events. If this is true
@@ -110,13 +106,13 @@ struct decomp {
 struct perf_tool;
 
 struct perf_session *__perf_session__new(struct perf_data *data,
-					 bool repipe, int repipe_fd,
-					 struct perf_tool *tool);
+					 struct perf_tool *tool,
+					 bool trace_event_repipe);
 
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, false, -1, tool);
+	return __perf_session__new(data, tool, /*trace_event_repipe=*/false);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.46.0.295.g3b9ea8a38a-goog

