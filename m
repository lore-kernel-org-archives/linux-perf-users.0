Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551F47F4D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484632; cv=none; b=vFhv498a8N1URuYOtA9KhJQV4AFydbqBdlQdcXKCXJxF9r5T8dS/0hakbKduL/dIlkRIiE8ebKazcovZSjKKl88p6pbF87Et1ZT9fYPCvjMR90cak71ZdXvItPVi8srPx2ZRjbtGcxP5Eesc+S0152bf+TCDC3SdyMHx3vvy7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484632; c=relaxed/simple;
	bh=sw6PdzoA8edJ/FZwSBA7Pp00GqIZLs5I64ITVdroShU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=VR/Dty/4QYcZW0sg5AWLp3b1sxobWTsdhFt7EtRZ1/CimHW2KdKQgZY2HGW1DTlMf5DdfCMsXApbGkFR0cUL7tiHM/80qeSlypBcZU1BU40aseixU/VPLuvJJEdUeoXj4kqOmv3tJ0d7u0MhkiDwPvUBiCqYC+nsKwjHbnxmi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuwR+h6U; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuwR+h6U"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so235130276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725484629; x=1726089429; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LSKRbPPROI10402FVcupQQc44qQEukdAyMkZrVit+8=;
        b=WuwR+h6UOjy4ibITszibmBDYPCw5SFwKMM/lArzZ0IP1idOd2zldIieDzP2TmLyICZ
         s3V3+vTdU9P2btdO8CMJOgWOawQxHulXrysjylFDxmLE+IerBOSEKl1+NkPuuDLtZlVj
         bYE9aMcOmqeKgSfpfF0QS4MYeleI+r0x4FUtNMGt3vwspZoTEHMKj9m+sPNdERmb6yVG
         dVB0sJed7YPwviVS2ILj+DniDk3/tl8TzqXtHhtDBQKkOnH7x2Xo33yWU7jdGYGGMp+T
         wrO5rbPFHs9vAKsIVqM1IOtn/20ihxpgOlOPjzexdk9gZLbE8hwtMyOeVYDqiXnxjODL
         EyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484629; x=1726089429;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LSKRbPPROI10402FVcupQQc44qQEukdAyMkZrVit+8=;
        b=kvs74Gn8C80sp53G3eLQZiu0Klx1onbn3Rt6prBJFkCACJ5gXUjN5aLW7HvIh4OUxE
         RiAoK3D+SahTxQDPPyCkrvmiiKDwNPQ2cKXKBU/g99SatHB5bhJzzF2zYp9NmD7GFI+8
         WUoyc4y1+wtFyIkHoH+V7yLtMB9bweF2uII/brpbK+ua0G4ZkGyJsuWsBKofCVc5bbb7
         oVGl36FrySYLPyPvXef6KhTFoFowICwYLtEP4omkKI47GVBYYvl3KRbAbSGLxh6k6IYv
         tFLwdcUErRf+4anA2GayFzazbVuTXONM+4qpSphnKHqLw6NXz4El+4E7FiWHSx4JLEbx
         Fm8g==
X-Forwarded-Encrypted: i=1; AJvYcCX6n5V+wfLJ21tQ2poAuyLkK9cbD7ntrn0OkMlIn98jmtBTWHRZ1J5ZCW/aEfVFaGAptEEamB5JNWiTHdF8CTIy@vger.kernel.org
X-Gm-Message-State: AOJu0YyX95yVQC7laqYeouJEfM9wxd7fTVtPBUnWkvvqXHImKHH4nybM
	AawrFUpZJQJCfhyF+zWZdPj+0jjxGEIHXKNH7zxOkUbv4wzCwBH1bWXk8UofdwMX+kcaFjXODFT
	iHHLzIg==
X-Google-Smtp-Source: AGHT+IHxXsCmjr7nDR1gzVFUSR2MHv1sTzvy8MqpSzwxQxFynLR5CENdqoAxYET2l9qFkp3t+ejq+4o15sJZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:11b1:b0fe:e30b:a492])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d5:b0:e05:fb86:1909 with SMTP
 id 3f1490d57ef6-e1a7a1a339bmr2362826276.6.1725484629231; Wed, 04 Sep 2024
 14:17:09 -0700 (PDT)
Date: Wed,  4 Sep 2024 14:17:05 -0700
Message-Id: <20240904211705.915101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1] perf jevents: Ignore sys when determining a model directory
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Existing sys directories aren't placed under a model directory like
skylake. Placing a sys directory there causes the `is_leaf_dir` test
to fail and consequently no events or metrics are generated for the
model. Ignore sys directories in this case and update the comments to
reflect why.

This change has no affect, but when testing with a sys directory for a
model people have reported running into the no event/metric issue.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 1d96b2204e52..bb0a5d92df4a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -635,14 +635,17 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
-  def is_leaf_dir(path: str) -> bool:
+  def is_leaf_dir_ignoring_sys(path: str) -> bool:
     for item in os.scandir(path):
-      if item.is_dir():
+      if item.is_dir() and item.name != 'sys':
         return False
     return True
 
-  # model directory, reset topic
-  if item.is_dir() and is_leaf_dir(item.path):
+  # Model directories are leaves (ignoring possible sys
+  # directories). The FTW will walk into the directory next. Flush
+  # pending events and metrics and update the table names for the new
+  # model directory.
+  if item.is_dir() and is_leaf_dir_ignoring_sys(item.path):
     print_pending_events()
     print_pending_metrics()
 
-- 
2.46.0.469.g59c65b2a67-goog

