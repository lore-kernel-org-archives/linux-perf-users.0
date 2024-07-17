Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED773466
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256471; cv=none; b=i1NRmBD1fgKf/wE2+JO+Wx91de6vDKa4iiBRlIlURlII1IibsD0r/FzKLsCTjTclkvjME4IqKQA5qVoHLoYceta6tmZ/51BtgeAr9ZaNwHzWQ8jIxxwJmgsjxb/AwyuqOvmvxhGqmljWdUW7Z3oPASeUZjGvLxJNeqwXdyou0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256471; c=relaxed/simple;
	bh=xO1LeDUwAlVEwZnVaFmHHPJ2GZce6TEJ/S7/OdCC7Zg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Pz1wf6ARoaJzJfic7dRVLB1hzSPQtWokFZaH9r/++FZOqA0XqeuRLl1M05lijjVC3B/ePg82fppZpAX1O1u6djqUdhBunJwa8eQUthJ7bEMG4M4s9sS/sY4/Vj/UlYtLS5wsfDWjIK0DCdyw+C1FtqWvYZQzaExyq0n66yzdQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lz9XADGm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lz9XADGm"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so434024276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256465; x=1721861265; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=Lz9XADGmqG5ApnzFw3PLMkAyHTwZV61OOTcQnV2szMHn7fxqQ+vm8JIlZE/f30PPyx
         FNpAQS8AwF0V1dX64OkayFWNoUznP98FBdT2btdYrhB0Sc3tPnCc9UZ1G5nSzTZUUBjF
         soBvwqTUiH4e+Zv3CYRre8mtRObHtG+s121IsBmhXNWyVONDV7bG0Fl3lVMmzzqaPhGU
         dVOPwldynZ2YFEfQH1jOimEgvVvzSlvPGHAdGpkqqPcV69liiuT1GL+4AngVJBzJHnv9
         KI0FdQ/v46TksSSZIqYsyCZxLWdoUw7ZV5yt8jNXaTrghaIc7zBiwjp2lEOrXo2uOe64
         O/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256465; x=1721861265;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNlJN2SGII3MYeevUlf4p1OQiPVTTvbXe1jkW5mOAw=;
        b=qDI/PqPmizKy57I8dIDPXA7+atrIe3QNtmtxltJchj0Fts2kZCFdf0qon4xJ6Z3Y3f
         ECnu3qRnp/WjGXCrsf0eHUHhT8NUfQiQdFqpbWDINZmOOhxCW0ZeXE9/zdOQKWaGn2Ws
         JKfpwYzw1FBO1OHxbNAbX1gvGXCYuHfgHP7Tu/Az06j071qj3JOZYXw03s9NwJPV31G6
         TvilLJMHXjY0ogb+U//qUqFsVR2ydeODQCpPSikri7hXBh+ghd3hGRucfjr2Z+woaUry
         YBSyWd1nE3lreMOtTEQZmX2ir5lRZkuLx7bUZLHOTsiiuiYr6SJp07/QjlZIXEcbGj7+
         D1ww==
X-Forwarded-Encrypted: i=1; AJvYcCVHKbjpEi0OEKdj2Sj1NpGtCjQLRLm6LTkUvrJdjNAGTFab1nfzpEbWJWGLxH5/I74OapyaNkZ8+d7cmECD5V3zXxaaQwxrGjQPV95OrYa9Yg==
X-Gm-Message-State: AOJu0Yyh9l1Ctm850D4w8j8HQeGvhDAoxO1ds/OWErJ6DWSdc/VvQwkc
	SuGLsnNlTfWES5lHCsiDOpTmd8s/d/V6k6i9JxMBem93MKkA1D5T8yAL+RGRgY9qtIsfcxvbhjx
	z2lhJFQ==
X-Google-Smtp-Source: AGHT+IHD579pgm3HArxrQGR94j4J3NgPiAcdglBtctueU/H6FmZ0a/dayddNY5G65oQ1POwqO65dBGQXMvHE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1144:b0:e05:fd7c:9cfb with SMTP
 id 3f1490d57ef6-e05feb3769amr2480276.1.1721256464923; Wed, 17 Jul 2024
 15:47:44 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:30 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 4/6] libperf cpumap: Add ability to create CPU from a
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

