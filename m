Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEA3C30
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857182; cv=none; b=VYu1q306Tkqp4T/fFjbEQtVeoomL4xGprRu5uU+Ql8d/SFvy1l0XGyrZTyRL6qWRIr/l9OBxvhrWc64DTvddAEzahcObGNfzhcPrfOm3iXSrS8pzZYwaCEbXU7jTcvpbiT2n8MrdL+PrrofSDIzwKYYRo+bzs1WRPd/2R6I+lGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857182; c=relaxed/simple;
	bh=kbFBHdCad/TTKVPzgQtSH7M2inFZrQ/NSaJSVlW2wnY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lIikpHnIdC822sfX4Y/5TM5i1P6Unsd4JZT1SYZkP50s9ytgFhoosJ61xPaOakVSqUBaO/ZQ3IzWufEehR2QPQLRLqukyFPtn0kw0kya6tnRTKqRCx+q+r1871lc59z6XY60dmB/GywjTCMrL4a8UHQsKdx9FF9fY4HC/nYMDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQ4ZptBi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQ4ZptBi"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso2415246276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857180; x=1710461980; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=QQ4ZptBitK5TTDAKSdCOdFGhIpb55UUs/3U5tVvnVepfGVdHa06+0GZPrX0LlJA5JK
         DThxZ+bWZ0IPOkhKkZrcHJSGFLGkqoStRlWrwsDA0MOZ3MA3W07sT1CJm9gse97kV6Dl
         3XuZgf6fyFw2wViovu5srkfbuxNEJM7Jidwk1YBvNOE24HWmtSwzvks1pebQmtHWf9eB
         Omhw53U1CLQ2IXE5+6CbWkpP2fO1fDJRD93r/wVg2BS3EMiDZ5xG1AvRZuUvHpu1a79q
         Ds6VyVAP8DVpKqc6YFE8JmL/H8Nc9e8nw0w1vhFdTl6CC81kKfF7RO2bgYTyYtoZNn+e
         ohpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857180; x=1710461980;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=MbkfJBhaxaPONB8Gng6r5zdTQCJYHMYVyxlCXZtjdRXtW8d2wW1BTRp95wNUkJMj5B
         WwiSG4CEkhd9HQ+9lkohRcT3BjiyUjrDq4073z54Uk+BmoLucGORP/MzB04143+uDNqR
         1ZPEbpa1xepAJ/X2J2lUk/ORTVlqu9tTGoxEj63AX0o4MpbW6hY/0RzkeFLP+52c8zhp
         KswTbc4DSlSMkQAsZCXTo4ejwIp9gcfsrl7DBfQTkA3qhXRe6YY+wiaVVqZNi6AeBYVa
         FvtupxG1jf+xNC+n5EDVTPTIbZdIDUYp7UjQNpwod9jXSBMKXACj8NdhF+pnaGE/ISqc
         /lFA==
X-Forwarded-Encrypted: i=1; AJvYcCVLO49eD9FsDwouJJxclyyIvLQDbDUqYY7Q9BU+vYYp4gI0xSCIE3HtHpq4+H27fugpvARdNTN0/httk4gZA9/eT/Z8Lm0ZIdYVNnsEq9mrnA==
X-Gm-Message-State: AOJu0Yxm4LyImH+3kI63Bfae6JslMfU1P0wk9YMGJ5gJmkOcR4x/VfV/
	kAbmxJgCUuuaateWTLJLV3cVjgv1xgNvc1RALj8c/gKKcp/2FGR3YLom8rcHdPFZlx7RDgHIjbi
	Hcl/gZQ==
X-Google-Smtp-Source: AGHT+IHztcMIkTIC8gB0elvRFJcsKwcUzsPx2wj83xiF8gMH2QEYPBba6BBXD9kRH4bglX9Pa8g2PDxs21M3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP
 id cf33-20020a056902182100b00dc79218df3bmr879191ybb.10.1709857179792; Thu, 07
 Mar 2024 16:19:39 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:11 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 2/6] perf pmu: Drop "default_core" from alias names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"default_core" is used by jevents.py for json events' PMU name when
none is specified. On x86 the "default_core" is typically the PMU
"cpu". When creating an alias see if the event's PMU name is
"default_core" in which case don't record it. This means in places
like "perf list" the PMU's name will be used in its place.

Before:
```
$ perf list --details
...
cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache]
        default_core/event=0x51,period=0x186a3,umask=0x1/
...
```

After:
```
$ perf list --details
...
cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache. Unit: cpu]
        cpu/event=0x51,period=0x186a3,umask=0x1/
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f39cbbc1a7ec..24be587e3537 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -518,7 +518,8 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		unit = pe->unit;
 		perpkg = pe->perpkg;
 		deprecated = pe->deprecated;
-		pmu_name = pe->pmu;
+		if (pe->pmu && strcmp(pe->pmu, "default_core"))
+			pmu_name = pe->pmu;
 	}
 
 	alias = zalloc(sizeof(*alias));
-- 
2.44.0.278.ge034bb2e1d-goog

