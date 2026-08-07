Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F873C3429
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087122; cv=none; b=XRRrhGTiy8PvqNlYy31f218xANi7yl1xYmgWSsKH4pgB0o6LurRELpG0+6mKym2riUYGVH+1r8wcIW3GVkqSBZibAb0C9fUtYQ3axGfjEn11HuZoi9H8VTqcBwI5gbs1fMA9X3R/jI9T+gkCHGyLW6e51SuLz8rFlRVasosKFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087122; c=relaxed/simple;
	bh=5xQAqmvorxXdNNFmQzGl8mnKvCDu0Bkadw40xjrakYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HYbLOAR4qvvYG8/tC1C1gpKYjQayrlMRU/OaDQy8rWMTtwJ6zORWiYe8xlWBGsR9oYu8BAklpIFx0rr+nxfBQsB4B/oyv3tS8qPb2woJuCUD/emFlm8ogOpVJIQT25wj6e4jfea8PepmnKYTCTrFG5+EdBp7SIg4ZgqvYn2qJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRUlq72G; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRUlq72G"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so37672135ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087120; x=1786691920; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=id+6dnzU4I7sg38xB44NTSjVHYaER430HX1yg72oJFQ=;
        b=WRUlq72G0QxhV5q2yCiFYNvZEOfg95muzH8jPnmMlxDh8rawA6c3VO8HzN3IQE4a3e
         le6+AYBsEFK61FVsdcPB7a9R3FOEA/uOkbr/EqdOh5L8TR0C8A88T+7wzSRXrTMPf7r7
         xUh1E7HBEoE+RHL7Zg4aWG3RoCg57lEy0HFwrYV9cRO6VXqRYdBbAPmogz6aPWj9zJ0f
         DDHq/7LHtndn0FbPZ8dCUFR2tG9Vave6kg8l1N/JWx8wD/Azs/m5b5c4NFZnnVq1kRcC
         DkxpBLO5TFQb48HDHfSjx8KSfWLaGQJQMGNsracFrEayzy5oiHIBL7NA1HmOCzH2Tkqc
         HEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087120; x=1786691920;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id+6dnzU4I7sg38xB44NTSjVHYaER430HX1yg72oJFQ=;
        b=aR+tHrUh65gt5+C8qete37y8icPPt7iAp5JQItQp5Rkaewd7AtqPDfMnlyFO8Gn8BA
         CO7FJO56fsAxhJollXCKvFDGZmCG8oyzvPjMcHOc23i1svIOvCdPRaRuL1PHy5+oP3os
         3Sl74N9+UmcLIq4qjgx7WCG5oR+kEdcy2j/BIV+JKO2nD+THQ+l9Zrtqe0yVOrXLNndc
         hrWGvgMO98FQz5vVdGW5sbcsfjOgtFVj3JgKtOpOOy9w/8tMAiQlBkpQmcxAuEBPKKLF
         wRTtuVH2cC3Qp+GPKfn/rN27U8/VbEO8U1OGzDEnOkcfqultZp03+BKryaaVmPAKIlDe
         YSzQ==
X-Forwarded-Encrypted: i=1; AHgh+RohMZpoFnOovdgjbo+WUA4Wc1s0YhqQn6C4fKNK/2rADSlhc2f8BwXrYyqKFZYPhRch21nIrL4EOft1a7yZZKvL@vger.kernel.org
X-Gm-Message-State: AOJu0YyEef6dRp0WmqMt8iS3xEOZ+WcqoCgcF2vDopK9znLVyvvFUcFc
	+CmRH2IFwKfwI1udn1CUCI6zBWN2r6+z5ANVHxkipMpmxQ3hlMZxa/dla+4PFZ/gRpiYfh+b4xn
	Y793kFo+nWQ==
X-Received: from dybhg52.prod.google.com ([2002:a05:7301:2ab4:b0:30f:4402:de4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1fc8:b0:3c4:397a:69ba
 with SMTP id adf61e73a8af0-3cb85ef8666mr24983360637.28.1786087119621; Fri, 07
 Aug 2026 00:18:39 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:17 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-8-irogers@google.com>
Subject: [RFC PATCH v1 7/8] perf record: Add --buildid-offset option
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add the --buildid-offset flag to perf record to natively request
PERF_SAMPLE_BUILD_ID_OFFSET and PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
from the kernel. This configures the evsel attributes by replacing
the standard IP and CALLCHAIN bits with the build ID offset equivalents.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  7 +++++++
 tools/perf/util/evsel.c     | 11 +++++++++++
 tools/perf/util/record.h    |  1 +
 3 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..9ff9cfc06278 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3608,6 +3608,8 @@ static struct option __record_options[] = {
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
 		    "Record build-id of all DSOs regardless of hits"),
+	OPT_BOOLEAN(0, "buildid-offset", &record.opts.buildid_offset,
+		    "Record build id offset instead of IP"),
 	OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.buildid_mmap_set,
 			"Record build-id in mmap events and skip build-id processing."),
 	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
@@ -4166,6 +4168,11 @@ int cmd_record(int argc, const char **argv)
 		rec->no_buildid_cache = true;
 	}
 
+	if (rec->opts.buildid_offset) {
+		/* Do not drop mmap events here so we can generate build ids later */
+		/* rec->opts.synth &= ~PERF_SYNTH_MMAP; */
+	}
+
 	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
 		pr_err("Kernel has no cgroup sampling support.\n");
 		err = -EINVAL;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d9a07f5825e8..587f0fa41cce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1744,6 +1744,17 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	if (opts->sample_transaction)
 		evsel__set_sample_bit(evsel, TRANSACTION);
 
+	if (opts->buildid_offset) {
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_IP) {
+			evsel__reset_sample_bit(evsel, IP);
+			evsel__set_sample_bit(evsel, BUILD_ID_OFFSET);
+		}
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+			evsel__reset_sample_bit(evsel, CALLCHAIN);
+			evsel__set_sample_bit(evsel, CALLCHAIN_BUILD_ID_OFFSET);
+		}
+	}
+
 	if (opts->running_time) {
 		evsel->core.attr.read_format |=
 			PERF_FORMAT_TOTAL_TIME_ENABLED |
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..a8cec7db150e 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -55,6 +55,7 @@ struct record_opts {
 	bool	      kcore;
 	bool	      text_poke;
 	bool	      build_id;
+	bool	      buildid_offset;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
-- 
2.55.0.679.g6767b8d81c-goog

