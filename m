Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205472E6CA2;
	Wed,  3 Sep 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885929; cv=none; b=IH7bz7fBBnDUlelfR/1Pz5AUxFyYbbra6bYT9vfPcKcQz4J4cPFBt5GSJVj2k1p3/0PvESbHSidyZ4brn/vYPlPdbfAe5m/FzXR7rex5RnasGfMniraTFCQjqvgfHW15UCPyACBpvDCplwPfdr1XaDEub8ldACwoUahV7gdUHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885929; c=relaxed/simple;
	bh=ijv3XrZLm2/TJnChmh37riflNbEO0YahbExZZisEp2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnHqt836ExISGAIpvrPY2wvdCwmP1BJrv2FK+LasbvgHDFjzRFQB2ZmsS0beKW6r4Wz0AAE30/BWgr/7V8FweJphSdjp/6S34jCcLFBYRsbUNGCI1BMoGcySfy4soEptGGO70Ql8ZGlvc6WeSusWymZs2TuCsRIccxCihqpO+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTX4NkmG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTX4NkmG"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e97021a3695so4872283276.3;
        Wed, 03 Sep 2025 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756885927; x=1757490727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WevYTlCPqTL1WxoQFVrzF+MsCB7RWtW+mPaqKFqA5Z0=;
        b=gTX4NkmGUgeebsu6zyqtV3UC07/2YEMzS1HOc1+njJdUiEFdySHjA3/0EbIdpKCDUB
         IUM+iZ1XI+zJsXtfZQVWiNZ504/DCxDt/iuGUV/iglJZM86h0lMfHnEMN4sdSx2kh111
         ahyzK38gjaafDgC4agMJe84JysFNUDmTqhpHVcToF3YK1DuYkJ96iUatw7HkMjrlOGqT
         5kyC1zbUSrgSUpJavcw8qnRSHo9k6iD0Q4mxD/bvecphv2jj7mCvts3AhP4Ku2wq0HC2
         gQkoH/RvT2mmYy0n7UCp8pJxdE6TSAy3yjsq6CadkrPkIvKOPGHcyUc1Tau+Z91Olg0Q
         /oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885927; x=1757490727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WevYTlCPqTL1WxoQFVrzF+MsCB7RWtW+mPaqKFqA5Z0=;
        b=OuJTZp1iKNYYOiKGcqadIggchbtBZpibLnJuB5xZI447CZTeR7hEkP/iD4xO2ByYb8
         2bDsEz2SnpOIZna5rYDht1ySsiqg4vFLnZXhFwMTJUgpP4gyv8payhOOwa1cc6nM3lj4
         YU0WBjPLsa1LarNKMw4/qronQWY4qXHv1a2tu8NFBHPZTeCQySho8/mrWU9NeQCvBXcA
         zU5ZvdEkALuF0omB1PkUeW14byNhXRO63hZ6AJsmJ+kxriJg0gU1EsFT/LzIry1gN8e1
         JBEQNhS5b44vBuFSbL2ihWjAnaEiIA7S+Amw8etOTO52mFYlSXicdKHDJ3C1IEbQprTT
         LaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeE1MjssGhDzXAoJogFvcpe4DL9CP13nGS/Tyuf3pFKVId25AqaUPYbVDjAmG+rqDBpT9zBGtjeKVtkTqTMSQO@vger.kernel.org
X-Gm-Message-State: AOJu0YyeB/qPDAuPES0rb4YOZjCkuODk79hXcvzQ9rGxF/6VhvRz5eic
	Gd0fVoNw9UomlAZirXiem59cprxYvrLPFDfhwM7ij3H0tN8qykchiI7Y
X-Gm-Gg: ASbGncse8GcLYzkCQXPcdI2ZHE3AwfuGTsVkTuw+xpr1S3q5WruWV/5UzxD4HH34u5L
	oU/ozKqfWE10qDwSpNgGGU4/dJRDGqTrMt3WWC39nuz8taejKUt84bwXYWh7AZ23WXDVUBori4g
	vzGmE3figuF1xX00QDuyLaEXmgpqXuI8SDcSqocSrxSEs+HS+A9uCIDQSLtKGs1fgAsRf5lzxRo
	ZBp6c2nfvRKQriQfmt0MVziPtA4UKwMPEGLSKHeCde19cFP5I18nclAhVlhIpOVihPEAamJUVnR
	aMhoMUFMeLeHfwvdme+qaviLAxKDoz2WtYGDR2wTGs6oSXO60QosybVUWGjMr8TEX6f11/yjC7a
	hpB5Z+NLJiU2XUN5jiRR7hlQA0kXmOZt8
X-Google-Smtp-Source: AGHT+IFR6m7sMRYq60YYdiwNHcTGZgBDSJvdiB2hyzS/2PlASgOEutBAVhyy9tEnlPYj2g+a/4aHxQ==
X-Received: by 2002:a05:6902:18d3:b0:e93:3a40:8d49 with SMTP id 3f1490d57ef6-e98a5839762mr14591292276.40.1756885927052;
        Wed, 03 Sep 2025 00:52:07 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a301:1000::20f3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08c80bsm1288391276.29.2025.09.03.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:52:06 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 3/3] perf/hw_breakpoint: Skip modify_bp_slot() if slot index unchanged
Date: Wed,  3 Sep 2025 15:51:40 +0800
Message-ID: <20250903075144.3722848-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903075144.3722848-1-wangjinchao600@gmail.com>
References: <20250903075144.3722848-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only call modify_bp_slot() when the old and new breakpoint types map to
different slot indices.

This avoids unnecessary release/reserve operations and improves efficiency.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/events/hw_breakpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 1db2c5e24d0e..6fed9521baf2 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -752,6 +752,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 {
 	struct arch_hw_breakpoint hw = { };
 	int err;
+	enum bp_type_idx old_type_idx, new_type_idx;
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
 	if (err)
@@ -766,7 +767,9 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 			return -EINVAL;
 	}
 
-	if (bp->attr.bp_type != attr->bp_type) {
+	old_type_idx = find_slot_idx(bp->attr.bp_type);
+	new_type_idx = find_slot_idx(attr->bp_type);
+	if (old_type_idx != new_type_idx) {
 		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
 		if (err)
 			return err;
-- 
2.43.0

