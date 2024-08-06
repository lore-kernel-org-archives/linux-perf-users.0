Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8116EBF4
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722915849; cv=none; b=VH2CXYDVqKcaYKNQJ+9YD9uzYilDiQdQ3HooFFxNt2PpQ20hdnbC3IOvZjmsRIfH8TYqnw7c1zs7sm9j9dyZb7Ab6trypJY5Qm7ypbr5Gc67GMvJP0cJessi/0fxfhUfVJ4hWAORBOuq6PHSU+z/+ozgDFB4kFFUTRorUoP3I1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722915849; c=relaxed/simple;
	bh=9w8ncq3RRlP4l5j0Y3KPln+B5xci5rtypVVSJcn36hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZSaHQ8CSlr8Mtk1TYB7n5fJMvTuELn+4Pdf2KxfJpI+nPVbplBELgD4VKFnYMJS0gVpsoLfa4mpiarDj5tmXOVGk1XtKUf/7Tpabqph3XsUUhaJdGyS7MfsDcg0KWzbR/TQ2m1EIZ09b4tLcT54rBlNIwZcMXBPEbfPuNKPqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T2i2g83E; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T2i2g83E"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so129094b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 20:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722915847; x=1723520647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRM9FZSh16rbfz7ihxtx8ZJYPVBYiimSpzVKxSu/NJA=;
        b=T2i2g83ELDsOeP7ZlqctGblSqCJqKBiQmzBothltGBRfqoepmL5TdX6V1h7GSfltUw
         ox9ptROzGE6RgguAIXERvvJWEp1r7xfshGn5Cccs9OL5EetroI6xvhPbTe3Q4rCO6kfa
         8k8mLO8gaVpWZnkSxtJ6XPDUiNfLvBinfYctGwQBVcRJT5Q3z8yOROZdKamnGGx9nb3+
         df4yC+VqoEO4A5L3QbQzH7wGbTOvwNS5ZRRzIILo0BU0R9Wt02Gepo8CzbgDN84hq4EJ
         TXfYmHWlGfGrRancZZkBwmm0ybANBL5vyhOcQczTCVKGfd3HXMTfzxOfr2BiKlF5wBuo
         UIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722915847; x=1723520647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRM9FZSh16rbfz7ihxtx8ZJYPVBYiimSpzVKxSu/NJA=;
        b=fTNUm4he7iH29weUApMJFweZFCOmc01eLT01CApkAPbf4+i7DbT/bIano8xskyRQQK
         aWVxUcyScNn4NggNJPPBffC3tcX0IsA5+L89BO+EwKgcxJbkijvfWpOhvzUSenuoPHMG
         Hzvt3bjucPYNvv+2zxrwkzsvWmrwR0obqDPYjPb5c+FkVjvrXCwcm0r1JlYForpEMi0X
         2+MZdpLwANfOwpF1vgFadE2i/hBbOkz8MYjABVlPxoCGUBPM7En4LcnmOMsCbcrW+acb
         aahYVTCIk6CXqucOwPO0uENg9AkzOYmc01+zak8DlJ20oICQpS9dGMVtZ9n46Qat1B75
         +qRQ==
X-Forwarded-Encrypted: i=1; AJvYcCViDGTioa4ZJ5s6da+F/RT+Z5BnPtFE8b2EHVzfn9X+3BI7U5syefBGh+mvRq8kVnqrKCbYHGsB5DSVdrEpMpu8kY/90D3mAxGtzXMFhRzWAQ==
X-Gm-Message-State: AOJu0YzXATJ70Tcysa3UfR9dq3tiPWmSWxZHib4QgPbo7uxJpu62QX/Y
	RPVVSXnsGSARublmDlj9ewS4HELOBRfIIi3c0bVgbG7p8xHAuGt/qFBqclcueJs=
X-Google-Smtp-Source: AGHT+IEt+NsWrhDZvNKh+KL5PXQ/tZukt6UMHbZ2/1vsVJU8L/SGBi/xds/Pna+3NasWdgtfRP3gWQ==
X-Received: by 2002:a05:6a20:1592:b0:1c6:a825:8ba4 with SMTP id adf61e73a8af0-1c6a8258d8emr10547856637.41.1722915846608;
        Mon, 05 Aug 2024 20:44:06 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f21718sm76723415ad.59.2024.08.05.20.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 20:44:05 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time
Date: Tue,  6 Aug 2024 11:43:57 +0800
Message-Id: <20240806034357.1340216-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If sched_in event for current task is not recorded, sched_in timestamp
will be set to end_time of time window interest, causing an error in
timestamp show. In this case, we choose to ignore this event.

Test scenario:
  perf[1229608] does not record the first sched_in event, run time and sch delay are both 0

  # perf sched timehist
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
   2090450.763231 [0000]  perf[1229608]                       0.000      0.000      0.000
   2090450.763235 [0000]  migration/0[15]                     0.000      0.001      0.003
   2090450.763263 [0001]  perf[1229608]                       0.000      0.000      0.000
   2090450.763268 [0001]  migration/1[21]                     0.000      0.001      0.004
   2090450.763302 [0002]  perf[1229608]                       0.000      0.000      0.000
   2090450.763309 [0002]  migration/2[27]                     0.000      0.001      0.007
   2090450.763338 [0003]  perf[1229608]                       0.000      0.000      0.000
   2090450.763343 [0003]  migration/3[33]                     0.000      0.001      0.004

Before:
  arbitrarily specify a time window of interest, timestamp will be set to an incorrect value

  # perf sched timehist --time 100,200
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
       200.000000 [0000]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0001]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0002]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0003]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0004]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0005]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0006]  perf[1229608]                       0.000      0.000      0.000
       200.000000 [0007]  perf[1229608]                       0.000      0.000      0.000

 After:

  # perf sched timehist --time 100,200
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------

Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..92b1113b22ad 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2683,9 +2683,12 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	 * - previous sched event is out of window - we are done
 	 * - sample time is beyond window user cares about - reset it
 	 *   to close out stats for time window interest
+	 * - If tprev is 0, that is, sched_in event for current task is
+	 *   not recorded, cannot determine whether sched_in event is
+	 *   within time window interest - ignore it
 	 */
 	if (ptime->end) {
-		if (tprev > ptime->end)
+		if (!tprev || (tprev && tprev > ptime->end))
 			goto out;
 
 		if (t > ptime->end)
-- 
2.25.1

