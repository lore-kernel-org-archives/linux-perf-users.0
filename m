Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8942DCBFC
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643165; cv=none; b=htr+t4NtwUEfOH5edm0Yf6oz/lwhpaPHJK9QGXDl/zg+9iOzAoETCaC+c8Lb9HNyfNU+p6sDmIyFyqLSput/+05eliOwF0xzD7fV9P6hLaxgxreitzpoybGS5LnaJvj6yKCG80QvafPtcCuBPogd88ZX1oBAxJSwqtVjqUaIhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643165; c=relaxed/simple;
	bh=xD+XvGWdJ1twPTWkJJ/cVcJXypCdOt0uHpUiNL/6tIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLKBK/x7ZR67RtapTE/A5ZUCpvlkdb5rLjuTz3ufL/foziYjkVNXcDfdGerS+WK93kdNYip+6XrRFfQK+5tv8qCXJ1WSE6Ef7PeYwLYpYzYKrubhQ1w/P4+0SNfIpKzha/dSP0UITM6FGqy/3OmXrc2kIKOa9ZJTMiXmcBQAxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEvenUvW; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEvenUvW"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8de02a4dso1151883c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643163; x=1777247963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV8HwBs7L8DWfF5eZqklbv2fzPlky27Yd40FsyTJ/OM=;
        b=HEvenUvWf0rwygJdRMjo3FaPaH08uSFP/D7201JYYvyWqEBnTeEYyeSpDr9UArhich
         xQ+lj7OS3iEALcEjq/byh/HW+WdhI8xZIKEuZoYD/2zIaTg3M1DtvlguodDsOz1cHTFZ
         ydtmA/wBeGnlQWX4L+1Es6/Vc6yTTKdKA7XDRXV6y9ebZK66YeiuZBD6r4EGb2hSKW6H
         0woRQZGJ/+A7RX2Lx+Nm2+KgSRX0/MwyIpvb8+puVuhY75vBxvrLknSbvMuqfdkz6abJ
         YhPnoKfuopCfw3ggsgeVjqYxuiunSbWrvpGUaE5P7LZ9JxiQDQXwFDuuq6Rw8cYl0HP9
         qh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643163; x=1777247963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV8HwBs7L8DWfF5eZqklbv2fzPlky27Yd40FsyTJ/OM=;
        b=UCUC3muuEB5WZfssqQ72BbfghxBfurzHlMhrz1/ZY/xtKS+NM5WF/dXdTPqRDlAoWC
         sAvteJoHntwaa73rG+7ZJB55qdb+GRUeaEk0LqQbOGP0TDcVYZJwyVN9YKqXG3soclqt
         IE6ScG4Ukydb2rkwNNoAiqSkFelJCHwo7iNEmmHABRiIc/esE8WPDxk0zm6+VPbws5hq
         qmWLQKQ0xwpO28gGPbP3c88JDQN8D6OyHvwqXt/kY1A0NCVp6GB+CH0MgZ2DUbEcXR2/
         uHvExl8NF74q3muf6ctabDlXspVcLXME3XzU+oXRgyCpRBu+78EMP27I/ZCi3pZeyUne
         TD3w==
X-Forwarded-Encrypted: i=1; AFNElJ9jUnjg1mbsbS1tqMOUfCC2dPsj+9Enqpdegw3kXkYrXBDU+vhOExKGCic5QKIM2FIoxLcBYD+srqE34sEJJEiH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbsj0HULU26M4xZ3WJ2jNZrirufyaE4ydPis9c6LndLEOUqTFA
	fd31Vc0dHQuIiVntIHZSViP8UvjVENWA9frE342koMGtdxtnLsBvKKD0MFQngwm7tV4d5BzEBcu
	IZtUCSOG3CA==
