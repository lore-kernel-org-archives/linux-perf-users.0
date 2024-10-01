Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18931BBBC6
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760218; cv=none; b=nGVuz0xdiwyAZKpIMXR5bq3JH0mPk48cqsF3OvVXXC3Wp7pDdlnFvsvWvF1cuBsRTpMlSp1slI/9RZvviQE39jGQ7rz/LFfcZxx5mozU+3Yjt2HzsGUtltPI9As4qloK+LB2yuCTycdEsARDwTyo4Fc9wzngMpppMTQdp+p8qMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760218; c=relaxed/simple;
	bh=ZUl/ydmmbgHj875SzIndORvnGh+y4tgIfETJAN0I7XI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Lc1yUylsl7dvRDH32LxXALZHKEgIeZrzs+anc/MtlhX73xuPfXPfHBK/9uTM0DRT/tP0IzwzCdctUKHAgHfwahvOqL+LJcUciHjyYCi3p6SH09f4jfx/mgfQp5qGEHjvsFTqhl2Kjp7fVuPxnv36YIDAmnsuJkxXkq3qXo6RK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulbduHJ/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulbduHJ/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e251ba2243so45336187b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760215; x=1728365015; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDg21Rij+IIeZQVgaa8iBgfJqI0jYu+y1eH5S/MzuI4=;
        b=ulbduHJ/YD3gYenUUioMqMmR4cekFVaQV1Uf6FCxQkke5xPWADyWfI4ut6MpciTb5f
         EU8SFCfqGFPL6FE2YW+D7OPtw8UL4+cNloNkffZdnS659RE78dCLukcZswSYuDEVkr5I
         5BEXO26RPUu+2KcqRpmJ7NicQS7f/udwCbggW/hNK+0SR3x4MHXgiIrmv2WXyYbWsQsy
         GhQcA+QoTF40Il9GduV29QReZ6MeKKUw68miDByEVo64szcw+AXyZ99l5C0EfyZsB3oP
         aHsB0TgDz0wX0vUtH/1XjPQjIaCwhG7uZHeYSo/ito7AjOHcFXqQAX86X62KuMC/EZss
         oS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760215; x=1728365015;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDg21Rij+IIeZQVgaa8iBgfJqI0jYu+y1eH5S/MzuI4=;
        b=mVzyFYHaveWLb9xRyYQYd/c8DMzSDSHMhvyglmZ+2zb6KmsCJ/WhBkCp7Q+9OJJRKB
         oSGU0z4LoyvO3EaEDaR66tIkmAFvdUsUf5ibLAlRLDi9kqn9sZhyfCRzvaw3PsAgvMR3
         Wy4pd0zmL6lS+3X6sixLXek7L3/R3Q6qbkUtYGitWK2jlfr8LLLJmxcsoxyS1INX2BCm
         1dau8eoJbbLppScOwETT0aMdFA6uwuWE/Oq9ANyo608JAUgxpJrL6PxpnFnpEdIKJqyM
         X2uj0VR6csVcxJ++woMXfY33FwVhFhn2MdOXhEjdD1sBI2VuMau0WHWpqpB3xb/UcI5i
         QByw==
X-Forwarded-Encrypted: i=1; AJvYcCWqvWLebG0b08+OY4TegdjPt7UFvVER+RpWPV3DtzBoFXqwMlWQbO39U2ITzGknpcCZ7PjHr/XitPMZOlQRP9rw@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPVuOUFBMzPG2/5x67hIw/ktPJq6DhL9IyJhzITDLI5Lln08V
	5UQvxd6xRC74HPZV2Ex0vBd/jzNknuv6DBqLWWxLm8iLI6JHqEuWXToOkpO5z01nSFts+B0vGQF
	R0ES+Ag==
X-Google-Smtp-Source: AGHT+IEePI86EHzO2lKFHMUhhhibUrr1ifCWaWS9m6yGJmNtyzlTdWvIyNugozYcmICy9rbCctLESW+kX90s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:23c2:b0:6db:d365:19c0 with SMTP
 id 00721157ae682-6e290eb5dd2mr581447b3.5.1727760214866; Mon, 30 Sep 2024
 22:23:34 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:24 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 1/4] perf stat: Fix affinity memory leaks on error path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Missed cleanup when an error occurs.

Fixes: 49de179577e7 ("perf stat: No need to setup affinities when starting a workload")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1521b6df2606..3e6b9f216e80 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -827,6 +827,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		}
 	}
 	affinity__cleanup(affinity);
+	affinity = NULL;
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (!counter->supported) {
@@ -965,6 +966,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (forks)
 		evlist__cancel_workload(evsel_list);
 
+	affinity__cleanup(affinity);
 	return err;
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog

