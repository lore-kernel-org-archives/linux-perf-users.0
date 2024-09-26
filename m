Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548121D5AAB
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372470; cv=none; b=RS7VyQsYhf6mZehhgoOV9I0f3f+hKyDiethsvnYsJsKMgeT1ioB9gu973zzs4HYsilbdTNHsJhOB6Yi+ZAJAduEeuZ4sC0EGRABl9/vjT0AQlcdOMtG6HOHXOhSip9eLIOLbWLbDtapGp46J+2lFY3JOzAYz1PVJsub0g7EzRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372470; c=relaxed/simple;
	bh=xYTvT/X6H/Jy/9lhvkNHbs0MU+Ds+5Fj0tHuRvF0PbA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ro8PcybZQ2lLlYlLNZknrbKd6qAIfnI9BUmmM7EgACW/DzetPZDSDPW422IB5nEAH0iS5IbqcJjcQVHaI62IJpQaJzU8ngNl/z1Q94m9/xLpUX5AbisWiIkbZShfj5GQgKuRAvjRebB6735wp7n6WlW1TsX/EDL6MEyRGetGbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOWx3pwC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOWx3pwC"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e21d0bfba7so24295697b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372468; x=1727977268; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GyH3SO1mNYuRldKvYuRf0v70ujcGsRvXTczGrayvKgE=;
        b=sOWx3pwCygy2my5NeBNTX9K9dPoYT3OSL4Y8b8w2YIij63xSFH3ro3xWm6d3KmQTNO
         8xv8/Jh9hANZy32Qq0P+RclCta9+63+sN5qwDsRuGfvNtcJLCu+AqNfqBqM4ebWO7+/O
         Q5FrGbnubjtw4h/PQDYV81+slEvrOtRfgGbpOrVGDOMJK2rF2WPfY4baYlAPvuwiV/g6
         LO7d3rFEjzUa/GH+aBlOgfeL2WVDxFETCfnhz15C5RtTYA/zMMTss0I6aD7kSxhW3rfd
         v59gJDaRM/ZWlk7hEFduC+T+jf1Av7SC532FMUUBYotMB6vqrCjJb54uekHbP+WdocSU
         OF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372468; x=1727977268;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyH3SO1mNYuRldKvYuRf0v70ujcGsRvXTczGrayvKgE=;
        b=r2CpAfIeOzQvS6gy54/+59fRl3ggxuzATZmO5bECw36YoEs+8GZmVAqEHbVAFNLVFH
         KohA4YcZ1js9JxAtv3NwdbJL7yX1Q6YrmCvtfYE6esHc0rrOIBAq3EjNOKPDKbqxo1NQ
         hJ/OYye+WIEQy4ImcUXY3j3FMkeoVHY3HZHtYowVjm3J2lx6VF6y+tG2SzHfnoYHJJ2k
         uPphbnfJK5TJLHWhXz0s4xiyBTIhvnDxlhZYN/9Qa54qdzS32yc7LA4m8V6bkKYi8fMH
         9Hgnlb6EH4+lYa0XYG+0YCS3DjR8Rjokbl0TB3EO4wCbXiLPzeJ9D6vqtZl0j3Dw5dBM
         Pu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFNGzJ+0SqfKV+fIlLB+VQY6fGIjq4NtRPP+H2E/nJWafqkiOG5UNjLCZN5x6CNXIP+NtO8UfOjqmjA1nmjrkX@vger.kernel.org
X-Gm-Message-State: AOJu0YyfT8eJr2HnbG1ldjzgK/Nx6MqZAYZHXSRSnV/D36fEH5CxfnSB
	S8z3Q9NN+9kj4X7QO3c2FLi1X8CVboQFxCGzyHtGs075rluQRcCb5QVP0ZiCngcYf5oKTyFTIla
	uonj/6Q==
X-Google-Smtp-Source: AGHT+IFtUX3Z97jE1thwb87+PLNbrw+/Ef5tJnpoOZBB123Lkucq8zRkpEkpb7eMlOOwF7DwYXFl8Cj4AYLM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:5249:b0:6dd:bc07:2850 with SMTP
 id 00721157ae682-6e247600427mr11327b3.6.1727372468208; Thu, 26 Sep 2024
 10:41:08 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:49 -0700
Message-Id: <20240926174101.406874-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 00/12] Python generated AMD Zen metrics
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

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.com/

v4. Rebase.
v3. Some minor code cleanup changes.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.

Ian Rogers (12):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD

 tools/perf/pmu-events/amd_metrics.py | 630 ++++++++++++++++++++++++++-
 1 file changed, 627 insertions(+), 3 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog

