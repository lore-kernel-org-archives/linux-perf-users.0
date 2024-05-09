Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CF1494A1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232691; cv=none; b=T3PX1ppxJVYcEZ8SI1o6ku8OwsXX9sfrjNuGuK8MVrfLJiGc5rNXN0WOTZvvtPSFDoBEi00Ljot9a+Di1cZl80TZis138JlcyV+A2jO6rfMrFGK9PBRS6gygvnuvr6z4OiyXvKkX0Kd5LEEX/bK6tAs9K6nBa+7M0gQx4avUYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232691; c=relaxed/simple;
	bh=pTEExq5eYMtvhoUpicI957vBqyqltPGfA+Tl2tQLAcs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=SnZ3wy0vvRDSsvC+yR0uGetADhsnqKH1dLbHZaQSwdqBYamwIU2bqJ8jmYBCUYLsW4Y5DYRwwGKBAWXj+NN3hj/9zQBNV8tFL5Yu0MmNYVA4RTvA2EG/V8f/zscp5cZG5j0ym1NpBDmDKZlUopT4cTX3/3RhXkHcVoT8bDXU4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9lvic1W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9lvic1W"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6202c9d143cso9456287b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232688; x=1715837488; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5aJbLYHe6GqC/mebjTDicObCEBB4J8UKwRZUPYrQKM=;
        b=k9lvic1WVExRqjvzs0Q5uAR/g8NeZ3rt681E/9Ofi/6BOSSJmAbT4xZs+A6zy0NkMS
         fK1NsOsx/JWur+39Uwqn4zylRHtdBC1exPcI1nqG6jIvwcwv0oO1SRfdAtjvZxc15hkj
         CV+fA1RrPDFhBp7YBe7vUThILrHbZItiES5RKf2TGGgdv0XlvgomZfmAbgBmxMwIs2nb
         jyErxe33BRLzxrtvfW1RkCA4dp0p94V3j6xR7cRr8cvu5JZvSk56JwAC2s6KySNTOsmg
         2wytWwW2TUz9FJ1els29nL/AExpRk31NlReSkCSO+HtkdCu3bUmGAsaxPWbUEUftVHL4
         U3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232688; x=1715837488;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5aJbLYHe6GqC/mebjTDicObCEBB4J8UKwRZUPYrQKM=;
        b=tFNxrw6fhhjVtPMceHR9alM8OA+GArovaxLfiLMlpOU8G4hQ4ouMuXR0lGyGfF4LYD
         uQgYTWaDITCDyFsViBh5u3y4IpOM2OYdZuqehJb2O+EvvszZ4FRIZfBMNmepBmAsWILd
         q9v5gSeTapMvpRSvQZVJXM0bka2llEoeDdmQnMM7W66Z2hjUfRIqo+wg/+T+hbiHL2zh
         3fb3Fmwozld2cv3RywzyZvRsKEXAF6gIUQBhir0SbW38ccpFGGQawn0642mMIqzfxN0j
         J/6XJrVEERn48l7pebiOJOuyMz5Sg3JmGNW2NFkpj6pJLplECsh+cugPwkWMj8407QU0
         Ji/w==
X-Forwarded-Encrypted: i=1; AJvYcCWgu22ImIFJfy54Gwi4nCIeLLxqr41PpNVhLEgSCDNUetjcoEQQK3LkOv6Vf3zlTwYMJbGuxayWPNP1csbHaDQzVZFK3oGSq+roDrQMyXZs5g==
X-Gm-Message-State: AOJu0YwmZ0I94jDn9FKWr5r1E8XiYimDbNtlO4FI9jZ1kMhD0tlSO246
	W4iLFCXo80+HNZb8mas0s7lTL3eYvjXtygwpkBiM2eKwGh8jcrI7qsVDruBjNh01hVduLUO0bv7
	ATgXRnA==
X-Google-Smtp-Source: AGHT+IGMmqrphMvD9VLuxJoc4Pax2f9fdE3/23sT3qktgwrSIK8nZxvg7UwlBEM4ZnP0aJgflzMDAhAM20Fd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3887:270c:55a5:15aa])
 (user=irogers job=sendgmr) by 2002:a05:6902:1025:b0:de5:9e4b:fbb with SMTP id
 3f1490d57ef6-debb9d85224mr1445450276.6.1715232688300; Wed, 08 May 2024
 22:31:28 -0700 (PDT)
Date: Wed,  8 May 2024 22:31:23 -0700
Message-Id: <20240509053123.1918093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf lock: Avoid memory leaks from strdup
From: Ian Rogers <irogers@google.com>
To: zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Leak sanitizer complains about the strdup-ed arguments not being freed
and given cmd_record doesn't modify the given strings, remove the
strdups.

Original discussion in this patch:
https://lore.kernel.org/lkml/20240430184156.1824083-1-irogers@google.com/

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 230461280e45..7007d26fe654 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2275,23 +2275,13 @@ static int __cmd_record(int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = strdup(record_args[i]);
+		rec_argv[i] = record_args[i];
 
 	for (j = 0; j < nr_tracepoints; j++) {
-		const char *ev_name;
-
-		if (has_lock_stat)
-			ev_name = strdup(lock_tracepoints[j].name);
-		else
-			ev_name = strdup(contention_tracepoints[j].name);
-
-		if (!ev_name) {
-			free(rec_argv);
-			return -ENOMEM;
-		}
-
 		rec_argv[i++] = "-e";
-		rec_argv[i++] = ev_name;
+		rec_argv[i++] = has_lock_stat
+			? lock_tracepoints[j].name
+			: contention_tracepoints[j].name;
 	}
 
 	for (j = 0; j < nr_callgraph_args; j++, i++)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

