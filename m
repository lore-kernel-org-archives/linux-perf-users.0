Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB51D5154
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460049; cv=none; b=VVvjH163Gs7mQvbmh2eukddJ7jTBtBKWg8MAqiTYnVIidRdMO30v5wTPFdbXv55BIQ9a9uf+h+ZHNUCkGf0Fcnic9DG1sX3Bw/RFxrDbgvpgxNNco3byBsE2dbbdcRlaqOUADLCmBBIGzmAkBLqZs0wVqvSxT20TrIHUTsiHmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460049; c=relaxed/simple;
	bh=sy3VlSAHvcJviVgcFZMJmc7WftJUr4tw3K+lsQD12d0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A4Nk3adEQWj1l6IYtwc0n7rNuKDLS/5NFo17eGn217DM59AlRgHE37Ookb6U4G81hmWQTqnR/pgwMB3fVlhnyIcAnhpqEIIuzXd9og5SP+nnEcsqMjn2Fi4O0oCAZjGQ4dy9QsXrwWk/KUXhcUkH1lWEaIE70EzbGrgpJvewtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fFqmvrw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fFqmvrw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a109984a5so309659276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460047; x=1734064847; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TRhSW9l3K7YWslNZkoYOdpdUsj4ahnHxjZdZRRIcDQ=;
        b=3fFqmvrwIGiqy9GF1+OOOU9cW46/4/c2gQuloJRjqkfKedsYnPKoyOFK3NcgVFz19s
         atHTan8zq30epiOa6Bl6Awf04/U8wEG6tputXb7kTs2byk5IjlcrMVyj8F9BdxVuqLbr
         Rgjo00hwmaoMEvnS58rtCBFTUcAkuru6ARbP9Cv+7iAxF91lIdHJLOqjwI9i0R5JlMkt
         DiaQWZaInzcV8yTEsTMZJYcw75YX2ADdVtXeE5v/9Ib6gkACqqbNQxhfgidWffZSuKkG
         0rud4wZdGCVjwNU7Xj0B8Rr7bea85dyNVVJ39y+eVD2CFxQfy7kS+Tae4kcKgrv01H9i
         7cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460047; x=1734064847;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TRhSW9l3K7YWslNZkoYOdpdUsj4ahnHxjZdZRRIcDQ=;
        b=YcFxrUZf78Dp2Sht2VMFrcuZRJ2CpWcEgI8tftkwEa+UpxHuPpTtunRMJKGTzGYCA4
         AK7HI4mZNl5A3DhQFM0y70Fc+8fnudeqUgcfukbdGdGw5r1uSoJby6SrR0ajyXwE/XXW
         WACftgoFeVc4y54xHfATA3gnpx6nCxth/0K4BPgkCFruW2RKwnlcTDBfrnWl1e0gmc4G
         O8MQ80GdZUrQEKXLoRmAZxbTeXONQIXJiRrrmxBDRF8nub+LbBS7VFHq8IunEKp9efKe
         4FmIKiMnf5cNofRFydG8E/yALajoPlR5aFmQJYOS05oCT1O+YduyZi95Kx2RtzJxO27q
         VrZw==
X-Forwarded-Encrypted: i=1; AJvYcCWr8rBhYXl0CZGqEduZ0zH4dkTr5nGETXD3uC4sxd9zrM978PA0er8zj3x2COCSpCi5rd3n4/C/21/gIz0KQDuY@vger.kernel.org
X-Gm-Message-State: AOJu0YzhspbISpy89b9TWT2Tbystcd3Hpxfhjs0ogg39Kh7yGYyH3mdk
	6xro50vzPZ0TD2b5SIqCmeZ0obAD8FXnn+S2MMw+8iXGctw89FzpAsS9zJbUaURwAch0VJlzvL7
	WBOHRNw==
X-Google-Smtp-Source: AGHT+IFE2LwLNaSTO62nxIL6A+u7AnZGRX7WeJwZhuOzG3htBmKYKjKvD2BCbNixg616M4EERkMINqDwdmlK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:c5d4:0:b0:e39:8087:42aa with SMTP id
 3f1490d57ef6-e3a0b07a87emr817276.1.1733460047449; Thu, 05 Dec 2024 20:40:47
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:31 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 4/8] libperf cpumap: Be tolerant of newline at the end of a cpumask
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

File cpumasks often have a newline that shouldn't trigger the invalid
parsing case in perf_cpu_map__new.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3ea06865d4b0..20d9ee9308c6 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -240,7 +240,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 		p = NULL;
 		start_cpu = strtoul(cpu_list, &p, 0);
 		if (start_cpu >= INT_MAX
-		    || (*p != '\0' && *p != ',' && *p != '-'))
+		    || (*p != '\0' && *p != ',' && *p != '-' && *p != '\n'))
 			goto invalid;
 
 		if (*p == '-') {
@@ -248,7 +248,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			p = NULL;
 			end_cpu = strtoul(cpu_list, &p, 0);
 
-			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
+			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ',' && *p != '\n'))
 				goto invalid;
 
 			if (end_cpu < start_cpu)
-- 
2.47.0.338.g60cca15819-goog

