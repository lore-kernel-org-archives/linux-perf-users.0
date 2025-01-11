Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB091BD9C1
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622135; cv=none; b=U4AIPWGe4utkWLecigJCoP5aHyYpK7dWGgEItnH7pGab3/NoRHHBYGYypGvg29a8tBZPxWKX49v9TQLLaUg44j+iW2Kpy+SKQYP/YeSMIizct++b2zFkKSHj1W3z86GGxN5Q28s4ipXngiNcpu49mrrDGWYvu4Q5Jj0iRYUuGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622135; c=relaxed/simple;
	bh=34yhx+tyZYMBexY/N510FoV9b7eWcWrTsAiR5+Nfbs0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gokBex0VIaLfKyAwKXsuINpiREt8R+pGZqRhTiCq8/yZOf01BaYPER+ysZBc6dfGgX/jV+e0LqNUtkMNgkoZy+1xflY5vJ4C1gOUdOn7y0lkgrZWJwpSHFg1uieCh71ZCmzCttT2djLPg2C1W2zaM0tyUcfhFPzUGwfp+RZrhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqSkKbsx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqSkKbsx"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e573c46fd5dso1164318276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622133; x=1737226933; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdHYhFrNVIqtHmEvS3ztNPxYRt3R+LiiQaFr8xJHZro=;
        b=yqSkKbsxu0h9A3r1VhV0joQchYifYTiRgcbCBra2A55A1OvvLVYemBC4uWq0HIWugc
         7Vr7fi3ABg8hH1gQrd4+UxfHJRcFtH9mlegp2czbLQEd8SOQXLhmx15K+ent2G35F9Oh
         /y/FZpIVTnqvPD0pNF2o2CFMO63EDUz9zWSowXAoumaU2C0T6785lsriKyET3hwgpr7E
         2wR+T9YruBHERLnXukR8hlZPrwZjAvTuzaXFT1WHxvgo5XLk4KJvqD18DD9mAs05cUm2
         hsYq6UXADT2tZsyg4Ud/uIeGklRZZeXe29QZ2BpLUqcyIcOYh5Pw9zwBjNgsNBAPl8pg
         M/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622133; x=1737226933;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdHYhFrNVIqtHmEvS3ztNPxYRt3R+LiiQaFr8xJHZro=;
        b=Om7W1pUkQdQdFv3QVPyJEWJJcD9/HLvm6x2r7Pz0EeZs01Ch1yO4mhRrHxyYBNTvCI
         bNqFnBfRKJfTr9RKYnCOmyQDQegDG5d+6yoWQfdEAB8zqV9+fjZFrnmkq32XooMP96nb
         BQgae9UEkmRZ9yqQ/bl2ut9/eyfXI11kqMLMv6XrQG4Sff9ieUS4oeyNPCj73R3It7LZ
         pVDqJcIvNeXj8dq5qCVUm9pVfNWpp7RxA67/wdOd9j+Co1FkE1CheUUyeDsjtSCtgDX5
         QsRHuhFf3GrlzU7KfYGlsWbG01b01KUpJekyzWqvxUmq+Lci3nR5IKVDTWcVP+WxFKSM
         G0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVXJsPSNd5lI93RKxYiRGEU27KL0fvDEe0aV/XMyGmYJt0Nk2wWv2xhHruw1yBk3DLVSQJW6p+rU5VKKgaRPcib@vger.kernel.org
X-Gm-Message-State: AOJu0YziRtGk8bFlK5WKsIOweirsRytuVv3wX8hJfp2hEqyZO4nA1DcZ
	pU9FFxDlMJBoL4DL4k1t/e1wLU1u0XPInO0oxxMeJb8gJWCWTVffhogVEFamJ8TTlRE2pkZ9qfb
	4RwVtUg==
X-Google-Smtp-Source: AGHT+IF3VZBxbyLkBSTyR6IZ3Tvw8GSMA1nzChpsrnODeXVR+Pnt/DsFjkoy8YYj6hZoJ/mHcLfzRgpl36Od
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:a442:0:b0:e39:aa0b:bee7 with SMTP id
 3f1490d57ef6-e5507353f8emr22575276.4.1736622133248; Sat, 11 Jan 2025 11:02:13
 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:39 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 06/10] perf top: Switch user option to use BPF filter
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
 tools/perf/builtin-top.c | 22 ++++++++++++----------
 tools/perf/util/top.c    |  4 ++--
 tools/perf/util/top.h    |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ca3e8eca6610..f6d837be185b 100644
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
@@ -1562,7 +1562,7 @@ int cmd_top(int argc, const char **argv)
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
+	OPT_STRING('u', "uid", &top.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1753,15 +1753,17 @@ int cmd_top(int argc, const char **argv)
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
2.47.1.613.gc27f4b7a9f-goog

