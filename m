Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7C2F5A2B
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799591; cv=none; b=Qb9NLcd7PJRHkKLGwmQRd4yKYccPzpelslhZSt1SjwhilHiwy4Rr34nGdQGdFv4r/DZxHRrOUhme/YukXn3fms8B/w1ttTYSnW1vSH0h1JnYbYAYR+QKMJjeU5Vu7Cua5LIjNu80n4qqU+qGB4W5C/QPGRj/dm58UELGiuE+xWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799591; c=relaxed/simple;
	bh=hLrbAHW/IK6axQB9NY9RWrNAve1SBIexdAJ/QY9OtJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=vEG8pALkVtYYPPPkkY35/4exqBpGBYBWCqrg14GiV//4DI5BEP45IWlsuLG4A/hJEI4ljnP9GX7XP3ITGpq1JHv59Oci8y10jU9CVR2+40jrbJl0OSiv+7pL9lGPQ23zu0AsKK9pl5QJydVH+iVzkECcswb26tEW1FQbKn/TGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sL9YLiW3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sL9YLiW3"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so2235939a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799589; x=1764404389; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4FKXjQbv8ClBiFRqeWBB89RpgtzwCj69Ux7R6g8Glw=;
        b=sL9YLiW3IgJE71wEXWnWWKmq2yq5mpHofvwjgvmQR/uobHFVs95bYGzgtMURHWPNhA
         F80VbQx7z7PJYbUDQlCk/JUmVwYhKwFUeRgGjbag0jx6OFGaVMQRsbIQZzKJxEBbdhOV
         0GQokbZ/Q5VOZppLSFkAVaQHnO9U1qwiOrW7r5b9kqTpANK6qPR2Olj7SUV6l+WJAwA7
         YH9r3qSZlkLYWfzrswHH0zMDNse4sPOFIPLT/y3XWCs3vl7GxeV864iOcTWuEZH/rwx5
         v1GtZW+GwQY0161hyrqNfKvuL3QE9u5RPYEoh/7Uyo30xfdMvyya0DgAxaNPT1NTmIT9
         pDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799589; x=1764404389;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4FKXjQbv8ClBiFRqeWBB89RpgtzwCj69Ux7R6g8Glw=;
        b=rkW/2vgqyX2uXZsWXSg3qsRegu0mlEevjUor7VKfKuJ8TYmlbsGv+w6pyB5REo+eW1
         WpHwxuKExoUnX3uEawqa6mnjqkdlYc5SJbYDzzStOsvClbKqNQtWQm7vgpiEAWbTCTAM
         vOcYRohS5gqwfDe5SyAjedr0f9/Xb8U/+Rdg05OyCmJoxFHec0HwtapHsVo0uYtQjP5n
         ILPTrAdIzrjXiImAsVy+kXzx56pj0vGOd/dyp20j4HeGcNLg4s8q+tAmImiFzXOpkA/J
         rSW2Lz9a9/3flFhWenqLaOMCG2h01t+H0ux9/kZTDU14T2KUl3qPRiwv21LYR4+tjRqz
         kwcw==
X-Forwarded-Encrypted: i=1; AJvYcCVI4Px+jW68LH5tYNjWpUd8f4HqvszhWlVe9FGrRWe/4or9BvjhakD+fMKWMXJ9gfe0X2DFF+LZ3PeOddLSd6dV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44heIBK/8d9pfVWQaZ1tTvu14S3sSnAAuaE6QvKGwY2te2dlV
	5c3KScaslI+3hFkBXiDyb3fH2rtNiSQuPS03OWY50iaVtPBAlVxmTS/pQR2MSiOiyM8EeM/qplI
	NHeV5nRe4qQ==
X-Google-Smtp-Source: AGHT+IGtWQaAkXGZEUVwfz7nHRHgGzDNhILsM3LsP4ku4cyiAVZ7R9MPKydE9QotJ2rlK4rsdSHhTPzqr2ry
X-Received: from dyb14.prod.google.com ([2002:a05:693c:630e:b0:2a2:367e:4efc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7009:b0:2a4:6a87:7285
 with SMTP id 5a478bee46e88-2a71a132a83mr1852426eec.39.1763799589451; Sat, 22
 Nov 2025 00:19:49 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:19 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-8-irogers@google.com>
Subject: [PATCH v1 07/17] perf mem-events: Don't leak online CPU map
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reference count checking found the online CPU map was being gotten but
not put. Add in the missing put.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 80b3069427bc..0b49fce251fc 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -303,12 +303,15 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **eve
 	}
 
 	if (cpu_map) {
-		if (!perf_cpu_map__equal(cpu_map, cpu_map__online())) {
+		struct perf_cpu_map *online = cpu_map__online();
+
+		if (!perf_cpu_map__equal(cpu_map, online)) {
 			char buf[200];
 
 			cpu_map__snprint(cpu_map, buf, sizeof(buf));
 			pr_warning("Memory events are enabled on a subset of CPUs: %s\n", buf);
 		}
+		perf_cpu_map__put(online);
 		perf_cpu_map__put(cpu_map);
 	}
 
-- 
2.52.0.rc2.455.g230fcf2819-goog

