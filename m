Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BD15ECC0
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700233; cv=none; b=TQkJih+69hBBPy/rJq8FvHUv5qZWHKRTkTZ2/4D+Zp3IM8YPpMgkPkD5fjmYiCsZOE75HNcSxrJrpCrpIakjdjlrBr6md8h8ynTtSzngge4gN3REEiqC6h2exaDte3XbjtkbQBBLHrgkBWIXyGFPXrYT8hRzxmo9w/NVf10woa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700233; c=relaxed/simple;
	bh=LylSGN00CZycrIeZtCZWrilto+Oh9Zgg0qJLpjORVCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t3QZW2x+P5sZlyJ6EmVGxBN6NBJkHDRjNj1ujgKr4cTiDP8m3rR7vSRW59xAjomj/VTKxHxeLK8eAjz5xEQs9CqpVm8Zoxk4D8dmRS1gWy5HiB2bOxR+bx4U4cfTncLtwSaughJXfWSOueZdawRt8HQ2Xj+eEtQlqZwVwRmZBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KK7LuUy+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KK7LuUy+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af22a9c19so617603b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720700231; x=1721305031; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zNUgfMo2gXZSNLPHfh654aj1KCXo46JCf2k9E+T7+E0=;
        b=KK7LuUy+DBSzLjLX10CbOSk3k555My2TQvb9zodLgY7dCbEGe6XkgA/6vtkyZqmWXh
         cljPNDwaETAJYPd8Hz4Bkqqry/FvvVN9fmzEtPOz9r92yOIgX+yMwvEAc0G80zAKUcD+
         LzohAkmFSEWr5MenVgG3kzLakMUPFiNikVz5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700231; x=1721305031;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNUgfMo2gXZSNLPHfh654aj1KCXo46JCf2k9E+T7+E0=;
        b=tHXVJMEqAx5YrSYyA0DeVsYLkmZrNx+gmVIbmNPSoBSj/f5ph4bpJqLkSzcRTsHV8K
         DwBq7R19aGYcvkIEm9ePujRQYFc79eZ7PT7nDiQSAulKIDvR+nkMqxZ62xQWkdFbVOkA
         dA9y2NH20lsNmJQDuuH+g7c0/d2xgzjEWg5CfmjjoCKdmZ2ykwg6IzHXYke+2IfzSD81
         lj1tjq5tQVC1RFU65xvdf30vs9zBOrGZW6KK7vtOnOESBoMJC52jy1CmK2hHAXgnNEra
         eiQ/us59utin4P3xkunZmyMmZJ+KPVW2/DA1Hgig+Vxzc+C2dOm9hrVhzXM2GirbHa+D
         cAOg==
X-Forwarded-Encrypted: i=1; AJvYcCXmo2z5lJ8wxVF9fabM151HNdNH2fulSoolbq4Je2bW04gmu1Zg3MNPSLitInsStgAJX2Ie7+F5PvhQAFwLSU9H2R7TIV0d1j++VxWjpeS2Ag==
X-Gm-Message-State: AOJu0Yz0/V4aYGJl5ZUzdeXmjPgOrvWjvFDRoURHdakd5iJS79OSItKH
	Szw3M0veXG1FNarGQ8tcInaY3vtoiNlBDfRp5kKrNvj/CKU/gmQoNNVehU9FHw==
X-Google-Smtp-Source: AGHT+IFNkZ5F02HmXU6UCANTg5DiTRJQwTFLrtdtbLiaqEloiR+jcdq1tO98nmpNd2EYHR1M29lc+Q==
X-Received: by 2002:a05:6a20:734c:b0:1c0:f6b7:a897 with SMTP id adf61e73a8af0-1c2982285f2mr9806840637.32.1720700230784;
        Thu, 11 Jul 2024 05:17:10 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10111sm49211985ad.20.2024.07.11.05.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:17:10 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	asmadeus@codewreck.org,
	siyanteng@loongson.cn,
	sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH RFC 3/3] perf/report: add off-cpu samples
Date: Thu, 11 Jul 2024 17:46:19 +0530
Message-Id: <1720700179-22839-4-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

off-cpu samples represent the time period for which the target
process not occupying the cpu cycles.

In following example, perf has collected 15 off-cpu samples and
program was running on cpu for 27%:

Samples: 24 of 'task-clock:ppp', 15 of 'offcpu', Event count: ~9150831908 (73% offcpu)
+73.77%    73.77%  a.out    libc.so.6    [.] clock_nanosleep      <-- off-cpu sample
+24.04%    24.04%  a.out    [vdso]       [.] __vdso_gettimeofday  <-- on-cpu sample

Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>

