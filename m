Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F191350F4
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111250; cv=none; b=K6xFEyn1xXp+MbJaQlfaZq79tJxIQ6an7Xybe+7Ir+dHJXUiVqlpkCIYrWV1mArgzpPtyIaJwOcFLP1xekgAyTemZgZA12pIO1gKNHd8uG1CH01YaD0vnWVjRwX6sPuvApT9pZQftx0TRaizw8ZXt/aWFQdcwvyQ8+sXwR08qiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111250; c=relaxed/simple;
	bh=hzaxoakXROKnRJ1C4f1sq6rI3UoGJj8IleqSmH8R1vE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=qSZUFx3XXvtmEdConTyZEgSanng3YV8L6t0HfkdjX4eEvDw/w2K3Lcfaz+FvvRfps/tDZmdWb4sV9u+/LRPcUiBIC4KlA+y3xQ7j9W51FQCj9Nj44dqkJ3ss/XhwnrpAJbB9hDVv/bExnzD3bAEiM81CAE1kp1qJB6LJG3hwEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAYd1qKQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAYd1qKQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607fbfc2584so16056347b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 11:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708111248; x=1708716048; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=meszDWVr+WK9vZcLqk0e2fu64K4eX/Xq5d5kxnUSTVw=;
        b=YAYd1qKQmi3b7OIzroA6kRwD+8y3mztD5alVgQredwbg5Az5UIRQUXbsTOeILyE9zq
         eySGpcKb2XSUEE1ME1/YpgxnfqahhFk8b/Sg2sv3St6a6wd3qOO0gSqgJJzKzxPA/9eB
         C81p4DX+SREo9hsQFpuWV+GwETBcc8d0zxY3B73Featt7pcEaZeK6Nw8FUFvfX9lSq2l
         JJT5siq9qBbXDP9DCaLXWTww2cQ/OXkb16RRgCQZBCKFbvLEGo/0xixb9SpP3y7oadDT
         Dggdhs080S5qCskISolpYDbMoI2Aq6VafewYK0LjfEsv3lPtbGKlOZJ2MMmYbVOBfmsR
         yFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111248; x=1708716048;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meszDWVr+WK9vZcLqk0e2fu64K4eX/Xq5d5kxnUSTVw=;
        b=sxKKrlH9onHRz3D6c8/Hzs1hj9Fq9S2QhBET/z4eP+vCPTpMu+pzR9xVScH6VG5R6j
         c5lFXaxhptgtE7DsR9VCx63siPE8yj0uWlZ+hGokutIcww8UmUstUKkUnbO+xbSJNLqe
         MDIjwXLey03e04bsLvjtyFMDzLYFetFLAIvROs2ggXFETQio0Xa5EUGZjTZbMNljc9LY
         epftYdk6R0M9xey9qaOBAQN1DotGpmfahEshTo/hWYfW78FYKF5XTeoUu2Lw0SjCOcUV
         4rekldO/qJfrLACgzFHVR/HBnBrQIFyYPqgHAq9r2m1jMCmQC8LPVBhFt8lviGOwHDsP
         mLNg==
X-Forwarded-Encrypted: i=1; AJvYcCVrrP5JqqCgzqJD06pmxUdjlLc90Khkafbw+y0qbDQY6JjbTb+jJZw023x7ghQXnxuXI/fRbBV6lRLzJkSiII4Ajl0XMimvVGVAGD4Is+S//g==
X-Gm-Message-State: AOJu0YzKZd+snJuv6ow6Vmi1RaJzRAX0WjyWufz6YVGyyrj75y0FS9WX
	c9BBxoZyhbhdtkfL9sfprEL36cXK1Mctce/Adq1XIYPPfw6VOUpDIJAGw4bUu32cYam0SyTrlVN
	CjCiFkA==
X-Google-Smtp-Source: AGHT+IFd5YfFbZwtV7cT/VlHdN9K2fe2lBmafMny/iGIIW5e9gwseuiwlWljLcHbG6jW1vGdn0ybSSOZRMfV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a0d:cc4a:0:b0:5ff:4789:a406 with SMTP id
 o71-20020a0dcc4a000000b005ff4789a406mr1224133ywd.1.1708111248392; Fri, 16 Feb
 2024 11:20:48 -0800 (PST)
Date: Fri, 16 Feb 2024 11:20:44 -0800
Message-Id: <20240216192044.119897-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v2] perf list: For metricgroup only list include description
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If perf list is invoked with 'metricgroups' include the description
unless it is invoked with flags to exclude it. Make the description of
metricgroup dumping dependent on the desc flag in print_state as with
metrics.

Before:
```
$ perf list metricgroups
List of pre-defined events (to be used in -e or -M):

Metric Groups:

Backend
Bad
BadSpec
...
```

After:
```
$ perf list metricgroups
List of pre-defined events (to be used in -e or -M):

Metric Groups:

Backend [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
Bad [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
BadSpec
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2 rebases on top of perf-tools-next patch:
79bacb6ad73c perf list: Add output file option
https://lore.kernel.org/r/20240124043015.1388867-3-irogers@google.com
---
 tools/perf/builtin-list.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e27a1b1288c2..02bf608d585e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -208,17 +208,24 @@ static void default_print_metric(void *ps,
 	if (!print_state->last_metricgroups ||
 	    strcmp(print_state->last_metricgroups, group ?: "")) {
 		if (group && print_state->metricgroups) {
-			if (print_state->name_only)
+			if (print_state->name_only) {
 				fprintf(fp, "%s ", group);
-			else if (print_state->metrics) {
-				const char *gdesc = describe_metricgroup(group);
+			} else {
+				const char *gdesc = print_state->desc
+					? describe_metricgroup(group)
+					: NULL;
+				const char *print_colon = "";
+
+				if (print_state->metrics) {
+					print_colon = ":";
+					fputc('\n', fp);
+				}
 
 				if (gdesc)
-					fprintf(fp, "\n%s: [%s]\n", group, gdesc);
+					fprintf(fp, "%s%s [%s]\n", group, print_colon, gdesc);
 				else
-					fprintf(fp, "\n%s:\n", group);
-			} else
-				fprintf(fp, "%s\n", group);
+					fprintf(fp, "%s%s\n", group, print_colon);
+			}
 		}
 		zfree(&print_state->last_metricgroups);
 		print_state->last_metricgroups = strdup(group ?: "");
-- 
2.44.0.rc0.258.g7320e95886-goog

