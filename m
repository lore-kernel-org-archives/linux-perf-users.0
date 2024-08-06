Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42EAD2F
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911746; cv=none; b=kNUqgp6+oFBc2q1Bsh07//LfFdwM6pRt79hSXC6AfzAKSnX0Tl6NJr1Tu5p06LX0m9Gs8SO3dGKn+WwMM0CCTbW2Trij8yK/WcuBl/y4Uyfd+XAJPDvPWVmogNqzcngDMAho2bfHvb9Z0/FUwtj/gC2Q1YgjYVS48Z/aKIjRFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911746; c=relaxed/simple;
	bh=qIg8yzlF2xZhvsCt/8paM2r2Z8UqmNY3G8iwh67a5fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoIC9nnvd9RTwze7T28COhN96kSs30yXEcq8RcHO2H0w2FF+XMniBUDrqKHYbt1tTNY51ROFtlawc1beYjewiIvGMuOdRnrDko6Wk9w9kaNMNke7o2UCjK9YvfzOIBKTKlxYpZRqW7E3uHIQpgY1mwm/cYdBvF9Hbo95Si8ZtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TAhbkbgL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TAhbkbgL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc569440e1so2700985ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722911744; x=1723516544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCIdnG6JlOPVFpWP4R3rnPh1itu4fm9+2fAZBr1oqW8=;
        b=TAhbkbgLIiX3/riFJk39uqiAUnGfF5C6eoKKrrDvC31FjclSDdqiol0sVnlsrNsPL0
         WRjyRtvhZvuAbX7YFlKeUmhe5szOkPNPYguCJpWT9o6Qn4WABpARdvB/xmiFxPfvUwK1
         9qlXZsKQ2fkUaA/bYLgEWuJwDhavkt6c2ROXc3I/VIQWCzzrP8zJ9J+IYDTTEym8VKFb
         UGFxvnpjeTA4c6l4hxMUBCdfqXdLIafNeu1a0Gsbq9+tuhirDbI8Xnom5BwdUQE40fUy
         HpjiYpOZzq4BHpsZNw74x43+Dz4AJPLhiQwJ3awD4MWKDGf0QmR7d5g0HKsTT2wN0SEO
         kfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911744; x=1723516544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCIdnG6JlOPVFpWP4R3rnPh1itu4fm9+2fAZBr1oqW8=;
        b=sOxK42sKVf7+yhq0cBRv6WPLrXP8xl3tVdO9NJHFy9pl1U+mpbZAW2wMa1X2dSFMcD
         sT2pyg31p0HaUxTnMSmyZXg5/j3IIz5iWoWpNocByROl+vXZPLnYY14ysKxwsp5BM3gb
         JvKjOxatFvYBBJiEowrewjStxAsdD7zO6B/PH2uvll7vq7LTRcQ4YtulsRCy5ENujgS8
         VppVg1pUuOKf/gplSeF9i4+wLVxCdo5vosTBKAXwzZ40NilhyB9T9hk44eBHYNyYsKOB
         ppRBESyey12AJ5K3CDUC6rlB6vdpkRrppV/z5OGyc/T++FuykGvr8hqHGuD1WPnkjOkp
         qFgw==
X-Forwarded-Encrypted: i=1; AJvYcCWJX94WLDDuLzTj7TBeB4u/R4vdDLQI6x9HHXmwSO9rEnTV/ExYYTwA/g2Wb1LfYStrC5A4FiTNjhgfDsjAq6XW4vIP+KTdoJ9VHOqdF7lSkw==
X-Gm-Message-State: AOJu0Yzrev3W2IyTvvYWIH/qodVBLOxutdKKqHvE1jO0hWvBOPoW9JOn
	EpvDcAkCEmyymIe69xvMx1/lE4BYYgezGlWpY7B5WBgu+D5Rg5GtfJLF+8mN/Ew=
X-Google-Smtp-Source: AGHT+IFYA0lBl/EuXvwzMNA/hmZojSyuazTamcGyj/T6TSZSajcF1WFR5fLuVBhzpa8nUkWGuA4B2g==
X-Received: by 2002:a17:902:d4c2:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1ff5722debemr181766045ad.3.1722911743995;
        Mon, 05 Aug 2024 19:35:43 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59060107sm75725155ad.121.2024.08.05.19.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 19:35:43 -0700 (PDT)
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
Subject: [PATCH] perf sched timehist: Fix missing free of session in perf_sched__timehist()
Date: Tue,  6 Aug 2024 10:35:33 +0800
Message-Id: <20240806023533.1316348-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf_time__parse_str() fails in perf_sched__timehist(),
need to free session that was previously created, fix it.

Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..928b9041535d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3121,7 +3121,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	if (perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
 		pr_err("Invalid time string\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (timehist_check_attr(sched, evlist) != 0)
-- 
2.25.1

