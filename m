Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B41C9EBD
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696913; cv=none; b=r6FML25x0LzY5EemOffqVfeXGRSRK1Ed44BrU9yk0+Ujm2Q12H+SpZdjh3FRllxgfnu81glDhpUQASGO/KjfgE3HmkIlW5mknoBD/sJ780nJY+7sY7i+vF5t/UNblH4LBfUhFrzUVrCG7UEZ42aW/sob0d0vXcgGNjlL3upEDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696913; c=relaxed/simple;
	bh=uHynIhO2a6wMIH0GHztIOVR6Gu4I55/nbVHOrmgwumg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XrmMoE9uDUSZD9PhJl5jqH2tjF1Biq89h5+NoGn1/5IkywdAsfFV0B4CczQB8aXJ0PeTHQJfZ/3DfMVShjxTKJNXjkRPY4B60/Mrj0+b85Cdp5jOofThWxwT/86SJLS72O5rq/WjL9iONR7vNwjkntGMYnTMHk1LxtMFb5oZRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoL8Rvfq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoL8Rvfq"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db7a8c6831so3696077b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726696911; x=1727301711; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tA+ca2CfCA+dPHers/lEUgLS4RmANjgCVGUaPchRg24=;
        b=BoL8Rvfq6IWFL88D7Zfmyj4clzJQwrqW+vXxwN1dSbHqvKZvJq8Y6EpqAEFW7EsG3X
         oU0H+V7+Coe0/UIqC0uWW6bLv9Nvr63vLWJ2qTOz+rAAyaF0esn7TC1oqfpqrZx7mJjp
         rCY4C/5eOrSkzqDe4L6G7o/FuUWH61LUhhJ2DPXzBJJWHOamPWtpLlcC0AR/SJuQjPqL
         eVK1d4/8ovgsfnUywQIC1bRw4d6R80V9HDWsyeW31MSa4W7w7D8e8zeZ0fKQ+jYdodt6
         Vam43+qlvb7Lmhiko7nTTjD+ubHES0AadXJDKRUXO1KMH1q2M6XPOQPs5nQ0wYoKyTDw
         xGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726696911; x=1727301711;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA+ca2CfCA+dPHers/lEUgLS4RmANjgCVGUaPchRg24=;
        b=tETPxuoZJaU36ZGWM9NN1tyeKZRzhedAhHo4RckdQ89GDZQ+6vUNhqrRMydd9fLRS2
         fiihxRFonwm736eKf2payA8z+zfInOd6AZbOeKAD84VvixCrwH+CzGdSV84YSqLhHMXH
         gRsyo7nbca1APc5GmL5+1ysL0b5AZflkD+eddN94RVmbQDU6H2ScALn3ByuiKWv75OXp
         J2FPB2dFriyZa6imlrFSscWkmOAGvYvt8fGXeAZ9tNMO23gUXoxuGkBj6wlf65gYSeFK
         DDYooupZtMOQUbsHAqp4pQlQG+ypnY/eJd3ZbGnzh6DBET/CTmoB1pbbTF6hTtRlMlXf
         2d2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXavK509dCf0CqxBjFRGDogsk5vAElRaRvKLUgETqwMzA0HkqmW8OTmnjvstrmiescouucbZSVyJcMsiE9lstGa@vger.kernel.org
X-Gm-Message-State: AOJu0YwfICLr4pAmeiQ7C73ZhAK77/934QKkCCRw2a8YfQ/Gp9qDY3NU
	wCJTnSfHaFf3s9VwS+YRr6UBHdw2XeSPdVWfLiadDlS9YTU2nk8bze2JcBnNzmTYDK1RnnMfOuc
	wyWN+ZQ==
X-Google-Smtp-Source: AGHT+IE8oGOkMGpijeUr13v+FWv/cSJFJ+UhD8kBwfC+Eau1PSptnJGHpI0SerfYTZ1mBE3UCoiS9RJhehTr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a05:690c:338e:b0:64b:5cc7:bcb7 with SMTP
 id 00721157ae682-6dbb6acf2ebmr12290067b3.1.1726696910799; Wed, 18 Sep 2024
 15:01:50 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:01:31 +0200
In-Reply-To: <20240918220133.102964-1-irogers@google.com>
Message-Id: <20240918220133.102964-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918220133.102964-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v3 1/3] libperf cpumap: Add ability to create CPU from a
 single CPU number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add perf_cpu_map__new_int so that a CPU map can be created from a
single integer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 10 ++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index cae799ad44e1..2c8e36d0efaa 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -293,6 +293,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
+struct perf_cpu_map *perf_cpu_map__new_int(int cpu)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
+
+	if (cpus)
+		RC_CHK_ACCESS(cpus)->map[0].cpu = cpu;
+
+	return cpus;
+}
+
 static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
 	return RC_CHK_ACCESS(cpus)->nr;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 90457d17fb2f..79ed3449d288 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -37,6 +37,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+/** perf_cpu_map__new_int - create a map with the one given cpu. */
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_int(int cpu);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
-- 
2.46.0.662.g92d0881bb0-goog

