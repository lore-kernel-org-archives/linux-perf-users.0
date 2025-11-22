Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E302D4B40
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799587; cv=none; b=ECyC5iVGD5PM/q9NV9VVeo5Dxtp5UP8f3rEQB2cAWg9omw0F3FIyP/JLLG3Gl0KFbgHK78Jk1TK2ged7aE3CuQdNUUr5bqBYEr3482h80W8djZmepp6bnqGvFlEU+NoB9jpn42kfj6zvdEUIQIJBqOSknqWUfn+i6f9ZiK2DpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799587; c=relaxed/simple;
	bh=G/aW5peChO+UAsXLrxbnBK/C5iyGmYE1p5zjBCdvV8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ngyWW4fNn0giqLdx69xxQvcGVJ+UOWw4o5ZGUo86MK6pSixz0Mqid8vwYcICeaJhcaD4eL4dpReKieniy2UIaLeTfSvrrMd3hmyIhVe42X6fi0xNVHQFPRggl0zts2DkLBCITEl3AL7HKgRmzg2qGePJwIF/jclT7ahhlJJygbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO1R9uah; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO1R9uah"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34378c914b4so9225739a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799586; x=1764404386; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWcorUar4Czscwonf/eqS0QDW5x4dx/5VrikSBKo6nY=;
        b=EO1R9uah7udnh9cT5J0iXRdleIurZXLjZ2KWaeVRKCxelgRE9ZI/s/m06yji48Rgf4
         vomEufMNMorNcJbhvFfH1pIhZ+Sgf3RwK7CgjmkQjXaHW8PZLrKKQOpP64KNzP7OO1iD
         iht50Vlxar5FaTUHuhCQV+YA5dIQ247wPT1Be4nk8T5n9UhRJulqwhP6+Zn8TDI+0v6M
         BwO1ABck4i9oFHvP9iEV6HWs56kOmVqdqsLJ+iJuixf1DBT9p/Xea19ey5Ljo0Xt9hDE
         hoIyTPB+uxeOrneOzZlzB5ODfwLk8Z1d+JpNErjMaSd4c+pxoI5fOTC1me5Dkpwnz/uJ
         lLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799586; x=1764404386;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWcorUar4Czscwonf/eqS0QDW5x4dx/5VrikSBKo6nY=;
        b=mSCyQoZot+jh0rwJMem5BUGPSuGG12j+0FJZAUNO0HCgZtqRtYeh3OjoxpWjMLArjd
         KFKaQ1VOHJNr8yNitXPvLRleFxssBn56nYr+3Nhv9NxzqeP0X5OOiNMAS9kLVvVDIwAt
         Z/E4sYlbb3hcoP7Y8DXdEtwH25d3Cbd564PoZnsWkOuyYr5vZRYSo866jrgbUQnbehzr
         xz9q52PdCwxIB8Ij3gWfN03I8LRmjxRqOPBIRdFS6uW+dP+n7hQqEqpatvQTLnIWpc7i
         qxraDqACzIAWvTya/mC+mDtSexZHArNS9sIpr8b90f5oRcf7cP3jlnA2uPKU7oH/jy3D
         yhQA==
X-Forwarded-Encrypted: i=1; AJvYcCV2GY+M6SjWJ/d4M+qc/CCX3OoUOOIHPkDqejauwAikx0luhZ4H/4Vm3l6eGMsqZXf47jN+px6sEnByIx+NJV+1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1wMohWryQMTv/EfZJN8eztwR7zKsjRe2DQuWptnSG0c/+4eR
	4MwaA1Hx58y567LVp9FGrHy6hAEghkjVMKfM72ZU0B2QiXAO+8EAmxsaTxwtz+huuwChQVgYm8t
	T7b44PcMwSA==
X-Google-Smtp-Source: AGHT+IHtFZ48zbqnStwMter9nR/gui+D0e/YIdH9vXlc1sswh3DJ/fx4gr5TrWgH+4pagfpfcsKp5FEX7tRr
X-Received: from dlyy12.prod.google.com ([2002:a05:7022:68c:b0:119:78ff:fe1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:69a8:b0:11b:65e:f40
 with SMTP id a92af1059eb24-11c9d709f69mr2441455c88.5.1763799585482; Sat, 22
 Nov 2025 00:19:45 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:17 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-6-irogers@google.com>
Subject: [PATCH v1 05/17] perf probe-event: Ensure probe event nsinfo is
 always cleared
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

Move nsinfo__zput from cleanup_perf_probe_events to
clear_perf_probe_event so it is always executed. Clean up
clear_perf_probe_event to not call nsinfo__zput and use the pev
variable to avoid repeated array accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/probe-event.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6ab2eb551b6c..710e4620923e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2419,6 +2419,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 	}
 	pev->nargs = 0;
 	zfree(&pev->args);
+	nsinfo__zput(pev->nsi);
 }
 
 #define strdup_or_goto(str, label)	\
@@ -3767,12 +3768,11 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 	/* Loop 3: cleanup and free trace events  */
 	for (i = 0; i < npevs; i++) {
 		pev = &pevs[i];
-		for (j = 0; j < pevs[i].ntevs; j++)
-			clear_probe_trace_event(&pevs[i].tevs[j]);
-		zfree(&pevs[i].tevs);
-		pevs[i].ntevs = 0;
-		nsinfo__zput(pev->nsi);
-		clear_perf_probe_event(&pevs[i]);
+		for (j = 0; j < pev->ntevs; j++)
+			clear_probe_trace_event(&pev->tevs[j]);
+		zfree(&pev->tevs);
+		pev->ntevs = 0;
+		clear_perf_probe_event(pev);
 	}
 }
 
-- 
2.52.0.rc2.455.g230fcf2819-goog