---
 tools/perf/util/events_stats.h |  2 ++
 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/hist.c         | 31 ++++++++++++++++++++++++++++---
 tools/perf/util/hist.h         |  1 +
 tools/perf/util/sample.h       |  1 +
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 8fecc9fbaecc..7bb3cf1ab835 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -44,8 +44,10 @@ struct events_stats {
 
 struct hists_stats {
 	u64 total_period;
+	u64 total_period_off_cpu;
 	u64 total_non_filtered_period;
 	u32 nr_samples;
+	u64 nr_samples_off_cpu;
 	u32 nr_non_filtered_samples;
 	u32 nr_lost_samples;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8ba890a5ac6e..ea41586474e3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1146,6 +1146,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->write_backward = opts->overwrite ? 1 : 0;
 	attr->read_format   = PERF_FORMAT_LOST;
 
+	evsel__set_sample_bit(evsel, CPU);
 	evsel__set_sample_bit(evsel, IP);
 	evsel__set_sample_bit(evsel, TID);
 
@@ -2438,6 +2439,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			u.val32[0] = bswap_32(u.val32[0]);
 		}
 
+		data->off_cpu = u.val32[1];
 		data->cpu = u.val32[0];
 		array++;
 	}
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 2e9e193179dd..251333e0b021 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -23,6 +23,7 @@
 #include "thread.h"
 #include "block-info.h"
 #include "ui/progress.h"
+#include "ui/util.h"
 #include <errno.h>
 #include <math.h>
 #include <inttypes.h>
@@ -725,6 +726,7 @@ __hists__add_entry(struct hists *hists,
 		.socket	 = al->socket,
 		.cpu	 = al->cpu,
 		.cpumode = al->cpumode,
+		.off_cpu = sample->off_cpu,
 		.ip	 = al->addr,
 		.level	 = al->level,
 		.code_page_size = sample->code_page_size,
@@ -1076,6 +1078,8 @@ iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 	callchain_cursor_commit(get_tls_callchain_cursor());
 
 	hists__inc_nr_samples(hists, he->filtered);
+	if (sample->off_cpu)
+		++hists->stats.nr_samples_off_cpu;
 
 	return err;
 }
@@ -1740,6 +1744,7 @@ void hists__reset_stats(struct hists *hists)
 {
 	hists->nr_entries = 0;
 	hists->stats.total_period = 0;
+	hists->stats.total_period_off_cpu = 0;
 
 	hists__reset_filter_stats(hists);
 }
@@ -1757,6 +1762,9 @@ void hists__inc_stats(struct hists *hists, struct hist_entry *h)
 
 	hists->nr_entries++;
 	hists->stats.total_period += h->stat.period;
+
+	if (h->off_cpu)
+		hists->stats.total_period_off_cpu += h->stat.period;
 }
 
 static void hierarchy_recalc_total_periods(struct hists *hists)
@@ -2745,14 +2753,20 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	struct thread *thread = hists->thread_filter;
 	int socket_id = hists->socket_filter;
 	unsigned long nr_samples = hists->stats.nr_samples;
+	unsigned long nr_samples_off_cpu = hists->stats.nr_samples_off_cpu;
 	u64 nr_events = hists->stats.total_period;
+	int nr_events_off_cpu_percentage = (hists->stats.total_period_off_cpu * 100) / nr_events;
 	struct evsel *evsel = hists_to_evsel(hists);
 	const char *ev_name = evsel__name(evsel);
 	char buf[512], sample_freq_str[64] = "";
+	char oncpu_str[128] = "";
+	char offcpu_str[128] = "";
+	char offcpu_percentage_str[128] = "";
 	size_t buflen = sizeof(buf);
 	char ref[30] = " show reference callgraph, ";
 	bool enable_ref = false;
 
+
 	if (symbol_conf.filter_relative) {
 		nr_samples = hists->stats.nr_non_filtered_samples;
 		nr_events = hists->stats.total_non_filtered_period;
@@ -2785,10 +2799,21 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->core.attr.sample_freq);
 
 	nr_samples = convert_unit(nr_samples, &unit);
+
+	scnprintf(oncpu_str, sizeof(oncpu_str), "%lu%c of '%s',",
+		  nr_samples - nr_samples_off_cpu, unit, ev_name);
+
+	if (evsel->core.attr.off_cpu) {
+		scnprintf(offcpu_str, sizeof(offcpu_str), "%lu%c of '%s',",
+			  nr_samples_off_cpu, unit, "offcpu");
+		scnprintf(offcpu_percentage_str, sizeof(offcpu_percentage_str),
+			  "(%d%% offcpu)", nr_events_off_cpu_percentage);
+	}
+
 	printed = scnprintf(bf, size,
-			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			   nr_samples, unit, evsel->core.nr_members > 1 ? "s" : "",
-			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
+			    "Samples: %s %s %s%sEvent count: ~%" PRIu64 " %s",
+			    oncpu_str, offcpu_str, sample_freq_str, enable_ref ? ref : " ",
+			    nr_events, offcpu_percentage_str);
 
 
 	if (hists->uid_filter_str)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 8fb3bdd29188..c64a07ce92fb 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -236,6 +236,7 @@ struct hist_entry {
 	/* We are added by hists__add_dummy_entry. */
 	bool			dummy;
 	bool			leaf;
+	bool			off_cpu;
 
 	char			level;
 	u8			filtered;
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 70b2c3135555..59b0951f4718 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -109,6 +109,7 @@ struct perf_sample {
 		u16 retire_lat;
 	};
 	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
+	bool off_cpu;
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
-- 
2.39.0

