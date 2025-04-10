Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF9293454
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306625; cv=none; b=Scq6mrVXd3ndE+k5+buvstvQrNTMSfnhBIf4ufG/wEyOJlt6E2G0DdnsnSANLULSftJOUlyPqXCYm3qrzBuUileYcG1Hys7CYWUckQZDMIVDnxL8EjxL8oeeX80UrWFbkf99rKkUKYEhVsUk1WZ4O8bDBltr2OvQVj06u2PTBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306625; c=relaxed/simple;
	bh=OqTPFhQNMqA0kroRrrIFZ7VNgDyIrdQDv7/85+I3Vh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cEXXUlOI52q/gtp480SBNouGiA6+oLw5pTBIMzq3i2xXsbxdZQhufegmulshohjIqj0+5nnnxSNFsZlKE9uqItqPyjbGfJLChRBKloycmHDwUlKh1slu5b+ekf8ZCCNhKTTfwPXzou+KmWib3LvDHhyyheq22Jmy4w1WPEDvPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjzC/Au8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjzC/Au8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-306e5d9c9a6so1898236a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306623; x=1744911423; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQvK5ga6mbdGcs60cOEjaVt2CnhMO3nnFtvXgnIjviw=;
        b=KjzC/Au8vXIxBFBfTXNzYvpfxfOJ42hstGXxbLbN1yEeSKk3cbTZKP4bNgzWCO8Ois
         ZVVsk/742/NWKsnKTeyuSSbcUGSMmolp+rRhUEWhLKW80rsvaPkx9UlhFrBWDJqep5pl
         +3MvNKF/JTzQIvQPz1CA+cS7iPnrEpnmLuAh+/bi7wJ5n+xl0LtTfkxMEGObEkkPaLci
         0Qmv/U5V203AHa9I+szW5n0ndeSigAO8OqAtUUtQDO9hSO05eGwwC6PCKRTZ/V9Q7eCI
         KMEKudWTVOtOyzUsdi0QtDIe+6PfrRH8VOZnh96arIIYIlh+wvXU9hTC/8Vs8Tkr8yds
         2Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306623; x=1744911423;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQvK5ga6mbdGcs60cOEjaVt2CnhMO3nnFtvXgnIjviw=;
        b=jN4jEjkWivY0GUPZr1F+NKRTUeDcYrKGA5aiFO+IA3yDy1RokdjUu7JL+aHIIwAa1Q
         ulYQbDHaMqz7MmYoCdsM8MK4J5BRLDuaa2kn1mt9k5C4HOpJza+9tzarNTq6OfPlynrq
         c9JAu5FBeywiMBJqrr17mQ35oAqEQ0PaP7NanFsils7EhKULoYWdcKomwBaKtUdiSGK5
         sXFwcs+N204hled/ryw0HRHJLywAaVumZWHZLd4lQGNGqWCAalHiJ33vPdReARb5xOfu
         FqvDmG3FvjiygOhPEUC8a1TFOpQcJstyUf6WMfiVWi4NcXtI/iYZZkBh9B4wdQ4qPbWo
         Aoyg==
X-Forwarded-Encrypted: i=1; AJvYcCVHKESp3iSAtGNdhtihKU4EXvgUcA/FLj2mmZqiuy6zYtRma1d9kECHHq7mKAQiyfKGHUedrd+nncpTOxV3iVs0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5VYNsb8wZrTU3tMUDmVZnBPaD0793TRK1SjK4/QDvFa2v/YlU
	9Qbupj0W9TrJi4/aCfO9X859A21Y9HBcQnrJTEjsxZUz9il5Narc0jv7Ae7AV0LCTdtCWNMlK8R
	AGJ0vzQ==
X-Google-Smtp-Source: AGHT+IELrMq7P3XO/BVtHJWWdlGWFYztHi/XhtOisl5L5h9RCt8GE54ixzv6LneO4zsw6KvJO4vaiirkoA6p
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:2fa:284f:adb2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c6:b0:2ee:7411:ca99
 with SMTP id 98e67ed59e1d1-30718b64bb2mr5111942a91.1.1744306623335; Thu, 10
 Apr 2025 10:37:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:29 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-11-irogers@google.com>
