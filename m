Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212945;
	b=ihHO+j2lRqP+6elieMeNQci34oB1eOpjSSjEI2fcNvqb4xqKyqZZcYR8NocEtwZa8cQT
	 yica2fsaHelu/t5ScAFTTITHSrNo9/9v/tHKo6kyBZQd+RSyhhuy6kzyf3RkI3EYkB15J
	 nv7c+3fDO0ZfHDNhn18/JNTcAcsprKS2ZTHaTFmafU0w+qxOmPwcTpKiucNLiWyGJz0Tz
	 DHE1VogRFkODyI2xEQPhsIH6E3D+cmMtVPgDp846cCqi3IsjdUMIBG1rwfL/UXYSjBWsu
	 ha/7naWdLsRiauCFPmGREEuAv6wyB//ozhJwDAhV6H/zzcvKwjSPdaSF1r1Qcyocx6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WR4sp0IgBSLp48NAmbVB6Wvzuz5GP2e/9tmn2eNf8a8=;
	b=DBxb+PdUOkb5TqlfqlaIbMaNnN/PHE9Do3YJrGmv3XMiDT30irBPio84iGpPbfnzr+UK
	 72smH5QxwUuUlM8eWwhurUsmiwlI/VEPlys4yil8VAL9HtLSvtVn9z0uJUflq4ZLdll7N
	 eH+E8GPZQMbIzFvHL/Cz1sLss/iUjVHdMuJfV5vojvdb2eTTE2cx25wBcIsi08kqbU2hk
	 XO049oBZNmtUcFc+XAgSqZw8aycjId/oQPEgEeOhjYPmeZvaVSvZtGnCjf/a3dIreSYP4
	 U756DFCugfMHQ61ZF7wbi+DkhIhRmknfF2wcFz1xjpO6ZVDkfS4SS48VFnd/AtFwMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WROmI8t1;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA563606A69D
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA563606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WROmI8t1
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383ec96a7deso1546007eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212941; x=1795817741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WR4sp0IgBSLp48NAmbVB6Wvzuz5GP2e/9tmn2eNf8a8=;
        b=WROmI8t1ONeuTS4dThJBhirUwZP+ArYxlfWnYBTd4ONUCKxCThl9rhDiYN4A/c4sVa
         HTmujYhiWqsbWcEEYtNwaGvR1hc3QjNoC83ZuHRm24SgSHfuWm6hwv9fbNNrJrwOz+uH
         ZbNTSNwPuSDkI3RQMbc7Q1B6nKgT869fNMJXsWTJcmuu1nouSW+7tX8VxRH9mQtrJNbr
         pUnUWL4vEFGhiPKFo4HJIBJI7JH2OvMPxJailjblO0BJEKWZBh2yX4y4OOV3RILvtQg7
         aJcElNQVkux2KxcfKc7tG5pdxThO2YKXn7UotBqqv/0P/sxs0Wkxhb/NgPw5FaQnUDFl
         42Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212941; x=1795817741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WR4sp0IgBSLp48NAmbVB6Wvzuz5GP2e/9tmn2eNf8a8=;
        b=Rt/W/Q3kfwdwaMqJxO1+1ymX8x+Xj6aoF7epaGp5Pu7NUT5UxtrrwY77JqL7aDLWf5
         cqZbHom+rW4mgi9ZkBXQ4nm4yKbjrWD0HFmUkPouwuzMXC9hQjOXfiQTiRfFZTUeI5vy
         rF645HhznCm4qg7UnofuE0ubuiRjRnHeDkUXx88zKeAuwzuFB2EmsTf9QB9Gjb+rvrCB
         x556DEiN721jDEZWn+JYkBhb0MIHWyS9QPcb+aK5eNFdt0pmZ+atgVGut+h/FxatHUCQ
         C9ga6cNqMs4KyeP09nHquDRvnPI+9jF+MY7KCxURUaeo+cJQ+KybFFE2ZLfRn8Obqibz
         M6hg==
X-Gm-Message-State: APuU4Z8kAOxv9p6njsba/gx578c+EK0Y/RmXJ7PEntTLD9OIGxIH6vgp
	uODKWDDhxrMP1sgrnO/i5kOt+4+S/5MRYm6zVE5ovItnLQvGyh/0Ya08KpAwFR+pISL63O++u5W
	h+RA0CD2Fhw==
