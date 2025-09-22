Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D061318120
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564542; cv=none; b=k+JKk9z0K1ub2fnpQbo0amKno3wbgfijrgTfGWPBPHzAoIzRHJ4ubzkDX5TrWDdC6GS46qcr7EHUcNn0kiAtdLEBAdeCTiFbw9qz5N7rCC8yFH3rTsXi4JYakAYuMGhhDprB2p7GYHf2npkYqwOhaRRnLdVptIfF7gctSoLhG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564542; c=relaxed/simple;
	bh=ClvKFZ/b7716ndh5rkOR1V+bcY01pXI7j9WIQX5fb6I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K4J2POJ9xbIub47/2SJPHGHaLe1LcpEjavrOgZV3h8ZG65J7tLLa+nrzE/mu+VMqchN/EULfA8geD9rXhE3N/wdMf0BL/XRcevZnARVJApsW6uTTay6EyGNVDKizZ8d2ZnbM7Wqm3ZgjL/+y55UJ+MmhrDzyzPfEQQQhySXU5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxJql1Ig; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxJql1Ig"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-278bfae33beso13013815ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758564541; x=1759169341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToEoYspZoDukL5w/NejXRw07/Byo+3irLVr2SZ9SWds=;
        b=IxJql1Ig5JyaUkC4cripVkz9kEZCY4szO/xE4hRd0ltfyIKUXbdyfXwGZFwFbdws6R
         1LGdZiTvOXpFKg47Mfk81js4OCc9O+XaMWsfsh33bsymUqy7EmZGNbwF9WMK/cpyUjUX
         9fDhsH2YNVHrIgCO7ib8wvPq+EH3qzJxWVYwkcfabtNXLiMXgZNMeAZRfhLIiAVTar7P
         TrbO+R89tcOKHvKjfEH5U2uDA7HU1cU9tJzM0tEvBO9CKvxXOtKRYopl8Al9V7YdmyXQ
         tbleZ/FrvBxnpErYMMxMDOSUeLH7eOaIDEXUH9GScijb9MWWO3Gd60lbhgDP5gVQXXes
         +xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564541; x=1759169341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToEoYspZoDukL5w/NejXRw07/Byo+3irLVr2SZ9SWds=;
        b=w9+rU9GV4LbjyKeclLAp12N+iUPhZ0mAxDRBl6NHNdMjgdGe1Yn9FjNYd2olLrIlAq
         z+rzMoxTRRFi6uIxoqDdU0NyB1F3HhBLHZpjn3fAPWHgxFzxJ5GtznTsk3f52cZ0BxAP
         JL8uE0OnqIpm2imSYW2xiAkVLxxE19+F95Lw8k6hJAun/Se6KoWIRff7RCKItUMTiuDF
         vTvakShbSBtWeenszxn34Gdlo3m55gTpPak+wtO+7ZcqgKGDq8V5tdIuyZOaTxgkgJco
         XiMokjjDKCyF6ALE6F2sSKmSvCoXD3GYbXgNPHdqcdszg/BOZCm/3VMwP6SR/DIxvD6P
         E3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqB8J+nReWC4X26uk5o8ZGyChOPnLAhH/Di5S6Y/WXTmRh7Z9e6GjlkQndsBjDzeRApsFc2Z6lHiOb+DdsXK7@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJdDUezoc9ujMKByUWfK3/sq6J4dgKIniUsMPl7VbOrWt+lPQ
	qJYuNk+t2JF1Mv5u+b4c2wIsLTM6wrtB/Ot3RMF6+BYPaRT7dgDWQ/la
X-Gm-Gg: ASbGncvQsV0zqPqNNB0pfqpCR+i1suzQZP+H7x9bY1u51VDctLFcZW5uzHKatin22mi
	e8Xm107oIVeIZQhBOd5KYEWFpXfohb1Z0AN3NFq2mF/GeIRilnu9AlQA2PUbymw/drmWsQgEdBm
	vAhJmquUx7x754QfoZoxCurHv1r7y5nu3Nlwl3UTll4HJvkKmiuoQFSTdWnDWBf93ubBBAQHCTq
	pHOug9NBh3EG51YDc5abnezpTb/VJF3Gidk4aciENWMbVJC2TC/UMrXcSS7EvwcXO6YLjL/Yumu
	3mwcyDSiXp491ToIpGNoWSrTNBV6YGVdplwPAd4sRJC2aIT+/+fk40hLQdVPwzjWLjETd1cMG4R
	iIhnrZVJOt4XyHh7kuOfjVh4TbrOnROGEBrM=
X-Google-Smtp-Source: AGHT+IFZXZ1PyVy0iEuxUGNtkFvpvoD2o14jNC4/NMrkx90+TPiBtYnuHYVnqH1dcJoEet2Vv52Bww==
X-Received: by 2002:a17:903:90c:b0:24b:164d:4e61 with SMTP id d9443c01a7336-269ba40a0d7mr185701835ad.13.1758564540683;
        Mon, 22 Sep 2025 11:09:00 -0700 (PDT)
Received: from ThinkPad-T490.. ([49.207.194.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e14f1sm136155565ad.71.2025.09.22.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:09:00 -0700 (PDT)
From: Faisal Bukhari <faisalbukhari523@gmail.com>
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
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf parse-events: Fix evsel allocation failure
Date: Mon, 22 Sep 2025 23:38:34 +0530
Message-ID: <20250922180834.1744399-1-faisalbukhari523@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If evsel__new_idx() returns NULL, the function currently jumps 
to label 'out_err'.
Here, references to `cpus` and `pmu_cpus` are dropped.
Also, resources held by evsel->name and evsel->metric_id are freed.
But if evsel__new_idx() returns NULL, 
it can lead to NULL pointer dereference.

Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
---
 tools/perf/util/parse-events.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 452f12191f6e..02e7ff94a2d2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -286,8 +286,11 @@ __add_event(struct list_head *list, int *idx,
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
-		goto out_err;
+	if (!evsel) {
+		perf_cpu_map__put(cpus);
+		perf_cpu_map__put(pmu_cpus);
+		return NULL;
+	}
 
 	if (name) {
 		evsel->name = strdup(name);
-- 
2.43.0