Subject: [PATCH v2 10/12] perf bench evlist-open-close: Switch user option to
 use BPF filter
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

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/evlist-open-close.c | 36 ++++++++++++++++------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 79cedcf94a39..bfaf50e4e519 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -57,7 +57,7 @@ static int evlist__count_evsel_fds(struct evlist *evlist)
 	return cnt;
 }
 
-static struct evlist *bench__create_evlist(char *evstr)
+static struct evlist *bench__create_evlist(char *evstr, const char *uid_str)
 {
 	struct parse_events_error err;
 	struct evlist *evlist = evlist__new();
@@ -78,6 +78,18 @@ static struct evlist *bench__create_evlist(char *evstr)
 		goto out_delete_evlist;
 	}
 	parse_events_error__exit(&err);
+	if (uid_str) {
+		uid_t uid = parse_uid(uid_str);
+
+		if (uid == UINT_MAX) {
+			pr_err("Invalid User: %s", uid_str);
+			ret = -EINVAL;
+			goto out_delete_evlist;
+		}
+		ret = parse_uid_filter(evlist, uid);
+		if (ret)
+			goto out_delete_evlist;
+	}
 	ret = evlist__create_maps(evlist, &opts.target);
 	if (ret < 0) {
 		pr_err("Not enough memory to create thread/cpu maps\n");
@@ -117,10 +129,10 @@ static int bench__do_evlist_open_close(struct evlist *evlist)
 	return 0;
 }
 
-static int bench_evlist_open_close__run(char *evstr)
+static int bench_evlist_open_close__run(char *evstr, const char *uid_str)
 {
 	// used to print statistics only
-	struct evlist *evlist = bench__create_evlist(evstr);
+	struct evlist *evlist = bench__create_evlist(evstr, uid_str);
 	double time_average, time_stddev;
 	struct timeval start, end, diff;
 	struct stats time_stats;
@@ -142,7 +154,7 @@ static int bench_evlist_open_close__run(char *evstr)
 
 	for (i = 0; i < iterations; i++) {
 		pr_debug("Started iteration %d\n", i);
-		evlist = bench__create_evlist(evstr);
+		evlist = bench__create_evlist(evstr, uid_str);
 		if (!evlist)
 			return -ENOMEM;
 
@@ -206,6 +218,7 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 
 int bench_evlist_open_close(int argc, const char **argv)
 {
+	const char *uid_str = NULL;
 	const struct option options[] = {
 		OPT_STRING('e', "event", &event_string, "event",
 			   "event selector. use 'perf list' to list available events"),
@@ -221,7 +234,7 @@ int bench_evlist_open_close(int argc, const char **argv)
 			   "record events on existing process id"),
 		OPT_STRING('t', "tid", &opts.target.tid, "tid",
 			   "record events on existing thread id"),
-		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
+		OPT_STRING('u', "uid", &uid_str, "user", "user to profile"),
 		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
 		OPT_END()
 	};
@@ -245,15 +258,8 @@ int bench_evlist_open_close(int argc, const char **argv)
 		goto out;
 	}
 
-	err = target__parse_uid(&opts.target);
-	if (err) {
-		target__strerror(&opts.target, err, errbuf, sizeof(errbuf));
-		pr_err("%s", errbuf);
-		goto out;
-	}
-
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	opts.ignore_missing_thread = opts.target.uid != UINT_MAX || opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	opts.ignore_missing_thread = opts.target.pid;
 
 	evstr = bench__repeat_event_string(event_string, nr_events);
 	if (!evstr) {
@@ -261,7 +267,7 @@ int bench_evlist_open_close(int argc, const char **argv)
 		goto out;
 	}
 
-	err = bench_evlist_open_close__run(evstr);
+	err = bench_evlist_open_close__run(evstr, uid_str);
 
 	free(evstr);
 out:
-- 
2.49.0.604.gff1f9ca942-goog

