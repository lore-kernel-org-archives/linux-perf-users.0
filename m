Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F2158A09
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372170; cv=none; b=A7GnKzKGCtStBM8LME5AmDq0BWhpxLKwHISNbtjD1EKWUpXLo4nH6NHqAZMGpL3x0nbVo6tkOEpp1EaiGsOuVt7QwYMah4Wjxu3JDem5MgAsWtp4UtKF0QpCSJ8mnEX6lWAyWPIEo/EJpmNwCqoVBOXwLdTK60i4DPeQAXM3BB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372170; c=relaxed/simple;
	bh=WC+iMj4Hkcm+FHxpM7x5FobAfj0CrGRSr9tKhj1zeMY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DXrIwpu3KF0AqQUJkc3cTYasbOOmdWlEJlPOqsUhbgaLTnEjzeQYy0h1rQ2Iw3JWRlJphj9aeXuSbtQBAo2q8S5JTthSM2vXCra3U2r3ge2+OytDKcj3UyNT0tg7JArZW4uOnPHk3JBZ0mV1WF9NcJ8CRuoEllvJgwgIVeRlP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI8TwucJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI8TwucJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e22243dso21244147b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372168; x=1727976968; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TDAxfBNX/3AJTgXvbASWXJd3dX0Wd/7tQQ/sW4xuxc=;
        b=qI8TwucJyt5MJ6Y2nnWHchLcFYhQSkWBO+f09fSstnyUrz7NPm4aKWGCUjlpN/muv+
         kdPVjQkGk44zCeIFMs4ctUoTUenauXQ4qieT+k9heJxVaB9kEC+IkMLT6EjD0zYG9UGg
         r3lYT01M7wyh3kTrd9gtebF+LNN4S/q5f/B6eB77XrTxAkExeGuas6OvSFxNypiU6vj6
         YJybWhOP6YJhuqhcnH/ppbl04WyTr7Af/Ik28Ntv051jRiLYxj9orR4sYzagQD/JMgKN
         spvAFIkjL1GuWe2h6Hk/E3hRghVStXbqBVwL9y3pmcqHs+FOd/sHG2w2uULwuLYStiCG
         uIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372168; x=1727976968;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TDAxfBNX/3AJTgXvbASWXJd3dX0Wd/7tQQ/sW4xuxc=;
        b=hYeO1Wqec7DeriUyz0IkgiQdFGVBMkuRrBKmMG0nRFd6PaMcoVMSbf/PyDMlUi6Lkp
         NSIGYeUvg8oiK+I2zEmFN3FUt5euWVYOnj5jLOO5ybKirMUMS0fVWED3+1toRseXq5AU
         F6lCFhPJPOmxqNuLozw7oNaUMpwcCjUpy7Ry00NyZT1QI9+G9Cp0ZSW6HMKcukUuwKfL
         GOFsiJpHjmWCAUyj3MJCe7rSB8a/semYSrSd1eQKf+TShpazpJDOz+INe2W73XKHIXAM
         +NbP12JzSTyU66CtTd4zaLmlzZJv+9FhP5Pb763OHhgogWTi/LshJ6IhZMguCqYxOAvf
         7kXw==
X-Forwarded-Encrypted: i=1; AJvYcCUbe78CjPfaDLNEcK+YmVCfDrj29eIwzji0+6wJAzTKU/EyHPj11BL/+C/qqh+J4y+9+gNo7OOJqaLzLaJXFuv5@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4H11SCeGUePRFWIUFj39EytGVTH2APP6JOafMCoctjA9Q7re
	H08MOKak5rLurb9e8zHQKhb8aOn640RK68WWS340tF1cvb88MiAdG+H0SlTv56WYrVkVWOWD1Wd
	zKuhE6Q==
X-Google-Smtp-Source: AGHT+IEEfgHm7cEL7JcDDsu1j/kP71CYUXSYaOtcfIXql4xfJGN8vDdY6YrZOdooF0ZlCwQi3Yhzeyqwd07X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a5b:b4f:0:b0:e22:5fcb:5e22 with SMTP id
 3f1490d57ef6-e2604b28574mr160276.3.1727372168155; Thu, 26 Sep 2024 10:36:08
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:43 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 01/12] perf jevents: Allow multiple metricgroups.json files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index bb0a5d92df4a..8d2cecb87e88 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -612,7 +612,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -665,7 +665,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.46.1.824.gd892dcdcdd-goog

