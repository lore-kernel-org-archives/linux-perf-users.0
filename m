Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81D3E6DFA
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553489; cv=none; b=AnbA2khIVS3idoCjAjLCWSgYg52gCo7N9T8d61Ra2uxBmGCIDf2FzLFiF05K7TqUofVKhRWoYu8NzrMBPjiuSbgTU9eLCTvequYHPWBW2Qi3TbMT6OYpWC+0VD6McNC0B7My3pTuse6LciQQrWZ1VtTiKgq7tHAwSU+jxgH0gM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553489; c=relaxed/simple;
	bh=ZYJTunq+6oVrW1dWpi8lpaQOKa+jTPx4VeiGpAyE5Zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0ikVuDHHAwMztVse+FG9UbSdp+pjQ5l2LU391JDg0u3pmRtJR4r8HqBhPhZl5SNhPrxlzAQquyjYJg7GpYmsY/ujed7rD9XGKPM4YmvPpYSb/Ug5sgi430SvEsncVl7hbSHzL/mGN4q8Eiiqc5OPEOtx0d49pmLD3l98rnidmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXJCDxPq; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXJCDxPq"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso4686533a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553487; x=1788158287; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujroS2avTTF07SdRTk2D1dJLoLgQqn9x/r5p4GN3tq0=;
        b=iXJCDxPqjE+A9TWQdt79NlnL8bhK97Z8H80bbh6y473/tA+7zPkvb2Q/hD6mgtCw4k
         2VIvqbUIEbGylaPoZQlU4ClbLGTDJCrgr8+4Df5Ixh+t+/fgsQFsSHSDfWIKJjAdPMB7
         3Q9F91kHf6ZsI2T4nY5w6saEiFJAqbTY6PnwlnJa+Vs3BK4eYq+beBftZ5paI1ToDy4+
         NiRCgHx0wH4YZMOEKCVVh/tEE4j1sNNyW6H8d/j6fjVWpz3f9FUUB9UNwS8ePCTgKQzC
         j1pryPVcuj4F6X3enVJ/kwCHLnqQIHg1QaAoDU69PRe8061Hp9+ooFWdqXekYc3oTzWA
         y4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553487; x=1788158287;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujroS2avTTF07SdRTk2D1dJLoLgQqn9x/r5p4GN3tq0=;
        b=F58ldMTSnsm+t8DawkJex79a728P/IAkss8woIS5SOERZmJd4qVNBmFzYaGahcDmyg
         7AmQCwGtkhz+H/67+ES2T9XBIWirFKG7M9Rif8Vy9Rkjtg5NhHZdiUIyyrQpr0W33BoG
         4aFc9qT723A9WK3qbuDSbgyUqBy3B98iveAv1ocUoZGWhst3kC0Hq3LJIqQJF9CZl7XY
         Q1UKf2jda62cFl3dPs//Btt5uzQiQ7ffMCD3rovDweDsKtY4vBtgq1fmyJHg2CaHA75J
         AnaamCdEr+NU06RG4QBA9ZHMifCtupqWTKxc+8cRIhfu5MBxLDE/JXw3Hcd67fYibYpE
         BDpw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5nmc+X/x+Pa0YvoiiIlRV21fKmSWs1G83QM1U1nJbg90+hcZlO8aI4PNRs+cUGhnlhqTNmLytV3bKLK5K6gnD@vger.kernel.org
X-Gm-Message-State: AFuF++nbLX4WSKi/Z4fJ4xI6LY6XESHNLoAKsNWNj3ZroEEnBUdFSb++
	9/qcURlAwsaxGuqN72FAYPDIws8veirCL1g5LYqfJOivSTDx4h0Oh9wLlaBlK5+nfQc+cTgS4/a
	ZWcApJpRYKw==
X-Received: from dyjo21.prod.google.com ([2002:a05:7300:3395:b0:310:61e9:ab5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57d0:b0:37c:6130:7a5b
 with SMTP id 98e67ed59e1d1-395c33bd6c5mr45145740a91.8.1787553487174; Sun, 23
 Aug 2026 23:38:07 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:43 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-7-irogers@google.com>
Subject: [PATCH v1 6/7] perf ui hist: Format group headers iteratively based
 on proportional visual allocations
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Forcefully calculate proportional visual allocations only natively for
the 'Total' merge target header instead of uniformly ballooning array
spacings. Unpack strings directly into the primary column width fn.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/ui/hist.c     | 86 ++++++++++++++++++++++++++++++++--------
 tools/perf/util/evlist.c |  9 +++--
 tools/perf/util/hist.h   |  8 +++-
 3 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 09f0baa808e0..02c188100b09 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -57,8 +57,9 @@ struct hpp_fmt_value {
 };
 
 static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
-		      hpp_field_fn get_field, const char *fmt, int len,
-		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
+		      hpp_field_fn get_field, const char *fmtstr, int len,
+		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype,
+		      struct perf_hpp_fmt *fmt)
 {
 	int ret = 0;
 	struct hists *hists = he->hists;
@@ -98,14 +99,44 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 		}
 	}
 
