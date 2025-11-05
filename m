Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD121C9EA
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Nov 2025 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301472; cv=none; b=OzZPPZqQyTHw31VoS21s4OoRY44KBAU8UuTAxTPxIcMWzHRDaz+XoPxBf3vxyUirx7bR2YUhHmoe1Bug3m2uRYGI8GCdjhzQ5VNXoT9JeQfSqL2sK3+H0MgFzOxYLvUb0TptB5Fm0nkPqJFPkcjofz0j8B4F4MnDsjN8wviQRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301472; c=relaxed/simple;
	bh=WKC1+Jn4yTWgCNpexdA7rHgwJ5kIn/yyufrF+/7hXLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tY7Jq1baZL7fitma1UKalAqCsH+liUY/dUBIm8urn2Tc3o78fGaiBP7dDRZOb73/sf5Mmh0dL+/HFDMfv4zPujtSMFKuOL1aT22VBJjL7ER4mNHOiZQMcsjX5dQIGc1C2mnx3nMgOJ7UKImaH37CC3e1jJmANvB8pJ66ZWw8Obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oirn6ApY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oirn6ApY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3408686190eso10871831a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762301470; x=1762906270; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfwMp1kYTwyl+EpliFplhYJh6t9KjYwVwHx3Lfrmg78=;
        b=Oirn6ApYQ1OiQ7EvuhwxtOAVl3UWwJSlFsmKjzBPXeMKTp8lPWVCYtlw9yLHfrC+rY
         Szv9LMimlmyhKaRM6VhG05i1XMAZKmgKrUE2YKvhNzbKkET9TKK5PlPZE627bzzaPeDr
         haqD+bOibAUufiJQw8RiUCoImGPBpG1hS49Lchi0sm1C0TbC2KKpBNezQrdH2E9dD7mE
         8v3bPmdsLn8+MlYqvkCTYiJTuOKzCrtRV2h8A4REPTUZSbqY2vgFLk2YYDFu3Z1Ba/Nj
         5vR9Jhb6Hb4sGzraqTdMbr/g5+6Z3RZIsf6Zx7h5Iy0CSHESl+IWYs6FNfYnU8osXpHn
         r9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301470; x=1762906270;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfwMp1kYTwyl+EpliFplhYJh6t9KjYwVwHx3Lfrmg78=;
        b=nJVjIUEY5aThOOtPfFTR5ZQMl65V45yzLyCHRPcoQUvGvWPqAKHoIGZ3IhmLBFDMIV
         JMe4CeLW4z4B/EBjN5BDPFFI301cdCvl0rEn9whGa+PIhSXViMxTTaTEgS6Pyk2Hs4CW
         bitKV3Ya97V8x4hNm/fUUbd39ypheDvk11gP0M6r5r0xWnHoxsvXL7Yl1cR5vylO+3nI
         nJytqGajwmf7bFvOPLGefYQ8BE8xJFWbD6u55YHPObNnOHQPBAl2iiQnri2DMQbXEkBm
         PcIr94UvEbhs/+SO+U4y4pKRqLsznXFpnJHDHQNvPlE6/DqGDWX0qcLlvstsODYUZbRD
         ODqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQcMawE9SawZWNROWAU5f+zutJDDsHgiNS2yzZuBRmxthemvjxbKyCmBWInRxLJFurEmMXh9GegJp+huksGXJi@vger.kernel.org
X-Gm-Message-State: AOJu0YxTT4yhKEJOk6VwhUTk54zhmngsZqNM1gxL3xmL00dGGrGEK5KY
	GhDAowVBpmDUrggcKPmi+oPjUoOw11T9lJh42C9yFSA3asBk+TvrgWxxTsz095j5xpyf3tEq8/Q
	pn48bK2bEMA==
