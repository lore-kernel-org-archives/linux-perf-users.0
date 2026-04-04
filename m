Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B893537FB
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775282759; cv=none; b=jYNKOcBotyKZ7HXOGv9gGiXsmaa1NR2dvJXQMs3CiYpwt7VuYJ0K9H1SLhWApUnPwJpgxUxeympameZ2epEbH1Cb4wdkiXBrpSpbqqyipD7L9yBaTgYw2J2641IazsM6cDbby1NLYqLUBladTxUolSGy+7MgbhmbNddcSENhXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775282759; c=relaxed/simple;
	bh=kmXSmd/gwaoO5SjElYAn3EVfet98k9hAMaeX2WrIEg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gu6KrGzBPpvxBxNrD0xGoXq/YSpzBWrTIQ3dGX8eA7EAQsZHvM7K2HYtfFte5sBG5VKZVZcQis3e3MyHiF8NI4j+xnvy3hjPT27CIpfO3R2Ieimj39lCykrzICM4JUziRKtklYYLZpd4MQBs6Pkb1d/iPAa5JfAL2LV0utSNuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDJ2Mw84; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDJ2Mw84"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so4482934c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775282757; x=1775887557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmBxcmCr+2314ATKNVK327TwY//Umu/8RElIuAEXl1A=;
        b=NDJ2Mw84BQ2oNSKLsHSHtyL5XpCkze7tnE8rXtsN73LHuO2o6gsOcXmaHOkdmbEXRA
         bIs4q+7PvzWnckpPyUc5nasEpOhjVpRvQKOpLxjZKRXK9PFMuRaXKpgfuVCXWjTUWJX7
         tqFP0z5oxmD+8kekhjHAZldLHFOtqwK7XtiYV5YB5iUoVIoxXmlIoG33TXFoJPau8W9T
         20or5mIzc7KSaoMhQrHyYpFD6CsfENaq6T6VPU6q8XGmdERSlMpAmx0kwS9yzc8h8c6R
         jNyn61xNYQVjQxvL/ELGL3w3665FQ/F8EUdsfQRJnj3+v+p3t/wZjEXM2n4kqwsWEMwN
         vzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775282757; x=1775887557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmBxcmCr+2314ATKNVK327TwY//Umu/8RElIuAEXl1A=;
        b=OZSSMntu/B3YGcJUk5rNnN+T7Ieh0jlcN3f6PKTwDDlJTAkl0lOTqax3/pCX6D5eG8
         jfui+1w+kO7wXelnNxwRQ9BBhOLWZ3A3hJRl6SAnYyZOTFjC6B2Yrxe44TY5RhFj5h1C
         PSQVAj71qdDNafzj1Q4GxRg1/JaqJbV6Zb3SvMhQecvDvGVswyh+3kgNmpR69MtX+6NG
         ucuPKMW1c8EIt1nri+FaQfuo5dmQ95075dRzFsYEh24Aro3OvzbgXiIHZpEEWsXEAp2i
         1ceW4zf3jUqKffBZQBvLRlBYtq7ZnLpqVqV81fiOafUNUo58UB2MinltFIOYxnQ9ig7W
         wo7g==
X-Forwarded-Encrypted: i=1; AJvYcCWdq+jvho/MAmM2C4ZuP4pQO1N2UjiORYTHBZjGBGKq8B6eW+1GvXdehWBQMVyZNcCS2+gYQLgX+3hLo+WLKODc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6nZfY5qifh3w6JCiPnWgnGvlbr8dXQYq319VQGpwjXAwVmWX
	nJpDfQZOEHTFBLezVUQsiCvg69pM6oEvbVnTVgendDdfOt3OotQg0Wz3oFokXPtFrj3LWyHHjIR
	f0nVqc7ddfw==
X-Received: from dlai16.prod.google.com ([2002:a05:701b:2710:b0:12a:7a12:4f3f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:12b:ebb8:e518
 with SMTP id a92af1059eb24-12bfb779d53mr2312811c88.35.1775282756530; Fri, 03
 Apr 2026 23:05:56 -0700 (PDT)
Date: Fri,  3 Apr 2026 23:05:52 -0700
In-Reply-To: <CAP-5=fVbwwP6QBO+GrFoSVFxX1GM9rTJFqUwMVdsona_Gt6rug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVbwwP6QBO+GrFoSVFxX1GM9rTJFqUwMVdsona_Gt6rug@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404060552.1585709-1-irogers@google.com>
Subject: [PATCH v2] perf cgroup: Update metric leader in evlist__expand_cgroup
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	sun.jian.kdev@gmail.com
Content-Type: text/plain; charset="UTF-8"

When the evlist is expanded the metric leader wasn't being updated. As
the original evsel is deleted this creates a use-after-free in
stat-shadow's prepare_metric. This was detected running the "perf stat
--bpf-counters --for-each-cgroup test" with sanitizers.

The change itself puts the copied evsel into the priv field (known
unused because of evsel__clone use) and then in a second pass over the
list updates the copied values using the priv pointer.

Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v2: Take better care over evsel vs perf_evsel (Sun Jian)
---
 tools/perf/util/cgroup.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 040eb75f0804..1b5664d1481f 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -417,7 +417,6 @@ static bool has_pattern_string(const char *str)
 int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
-	struct evsel *pos, *evsel, *leader;
 	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
 	struct cgroup_name *cn;
@@ -452,6 +451,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 		goto out_err;
 
 	list_for_each_entry(cn, &cgroup_list, list) {
+		struct evsel *pos;
 		char *name;
 
 		if (!cn->used)
@@ -467,21 +467,37 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool open_cgro
 		if (cgrp == NULL)
 			continue;
 
-		leader = NULL;
+		/* copy the list and set to the new cgroup. */
 		evlist__for_each_entry(orig_list, pos) {
-			evsel = evsel__clone(/*dest=*/NULL, pos);
+			struct evsel *evsel = evsel__clone(/*dest=*/NULL, pos);
+
 			if (evsel == NULL)
 				goto out_err;
 
+			/* stash the copy during the copying. */
+			pos->priv = evsel;
 			cgroup__put(evsel->cgrp);
 			evsel->cgrp = cgroup__get(cgrp);
 
-			if (evsel__is_group_leader(pos))
-				leader = evsel;
-			evsel__set_leader(evsel, leader);
-
 			evlist__add(tmp_list, evsel);
 		}
+		/* update leader information using stashed pointer to copy. */
+		evlist__for_each_entry(orig_list, pos) {
+			struct evsel *evsel = pos->priv;
+
+			if (evsel__leader(pos))
+				evsel__set_leader(evsel, evsel__leader(pos)->priv);
+
+			if (pos->metric_leader)
+				evsel->metric_leader = pos->metric_leader->priv;
+
+			if (pos->first_wildcard_match)
+				evsel->first_wildcard_match = pos->first_wildcard_match->priv;
+		}
+		/* the stashed copy is no longer used. */
+		evlist__for_each_entry(orig_list, pos)
+			pos->priv = NULL;
+
 		/* cgroup__new() has a refcount, release it here */
 		cgroup__put(cgrp);
 		nr_cgroups++;
-- 
2.53.0.1213.gd9a14994de-goog

