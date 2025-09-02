Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3A19D06B;
	Tue,  2 Sep 2025 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804695; cv=none; b=t0U7IkZDWKp2ogwkFcUVS1muVaj8oSNUM/rwqNM6Ag8vUQdJHELnUqKG4ZRXThWFraOdUpdcJ0JLTMBml0fFvsSDXZBlFRlDjl3pSvUmuSY3djbqLLawl4YIIVBjxWkhHP/S51L48EPLEQW1zOqOwAjZBqwSpZ8ztkXc0d//wZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804695; c=relaxed/simple;
	bh=KzynnCtc6KsPATtu42bbVpiDOPZ6i24SIoDI5SdZ76I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzcvOg4veckAnE52CldTdK9nRpFZ2SKWlKYLXu3TgJqZZxaV9YdB2F0Jxu6XZEdYgazlRCUUR2lHFCdJTnw4b4V/yA6HsreLonCtgs6SvRIgzPWZaTcf6K7NGXyN1P+1liYIeSl6p/VGsh7RzM/p5tv+qWR7AKuSQCBuBaSC3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THq8h8va; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THq8h8va"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so4331434a12.0;
        Tue, 02 Sep 2025 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756804694; x=1757409494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=235DukVi/odAW5HS9zePltJ2aaH8f1ongwAUAlWuUsA=;
        b=THq8h8va3qAqoSM254+YvoH5Ph9W57QFmCN543NT4Ge4KwdY3dT38+lTsx7KiJB4Lb
         RN3Ry68NM0Rgsoof7dlV/GvBMZiTtAMGopxaUDLwkeHLMT/qMVVzjpAD12G1R/2S/SMM
         bi96HeyapZPrB038bzyp2syOfLUj9C/apth5rm/cOsqZhXir4SEJufT2jt35QYqTpzX7
         0cl0fGvy3lYPPcyuBktEumbfsHAa6n/RhDk/QEkZZ3iOcgArqVTnLHsL0FyquJg9QQGj
         o/cgSeDG8eV7NUUxTb5AO1q3EfrNUT/57Ry/zhPw/YXnV7DHAuesgE7c/jkHe6UcHG46
         KDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804694; x=1757409494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=235DukVi/odAW5HS9zePltJ2aaH8f1ongwAUAlWuUsA=;
        b=eerRUMwUOxp8PDgLoS+cbN5oY7iq5Y7zIGzDuxvMEV8CvDy2bYIrQLTSj0aenkDjT0
         E2gN4fSU9roZsrlmyyfxBUu8fNMkJQXctkixZVV0Flj9tVuSJKnEsa/M9yFMFpxihKXC
         osCI+r47+PQEbR7qDaxN5zZJW7apnANKbD1FBh4+89IcqW6B/KW1RNJk441VLl+TABOo
         DJ/XtBAUMhnH0TK9b/X1q8zKnVvoIgyO+rFZny+S25PdFkCcGw3eEKUTpLpItznwa19h
         dnfIDSVgwX4q2n6leT5Fb34Lr7uqf60a3hKY8kC8dumC/dlXlQrFn3HidkLHthwtD93w
         IanQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFwXJW5uc/rZV0aA9mzIK1TJ6dDhGN6nMUQ4240eXJOv19Rr9967y61ZOUXcp9LqrVSYKq5w95GMEJg8zXp8Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBTo93uIwh1asWo5KT5mzQ1DFppkAIfoGTbuJLVBIjxp+z8Us
	pAMt8OFWg3bXjP6w3cqvxZzrR3UGYxS3YZOG4qpU7E7BTdWVXiroPFqJ
X-Gm-Gg: ASbGnctz2dju5J88x3RtQ+EeccDimGahCZEuUq/VrWejvwIEkuCmwBMaNrkS9F0jdgj
	bLRqE2Bx2EHoXSIB3k6yJy5k+rEzjzogKfHE4GfFFf+od+IYMvpOfIMdzwvV/Ijv5rnlkk21Vhz
	3FKch613i22VJoYLQFuQXhdmdi3yBeMURB1RHfPWYI4yAcG5UdgNUOurF3d5Ib4bCu3FirSklQI
	zz9saWLaFsKTDAY/PkM9S9RN6MB9wBxM215f815qp0JQhz7gP6moUCPrYGqO+1vYuE4pOmnV7mC
	rztqJ4ILvwQAUyZYg0TS1S2FmRxf/I9t5GcAEWcE+8LI2OIsSyC2DwFArRFxujGRyXmwIvFTPfE
	lWaI0RmBp8Eqp0XroFFt8azCmCOTu
X-Google-Smtp-Source: AGHT+IGBeKZLBfXLYmTkzsnz0xi33MJlBsEkLGLSg1Yp51p1CUvTny6kyUwXb5PEGfYmYrgKXLrPuA==
X-Received: by 2002:a17:902:ea0e:b0:249:274f:84a8 with SMTP id d9443c01a7336-2493efe0734mr138788665ad.25.1756804693526;
        Tue, 02 Sep 2025 02:18:13 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705be3sm128032695ad.18.2025.09.02.02.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:18:13 -0700 (PDT)
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
Subject: [PATCH] perf/HWBP: Optimize __modify_bp_slot() handling
Date: Tue,  2 Sep 2025 17:17:54 +0800
Message-ID: <20250902091759.590664-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip unnecessary release/reserve when old and new types share the same
slot.

Reserve the new slot first, then release the old one to maintain
consistency and avoid transient failures.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/events/hw_breakpoint.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..1cc9cb32ceb4 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -625,23 +625,20 @@ void release_bp_slot(struct perf_event *bp)
 static int __modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
 {
 	int err;
+	enum bp_type_idx old_type_idx, new_type_idx;
 
-	__release_bp_slot(bp, old_type);
+	old_type_idx = find_slot_idx(old_type);
+	new_type_idx = find_slot_idx(new_type);
+	if (old_type_idx == new_type_idx)
+		return 0;
 
 	err = __reserve_bp_slot(bp, new_type);
-	if (err) {
-		/*
-		 * Reserve the old_type slot back in case
-		 * there's no space for the new type.
-		 *
-		 * This must succeed, because we just released
-		 * the old_type slot in the __release_bp_slot
-		 * call above. If not, something is broken.
-		 */
-		WARN_ON(__reserve_bp_slot(bp, old_type));
-	}
+	if (err)
+		return err;
 
-	return err;
+	__release_bp_slot(bp, old_type);
+
+	return 0;
 }
 
 static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
-- 
2.43.0

