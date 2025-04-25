Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC122D7BD
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617236; cv=none; b=nNlnWtjZtVCrMFhd1iff36Xw+A6FPlQy2gS/QmVQ6QmrWRKqswcX6iA7mTIb7lnlkivLr4hqYkcQjruNpts2CulKyoevzSFeR5H671C6qq4ndQGS/NuN+LNog/MQV+WA/Hk4pRZMfJTi61T6MHVKpokjGpysoOXIirmJVTW0WAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617236; c=relaxed/simple;
	bh=ETJXpOiPkRJYGh3SfFCaOywsWvWJiPbgmQnbhQPzOXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pjOiiG6f0MjF3hvFd467vOzryAxApL4K/e2b+1NJqhEulFA2C+93Tdr+iYOA+CQ42CTeNEgnKrd2IsLg6onMfDRxrhyMBrFAFrBFGOPUWTbTcNJktgjMIl8JauJNrHXBhkkEN1V4NpgXj2zhY2EaFR2xuDNuzMlZtEVeGm8zaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WE7baxZT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WE7baxZT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-309c6e43a9aso4148005a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617234; x=1746222034; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02ryzVedAARQkanLp1HnvhE2SOHEE70YtQbGJrfmJUM=;
        b=WE7baxZTqyvbJAZz3VOLQn2aR1na+0LhrcrlATLpOLnQ8F76YsBEpW4VO6vyhTfe6C
         XSEZa3tqDFOILyJCzc2izyEUg0sWe1iC6l0RTNyeTZW34L4xlWxp8fnP50HJc2oWV7So
         n+BoC+ZyllxcJfJERJasyaKuE/mE3bqYpes48nkbb05oYij9BX+QpODrnkdx79DPASPJ
         ++z8M73b1HavKHTh0JLfs/sJ3XIlo6v3b1Uh1rVe3lycvywx//xjvM/CbzVIwLo0Bv0j
         4d/bWHzOJeU/qJQkwsR0AxtjhGFgkt9Smhnrc+mvYGmkHu2ctmuMN+53VQ0peg8ANepx
         z33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617234; x=1746222034;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02ryzVedAARQkanLp1HnvhE2SOHEE70YtQbGJrfmJUM=;
        b=Qs09igKDonP+RXtM+0Su0fxa/7pCOJzmQWBMaSv0jCBuuru4sfNFRv25pH0goQRfBi
         1wfjQ7UfKNx5kFDTiPAxiEQ+KQHZ3Yd8cj+LDI3ut1OEXd9FwJpkyoObydaFOgGlnHPI
         8iP8ynMdqwJE2Kex2Q3TlzO/mLeBqfQfSeQJUSAEIRie54UYuO8Gf73e58C2nOWl0rIH
         wKnzw3ZU4zYa6Dkg2/tdS7nPjTiXntaiFIQGsImPeaaG3CAHbMmgKSroL0LzkU5TMTx7
         ZR1hgDAz8qGs1Q4UN4b8Acx+2N7yXFYELI0H3PTpiYIEvQzhQqwVcw0KbWdJlgHBNd3M
         kL4w==
X-Forwarded-Encrypted: i=1; AJvYcCWmMkDzwMDHhM/d+cs2E1hiKDTntLAqEfSn9sWlx5pGqMlY7OVcTU8hshKXlCK00gCWyyvJepyfU8Mi1KkvWPlR@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcvo4m9gdXdZ9pdxc6ABpRcfTD150WeDca20JYLt+pk/x9tFu
	ufizESJF2a/vqy1RpKwm2KkRatGfevV3C3hPS4gdyi05q+FubsVrIM2HcST7AIfpYm39NN2XDF8
	/7xkZZg==
X-Google-Smtp-Source: AGHT+IG19NnGKnApBu0HJSqww+Jf8NFjSpR0Yz/CRa2oNnzjitLT7j5APZLNXxEqls7FaDaLDMo4jCQ28ogZ
X-Received: from pjur4.prod.google.com ([2002:a17:90a:d404:b0:301:2679:9d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70b:b0:2f8:49ad:4079
 with SMTP id 98e67ed59e1d1-30a012fe1b5mr1565373a91.6.1745617234021; Fri, 25
 Apr 2025 14:40:34 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:04 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-7-irogers@google.com>
Subject: [PATCH v3 06/10] perf top: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing --uid option finds user processes by scanning
/proc. Scanning /proc is inherently racy due to processes being in
/proc but then exiting before perf does the perf_event_open. When the
perf_event_open fails perf will terminate reporting errors which is a
disappointing user experience. Scanning /proc when perf starts also
cannot inform perf of new user processes starting.

The ability to filter perf events with BPF isn't new, and has been in
the perf tool for 10 years:
https://lore.kernel.org/all/1444826502-49291-8-git-send-email-wangnan0@huawei.com/
An ability to do filtering on the command line with a BPF program
that's part of perf was added 2 years ago:
https://lore.kernel.org/all/20230314234237.3008956-1-namhyung@kernel.org/
This was then extended to support uids as a way of filtering:
https://lore.kernel.org/all/20240524205227.244375-1-irogers@google.com/

This change switches the perf top --uid option to use the BPF filter
code to avoid the inherent race and existing failures.

Using BPF has permission issues in loading the BPF program not present
in scanning /proc. As the scanning approach would miss new programs
and fail due to the race, this is considered preferable. The change
also avoids opening a perf event per PID, which is less overhead in
the kernel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 22 ++++++++++++----------
 tools/perf/util/top.c    |  4 ++--
 tools/perf/util/top.h    |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f9f31391bddb..8890bec9b63c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -642,7 +642,7 @@ static void *display_thread_tui(void *arg)
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		hists->uid_filter_str = top->record_opts.target.uid_str;
+		hists->uid_filter_str = top->uid_str;
 	}
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
@@ -1566,7 +1566,7 @@ int cmd_top(int argc, const char **argv)
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
+	OPT_STRING('u', "uid", &top.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1757,15 +1757,17 @@ int cmd_top(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	status = target__parse_uid(target);
-	if (status) {
-		int saved_errno = errno;
-
-		target__strerror(target, status, errbuf, BUFSIZ);
-		ui__error("%s\n", errbuf);
+	if (top.uid_str) {
+		uid_t uid = parse_uid(top.uid_str);
 
-		status = -saved_errno;
-		goto out_delete_evlist;
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", top.uid_str);
+			status = -EINVAL;
+			goto out_delete_evlist;
+		}
+		status = parse_uid_filter(top.evlist, uid);
+		if (status)
+			goto out_delete_evlist;
 	}
 
 	if (target__none(target))
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 4db3d1bd686c..b06e10a116bb 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -88,9 +88,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else if (target->tid)
 		ret += SNPRINTF(bf + ret, size - ret, " (target_tid: %s",
 				target->tid);
-	else if (target->uid_str != NULL)
+	else if (top->uid_str != NULL)
 		ret += SNPRINTF(bf + ret, size - ret, " (uid: %s",
-				target->uid_str);
+				top->uid_str);
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..04ff926846be 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -48,6 +48,7 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+	const char	   *uid_str;
 
 	struct {
 		struct ordered_events	*in;
-- 
2.49.0.850.g28803427d3-goog