-	for (i = 0; i < nr_members; i++) {
-		if (symbol_conf.skip_empty &&
-		    values[i].hists->stats.nr_samples == 0)
-			continue;
+	if (he->hists->merge_entries) {
+		u64 total_val = 0;
+		u64 total_samples = 0;
+		u64 total_period = 0;
+
+		for (i = 0; i < nr_members; i++) {
+			total_val += values[i].val;
+			total_samples += values[i].samples;
+			total_period += fmtype == PERF_HPP_FMT_TYPE__PERCENT ?
+					hists__total_period(values[i].hists) :
+					hists__total_latency(values[i].hists);
+		}
+
+		if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY) {
+			double percent = 0.0;
+
+			if (total_period)
+				percent = 100.0 * total_val / total_period;
+			ret += hpp__call_print_fn(hpp, print_fn, fmtstr, len, percent);
+		} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
+			double avg = total_samples ? (1.0 * total_val / total_samples) : 0;
 
-		ret += __hpp__fmt_print(hpp, values[i].hists, values[i].val,
-					values[i].samples, fmt, len,
-					print_fn, fmtype);
+			ret += hpp__call_print_fn(hpp, print_fn, fmtstr, len, avg);
+		} else {
+			ret += hpp__call_print_fn(hpp, print_fn, fmtstr, len, total_val);
+		}
+	}
+
+	if (!he->hists->merge_entries || &fmt->list == he->hists->hpp_list->fields.next) {
+		for (i = 0; i < nr_members; i++) {
+			if (symbol_conf.skip_empty &&
+			    values[i].hists->stats.nr_samples == 0)
+				continue;
+
+			ret += __hpp__fmt_print(hpp, values[i].hists, values[i].val,
+							values[i].samples, fmtstr, len,
+						print_fn, fmtype);
+		}
 	}
 
 	free(values);
@@ -129,7 +160,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 
 	if (symbol_conf.field_sep) {
 		return __hpp__fmt(hpp, he, get_field, fmtstr, 1,
-				  print_fn, fmtype);
+				  print_fn, fmtype, fmt);
 	}
 
 	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY)
@@ -137,7 +168,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	else
 		len -= 1;
 
-	return  __hpp__fmt(hpp, he, get_field, fmtstr, len, print_fn, fmtype);
+	return  __hpp__fmt(hpp, he, get_field, fmtstr, len, print_fn, fmtype, fmt);
 }
 
 int hpp__fmt_acc(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -399,10 +430,16 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 		int nr = 0;
 		struct evsel *pos;
 
-		for_each_group_evsel(pos, evsel) {
-			if (!symbol_conf.skip_empty ||
-			    evsel__hists(pos)->stats.nr_samples)
-				nr++;
+		if (hists->merge_entries && &fmt->list != hists->hpp_list->fields.next) {
+			nr = 1;
+		} else {
+			for_each_group_evsel(pos, evsel) {
+				if (!symbol_conf.skip_empty ||
+				    evsel__hists(pos)->stats.nr_samples)
+					nr++;
+			}
+			if (hists->merge_entries && &fmt->list == hists->hpp_list->fields.next)
+				nr++; /* Add 1 extra unit of width generically for the 'Total' */
 		}
 
 		len = max(len, nr * fmt->len);
@@ -421,8 +458,25 @@ static int hpp__header_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	int len = hpp__width_fn(fmt, hpp, hists);
 	const char *hdr = "";
 
-	if (line == hists->hpp_list->nr_header_lines - 1)
+	if (line == hists->hpp_list->nr_header_lines - 1) {
 		hdr = fmt->name;
+		if (hists->merge_entries && &fmt->list == hists->hpp_list->fields.next) {
+			char buf[1024];
+			int w = 0;
+			int f_len = fmt->user_len ?: fmt->len;
+			struct evsel *pos, *evsel = hists_to_evsel(hists);
+
+			w += scnprintf(buf + w, sizeof(buf) - w, "%*.*s", f_len, f_len, fmt->name);
+			for_each_group_evsel(pos, evsel) {
+				if (symbol_conf.skip_empty &&
+			    evsel__hists(pos)->stats.nr_samples == 0)
+					continue;
+				w += scnprintf(buf + w, sizeof(buf) - w, " %*.*s",
+					       f_len - 1, f_len - 1, evsel__name(pos));
+			}
+			return scnprintf(hpp->buf, hpp->size, "%*s", len, buf);
+		}
+	}
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", len, hdr);
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 431759e05e26..4c928ef5c985 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -324,10 +324,13 @@ void evlist__merge_hybrid(struct evlist *evlist, bool refresh_hists)
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__is_dummy_event(pos))
 			continue;
+
 		if (pos->core.leader == &pos->core && pos->core.nr_members > 1) {
 			evsel__hists(pos)->merge_entries = true;
 			symbol_conf.event_group = true;
 			symbol_conf.hybrid_merge = true;
+			if (!pos->group_name)
+				pos->group_name = strdup("Merged hybrid events");
 		}
 	}
 
@@ -345,12 +348,10 @@ void evlist__merge_hybrid(struct evlist *evlist, bool refresh_hists)
 		}
 	}
 
-	/* Now that links are formed, safely resort the active tree so the UI renders accurately */
+	/* Resort the output dynamically since group parsing bypassed this before */
 	if (symbol_conf.event_group) {
 		evlist__for_each_entry(evlist, pos) {
-			if (evsel__is_dummy_event(pos) || !evsel__is_group_leader(pos))
-				continue;
-			if (pos->core.nr_members > 1)
+			if (pos->core.leader == &pos->core && pos->core.nr_members > 1)
 				hists__output_resort(evsel__hists(pos), NULL);
 		}
 	}
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6cb7059e8405..5a0cfa8ea264 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,7 +339,13 @@ static inline struct hist_entry *hist_entry__next_pair(struct hist_entry *he)
 static inline void hist_entry__add_pair(struct hist_entry *pair,
 					struct hist_entry *he)
 {
-	list_add_tail(&pair->pairs.node, &he->pairs.head);
+	struct list_head *pos;
+
+	list_for_each(pos, &he->pairs.head) {
+		if (pos == &pair->pairs.node)
+			return; /* Already paired */
+	}
+	list_move_tail(&pair->pairs.node, &he->pairs.head);
 }
 
 struct hist_entry *hists__add_entry(struct hists *hists,
-- 
2.55.0.766.g2966f0265a-goog

