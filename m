Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43C4E1CA
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682666; cv=none; b=cgyJQ5bM2Jk+xGN1f5uXYjc0GHKvZMlV5OJXY0M1y5ArXztX0IpWAiAOyzegGjP5X01Y/jZ1VJUx2rdXS921Q/COKIB94eZmEKTSrF0cXdq8p2eGlXFTVmDL21y9q5teYNPpRofn1F4AE3wJTmEpXKCPynHubptafAdgEVNEkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682666; c=relaxed/simple;
	bh=ukGaeKDWoBnc0AIrKBff3Y2VDwj+LfqCpXcFKMzADh0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mZn2gzZ4lVBTsqZ9Y604z11BQZPVsvd5qhCv4dHza/9Si2RCp036Q5j4Ozaby66SfJ8deiOtfezeiUo3S9Uebqbg3DLziCE+OELzMQ4uftqV9AeLM083lfSCJ+sAJHX+hCtNeGOPwUZvh+LK2rPFp///cu3HcAQLVElhPswWJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+cNMApf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+cNMApf"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso1116146276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 22:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706682663; x=1707287463; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1xH5pJjJI+heTB8iMmEvxa0X+0fNgErrr9gRIyth2g=;
        b=z+cNMApfdnCiyR2tpp+pXabq1/2OzeBTR65q/VwEAJztm54xYjWQHxqxraGkSQM28l
         b4NS1swQgiZkmLJKpEJGdDWE1q/2/zJ4Q1XLLF8Y08JPM3JO8AXgpwmcR+DMdwBvHL5C
         VkPEdvUD4sXHO2JYAwhqTwEBdDppZK28KRmGaat73fUa8HHHvk44I/v2hk+1AkdV91bg
         Lm3Bvhg2B3o4BQVSkvTpI8bxXXTSRGm8yXzQ6DSmjst6NJ9DP+M5yEwXyroRD9rnOHSE
         FYS5TiztIV+elSKP3Qije8UtHth6BqV/VoFV6zPbv48Xx0cccBtco3LtIco5JmLQtkAh
         nshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706682663; x=1707287463;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1xH5pJjJI+heTB8iMmEvxa0X+0fNgErrr9gRIyth2g=;
        b=DLkAH54hotMg0A1e+ChUsSfceMI74meBYJrLS6MaQq7lehKTt6MkidrqixkV+vofH8
         piNm0bXaMxXQsoXqvgfG6J8gDJqCI5AhRZ2Z5EMZYuF9CN4kgMS76vzo0elB7fjsXVXg
         SNJuBjpeVt6ybgPjATCxkcaW5by59YN/EGAdc8gkOjB+ZlL4aKSc7GHFheZ561NQnCFe
         b/9iEY6fyxhJOFjL3qjgQ7FoyLQ8HLn+crxMxdAjySr0PmoVWGs6R6tROQDf5NIsHqfn
         dGVJBU4fFgjY6NAUDKdtrLEXTp7Ohb6tNtrM2OWgZGPcpYiAVgdTWExDWf2TwdOviYvM
         SDlA==
X-Gm-Message-State: AOJu0Yxu6oZH21ATVPqwFeGxA74fE1i1L4EO4rbbOnhwqqEZJnnzoMrM
	/TvGCaBX07wBV4JtdFZrW83l82wjsGcNh2IZNQOq8imXs7CHgJ1QrEfPy3LkbH98yR9VxmWngoW
	4ydKClg==
X-Google-Smtp-Source: AGHT+IGEAP5D5vAqHrvlnv6Eelf1+7FuoCNqHzUR7cXudPK8BmAeyVeZmn/bgM7Au0VD8i5lkH4LxN/578hy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d0ab:43c6:7969:62ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:1188:b0:dbe:d0a9:2be8 with SMTP
 id m8-20020a056902118800b00dbed0a92be8mr36777ybu.0.1706682663552; Tue, 30 Jan
 2024 22:31:03 -0800 (PST)
Date: Tue, 30 Jan 2024 22:30:47 -0800
In-Reply-To: <20240131063048.492010-1-irogers@google.com>
Message-Id: <20240131063048.492010-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131063048.492010-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 2/2] perf parse-events: Improve error location of terms
 cloned from an event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

A PMU event/alias will have a set of format terms that replace it when
an event is parsed. The location of the terms is their position when
parsed for the event/alias either from sysfs or json. This location is
of little use when an event fails to parse as the error will be given
in terms of the location in the string of events parsed not the json
or sysfs string. Fix this by making the cloned terms location that of
the event/alias.

If a cloned term from an event/alias is invalid the bad format is hard
to determine from the error string. Add the name of the bad format
into the error string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
These fixes were inspired by the poor error output in:
https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
---
 tools/perf/util/pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 355f813f960d..437386dedd5c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -657,7 +657,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	return 0;
 }
 
-static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
+static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
 {
 	struct parse_events_term *term, *cloned;
 	struct parse_events_terms clone_terms;
@@ -675,6 +675,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 		 * which we don't want for implicit terms in aliases.
 		 */
 		cloned->weak = true;
+		cloned->err_term = cloned->err_val = err_loc;
 		list_add_tail(&cloned->list, &clone_terms.terms);
 	}
 	list_splice_init(&clone_terms.terms, terms);
@@ -1363,8 +1364,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 
 			parse_events_error__handle(err, term->err_val,
 				asprintf(&err_str,
-				    "value too big for format, maximum is %llu",
-				    (unsigned long long)max_val) < 0
+				    "value too big for format (%s), maximum is %llu",
+				    format->name, (unsigned long long)max_val) < 0
 				    ? strdup("value too big for format")
 				    : err_str,
 				    NULL);
@@ -1518,7 +1519,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		alias = pmu_find_alias(pmu, term);
 		if (!alias)
 			continue;
-		ret = pmu_alias_terms(alias, &term->list);
+		ret = pmu_alias_terms(alias, term->err_term, &term->list);
 		if (ret) {
 			parse_events_error__handle(err, term->err_term,
 						strdup("Failure to duplicate terms"),
-- 
2.43.0.429.g432eaa2c6b-goog

