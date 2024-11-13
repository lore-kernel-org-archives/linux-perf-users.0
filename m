Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28861FD8;
	Wed, 13 Nov 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457715; cv=none; b=IKjhqHFbEWHvewlZyZP+l4LNenWHeJbuFRmr6agecFZrneNby6Z3wxlu8HO6s/Dt8f5U491FTp0Zd4dhaVpiacTAPA3MJKf01yXV1athN9eKllowq4lNAFzdFq/Bi+b2Z/QEgFvFX/GROtU90B4Jjo9rCB8NK05wM4w2b6EttMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457715; c=relaxed/simple;
	bh=vccFHYr8ZR9cgyM4HGgwFgDtARhDnJAfANCV1e9IKOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cafM8LNK2ekFedqjiCxSERjbzTS9ZQ0vJr7zOmhoNmhySYaNkg2uawpKBTHuG41yClQToJjmkp8A+AhhRQ1FFMKA/vfydKeRqhurlCIz1gkpwhNegsWVM2XKjY8xfyLzPe9YRbUhVCB4JAz1Dbylj6G5bVKNbTW/sicbi8y9EI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8PWPOKY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8PWPOKY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cb47387ceso65543915ad.1;
        Tue, 12 Nov 2024 16:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457712; x=1732062512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBlhrPHwwByaR2iQ3j+uYlOmJcTMAeh7R4Wsq+6yt50=;
        b=N8PWPOKYLcPDhX4ZIO2waw4OhXLvKiGDtFGDyAQ0ZzUJ5K+MU83ymVKyLkMjQFp+sK
         dViFyJSfBjTObLODz9f8/FTNbJKjmz/FkBaqqInZ9niSRlAmRlMpwhuGWi1wtMKS2iz4
         gQyQntzuSRFd6bmLQHxKPSCsDYbZVBPJACFTioG4sP3nDRAc8hsVzpx7UpS0/rdLKX4A
         X5iGAbDwiTz9gns9e81Q19TkZjQVqQ3cE5FxXF2/OgPQgMfR9s26f5iuvdcDXMeeBB2M
         Im6Oz+/WOUGy1Ru1o3fztenajvtPxkuc10c0nxHqqzw7Bx5+9p3tq53i/PvTGhvRwjg+
         yX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457712; x=1732062512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBlhrPHwwByaR2iQ3j+uYlOmJcTMAeh7R4Wsq+6yt50=;
        b=PRS0d9dLgWfwkfyaXWiFQgSYxmMIwM1NpgKZ3OWj8XAw9S1NTNa18mKapra6K5Yv7I
         BitfiA1iZ6qYccR3Ssw2lZnMq1Lz748E0xk0eKPjvkcqfV9Q9OX1T4qROUdBA/HVmoYX
         8mFjtlDtqw7YW2fWTNAEPCKlCA7E+D/7+6qqPQAJ3R+T58OLhWRA6QA3Q4OASOMHhZcE
         UEQX9SDTYLjLlVNU91sntI0mQ8ItK5LMfJGLwQr1nqv93X0pXesnBIaNbnA7f4aNf08H
         Lkah3K4J+5fXwakECvAkqjNeSZy31bpwvt+ETrJVVXpE8j/TZVdxssa+cM1a7vVFZaWr
         n0PA==
X-Forwarded-Encrypted: i=1; AJvYcCU8vFYkloJzQrasgRM/wsXrkxzXy0K8Z2G3WxYz6KND3tTTOwf/AFQxE2ZlSo2/c4BeLFYb9TUzduYCz5ERH9AdNw==@vger.kernel.org, AJvYcCWh/fZrfAnkGhAq/P+FU1EyRCLiIXue9yDCc/rfOog1y5Uv8i8RlauA+b2TCiNfElRopp8hY/y2toNps+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTljKe6S4cmlFgFXoRLvhj+zGJfixTT0tgJLNnFDI6IJC8H9b
	MtcfCKfQlckoqBWnkgtOKIVCbuD3BZcna/e8aDA4AwzQ7OCb2Fy0f9HmE8/1MV4=
X-Google-Smtp-Source: AGHT+IFewqU5eBEm5zFq7vySqDCIUFDJrjJcHBGEbPxPCUnETye5z/jZ6fo/RWYIg9NbCll/O2EuxA==
X-Received: by 2002:a17:902:d4cb:b0:20c:8f98:5dbe with SMTP id d9443c01a7336-2118354bfe9mr260228245ad.33.1731457712202;
        Tue, 12 Nov 2024 16:28:32 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:31 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 07/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Tue, 12 Nov 2024 16:28:15 -0800
Message-ID: <20241113002818.3578645-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a check in evsel.c that does this:

if (evsel__is_offcpu_event(evsel))
	evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;

This along with:

 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
			      PERF_SAMPLE_CGROUP)

will tell perf_event to collect callchain.

We don't need the callchain from perf_event when collecting off-cpu
samples, because it's prev's callchain, not next's callchain.

   (perf_event)     (task_storage) (needed)
   prev             next
   |                  |
   ---sched_switch---->

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/off_cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index c6edc0f7c40d..f07ab2e36317 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 #define OFFCPU_THRESH 500000ull
-- 
2.43.0

