Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B56131E2D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165683; cv=none; b=iO0+Fj+ciiNedVtUA5hgOJ7N1hbYOrhTMpTy1mbe62VFlHOe++qHxhy/mZArXbaD73+RWLCuw7hLxMMstysAbyAU9YwF9HHW0UhXzKm1ZTdKj5BXukohR1x9NhvMkB3q59JHYjzWWM1GeiDQRIe31rpEckjS/5zdAMFOLHNOUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165683; c=relaxed/simple;
	bh=ZTNWU3MNnSY7ovCjf7wOpRf0lxvteakNNbWNzL37rLE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GBB0fF/8gQyd0/nlHPGtuccLhTRnvqAAq1euNn6fWifruNeNLo6xz0lVQBelH6H2phe8BZ/dIePhLTeNdVcjSVGoY0oFqEZnTDn8B/PFjcifL6UcQTphYaRI6k7DLkZZlKZjuJ9GrAUgLbcQuETBnNSpoCRxN8FTYu2pgkY/zkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFjUEFEZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFjUEFEZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a6715so1470877b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726165681; x=1726770481; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MqrU1aCvZ5PLoScyw2apjWHZoKwbRrLtoVTExmPRRIs=;
        b=NFjUEFEZVqL/8KaCCBPehumSBn8YL53pEH446JYKImrDQXw3Lcqy0QGkure3gOxx00
         YgJlBdD0UfZ6fWI6l4JasE+KqRqlrywfxez5peodNJqDmtCj+V+GVwWCCY7iVvMmFEvo
         oC+k7NCWmRp4DYI7VkXlMWaUf/Rqop1comFm1hZDjr1/Jy3QWqiWU0yTlzsKUB54wzGl
         YmvrSomPKpyliKciLyKDtXm/tRlEj6WazKQoOtvAebGSCkcxUcQ9ONqRtCmCg1f0E9rQ
         LorOMdgBx1klv8vtfvWyYjE3HH9wq0ZWZjQgaWeDlFVGJDHqYcROX0Bzh/s/aF0ruV2l
         8Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165681; x=1726770481;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqrU1aCvZ5PLoScyw2apjWHZoKwbRrLtoVTExmPRRIs=;
        b=PocSbafFcvAfioIZr+AyFsQ0zM8tyKTsETgRzoEydpfr76zmO3bKNNFLMEyZR0Lsd2
         iMw98tWJ/EAmVbkbOh4EPxP/bnn5q6UB3ZMJtc4CRhtpeptqlk5fx3/gkD2n67br6xb6
         QxyfTiEW+q8SrtDvfNMC/SFEj4XVaLAVpwMa7COoR40K3296g2hO5iAu7As2oTCy/G+X
         7wlSImpcNUKj404mSUx2gKuu042fhz6IbPB1ipZam0W94+Gzn49dBTmgUjKvfCN0sWN8
         PpwmKqtI+UwPb5AKqBWMru0j9HA22GVYC+s9UY1QfG2f0IG65MJ5VzTzeSw7NL9ZVj/x
         2a1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8eTl6Kb4D68bP944gLihdfyfeA98/c+lO0wpD2CCScjLCHdjgR+pXnDe8YJ6Z9bXIRm+SHrPCzve+RV+0iMWo@vger.kernel.org
X-Gm-Message-State: AOJu0YydVIQWOcIJ5r0ENmZTId7W7Y+KlMhIFOJ2/6V8IzFT3GF6uoCL
	D4Xl3stBdL0OHffKIx4kjPl0LSyjJQ6neWZ5S07kb9aPYWBftOI46H9Bgrs5fuOfrGEVoGHj/V7
	bmkjXDQ==
X-Google-Smtp-Source: AGHT+IGv5tmZ+8WWr7aknF5n2SPKyiCdAg2Ml4Evr4pOKELFUjiTVZqg6lMPEe9BL0AMq+j7UxxRH1xsGX9z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a05:690c:720a:b0:6d3:b0a4:aaa6 with SMTP
 id 00721157ae682-6dbcc584e19mr119747b3.6.1726165681173; Thu, 12 Sep 2024
 11:28:01 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:27:57 -0700
Message-Id: <20240912182757.762369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v1] perf vdso: Missed put on 32-bit dsos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the dso type doesn't match then NULL is returned but the dso should
be put first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/vdso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 1b6f8f6db7aa..c12f5d8c4bf6 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -308,8 +308,10 @@ static struct dso *machine__find_vdso(struct machine *machine,
 		if (!dso) {
 			dso = dsos__find(&machine->dsos, DSO__NAME_VDSO,
 					 true);
-			if (dso && dso_type != dso__type(dso, machine))
+			if (dso && dso_type != dso__type(dso, machine)) {
+				dso__put(dso);
 				dso = NULL;
+			}
 		}
 		break;
 	case DSO__TYPE_X32BIT:
-- 
2.46.0.662.g92d0881bb0-goog