X-Received: from dycns6.prod.google.com ([2002:a05:7300:f786:b0:2df:c53c:24a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:30e:b0:12a:949b:b9b
 with SMTP id a92af1059eb24-12c73f99c7fmr5712676c88.23.1776643162927; Sun, 19
 Apr 2026 16:59:22 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:13 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-2-irogers@google.com>
Subject: [PATCH v1 01/58] perf inject: Fix itrace branch stack synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When using "perf inject --itrace=L" to synthesize branch stacks from
AUX data, several issues caused failures:

1. The synthesized samples were delivered without the
   PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
   sample_type. Fixed by using sample_type | evsel->synth_sample_type
   in intel_pt_deliver_synth_event.

2. The record layout was misaligned because of inconsistent handling
   of PERF_SAMPLE_BRANCH_HW_INDEX. Fixed by explicitly writing nr and
   hw_idx in perf_event__synthesize_sample.

3. Modifying evsel->core.attr.sample_type early in __cmd_inject caused
   parse failures for subsequent records in the input file. Fixed by
   moving this modification to just before writing the header.

4. perf_event__repipe_sample was narrowed to only synthesize samples
   when branch stack injection was requested, and restored the use of
   perf_inject__cut_auxtrace_sample as a fallback to preserve
   functionality.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 63 +++++++++++++++++++++++++++++-
 tools/perf/util/intel-pt.c         |  3 +-
 tools/perf/util/synthetic-events.c |  6 +--
 3 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f174bc69cec4..9da334740017 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -375,7 +375,52 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
-	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
+	if (inject->itrace_synth_opts.set &&
+	    (inject->itrace_synth_opts.last_branch ||
+	     inject->itrace_synth_opts.add_last_branch)) {
+		union perf_event *event_copy = (void *)inject->event_copy;
+		struct branch_stack dummy_bs = { .nr = 0 };
+		int err;
+		size_t sz;
+		u64 orig_type = evsel->core.attr.sample_type;
+		u64 orig_branch_type = evsel->core.attr.branch_sample_type;
+
+		if (event_copy == NULL) {
+			inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
+			if (!inject->event_copy)
+				return -ENOMEM;
+
+			event_copy = (void *)inject->event_copy;
+		}
+
+		if (!sample->branch_stack)
+			sample->branch_stack = &dummy_bs;
+
+		if (inject->itrace_synth_opts.add_last_branch) {
+			/* Temporarily add in type bits for synthesis. */
+			evsel->core.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+			evsel->core.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+			evsel->core.attr.sample_type &= ~PERF_SAMPLE_AUX;
+		}
+
+		sz = perf_event__sample_event_size(sample, evsel->core.attr.sample_type,
+						   evsel->core.attr.read_format);
+
+		event_copy->header.type = PERF_RECORD_SAMPLE;
+		event_copy->header.size = sz;
+
+		err = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
+						    evsel->core.attr.read_format, sample);
+
+		evsel->core.attr.sample_type = orig_type;
+		evsel->core.attr.branch_sample_type = orig_branch_type;
+
+		if (err) {
+			pr_err("Failed to synthesize sample\n");
+			return err;
+		}
+		event = event_copy;
+	} else if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
 		if (IS_ERR(event))
 			return PTR_ERR(event);
@@ -2434,12 +2479,26 @@ static int __cmd_inject(struct perf_inject *inject)
 		 * synthesized hardware events, so clear the feature flag.
 		 */
 		if (inject->itrace_synth_opts.set) {
+			struct evsel *evsel;
+
 			perf_header__clear_feat(&session->header,
 						HEADER_AUXTRACE);
+
+			evlist__for_each_entry(session->evlist, evsel) {
+				evsel->core.attr.sample_type &= ~PERF_SAMPLE_AUX;
+			}
+
 			if (inject->itrace_synth_opts.last_branch ||
-			    inject->itrace_synth_opts.add_last_branch)
+			    inject->itrace_synth_opts.add_last_branch) {
 				perf_header__set_feat(&session->header,
 						      HEADER_BRANCH_STACK);
+
+				evlist__for_each_entry(session->evlist, evsel) {
+					evsel->core.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+					evsel->core.attr.branch_sample_type |=
+						PERF_SAMPLE_BRANCH_HW_INDEX;
+				}
+			}
 		}
 
 		/*
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fc9eec8b54b8..b9fcf3b457b0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2557,7 +2557,8 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		sample.transaction = txn;
 	}
 
-	ret = intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
+	ret = intel_pt_deliver_synth_event(pt, event, &sample,
+					   sample_type | evsel->synth_sample_type);
 	perf_sample__exit(&sample);
 	return ret;
 }
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 85bee747f4cd..33b530b73796 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1719,9 +1719,9 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		/* nr, hw_idx */
-		sz += 2 * sizeof(u64);
-		memcpy(array, sample->branch_stack, sz);
+		*array++ = sample->branch_stack->nr;
+		*array++ = sample->branch_stack->hw_idx;
+		memcpy(array, sample->branch_stack->entries, sz);
 		array = (void *)array + sz;
 	}
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

