Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F071EC6
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143019; cv=none; b=szkThgbPYumrrENuRqqojtJXT8nKIO6rQtV3Zb3PJmoibNDJJopWV7V0txRlZp60xqXOw+1ATkW8Y7A5GOeX/sMizALOHIiXJ4yjwFII3d3E8Okya+wFeNdpQPsAwipM3egkFVmwAPOoSoRg5MW8RmpXlfMns7ZEQQpUSvBlbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143019; c=relaxed/simple;
	bh=r7EPMWXB50WRmPs6Ybs2X/h0mr+Q2k6sSSuIvq/Jh3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RQDGBEwbfBmlaH0yuIhBS1NGwRLMZb+96gtyg+JtRbHBPfRKruG2oNqr08rA789U0TkVGRgBfk6V7sroiYK/4SQwM+1h3j1P/bBPXsWPvX/vy6DCI8LYD5VDUTtn5M0FcxbWueRl/oUwo2P0XAT4y5smnpLdhMOnchYHPqHhN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOIIRose; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOIIRose"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so60183276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143017; x=1709747817; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=gOIIRoseZ9iFqQkJgw3gbBC+pEyaJolPUbWsbPn1fGSfVKntWGgt36vMMRkzagGmJ+
         XPL4s/PmMcFZuSYWSHiqAh3IpgsTfmQNLQSI4SJZpDAzcETjBmS63BwrREzrb6yMTNxs
         wDxD+9NzQ9JfD5oJS5/M52BWA0cER5eFV9ujocNAplkqRAV0Z6ujCyT7yzVL2TPfYqSL
         oo6MkJDLUqcSzQ0xGs6ccfE293FzMotpkMp2fjI79sBC4E30RX3Qk8WFFmDmbHQ/SDXP
         W4xcJceBd+fPom6ew32rmJOEnmrTgjw3TkHgEyAuPS8w5Cr+YlF4HBDDbrIezuDIEjRZ
         aaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143017; x=1709747817;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=SreZ6b7t1ZlxFQP7QJY5WZBau+N2fnQ//GsFtk/fB92VmvE0nfxQa+OOMaY6NlQsi1
         mN460EgAPm8smdqET0PhIJRf8iTlWOfz5Nr3ZKf07W5nsN8TNxcxn7ji6O4mL20rJljT
         D6I3cC/Rbog493bqOM21eybSuuvIMp5zz7zaLAzt8ggkQgIZnx3UMFLb9u2zt5TLWG2Q
         PirFNiKH3zyKflmb1aQlRm6FjunGrfjaV0LsRs/G6DGV3WrHqLGyuNfj4ZyXCyZG5jo1
         yCILGm+omtRIGflbvrcxnEAJYE1NfKqexrT72GQdsx0wpl9ojubWaF1TsQlg3L+dJQrh
         oeYA==
X-Forwarded-Encrypted: i=1; AJvYcCX4k5bYNCZkPNAis/KwP8Ej++lDkMfdC8cWnSwVvbqTEQjFaIljJ/GnHePYsNdR80f3KnR1pLDklmiPjeJ7D+/JjC/vLHsEYSj8qZ3B94LszA==
X-Gm-Message-State: AOJu0YxM/juCEU3SHiiRtAH4A4IgGOtvJTmq8Zzlocv/nsV5gNvpagk1
	BWrXXgxWKJ/rgP3rqO9Ug6vsCycpiBS49Lp9HLkNqETmGJiPSCuXfyz+6ARGZFeIKqU1fie0swY
	ACw7obg==
X-Google-Smtp-Source: AGHT+IFi5/bHZk8zQrEmsbF1iNnT4griY5Io+IhoeVk0Thq+2P/tyJLwO2I2phQSqvao27m8GG/ct5VasmaE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dbe:387d:a8ef with SMTP
 id w4-20020a056902100400b00dbe387da8efmr155ybt.1.1709143017469; Wed, 28 Feb
 2024 09:56:57 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:14 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 65ab03ce5064..55205a260a16 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -468,7 +468,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

