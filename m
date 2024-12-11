Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F911AAE33
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897318; cv=none; b=epEfWeeQNMYLh5NlKOilkZg+cjtR9ClACbFNjfEBSol4LeY/3MxRxsfBlEuxyJShdJMakj9SkAAHX8xyAWsYG1ugt459OQjt6ekE8dzGBm+Ow1WBHjZMGc+ylQV6E9Vi74fc2Yghm4YlpM99oiNMdAcAu8p52kV+rrJrOEot8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897318; c=relaxed/simple;
	bh=SR7tUhFz20rFGvCtXyCBGl6PkDO5QGcxCL2Tb+J1ZXU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=KDw88bce1LGI9mENP3+EP6w54hQsxe7R7ETMs8X00TZff/IUeRFP/VnEaZmkAm+P8ZmFzV55GFsgpF5rnRNVnB6sv5I+qMPL/t4THboPlP49KI2uwbuY1+wo6q574KUAXxh0pk/qb4WX4+nisHVLj9AYNeQbIjAWTtYWGCqq/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwtGqHqQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwtGqHqQ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef7c67eeb8so65009147b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 22:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733897316; x=1734502116; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVIJ7sBKo29N5wK7CyxC4hRD95JOXO3JOEqr1gB0IYk=;
        b=LwtGqHqQ4PFB/tjAwmcGnoUUNqOem4O5dYuWIlXj6lVDmBLi0rE2rJ1znBAgzRTbil
         jUyE36V+MO1tU1dh6Dh6OqvrqUknQzvirGP+NgeaTJ94zueANaH9WF6GKdanu9eOi8VF
         Fu1az8mwniWhoqHt2srrYXHEQBgvNr5SmRBux05wgLIieSInN3isf1/pMQ5ml/kBMhKq
         VFcYa6DjaPiqcM93VQ9ZQ980H56GxCQ/exAkUNC0018SbeA7FZiCPIAdmk5IZ5kR81MB
         WKDmLW7pN/tBPJR8dnDLxF9VhiFnClJZnolMNGCrdQq0iokvWeCjFMw2Cp898EKe18WG
         kN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897316; x=1734502116;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVIJ7sBKo29N5wK7CyxC4hRD95JOXO3JOEqr1gB0IYk=;
        b=ubaZs6VPvJrXZmMpUZyPW/Zo5rhfcFQQ7O3vd8qzl0WRRRwLLDu32Nr+CTbR8/9qqT
         djeBUd5eNwd2sHjxk6iRKmeELCWoSLt/A657WFxDRhQNn87hUERtRN+tdch8+wwlGkZF
         urus7syNXhgOCHBd/98ecJKFEUngvjZckWfSspq3elEKSZQmDvPXvpC6l3YBr7xbpv+I
         TQTb/rYPN2LOYs47zGtHLlKqNAZtE/8ifA14VwTfgoCJRgq/kQLUNNpxOcNSgjC4w/90
         SWs6d7NQnEg88+T5W4INWHhQhyLvbI9JwFgHGdaTyxF91Gzc6HqlOwzzskjo8LoL6hN/
         A7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWJFtDFe/w5PGEb1qJOt2YYF02BJTZFFJb0BQIL0L4IpNQcOXOIatGzexvUqMKQLnq+12zVUM4AerMgyTTfyi4W@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+IsBNBZGNfm5mYnuVXI34cSZv+XSEUWt2Z8jPJaU3rAMTnTx
	WCnApZvxMnk4oURtKDKcv5l/yu3ia8/JvrfQAQUNAqTPpbYT+7J8/0g/P955hXIpoGhqlqDP19h
	GRFtoUQ==
X-Google-Smtp-Source: AGHT+IEW56OWfH6NsKL9sVm6xNi8SxTWO/fPoh2yVzTYOxbd6gTdRTysJ/4fgv1WowUp1ZgbH6LcrPg6/iB3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:bbed:4ddc:59bf:36b8])
 (user=irogers job=sendgmr) by 2002:a05:690c:4589:b0:6ea:decd:84e with SMTP id
 00721157ae682-6f14804410cmr10597b3.5.1733897316361; Tue, 10 Dec 2024 22:08:36
 -0800 (PST)
Date: Tue, 10 Dec 2024 22:08:31 -0800
Message-Id: <20241211060831.806539-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf inject: Fix use without initialization of local variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Local variables were missing initialization and command line
processing didn't provide default values.

Fixes: 64eed019f3fc ("perf inject: Lazy build-id mmap2 event insertion")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d6989195a061..11e49cafa3af 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2367,10 +2367,10 @@ int cmd_inject(int argc, const char **argv)
 	};
 	int ret;
 	const char *known_build_ids = NULL;
-	bool build_ids;
-	bool build_id_all;
-	bool mmap2_build_ids;
-	bool mmap2_build_id_all;
+	bool build_ids = false;
+	bool build_id_all = false;
+	bool mmap2_build_ids = false;
+	bool mmap2_build_id_all = false;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
-- 
2.47.1.613.gc27f4b7a9f-goog