X-Received: from dyee6.prod.google.com ([2002:a05:693c:6286:b0:386:6850:930a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4201:b0:385:b8f4:755d
 with SMTP id 5a478bee46e88-385b8f47ad3mr3501940eec.20.1795212940199; Fri, 20
 Nov 2026 14:15:40 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:25 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-25-irogers@google.com>
Subject: [PATCH v3 24/30] perf stat: Share events between metrics and command
 line events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metrics added by -T, --smi-cost, --topdown and the Default metric
groups were parsed into a separate evlist and then added to the events
from the command line, so they didn't share events with them or, for
the Default metric groups, with each other.

Parse them directly into evsel_list so that the evsel matcher of
metricgroup__parse_groups() shares events counting the same thing. Only
mark the newly added events as skippable and keep the evsel indices in
list order after sorting the Default metric events, as required when
writing the group descriptions of a perf.data file. This removes the
copying of the metric events from the separate evlist with
metricgroup__copy_metric_events(), which crashed for "perf stat -T" on
an Alder Lake system.

For example, "perf stat -e duration_time -T" now uses the duration_time
event from the command line for the transaction metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 72 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f81192cec481..2b563382cf43 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1975,6 +1975,15 @@ static int default_evlist_evsel_cmp(void *priv __maybe_unused,
 		      evsel__name((struct evsel *)rhs_leader));
 }
 
+static bool evsel_in_array(const struct evsel *evsel, struct evsel * const *evsels, int nr)
+{
+	for (int i = 0; i < nr; i++) {
+		if (evsels[i] == evsel)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1984,18 +1993,31 @@ static int add_default_events(void)
 	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
 	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct parse_events_error err;
-	struct evlist *evlist = evlist__new();
+	/*
+	 * Add the metrics directly to evsel_list so that they share events
+	 * with the events and metrics already there.
+	 */
+	struct evlist *evlist = evsel_list;
+	int nr_orig_entries = evlist__nr_entries(evlist);
+	struct evsel **orig_evsels = NULL;
 	struct evsel *evsel;
-	int ret = 0;
+	int idx = 0, ret = 0;
 
-	if (!evlist)
-		return -ENOMEM;
+	/* Set attrs if no event is selected and !null_run: */
+	if (stat_config.null_run)
+		return 0;
 
 	parse_events_error__init(&err);
 
-	/* Set attrs if no event is selected and !null_run: */
-	if (stat_config.null_run)
-		goto out;
+	if (nr_orig_entries > 0) {
+		orig_evsels = calloc(nr_orig_entries, sizeof(*orig_evsels));
+		if (!orig_evsels) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		evlist__for_each_entry(evlist, evsel)
+			orig_evsels[idx++] = evsel;
+	}
 
 	if (transaction_run) {
 		/* Handle -T as -M transaction. Once platform specific metrics
@@ -2101,7 +2123,7 @@ static int add_default_events(void)
 	if (!stat_config.topdown_level)
 		stat_config.topdown_level = 1;
 
-	if (!evlist__nr_entries(evlist) && !evlist__nr_entries(evsel_list)) {
+	if (!evlist__nr_entries(evlist)) {
 		/*
 		 * Add Default metrics. To minimize multiplexing, don't request
 		 * threshold computation, but it will be computed if the events
@@ -2112,8 +2134,6 @@ static int add_default_events(void)
 		};
 
 		for (size_t i = 0; i < ARRAY_SIZE(default_metricgroup_names); i++) {
-			struct evlist *metric_evlist;
-
 			if (!metricgroup__has_metric_or_groups(pmus, pmu,
 							       default_metricgroup_names[i]))
 				continue;
@@ -2121,12 +2141,7 @@ static int add_default_events(void)
 			if ((int)i > detailed_run)
 				break;
 
-			metric_evlist = evlist__new();
-			if (!metric_evlist) {
-				ret = -ENOMEM;
-				break;
-			}
-			if (metricgroup__parse_groups(metric_evlist, pmu,
+			if (metricgroup__parse_groups(evlist, pmu,
 						      parse_events_option_args.cputype_filter,
 						      default_metricgroup_names[i],
 							/*metric_no_group=*/false,
@@ -2135,26 +2150,29 @@ static int add_default_events(void)
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
 							stat_config.hardware_aware_grouping) < 0) {
-				evlist__put(metric_evlist);
 				ret = -1;
 				break;
 			}
 
-			evlist__for_each_entry(metric_evlist, evsel)
+			/* evsel_list was empty so all the events are for the Default metrics. */
+			evlist__for_each_entry(evlist, evsel)
 				evsel->default_metricgroup = true;
-
-			evlist__splice_list_tail(evlist, &evlist__core(metric_evlist)->entries);
-			metricgroup__copy_metric_events(evlist, /*cgrp=*/NULL,
-							evlist__metric_events(evlist),
-							evlist__metric_events(metric_evlist));
-			evlist__put(metric_evlist);
 		}
 		list_sort(/*priv=*/NULL, &evlist__core(evlist)->entries, default_evlist_evsel_cmp);
+		/* Keep the indices in list order, as required by the perf.data header. */
+		idx = 0;
+		evlist__for_each_entry(evlist, evsel) {
+			evsel->core.idx = idx++;
+			evsel->tracking = !evsel->core.idx;
+		}
 
 	}
 out:
 	if (!ret) {
 		evlist__for_each_entry(evlist, evsel) {
+			/* Only events added here, not those from the command line. */
+			if (evsel_in_array(evsel, orig_evsels, nr_orig_entries))
+				continue;
 			/*
 			 * Make at least one event non-skippable so fatal errors are visible.
 			 * 'cycles' always used to be default and non-skippable, so use that.
@@ -2163,12 +2181,8 @@ static int add_default_events(void)
 				evsel->skippable = true;
 		}
 	}
+	free(orig_evsels);
 	parse_events_error__exit(&err);
-	evlist__splice_list_tail(evsel_list, &evlist__core(evlist)->entries);
-	metricgroup__copy_metric_events(evsel_list, /*cgrp=*/NULL,
-					evlist__metric_events(evsel_list),
-					evlist__metric_events(evlist));
-	evlist__put(evlist);
 	return ret;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

