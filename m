Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533A18C90A
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367072; cv=none; b=MSk0yOnu9sRywsfIsnIVu4y3A14LT/2F1wo0rCbieHeWeitcBXMC0y0+zsNZMhzLd6XnQIi3Fb+DxQ/lWahsPzxo4+H3fZUKLldshOoZIHbK/tvnsLI+PBYgg9pyHOZOraZziDGtceEdKtX3ka734VdiOP2vsvWJNwIQ3D32Fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367072; c=relaxed/simple;
	bh=QZOrbrVSFvz40nx9vDHmvHb3Af1cw8vhwpVnG+d/kxE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AOYnr9W9NMRrW3ePLRIdxks+XO6AF9AFAAvLusLurSwmpluAbmbR6MPZd9pjOr+UXayF1URcRfzQQuEL6/YEPY2ZIKObqaNi+J14MfqUrch06QLg3z1ylLrcTgknRfwkqY+Gu2LHCmcQiB9miqaJS69O2nG5n29taqDFtEurKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzWqJxxg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzWqJxxg"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0babce6718so1179063276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722367070; x=1722971870; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPOVxn1MOz4Po+ahQmLNc9pZpMQMX4IsBrGFVJB/LRE=;
        b=YzWqJxxgRFxdxXg3Lmmj3IxwAPoQ7Mi64HcRupHOb99I+XND+2tAsuOCabiEEqn2QE
         Trp5wOfFo/hfjr01//30VXLy1bXFv058lwZy0cPPUWSOLJZRCufEONBkHcU23scOgV9k
         DwDBohP2WWCP//lS6z6BaM0ozeRbx59SSmkaiIZLOb+aqeEKLY10aR8m2YFw9Xehfkv3
         WPZAWMNgGkwkraL7V7ZOrpHtjj8HoIjMbgNm39O9wvpbxQE13uXVCNwtDF1AT40It86x
         y4wYiP1AkjgNHEgl1EkdJBZ4KBG9JhjeFgZeUUI73FmSp3DGXrQKYe9rGhmA28HWukxH
         nF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367070; x=1722971870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPOVxn1MOz4Po+ahQmLNc9pZpMQMX4IsBrGFVJB/LRE=;
        b=uMUm1j/9CDoko/skP2VbOTqDOi0bKn98ongcvWqRHGaAKivzOnYlPQBdqZSTSazoJb
         1buKlLHfL7PqYMIQ/tAWBLnT523l30X0aGkbqvSCoI6wjlwJSmuYP3niESbIhDzXUZ1K
         waAcJYOSIKHdfKZFy7225fZcsiHCmOzZL+1xk6CbgaipkRDCH53Spl2eXeSOBpB74jpO
         FcXET+JckRLEbj4n77eMNBA++BnFYxWdcjZ6BBeWMlKi2L/dyY7uT79I51ZM+fZXgFzE
         3hHXdNnbRqMlitZpuW/sgpuuwRwiqPo2paW4BZZzvB1xPokNXqu3rr4guE3sAzxPtWda
         M/zw==
X-Forwarded-Encrypted: i=1; AJvYcCUV3zLBCfbnmBQwdn+pxHz+zErSvm8G5dbNgh6ZKTEazGv0pw1H6DCVukNpYIWkdRhmVtnUnlTr7fzHpFsI7BWyThb/8BHckMJr9uGziUlZqQ==
X-Gm-Message-State: AOJu0YyaQBcRG0OOt3WGsrHcxC6Zbu1PY8MZM1E9TLC9KVaGIQ5X1wUw
	s59L4FQr2ZTKBcpexLK/7z3Rf4Q5g6qEba0aWDojjm6Irqjr06aPN8udjriEWUO+hdIoAcKQVKq
	wPl06jQ==
X-Google-Smtp-Source: AGHT+IE5r3aHVdMBwAXY58Lu8fOyOfcpigXAVj2XKFlPB3GWt+T338Emu07Q9s4GHku0J9t9skoC6tDz/JFV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b07a:93d0:1b64:3771])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c1:b0:e05:6026:f741 with SMTP
 id 3f1490d57ef6-e0b5442a26bmr802456276.2.1722367070046; Tue, 30 Jul 2024
 12:17:50 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:17:43 -0700
In-Reply-To: <20240730191744.3097329-1-irogers@google.com>
Message-Id: <20240730191744.3097329-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v3 1/2] perf jevents: Use name for special find value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

-1000 was used as a special value added in Commit 3d5045492ab2 ("perf
pmu-events: Add pmu_events_table__find_event()") to show that 1 table
lacked a PMU/event but that didn't terminate the search in other
tables. Add a new constant PMU_EVENTS__NOT_FOUND for this value and
use it.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/pmu-events/jevents.py   | 6 +++---
 tools/perf/pmu-events/pmu-events.h | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index ac9b7ca41856..731776e29f47 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -906,7 +906,7 @@ static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table
   do_call:
                 return fn ? fn(&pe, table, data) : 0;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
@@ -944,10 +944,10 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                         continue;
 
                 ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
-                if (ret != -1000)
+                if (ret != PMU_EVENTS__NOT_FOUND)
                         return ret;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 size_t pmu_events_table__num_events(const struct pmu_events_table *table,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index f5aa96f1685c..5435ad92180c 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -70,6 +70,8 @@ struct pmu_metric {
 struct pmu_events_table;
 struct pmu_metrics_table;
 
+#define PMU_EVENTS__NOT_FOUND -1000
+
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_events_table *table,
 				 void *data);
@@ -82,6 +84,13 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
+/*
+ * Search for table and entry matching with pmu__name_match. Each matching event
+ * has fn called on it. 0 implies to success/continue the search while non-zero
+ * means to terminate. The special value PMU_EVENTS__NOT_FOUND is used to
+ * indicate no event was found in one of the tables which doesn't terminate the
+ * search of all tables.
+ */
 int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  struct perf_pmu *pmu,
                                  const char *name,
-- 
2.46.0.rc2.264.g509ed76dc8-goog

