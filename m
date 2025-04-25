Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13033232379
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617239; cv=none; b=GzGNH1YBaL69kv8fcALvpqKrFkwd1wSdcDwythi9Lt1EoBIxzPdXMHiFVjGf/Ymd0REK+xgGz6f7QC14LhR7lh+xioZuIZ9z+Phm9diycqPtwpFsw6wTLjCsfDehT9ofriyw+j4IEe3Mc41XjxQwZ/FCv0xIW4Xv6tx+N1PFVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617239; c=relaxed/simple;
	bh=Mowkv5qqJ/F5GpiVJf300uqyE570+zdeev7heuBS7dE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cyFIVfJrjHZel5g17BZfhdT0mSQLXIqkgKc4KZK7dUxlP4yMvrXYcZprS22fhLb4zHoiEgU2eWGSl2CKmOnoGSGlrkxznPLbJR6nLAiTNPBLQqIap++unwmP4VG82XdaZXlVUvvqR47UqgS/aYC+XL9pI7gau/wNlns7DclCzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0OtR/n/; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0OtR/n/"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c28e1b1cefso827933fac.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617236; x=1746222036; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCiBNIgyIq3tfdIckzwQPIYGTlpSc1MEqAHEJmYBsOU=;
        b=F0OtR/n/fQy9LRG4SVceUixQ2QlE6KkYITdo+2Pt7T6YykS5pU0Moo8Ahn1W953rHH
         qq7qQL5wP0Ade5NzXr9nqEG5JEkaP1KnIP277FFN7y5gOqmy59OFzAZAqd1MNcqqAmQQ
         YeFpUPWNcEiSnotllGFyOHZaaE+p+yDzjzxxauv/2TSkaAcwYeJap7oT3uhjdV1E80gH
         vLHjYK4JGUGbob3Lqj0M1GIICHKcw23LjQtMU1KIfbc/XgaqQ6xsbM6tEd/uQH9n8WDM
         C2lIBYTrFd5s5j9uDgBqz8KjvxsJEijmbSVfFiKa2aFEgkOCX4C4/dHBEaryP7SLqaT1
         Gwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617236; x=1746222036;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCiBNIgyIq3tfdIckzwQPIYGTlpSc1MEqAHEJmYBsOU=;
        b=ShRGCxB10UKnONuSpcEWQb8cxj3KcbzROCjdNu8IU3TbHuwtj4kvxkQ5Ue5iFfgN31
         RarvqvVPc/wGumb3PZHJMWZnQS34L7NXKeNpIPssayNnOitY/18jOiiVCVBBscWYc8gh
         Wh3HShXpMYTTJnsNahWiyRKWJglo62XRTI+J6uUx78cjHUJwWyRmdCU5xAE1zNFr5KX8
         3fXKiwLnqrYJZsU/zY64Ih7Ducw8/oqzObwNjbTLulP5e5qrCS115EAx7vmoEhdw9sU3
         gXO/GbZojtf5ISQQdXmuBimfrPu6L39Jur0G9dB6/9/bpuZqLuwhYGzxNRlBF3HELVc9
         4EXA==
X-Forwarded-Encrypted: i=1; AJvYcCUPCNrouYBxVDTD3X7l3FQw+PPFgxRSVWG04/cc24vuSrSOGGV5ao2pecVHKBGJoBH1aqH9+sac6XmaJ/e46aVL@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZa9cZdu2oq2iDU5jh/oJULNVn266RdCPEZsq6oNDyiK6F7Og
	j2UAdDVObVE6bxIctgxhTafD9Z8UC4cxB4Dj+9Uhg/iHctyc5knrrsa4ZWQQNGj4393Es57y2f3
	y8DhfUQ==
X-Google-Smtp-Source: AGHT+IEa2FLM10jcrrl+uJoBC09nP4IVEXI2lkCp+TFUaATjK6bauLtKrDXR6U2I/yDoVJ3h22f3O4wgOzrr
X-Received: from oabwc14.prod.google.com ([2002:a05:6871:a50e:b0:2bc:6267:d082])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:a1a7:b0:2d0:3078:e72f
 with SMTP id 586e51a60fabf-2d99dc404cdmr2537739fac.26.1745617236166; Fri, 25
 Apr 2025 14:40:36 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:05 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-8-irogers@google.com>
Subject: [PATCH v3 07/10] perf trace: Switch user option to use BPF filter
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

This change switches the perf trace --uid option to use the BPF filter
code to avoid the inherent race and existing failures. To ensure all
processes are considered by the filter, the change forces system-wide
mode.

Using BPF has permission issues in loading the BPF program not present
in scanning /proc. As the scanning approach would miss new programs
and fail due to the race, this is considered preferable. The change
also avoids opening a perf event per PID, which is less overhead in
the kernel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ac51925ea42..1f7d2b3d8b3d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -240,6 +240,7 @@ struct trace {
 		struct ordered_events	data;
 		u64			last;
 	} oe;
+	const char		*uid_str;
 };
 
 static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
@@ -4401,8 +4402,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__add(evlist, pgfault_min);
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	trace->opts.ignore_missing_thread = trace->opts.target.pid;
 
 	if (trace->sched &&
 	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
@@ -5420,8 +5421,7 @@ int cmd_trace(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
-	OPT_STRING('u', "uid", &trace.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5762,11 +5762,19 @@ int cmd_trace(int argc, const char **argv)
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
+
+		trace.opts.target.system_wide = true;
 	}
 
 	if (!argc && target__none(&trace.opts.target))
-- 
2.49.0.850.g28803427d3-goog

