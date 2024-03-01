Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97639AF6
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318991; cv=none; b=n9oOnRt/LbxxOHSXJbYF7lQlyoD0eo5qh0XjqrCjcyjzljmfYC8aOi7PMaGsYSKlUXsGL7MzGHUjnUDfX9Hbjv/3ealnJ8HTp8QhzBHdcYAx3vp5BPIce2oZUqobO5Q7f4jpK2t6hQ8eG1445Vi0fSPx9rBAwr8Wkwm35aPXLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318991; c=relaxed/simple;
	bh=DurBK1+YzS4Zj55zfkReuvuRCa8IKOApghKnxhwShZA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Ce2zi5lYqFqw68+wCy6iepW7nqcTgnQGnM6ghtuUEPEZq5zTwBctP5667/PIXURA8wgju+wm2UW3o3zZu8gOZSOsWKVWP+lszOdjml+ff5M1Z9d5JspUcoYYcgBEysz6XiBFESBXaTGU/0jiv6jHDPRhx93iC1hadGjZ8TAEbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKcde1lI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKcde1lI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so23217127b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318989; x=1709923789; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EffxSucwmFeFSroxX0cVPKZy2COrl7eRkJx5fhGIBBQ=;
        b=TKcde1lIxRCZMipvDg/6KQHbHGuUGBBMDSBq9yMeNUw+/lKPNPHff5ij6xKdpoSL8T
         /MlJJBOLsu2QHfTInOcq/dPPRrssMaS/RZKvVpxAh8XDdcP7hmIOKDf5HvSI4SrsJv17
         2XNp8uv6zC1W/166EzU7w9HlaLsjUB3wKZ+fO8GDNVOB2BztUkJ+QQ8pu3ya80QHx6UE
         oGDgEGl+X1kQWIejkp7einb3w4its/LDmLYOJ9P/vfl+pENzZx6JcFTbUqygaHaSN2tm
         URE3Xm/14RFp0jg+Oxw5ZNBTEoH/XUbt2YGbqlhB3YajpFo19ETZLDW5LSw1i1190bHV
         O8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318989; x=1709923789;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EffxSucwmFeFSroxX0cVPKZy2COrl7eRkJx5fhGIBBQ=;
        b=Y8ccitL8rx2Rr6MVPtpgoW6CAK11dKNJmzQwQmf5O5Y2TORov9OYhdfvOZ+aUTMDpx
         Fba9is3qxczHpP0WJq5wavIwA1dD2nNzQ+T9uc+Smkbq4u/HLt5Nlw+NjH0GDwHfLk2H
         fQBnhoMRxxTnP2wKE5wCmMeOTHPurXSQfQ6s3Pr5WA5ueJqpgs6V1atSPkkKw6frt6f3
         50YcBIW1/65jddw8k0HBJ/qu+Tpe+cyiQR82qtv47dE9l4+swSckaisinLauOice1xRZ
         UBQguupp0ivGpp7bxKnpG7HcFrpsmaibSIF1MrTyOnLJumRzjcHjaJpQv5xd2GW5FbZK
         OPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+NpXhjBoay6uMk0NW3WvKCG0MiixlQ2a6vTX80DSVPfwcgfdfRxmVVeySe9vJNwasdIe4CZBCMCBycYAP3Z6BnVeV3Kwkv7SMOZ7ues9Fg==
X-Gm-Message-State: AOJu0YwLiSyNU85plJzuqsrHzh0Wn+PJTUqAxNjfU2T4kQdykxv5ix3m
	T4hZgrOnDY0OhgBcIKCjvxcmE5A79qnJLdGXPu/Hh2xU8w9vAyvk5Fl5Ew89cbSmCfod3h7p8D/
	+mLPx8Q==
X-Google-Smtp-Source: AGHT+IG+5g8L392uULpkuQ3D6bCz32HeLySFoJXFk9I1Ege/v98P6B1H/rNggAiP0Q+lHbtAlhnVZcLWRCYo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:7e13:0:b0:609:82e7:c0b with SMTP id
 o19-20020a817e13000000b0060982e70c0bmr525151ywn.3.1709318989208; Fri, 01 Mar
 2024 10:49:49 -0800 (PST)
Date: Fri,  1 Mar 2024 10:49:40 -0800
Message-Id: <20240301184942.2660478-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 0/2] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.

Ian Rogers (2):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel

 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 147 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 4 files changed, 167 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog

