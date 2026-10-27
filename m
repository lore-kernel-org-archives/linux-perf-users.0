Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120683;
	b=fPzVffRLitnSTNx6zglKhvU3stTUxl+gPC+Ub0/7q4E7498h8bUV4BMzaZdZlPw09gpz
	 9IemcGpv3InEryyrtOdHWlHV2cT8aYHuMUgXV0hw7R/xcuOJzcxfjv/CX5jVxUv/DAiBJ
	 76IPGvvFNj3/ZtoAfinwhGuZ+5RE/pKfiopGy3clxIDSgM9iyjwa+AminTQAfYHXQjVIy
	 W/4nqYfSQMlE/A6QRLoG8JZeeUxAJqnBmgEAwxhk1JLS3y5WQH+QWBqWD1h0Q8QM2lAbX
	 NYK83DP6wU0fzSiTHbdaGhsdIKYVQ1RcXRJcDqpzNm9A9rK1sik+kNfQi6hf5iRECJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=3KBQWnsf/QAcn311EnsJ8AzZkkASOn1et9YnIECaJBg=;
	b=GTMpqwkuc3p1zvQjJwSHgV/9579RhXi5n+utX3TXAd3gkIlwZ31WLnMDrP8vL5KlSOeH
	 cdD75WHlc7XdefrAh1TVDkJe1IzaAlwdARU9ytC1utR7HfDYI/x5sKUbaJauXBy2AcPdh
	 HYNUrUoc4LTrYKFFirHFL5feQpEsieQ0uqa5/eYg3JCQ/EK7/Gg5LouUCe4NIewcWvpGr
	 lozVlHmtYq42OmqtPDRUH+oN59kMkvLmoBwDqaakfkx57dbduWpxJdElQaeGBo7uAewWM
	 kOgoXWpPlnvPOdQqfI1FKmcB3S41TJ5HtkH4v63NsV3gRKS6AW3bM+Q5TESyymn8zxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehCOTbhj;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F02606A329
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25F02606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehCOTbhj
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36637676140so82287eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793120682; x=1793725482; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KBQWnsf/QAcn311EnsJ8AzZkkASOn1et9YnIECaJBg=;
        b=ehCOTbhj4Sw2tlJBNRACK95z73Z9vhbuPKVK4epcQswGGlGN4yVtsbUgVBvX0YlYbI
         dAnhi55x+4ATxqbzEKU+bzWOwMeNHizmZ4ay73l2Cns3JtCfKi7TXjqS2LlBbac8NHNl
         av2e4X3Z3647xyvEpXbGQrrfM0P1lW+w0QaMDXS9DhXm3A6gMbRCvppN+lbJJJWXQEp5
         zY8/ewc1JBJ8wKRLBjWn314RztAucc2foE4ZzV+2aq9oOZVTMG4G8Ejl9g9HCmrqhSj+
         oXI1ehwVl2kLWmQFYsjL1C7pyZUnAJebAz8J+gpM9AEmeN9WwEHrJetvkhJFC3CxXOov
         IeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120682; x=1793725482;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3KBQWnsf/QAcn311EnsJ8AzZkkASOn1et9YnIECaJBg=;
        b=cg5IuCmbLWbQL95/wdb8ZXUERFceohsz8VmJqccRvCnMEC92foVVkDTolvgpxjV5uT
         An7QO0iYVKWO0omOg+lNnjmhjtg8tCyRGIsv0RTSx77zKHYXSi5SlTNWe6m8LVNXhbOF
         RbgFDxsoSg+4vAxIMklkmfaZXPlFnpvYQOLj1PnQKLaj4j9N4T4i0uaQ9e7d7gKX08rj
         uI4hSWTqLYf19qwTygvlmPsG1HHUC/aIq2qzyBbGSs8mg39rJaopOVTRDUP7SWi12DWP
         mQIDLaPaDUxjAtFgLNt+66tyTFGKlr0nfFewdIGYY3s1Xjv73RT3sfibmJ1hf0Xol4cT
         ELUg==
X-Forwarded-Encrypted: i=1; AKwUvByfdOZGgVGrRuCJdxc02sm9dTobpRCOKzHpi2qe9ARKxdnJXImNe+JXD04TWJYQ65nw8SzEMx7WDQx+TuVb/Qwk@vger.kernel.org
X-Gm-Message-State: AFq9FYLM6lgoRFcAdeQBD+0kM0YLHTHWOdMZltIQxcUhcPwIn2jPjnNS
	PdXjIt8KrOtryFM6Wj8a745Onz5/qstc57yt5z1naVVCjXBIp7ICf5+1KyOktl7gnytz7Gz9Xkg
	9VxuB/omtHw==
X-Received: from dybnl11.prod.google.com ([2002:a05:7300:cf8b:b0:369:e1b:2d71])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ce05:b0:369:fe81:a575
 with SMTP id 5a478bee46e88-36a201638d4mr94794eec.35.1793120681790; Tue, 27
 Oct 2026 10:04:41 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:04:14 -0700
In-Reply-To: <20261027170415.2815859-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027170415.2815859-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027170415.2815859-3-irogers@google.com>
Subject: [PATCH v1 3/4] perf off-cpu: Fix cgroup_filter map sizing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

off_cpu_prepare() assumed that if evlist__first(evlist)->cgrp is set,
the number of cgroups is evlist__nr_entries(evlist) - 1 (excluding the
dummy bpf-output event). This can under-size cgroup_filter when
non-cgroup events precede cgroup events or when no dummy bpf-output
event is added.

Count the number of evsels in evlist that have a cgroup set and use that
count to size and populate cgroup_filter.

Fixes: 685439a7a037 ("perf record: Add cgroup support for off-cpu profiling")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 16948761cc45..71933a71c8d1 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -151,9 +151,10 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		    struct record_opts *opts)
 {
 	int err, fd, i;
-	int ncpus = 1, ntasks = 1, ncgrps = 1;
+	int ncpus = 1, ntasks = 1, ncgrps = 0;
 	struct strlist *pid_slist = NULL;
 	struct str_node *pos;
+	struct evsel *evsel;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
@@ -208,8 +209,12 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		skel->rodata->uses_tgid = 1;
 	}
 
-	if (evlist__first(evlist)->cgrp) {
-		ncgrps = evlist__nr_entries(evlist) - 1; /* excluding a dummy */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->cgrp)
+			ncgrps++;
+	}
+
+	if (ncgrps > 0) {
 		bpf_map__set_max_entries(skel->maps.cgroup_filter, ncgrps);
 
 		if (!cgroup_is_v2("perf_event"))
@@ -274,8 +279,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
-	if (evlist__first(evlist)->cgrp) {
-		struct evsel *evsel;
+	if (ncgrps > 0) {
 		u8 val = 1;
 
 		fd = bpf_map__fd(skel->maps.cgroup_filter);
-- 
2.56.0.313.g2479322e68-goog

