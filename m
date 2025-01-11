Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDE1BCA0A
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622133; cv=none; b=HdwGROUse+zklUKHZfhg8DeFQFQq9QENexEgEYhWnZKgt6Go4xD4yOmGf8s7KYNferKEm9gJHsOQwUwODlFUguLhUdorCgcgXnf/V1HGM1QElQKWRIzE9g6YJ/OeBfIZcFdqsp5QDNY9Jf5YLz/PzE6ymVcYAfIeC1c7itAZLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622133; c=relaxed/simple;
	bh=7mUywMOC/o1LdpAhwS9wTZ/OmD/h/FA4gdvLvHYWT48=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LmbgiemucnYU2F6DYBwvodjl7QYBuDAYBBTaPB2jmZ2PRJdg92PH3pq7mid+D/7rwMn02QfgSyMg+TfFk4/Cff717JP0K/t+H98P5BoQ4it/RJQ727qxdIsl+or09VIPPU1DoNkVCIROwvwHSZrrYhhX82dRzJRAE2XsmzMIbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zSwuKET; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zSwuKET"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3988f71863so7134514276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622131; x=1737226931; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecFMZiGNp7fan7UfoFlHQMnJEtz/mf35WDJXLyzqixg=;
        b=0zSwuKETjZ7kpq0FDvNnpVApJbL/DvZYXqyivLVcBxPl8gxbnJDm/2uO1JQB9765S2
         ZmC0kT1iZ6SIFW/qCVoelusGbU9+Vp7KBjH++DioVa7NwTQzv5la2vH0sHrwg3cYrlF9
         h9TupUWdjQ1pWNy4a9CTiK55ubrH/CZfaUzyBw4Vm0n1UZOt89Z440jqBurYJti3HXnn
         f+PCx0dauPEbRqY0QekAoVQAIBbsvWGE9n8CwPprSTLYBQ6b0LxoUuqPgpDxr5iDtHOJ
         iS+t4b3SIpfTGF/Fvs03EK1JKONDQIryk1quAlGt7KkJm6/11Vw4k7QwPl/On17Px38H
         Z32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622131; x=1737226931;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecFMZiGNp7fan7UfoFlHQMnJEtz/mf35WDJXLyzqixg=;
        b=JScpFC5+xVd7Bms6dxiuKabOWK+kOwgubLXhWuEz3QpS3/FVcZU/YR1TBdXnYmFXl2
         lSHB94jzvWLlLyw4qo1RX9snuCgrwsvtre8KgXmcuLvQi8tQs+DpAvpoFO04EMasTCbY
         NXDdJOxLFNsr7PnNmEIP/YstjGoH18i6uVOXolhLhApCgvF7oF4Frf0fAYLZxoiAK43W
         7tu5CL0NntIq0fbzFzLbYMTE/wV9XTt8qdrmn1Okavn2fW5jz05Ii/1CuNg3nFWijI9b
         icaF4lghXPbUGOAz2E1mEWxgI1Gm2PT9z29/DU/Y8HmhF9Jedmos5trlADOSmMH5fh8x
         /X+g==
X-Forwarded-Encrypted: i=1; AJvYcCUYFNN5KrrWD/XzY46P21r1ccEYXPGBBaSq0OXVwJWoX/QeIVEaNlP/UR9xuSSyflUWq3lnSpScLf1GRUs5ayVf@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHTdGsl8+kQ/9r5OPc7Bs/j3U1kCWoGR8lrl4dbaOy7n7zkOm
	F8UhpSXS9hBJ9oImHHBwYqaBYhu6QeI8/CN2qKuQLR5ezLoz9idUfF6VveiTzxswOT5m9ky48s3
	BdVaHJg==
X-Google-Smtp-Source: AGHT+IHwLynNopDYbrz7wn+p1xNk/yc5yHrokXgy+gopNUNkleZttkhC9a5oUoROnrPbbC6b23GEtpU52KLH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a05:690c:854:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6f53121d25bmr331107b3.1.1736622131129; Sat, 11 Jan 2025
 11:02:11 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:38 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 05/10] perf record: Switch user option to use BPF filter
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
 tools/perf/builtin-record.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5db1aedf48df..d0203f62faeb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -172,6 +172,7 @@ struct record {
 	bool			timestamp_boundary;
 	bool			off_cpu;
 	const char		*filter_action;
+	const char		*uid_str;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	unsigned long		output_max_size;	/* = 0: unlimited */
@@ -3451,8 +3452,7 @@ static struct option __record_options[] = {
 		     "or ranges of time to enable events e.g. '-D 10-20,30-40'",
 		     record__parse_event_enable_time),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
-	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &record.uid_str, "user", "user to profile"),
 
 	OPT_CALLBACK_NOOPT('b', "branch-any", &record.opts.branch_stack,
 		     "branch any", "sample any taken branches",
@@ -4171,19 +4171,21 @@ int cmd_record(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	err = target__parse_uid(&rec->opts.target);
-	if (err) {
-		int saved_errno = errno;
-
-		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__error("%s", errbuf);
+	if (rec->uid_str) {
+		uid_t uid = parse_uid(rec->uid_str);
 
-		err = -saved_errno;
-		goto out;
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", rec->uid_str);
+			err = -EINVAL;
+			goto out;
+		}
+		err = parse_uid_filter(rec->evlist, uid);
+		if (err)
+			goto out;
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	rec->opts.ignore_missing_thread = rec->opts.target.pid;
 
 	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
 
-- 
2.47.1.613.gc27f4b7a9f-goog

