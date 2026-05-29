Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6D38CFEF
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030365; cv=none; b=EDXPj3UgHd9YaJyMq/hVgRB/ZX9PbdmBusLFzOhgGfhLd5+/+p3zG3oLGSdbsXRmbb302dym3zFGtdgeIgx9dNzYEXOb/7iaROkV6eyfJ8uX1o9KXohblRT2ZUq3Z3Mgh3L4nFHZ234IZPg6poCNZ20lCimwErEYJ+BaXtN1+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030365; c=relaxed/simple;
	bh=ZjfGW2BLEx4+3DJ3APEFTnLZGJpbFO88tYQmMVyseSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jgOFeIuMOZ/oPA5G3A8wngu/M4XgjdK91JK6B6+iTFqDV4A8Fqc3YqQ+lVtBRw6NP25gWmyLXK+lT2bmPgBL5F3XGCJqRAm0EXYofOn4zAByeXXF+pk9wSM8f+epQa0G7uRmBWnAQkz6v5H7OihemDv5lgQneOnDlB6qPpN7StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5bY2gSU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5bY2gSU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4654f9bb6so149462575ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030361; x=1780635161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QkQZ7lXFFPfFGRA2F+2/7T8mCxpsBFYhdlF85Us94M=;
        b=h5bY2gSUxmEEfvDPOF+3c+zjDjTvtSbHawoB/UlPOCimgSbd2mMPJ//xk76Hvy4v9a
         KfW39FlKG/9QZxBtRqvQWbQHoP79SSSrQYptqfiyFvKbPB/ki2sTxMswporvDZhyazQA
         61BiDGqe9ZDkLUHpHuv7G3nKOfBPjslR0a6D4fSon/AHPJwzIfQradX8+YMZfSBXYLsF
         S7XfF6+YkDCDzLbkserRpD+bP2o62YkhvWNXg5dZHXMevTDPe1t5dBUVaiQDlkFtLnfM
         REni08ZGvCUcnWiss3YS1SWrFqGL+8fbqUW956MGGqOOoUPK2QNGGLVwUFz/ddMq+jEZ
         w0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030361; x=1780635161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QkQZ7lXFFPfFGRA2F+2/7T8mCxpsBFYhdlF85Us94M=;
        b=Q+5wVifb3fXcwdbdaG8Pa9EjnPuzh7+dLNDuULgQp7YSAOvMiXJAl6ibapOQ7tqofc
         IGW42XXRf9KdjjFoKxZA1zOhF4BapXZk6c4duLlCkxgJDDUxBZczEvcI6ZkA+bFYGh8s
         jcy4tib8gVxvPm88+gxC5cbYyrANnDvOj+u8aaeI5Kw5UVohfpczAXfcihAPDeownhFN
         liCQbfdRg2sI9nFTjrPsQ5PYagM17KSNVyfl56JrwfXp7++7wfYc7/iCkMH7ha/OB21l
         S4iREMPtcqsMaanTqr3URN3CQRFsj+ojMDywFmh3Wsma9Pcw2tIBiCDDya6NAO33KOpx
         PZ2w==
X-Forwarded-Encrypted: i=1; AFNElJ9P80tUEPfza9W4fNtMT/Xuntr6jF/iwefxLrNi2JllNgBuoV2d2+PBslS7RPg1rp89bh87FrM3M7fbS2jI22xK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbqSYQv12KctERxlFvwWZhjMDOJwwFcYT17RDBzv6uGv270IS
	6e3Cmq4hyy9Wq2ZkCxtLDRvXIg7hDXhwLB57aQ+pAhJVmcx4OZ/eMQwpsXvDydym547WNnHEa6n
	dc18TQI4a1A==
X-Received: from pgmr35.prod.google.com ([2002:a63:2063:0:b0:c85:735b:ca4a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a9:b0:3a2:d79c:4161
 with SMTP id adf61e73a8af0-3b411e8f37amr1437954637.47.1780030361127; Thu, 28
 May 2026 21:52:41 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:47 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-6-irogers@google.com>
Subject: [PATCH v1 05/12] perf vendor events intel: Update emeraldrapids
 events from 1.21 to 1.23
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events and metrics were published in:
https://github.com/intel/perfmon/commit/526f1bf0ad6a42d275d1bb115cd337b71c561f92

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/cache.json          | 18 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv     |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index b2f8947f6741..ff6071d7728e 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -181,6 +181,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache [This event is alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [This event is alias to L2_RQSTS.MISS]",
         "Counter": "0,1,2,3",
@@ -279,6 +288,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache [This event is alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index a52909e212b4..b6d4d37bcf99 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.02,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.21,emeraldrapids,core
+GenuineIntel-6-CF,v1.23,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.11,grandridge,core
-- 
2.54.0.823.g6e5bcc1fc9-goog

