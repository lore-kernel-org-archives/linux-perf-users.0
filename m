Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C812255E56
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212699; cv=none; b=Xq26lKNkEwbPl+ft9dpYYI72qIWhehbw17vcM8Uv66HmaBBUMR4LJt0BBG3kVH83JCcYqWuc4pmnaeFwuMZd45eNuvYJhmblDAYGfYr907d9fJKNvirSQsfnVwwDTsMmx15GnO6yqxz0WgFirDlmc/iYHRBHfIMLOVFlR0vhYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212699; c=relaxed/simple;
	bh=OFakRqNQKHADdpdhmZgfVErGfxtO80Hgq1mtytTW264=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=It4aE32b96Q2yJPkc0ZZ5vR86nEqxOLYgipCXJ9hB5ox6Sa45weMv7rMl6arhk6VU57nEFmCpn+c81HfiuoCYN/rBnzWLaDSvjucRxcWsDEulXI1A+3iAH7H0tJgoFQuPi2gnTv4fUoFbOqfG0+IFyreOlWHA1NTjOTFMI8D9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtqYaJwH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtqYaJwH"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5b4b8d71easo4112412276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739212695; x=1739817495; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYBVa7z0m4z3JsO7DUulpiX1vMOJnR6DEMUcDKBuhfA=;
        b=qtqYaJwHcdPbGa6uWIo4NL37DHQxutq+G1HWSKu9sCcmi/Q2xzHRgTy2aml6ep5QG+
         Pid4BuVBXLm/ZBkcJoPWYH6JCDO/xiRYvdX2Pnt9OKINUQM2hIhVT/DsXXBhWufr4Khl
         Bqegvo9SsGH1j249gBHsRvmcaHtCDb+l1kBT2zrh+wbVN8mbLxjbY+XbY7GooIX7aBwg
         HJXH9dhph+ARkxHgDhzSM9UykfB9d9FcRHYdUhoyXyGhfKWWHoxlee+aIHsicgleplCN
         iK6qeq3urwPd8dEejrPEFwDXR4h1fGM0C+lvUlLG8f/74WCdB2BUXRaarjUx8xI1W5qL
         QzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212695; x=1739817495;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYBVa7z0m4z3JsO7DUulpiX1vMOJnR6DEMUcDKBuhfA=;
        b=I4FCFu50H+NfSREHMT9mVCoCW3EhzgUvKiprTnV6ZQVnXF3VtTrfI8o3C8kGym4Mbx
         iXGKJ40OSKEBh4yhWaqcFTjLbt5hNhf7bZya5JNwJTR6nGGstkYS67PB6Jiq5+P1hsKA
         eChbkZj7QbJ39XA6UWK8cPxdhs457RrYG0F/o+c6AJRMDsnalMKKjzcgjrtIL7xvQ2v8
         0YXvXwCuVrrox5400LZS3jOL9+CEwHUdxPEKKbibb41W3dz4MiXlnJ/KsMDKZOGpLKy3
         fI2oHCt0i+Ia8A+SMlDN2jS/gd+w95zVqQrW6Gz7m5auZD8q8DYNpbIe3FDwgChrO/NP
         jIsw==
X-Forwarded-Encrypted: i=1; AJvYcCWHiSbz8/RqrzUenQ5DeXL0ueQlcpnShr0DBPbBfh7y/OmQhu9NwzB1Aa2ph59CH4ttHyo7SpghX+5F508ysAM9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3UJFO+dEeIXnaeT8MRufDmEGHiVDMXV65eieFOdksQkqwnEB
	9x8SIU0DIVW5Gmon63cO3dpIdzpMtfC+ID8sUScspJ5sNdtgsE/uY1dpL+UUoRw2EaPu9UwYY2S
	PRYaJdw==
X-Google-Smtp-Source: AGHT+IHKeCisUol3zDmhjIr5zbOJ7wY6aZEFAXOChmLKaU4l4cT6Voj+AsLIzjf79+Pu4qf2BTOgzii8z1sH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c64e:af58:30d4:168d])
 (user=irogers job=sendgmr) by 2002:a25:7a44:0:b0:e5b:3445:d33c with SMTP id
 3f1490d57ef6-e5b461801d0mr111693276.3.1739212695310; Mon, 10 Feb 2025
 10:38:15 -0800 (PST)
Date: Mon, 10 Feb 2025 10:38:05 -0800
In-Reply-To: <20250210183808.130522-1-irogers@google.com>
Message-Id: <20250210183808.130522-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v5 1/4] libperf cpumap: Add ability to create CPU from a
 single CPU number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
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
index fcc47214062a..f3054894ff0c 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -242,6 +242,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
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
index 188a667babc6..077133935bf4 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -36,6 +36,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+/** perf_cpu_map__new_int - create a map with the one given cpu. */
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_int(int cpu);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__merge(struct perf_cpu_map **orig,
 				    struct perf_cpu_map *other);
-- 
2.48.1.502.g6dc24dfdaf-goog