X-Google-Smtp-Source: AGHT+IELJ/ZEmoiQa0auG8z8vkvh+pEqJwq1ZKIo1dBdQiFOoihEofr5rl6gwF1k5o1T6Eh1rxY0O32X1oe3
X-Received: from pjbpm5.prod.google.com ([2002:a17:90b:3c45:b0:33b:51fe:1a85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268d:b0:341:8ac7:24d3
 with SMTP id 98e67ed59e1d1-341a7008c4bmr1242921a91.34.1762301469880; Tue, 04
 Nov 2025 16:11:09 -0800 (PST)
Date: Tue,  4 Nov 2025 16:11:03 -0800
In-Reply-To: <20251105001103.1296863-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105001103.1296863-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251105001103.1296863-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf tool: Add a delegate_tool that just delegates
 actions to another tool
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

Add an ability to be able to compose perf_tools, by having one perform
an action and then calling a delegate. Currently the perf_tools have
if-then-elses setting the callback and then if-then-elses within the
callback. Understanding the behavior is complex as it is in two places
and logic for numerous operations, within things like perf inject, is
interwoven. By chaining perf_tools together based on command line
options this kind of code can be avoided.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool.c | 171 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tool.h |   9 +++
 2 files changed, 180 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index c983b526b30d..22a8a4ffe05f 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -321,3 +321,174 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
 {
 	return tool->compressed == perf_session__process_compressed_event_stub;
 }
+
+#define CREATE_DELEGATE_SAMPLE(name) \
+	static int delegate_ ## name(const struct perf_tool *tool, \
+				     union perf_event *event, \
+				     struct perf_sample *sample, \
+				     struct evsel *evsel, \
+				     struct machine *machine) \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, sample, evsel, machine);	\
+	}
+CREATE_DELEGATE_SAMPLE(read);
+CREATE_DELEGATE_SAMPLE(sample);
+
+#define CREATE_DELEGATE_ATTR(name)					\
+	static int delegate_ ## name(const struct perf_tool *tool,	\
+				union perf_event *event,		\
+				struct evlist **pevlist)		\
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, pevlist);	\
+	}
+CREATE_DELEGATE_ATTR(attr);
+CREATE_DELEGATE_ATTR(event_update);
+
+#define CREATE_DELEGATE_OE(name)				   \
+	static int delegate_ ## name(const struct perf_tool *tool, \
+				     union perf_event *event,	   \
+				     struct ordered_events *oe)	   \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, oe);	\
+	}
+CREATE_DELEGATE_OE(finished_round);
+
+#define CREATE_DELEGATE_OP(name)				   \
+	static int delegate_ ## name(const struct perf_tool *tool, \
+				     union perf_event *event, \
+				     struct perf_sample *sample, \
+				     struct machine *machine) \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, sample, machine); \
+	}
+CREATE_DELEGATE_OP(aux);
+CREATE_DELEGATE_OP(aux_output_hw_id);
+CREATE_DELEGATE_OP(bpf);
+CREATE_DELEGATE_OP(cgroup);
+CREATE_DELEGATE_OP(comm);
+CREATE_DELEGATE_OP(context_switch);
+CREATE_DELEGATE_OP(exit);
+CREATE_DELEGATE_OP(fork);
+CREATE_DELEGATE_OP(itrace_start);
+CREATE_DELEGATE_OP(ksymbol);
+CREATE_DELEGATE_OP(lost);
+CREATE_DELEGATE_OP(lost_samples);
+CREATE_DELEGATE_OP(mmap);
+CREATE_DELEGATE_OP(mmap2);
+CREATE_DELEGATE_OP(namespaces);
+CREATE_DELEGATE_OP(text_poke);
+CREATE_DELEGATE_OP(throttle);
+CREATE_DELEGATE_OP(unthrottle);
+
+#define CREATE_DELEGATE_OP2(name)					\
+	static int delegate_ ## name(const struct perf_tool *tool,	\
+				     struct perf_session *session,	\
+				     union perf_event *event)		\
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, session, event);	\
+	}
+CREATE_DELEGATE_OP2(auxtrace_error);
+CREATE_DELEGATE_OP2(auxtrace_info);
+CREATE_DELEGATE_OP2(bpf_metadata);
+CREATE_DELEGATE_OP2(build_id);
+CREATE_DELEGATE_OP2(cpu_map);
+CREATE_DELEGATE_OP2(feature);
+CREATE_DELEGATE_OP2(finished_init);
+CREATE_DELEGATE_OP2(id_index);
+CREATE_DELEGATE_OP2(stat);
+CREATE_DELEGATE_OP2(stat_config);
+CREATE_DELEGATE_OP2(stat_round);
+CREATE_DELEGATE_OP2(thread_map);
+CREATE_DELEGATE_OP2(time_conv);
+CREATE_DELEGATE_OP2(tracing_data);
+
+#define CREATE_DELEGATE_OP3(name)					\
+	static s64 delegate_ ## name(const struct perf_tool *tool,	\
+				     struct perf_session *session,      \
+				     union perf_event *event)           \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;	\
+		return delegate->name(delegate, session, event);	\
+	}
+CREATE_DELEGATE_OP3(auxtrace);
+
+#define CREATE_DELEGATE_OP4(name)					\
+	static int delegate_ ## name(const struct perf_tool *tool, \
+			struct perf_session *session, \
+			union perf_event *event, \
+			u64 data, \
+			const char *str) \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, session, event, data, str);	\
+	}
+CREATE_DELEGATE_OP4(compressed);
+
+void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate)
+{
+	tool->delegate = delegate;
+
+	tool->tool.ordered_events = delegate->ordered_events;
+	tool->tool.ordering_requires_timestamps = delegate->ordering_requires_timestamps;
+	tool->tool.namespace_events = delegate->namespace_events;
+	tool->tool.cgroup_events = delegate->cgroup_events;
+	tool->tool.no_warn = delegate->no_warn;
+	tool->tool.show_feat_hdr = delegate->show_feat_hdr;
+
+	tool->tool.sample = delegate_sample;
+	tool->tool.read = delegate_read;
+
+	tool->tool.mmap = delegate_mmap;
+	tool->tool.mmap2 = delegate_mmap2;
+	tool->tool.comm = delegate_comm;
+	tool->tool.namespaces = delegate_namespaces;
+	tool->tool.cgroup = delegate_cgroup;
+	tool->tool.fork = delegate_fork;
+	tool->tool.exit = delegate_exit;
+	tool->tool.lost = delegate_lost;
+	tool->tool.lost_samples = delegate_lost_samples;
+	tool->tool.aux = delegate_aux;
+	tool->tool.itrace_start = delegate_itrace_start;
+	tool->tool.aux_output_hw_id = delegate_aux_output_hw_id;
+	tool->tool.context_switch = delegate_context_switch;
+	tool->tool.throttle = delegate_throttle;
+	tool->tool.unthrottle = delegate_unthrottle;
+	tool->tool.ksymbol = delegate_ksymbol;
+	tool->tool.bpf = delegate_bpf;
+	tool->tool.text_poke = delegate_text_poke;
+
+	tool->tool.attr = delegate_attr;
+	tool->tool.event_update = delegate_event_update;
+
+	tool->tool.tracing_data = delegate_tracing_data;
+
+	tool->tool.finished_round = delegate_finished_round;
+
+	tool->tool.build_id = delegate_build_id;
+	tool->tool.id_index = delegate_id_index;
+	tool->tool.auxtrace_info = delegate_auxtrace_info;
+	tool->tool.auxtrace_error = delegate_auxtrace_error;
+	tool->tool.time_conv = delegate_time_conv;
+	tool->tool.thread_map = delegate_thread_map;
+	tool->tool.cpu_map = delegate_cpu_map;
+	tool->tool.stat_config = delegate_stat_config;
+	tool->tool.stat = delegate_stat;
+	tool->tool.stat_round = delegate_stat_round;
+	tool->tool.feature = delegate_feature;
+	tool->tool.finished_init = delegate_finished_init;
+	tool->tool.bpf_metadata = delegate_bpf_metadata;
+	tool->tool.compressed = delegate_compressed;
+	tool->tool.auxtrace = delegate_auxtrace;
+}
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 1f1461808371..88337cee1e3e 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -102,4 +102,13 @@ int process_event_sample_stub(const struct perf_tool *tool,
 			      struct evsel *evsel,
 			      struct machine *machine);
 
+struct delegate_tool {
+	/** @tool: The actual tool that calls the delegate. */
+	struct perf_tool tool;
+	/** @delegate: The tool that is delegated to. */
+	struct perf_tool *delegate;
+};
+
+void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate);
+
 #endif /* __PERF_TOOL_H */
-- 
2.51.2.1006.ga50a493c49-goog

