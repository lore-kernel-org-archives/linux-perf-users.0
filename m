Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FA1C3C1C
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622139; cv=none; b=sPVpPkHdm1inkc1eyXlqTmfI+16CoB5CYTjbPMOlz6fzE25c89jdusmZsMftQfVtTgkdaNHXTqKlVCLTC7BMRMfhWgKDDU52h8E5UxRj5UIcEjg8Iz3GrXF+SybfSVDKSisk+f4OK8OtFWAMufFMwQLTPMCAX27hcNPhExhW30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622139; c=relaxed/simple;
	bh=Tw+OPDUbcdS5Wb0VzHvdipsLwROLEiEFRwpkKTXqmv0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=blcVdMK1y8Tz3Ye4SlSL+Y1mwM0LlcfO7fsIyIuyAMzeMUhwois8IPL/DixMncO2eIhHIWLgycJMMBHUu+uxk6U05mCqUeyxXKRrYg9WgiBj7//5JNmTatl0oAoKnuSbaRENm7EMdzGHPe0LejmBMb3dZkoRR2mj47DpYe947CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NauzXCHF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NauzXCHF"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e549e7072fbso5586831276.2
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622136; x=1737226936; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNUtMPcabX0SfTzfn2XD7m+YmDr5TEGI9WbsaWt8feE=;
        b=NauzXCHFOmF2ZD1A4djb4lLoIm6T4uULBODgF3h7grdv/Guk5Nb09/ZKFrkeNgysLK
         8Iws7cqQ2Np1isO+alq8zMtf3G8rhXJQqYOA7FQo5ceDMsXbZJVkWSjOTZjgdCMK0xXR
         RCADMygkI7N7oIzIXWwtQRJ64k0He5yG/XUXz3C3jvZ755F7OTMAHP2N0aB1mvwrQ8Wm
         dPDlLYmk9r2o9XFgp1XmF5qDNgPFr9oieYTq3OndEDfrWEoYfhpx4TESGbyYRqeZzQn7
         eiWTcgGiVN1cozUTEN+5X1UxLtHj9uMU0FV6W/LUQqcB2kXx1i8xWE30YnMH2nUhYA2d
         QdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622136; x=1737226936;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNUtMPcabX0SfTzfn2XD7m+YmDr5TEGI9WbsaWt8feE=;
        b=FfHhHEuGEFso3PgYF+0Cwfxo1OmSu39ibA49mmnD8WQuUN0nDCTGW+9INx7EyjrED4
         YZzxk/igiOLOJhiYoTaNeGhI94dOMFmc5z1slfOLojPaFngTe7vxXXafhKtchc2Z0A5s
         Joz16WtZ2jwcLlokjoq9xxCtsG71ppBuve+Dk/znd5rwIxRaz9yGHAB4Y6hSukwj7aF1
         LQj2ZyNs4mMfQx/3lqjzuTIiGuZK6doSQoEfBjIjtwu7uL/kNJjmBhDBxBvtnZNYE03P
         ipnmoKlGX+TNIHpJu3KUsWlZmn0ev7Qmpt8XQ+MsuB9hvL4K2F1qoX+b5QCvRN10Nlys
         whOw==
X-Forwarded-Encrypted: i=1; AJvYcCUFyeKZR1DDVjyiA6lPjtPlF8WeNxMMv9LboUdJnLXy7VaFavVxAYV2WdKu9VhW6aQUS4Tux3tyq7TRBO7SSHTf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uOI0KgrlHhnO2tkbgoOCJ7b74/vB1E8/9wkrXrk3RM94MRrX
	BEP/1o9JytCxpa0CuGOhlEu4PpNyHGhoNNyOvU7AT8R/Ka4LgdgbvonemQcbN8vM1O8F8et0wzD
	SOdqT2A==
X-Google-Smtp-Source: AGHT+IGO0QquJmOQ9elQq4a/k3BDlOsZwyHYuXQ6uUzgMWM3D1QUg1RIMnWjHR4PJ3GoWM7n/8DeCJguOvsp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:3f86:0:b0:e57:359f:dce1 with SMTP id
 3f1490d57ef6-e57359fdecdmr9018276.7.1736622135820; Sat, 11 Jan 2025 11:02:15
 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:40 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 07/10] perf trace: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6f5ae3ac0638..4b9a34c9179f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -219,6 +219,7 @@ struct trace {
 		struct ordered_events	data;
 		u64			last;
 	} oe;
+	const char		*uid_str;
 };
 
 static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
@@ -4233,8 +4234,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__add(evlist, pgfault_min);
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	trace->opts.ignore_missing_thread = trace->opts.target.pid;
 
 	if (trace->sched &&
 	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
@@ -5138,8 +5139,7 @@ int cmd_trace(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
-	OPT_STRING('u', "uid", &trace.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5473,11 +5473,17 @@ int cmd_trace(int argc, const char **argv)
 		goto out_close;
 	}
 
-	err = target__parse_uid(&trace.opts.target);
-	if (err) {
-		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
-		fprintf(trace.output, "%s", bf);
-		goto out_close;
+	if (trace.uid_str) {
+		uid_t uid = parse_uid(trace.uid_str);
+
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", trace.uid_str);
+			err = -EINVAL;
+			goto out_close;
+		}
+		err = parse_uid_filter(trace.evlist, uid);
+		if (err)
+			goto out_close;
 	}
 
 	if (!argc && target__none(&trace.opts.target))
-- 
2.47.1.613.gc27f4b7a9f-goog

