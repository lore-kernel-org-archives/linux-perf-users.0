Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCC3E5A1F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553482; cv=none; b=mgfcOiLRTlyafeTOxvUIEYz2zQx1Wjt0K/6hA6xF1xb9DNQc5zjrroz8pWIdp6V7zmL3NA/hAF9cz54FjnOjgGpcCwNO8eFWDgBTo8eiOaSX5JC2XKj4Ej7goBu5xLEq+wbprKr56r+g2qSE4ws8AqUVtzhdTIp0fMvIe2cK+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553482; c=relaxed/simple;
	bh=zWUWQW1KXSfEix/aFMakAv10iRhdux349llom5of3M8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/Sfgk1xQh/8kPm0tkoWaBuoVWWpuGGGBXpmKTeVyQpGtLqWfl/14jEtAmS4EFIhBEwjeTwE5E1j43HayB4WUQP/8wBpsncn1k8GOfUrquY28NZhEEBgiGYZumjPQqLXXJQ/qqz01ol6Y+JfCIok+wqMEAAcRCLOW3RLr7eXuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZRKnifL; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZRKnifL"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so4768750a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553480; x=1788158280; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sce91W/fnERmny3wSBPa7HIZa1Vfdn40QbIPGip5K3M=;
        b=fZRKnifLUnoWi7TXeYC07CAcbNol/yOCU8rhl2siKev0oEI7vo9BrwlRwofy9OpOwu
         Pqg1Zab0y2rMVXtE3C8tpb0tJsGsYFHXh0qjOICoaq6KgDhVKiV5TqPw8dwH7DIxrYIN
         SR9gv2qIy4Ee1MBA1bTsctIATd2pXzXejVp5WqnOk9QSkdT6u/kZpDVHNsLyedOZqv7n
         Jjl9d4QsKIY3vFuV66koOd6by8O6+TK3w0oI7L5x9VnnhMqdSdVgjBBadi2q7o8jqpGK
         hsQNwbhrfMQ2rqg53wXdktiWfY4qC9cFwB9+iF9q+Tjqenm6pdw9cZJTjzNMgN+DLXJh
         XFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553480; x=1788158280;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sce91W/fnERmny3wSBPa7HIZa1Vfdn40QbIPGip5K3M=;
        b=Qwh3HrRGVq8m7trKjwQhUUYdJ4Nkh7BJ66V2t6Z8lGphBjY0/WCO8vnAFwDZ5m7rtN
         Y99HWLAGN51lVESqbWQZIV/9Ybm8V8IJP5w0pNHMAJwnSHS7mqoaVWQt+tKgEbMFeQge
         s5PTddZfv/L1SQDjdNd1Cx72jflxMeUU0tWKv6qstOT5c1PT9LyS4ocBjxfooej8VHYq
         6gjPpnCAKhREojCWY9jb4RFFYAxcm7TLz0uDY1l2xiiMR5k3cPC1LODlw33dyV+RudFb
         k0Aj0jHFEUw2l10su1k6H6R428Vjlr++iE5819kJhgjrkdTnbS2zD5vZSIql2rdqJ00l
         MrXw==
X-Forwarded-Encrypted: i=1; AHgh+RpNn1sXXxdIRshoOdKaVl087bSg7xbrkXRTpWnuQhUK4M70N17uSHG7Db3PceeerEkGN6JyR+b4Qoi+NsF+n2c+@vger.kernel.org
X-Gm-Message-State: AFuF++kiV4PMTNaIUAAmeTEs31zuHmxNddfQXA8bsGCpzPIWRmZg5Xua
	KRjl+wiwRtdJq+kecDHgYwAJSnbNOXeP2AfwcpZtKTcg9rRcFkehPl+AdPbM+sEf8dCytzEza9C
	eE6DWNeeS7A==
X-Received: from dlbtz19.prod.google.com ([2002:a05:7022:ead3:b0:141:2cc0:fb15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:520c:b0:37f:ed7e:7e42
 with SMTP id 98e67ed59e1d1-395c3867ac5mr45318661a91.14.1787553479614; Sun, 23
 Aug 2026 23:37:59 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:39 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-3-irogers@google.com>
Subject: [PATCH v1 2/7] perf ui hist: Add support for aggregated total_period
 and merging entries cleanly
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement cross-PMU histogram sorting logic and properly scale the
global total_period for symmetric percentage ceilings across differing
core types, resolving issues with --percent-limit.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/ui/hist.c   | 49 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/hist.h |  5 +++++
 2 files changed, 54 insertions(+)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e58327595d37..09f0baa808e0 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -287,6 +287,24 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return __hpp__group_sort_idx(a, b, get_field,
 					     symbol_conf.group_sort_idx);
 	}
+	/*
+	 * Relies on merge_entries being only enabled if there are
+	 * only matching events. If that is ever relaxed will need
+	 * more logic here.
+	 */
+	if (a->hists->merge_entries && b->hists->merge_entries) {
+		u64 val_a = get_field(a), val_b = get_field(b);
+		struct hist_entry *pair;
+
+		list_for_each_entry(pair, &a->pairs.head, pairs.node)
+			val_a += get_field(pair);
+		list_for_each_entry(pair, &b->pairs.head, pairs.node)
+			val_b += get_field(pair);
+
+		ret = field_cmp(val_a, val_b);
+		if (ret)
+			return ret;
+	}
 
 	ret = field_cmp(get_field(a), get_field(b));
 	if (ret || !symbol_conf.event_group)
@@ -1271,3 +1289,34 @@ int perf_hpp__alloc_mem_stats(struct perf_hpp_list *list, struct evlist *evlist)
 	}
 	return 0;
 }
+
+float hist_entry__get_percent_limit_merged(struct hist_entry *he)
+{
+	struct hist_entry *pair;
+	u64 period = he->stat.period;
+	u64 total_period = hists__total_period(he->hists);
+	struct evsel *evsel = hists_to_evsel(he->hists);
+	struct evsel *pos;
+
+	/* Accumulate global total_period across all merged hists */
+	for_each_group_member(pos, evsel) {
+		total_period += hists__total_period(evsel__hists(pos));
+	}
+
+	/* Accumulate symbol specific period across pairs */
+	list_for_each_entry(pair, &he->pairs.head, pairs.node) {
+		period += pair->stat.period;
+	}
+
+	if (unlikely(total_period == 0))
+		return 0;
+
+	if (symbol_conf.cumulate_callchain) {
+		period = he->stat_acc->period;
+		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
+			period += pair->stat_acc->period;
+		}
+	}
+
+	return period * 100.0 / total_period;
+}
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index ea79628bbc6b..6cb7059e8405 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -434,6 +434,8 @@ void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
 int hists__unlink(struct hists *hists);
 
+float hist_entry__get_percent_limit_merged(struct hist_entry *he);
+
 static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 {
 	u64 period = he->stat.period;
@@ -445,6 +447,9 @@ static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 	if (symbol_conf.cumulate_callchain)
 		period = he->stat_acc->period;
 
+	if (he->hists->merge_entries)
+		return hist_entry__get_percent_limit_merged(he);
+
 	return period * 100.0 / total_period;
 }
 
-- 
2.55.0.766.g2966f0265a-goog

