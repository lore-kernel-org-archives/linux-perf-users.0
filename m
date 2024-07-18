Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40011DDEA
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262656; cv=none; b=WfS/Qs5aay8+wjOCJGNG8lHj4Hq9PU8XUncqhgYmF9a7NcgrX8wG6LcHrNWIX6eNtEUhLUgF7a/KBsXQSCoHw1MTqCdMpIL8hF38Wzqn4F/iOBPjEBxJo8PPKzulRSXUJV/8UIphE9zpCGVXdk49RztM3WH0tW45zcqzcxbF5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262656; c=relaxed/simple;
	bh=xO1LeDUwAlVEwZnVaFmHHPJ2GZce6TEJ/S7/OdCC7Zg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cg5FOzPYCGy/5FOSBAZ4KJlNd/ZrpC+BoQzENa+FmH8XS4sGYj/7LZyMo/7LQNXwIx4Pn4ZGoeQsC+PFIhIjTcAzdnPRzmamE3Hep+EPwZ6BtozUJr8eJ0kneqnoC+v2c9ZkBr/3/CmuGbCz5HACouON9nL8kVUKRCa/6Gg9k84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlSsjkxc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlSsjkxc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6524309be45so5958357b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262650; x=1721867450; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=RlSsjkxcC/IRWN0WwacEwBho1lsHj484vVq20I8wgxjlpySQ7KdgFFm9QetjsWq4TT
         DcnnRzOrrfuoA7vrUtvT1DWxmOfVDBefQBvrFAWDe/QHWbmnIZkP1R/4qa8Q9EqhnioR
         j4f/sAOE74MPaFb1fPF2EGLmdaj8TpGUU8aHebIbt/5+kuLKgRwImR+N3+GuN1fDbFA3
         7eIyQxpYoFyK80Q3B3Y0xBD0Mc8kjUCeY/KmJ4EzbnhBrTtG6soLkCu8/tkNnMIDfTeH
         QpaIvz/LUSBvOIx1yE2fkk25QZr4qQRXGyDv9KRwoZCOVSYN8774EdGu4GVD8Gru8/rh
         wwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262650; x=1721867450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=HyLIWojP1PGZp5i8C5nMTyC6EnsX2x5spIwCb0H5htBwezOxpiZPE2cD/sosUM2DmM
         8arxpLS3S7s67/aN5jXMPpVqdUMDUAnh0BfBCpJHHgoZZnRkXT9rn6MSvVg4Pjk0RKAb
         DcCF+a8O67Fqi3pwyCPCwNGJC3tk3HOaj2dSCCa6XPEK56EFEiWWm0wYeUUmYEoHeroK
         +Yt11plN2yTOU3ZlOsPahHC5LO477T/Syo8jbYFiugFyO1TpOjZY7XV3W2QjdgVPCBlb
         GvHmdhI8dlJbxK5fYE9tII3ctL2eiJgJS1p6zp9DML1V3eSmSd2Thwr8IBTtusFaUB5T
         GF3g==
X-Forwarded-Encrypted: i=1; AJvYcCWVOXf0h3o9cuSIvLRx32rLUCE2YTOZlsOGw4x4sOlcmdDmUYihU/Q+QT/y8x8HpNTt80mFtHiOU9L+sRxb1kuMq2TWJLi6tc+KoNJxzN9dUA==
X-Gm-Message-State: AOJu0YyQ38TxXldFxFBSPRSX+bkMZRRE6H+8+m0NMcJynbYS0HWZqzAC
	ERN6WheLKMCz3tPg1UudyqK3LZhBxfEUn8cvRHKOaA5BtN4vPWh9WlcF2EFGCVAoMxO50HUdIbE
	OkV+e8Q==
X-Google-Smtp-Source: AGHT+IGG7VWzTnmycXmTdJphblM+hhP0c4L9vMl9r5mE9Xw5+miKnxk+TogRA/6By5AIKP4LV8790tNifGhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:289:b0:62c:ff73:83f with SMTP id
 00721157ae682-666040ccaedmr396737b3.8.1721262649825; Wed, 17 Jul 2024
 17:30:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:23 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 4/6] libperf cpumap: Add ability to create CPU from a
 single CPU number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
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
2.45.2.1089.g2a221341d9-goog

