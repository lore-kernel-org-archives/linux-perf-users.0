Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67825D208
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960351; cv=none; b=KiTzfPCeygrs3spGE6LjUF52VSXPKl7AYdJYJsAjrc+r0hQdftLmY9UmfG5YUwAtV0Ive8ast0M8BFIbu8mbxDh54UtHg1ZQai1N1cNZr5uq38E5TBKKKC7iIwnflE8d5Wiqych0PVG+1bF+FxaZTLMQJ+KsVqUfwQHIlrrOdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960351; c=relaxed/simple;
	bh=u+bva/+LfPt05RVTOBRKCLoU6rA9fPkmVSp5pxfNe4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aaKRb8+H0XqY58DlKKL60wPJ/+OAnT1qiMxg1zM8c1iryXHtPw05SWXwm5vgfwNef5Qc27o7HwPw3bdnMpb/kOfcmhx0aKJO4FT1tb3PYYXucJVUmtTd4U+IT2NI7eyhpQLDK/gimpTwjhVexcaAhIe8Bz7PoxF+A8mtOK0qK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iu5iX7Xq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu5iX7Xq"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32b58eeb874so498940a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960349; x=1757565149; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqLlT9pOYsKIiELgr3Sg7FTquyunCdkidduCA3qG0sY=;
        b=iu5iX7Xqxk9Vif0dn5Fowxaphbx0DlRWup3l1seG+M35HU4IDGrcsVx/FxGbJKtkr7
         BMyX3R35/slybeXhwPPxyM6auBlQSOB4ETMUeCbbNZmeTy+/6EFlpI0Miixo1fkP+zuM
         ffpa8zBoFW3j3DrmWBvEtmdH0CTHYwPGjJPnMuccGT+vou0MmtqNwhQil7x2NHLIXbXI
         Gptgf7ySzMBGgjFu/LnrsF3aZjq7YspRjTf4TFhvoSQpnQCgXmI04IUHobpyKS+Jr/j2
         SXZ/qjSuSSCw4BHrGkpDqB+FB+H7Oe1d6EzbsH5l2J1l+7eglvze3umdowzvklH48Nv0
         bgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960349; x=1757565149;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqLlT9pOYsKIiELgr3Sg7FTquyunCdkidduCA3qG0sY=;
        b=DNdUPLPhnZUNHhqpwotEyq4cnFgz35f0wMBQSg/tBsDca0z7Kh908bOxo7yEMWUymO
         UF97VXbifhAn00X+58kfsd8bcg8y3pTB6gut/I04s2BN5dl5At9iqeDk4aphX4EUnqOK
         DPbV+6YKTf6TZnS9wkSdUVFYQp1DmtwNZl9MMEwt0QsV4pNi/p3xQOc/BkVSDVKQcdTB
         vvDNbvmIJN4DR6XrNj2DgoNR4wHXgKMQjx6LYODNvV3dPu08J1Rv5nRwSR6s5bwIviCh
         Xnlyh3SWW0inWS//LHGc06WQKG0UHXypEsDUuD+3egElT6M6eQoB+2SLdK/C2fOkRjXR
         Z0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUGYodCtQwm9p9RoFUkl+AQItFS6rQzuY/eaL97L+hBWvo6AcQMhSgBH/oZ2jexfIm7j/tE8C5/7EnGtfJYC0eg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk97Z7BgIlaGYcN8Pvm+E+iWObE+7EVtq6xBzrx3e895Xd4F7D
	BdUvLbCv+jwz/kgF0KHT2oTewSYwWLapbUnkWn7+dg5LfT40ohZybtHPjTujnBDov4pRnLFJU14
	zstHW+Zh7Ag==
X-Google-Smtp-Source: AGHT+IGwvTXeM5FCHwvs/qwb/80EVYFAoeYn9+s/Dro0JccJkyeGUVVcrEWod7xx2CAJya7A68FcFv/+i2DT
X-Received: from pjbsq11.prod.google.com ([2002:a17:90b:530b:b0:325:220a:dd41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d81:b0:32a:34d8:33cf
 with SMTP id 98e67ed59e1d1-32a34d834d4mr6945280a91.31.1756960349273; Wed, 03
 Sep 2025 21:32:29 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:04 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-10-irogers@google.com>
Subject: [PATCH v6 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one. Ensure the
PMUs differ for hybrid systems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 69aec4661a13..7978ca7ef16c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -498,7 +498,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name and
+                                 e.pmu == x.pmu for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.51.0.338.gd7d06c2dae-goog

