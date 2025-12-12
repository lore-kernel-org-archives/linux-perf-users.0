Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462722C2374
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558289; cv=none; b=qnwpGnkLuEAui+ZijtaKZResh3YpsHb2YPAFlS/Rv3aKRwVbNtY3CkI3F+aOh7gS2DSkOnNQiVFORDqVOSkAXXtPds0lGnLMBQwIPPbvw+S94kNMBqakE9XEVJqIb43H/tD7Bjwrxu0NknHYq2C/FJfYVTb0b7cZUMi4MPMkf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558289; c=relaxed/simple;
	bh=la8Crln8BuxjX+NAKRSmj96+mNO/40jByMzjixrKexU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXrW+q5h5wRZFxH/h3AbERCrJy/pPynHawePseCkMJvvtAwXW5AlejBjonijbUpRCPK5k/BA77Vx/S8TWSJoyzk6K8EnsFw08LUPKdVIuHV/vQ/DTSzMIMGU5Jmx/4tQyQhV0hQaX6BjkyNW0STNekNKf/m0zVskRGZQf8+UEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5JeSopE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5JeSopE"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so1255576b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765558285; x=1766163085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOrkeoWAMjKRXSTnyOm788m94Ym9RUfx/E0MRW+fUv4=;
        b=i5JeSopE7o4mwDh1stQJMQIxBd9HArsYF5kdA+DIYlITiX32qaPocYqi+Cty7oczX1
         e/Jogv1r6miinPCt0pxLJTKrXEai3kRluUq/UnVrhftkGdtjQN0uThLMkgJ42rGTE9Cn
         0B4v2Kz9IteahPpJuy4BA7mTVYS4241J+rnZMs0uKlJeoppnbKY+VYxTME5VcLzl8tkY
         p81euyxoXV7r5WEukfSkw9Pw7dat9DxBGalz8cR5Ci86J4C+fdlPuj4mOw1DR7kF6i4F
         ekT162PO5P2ul3plFoBLcQnmSk3l6oNRstCRbhjPf2HDGrkrGBSfOQnB7rTK8GAlx/pn
         g3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765558285; x=1766163085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOrkeoWAMjKRXSTnyOm788m94Ym9RUfx/E0MRW+fUv4=;
        b=m3nZZJexSVDkXcZN3RHA9gEJla2SeKSW97GHrDoBEXDtAfV9lHkwjj1akIKkolo9wh
         gLP4csXAiFEOfO60uFAx6sb3GBITX/2xPYbOOj9vZVGLMOH8bbDqEiaUECTfuc3vE08t
         s+Kv9vqZHqADyMPm3RDNDhF9D2zI2h8/PeuCWBBdGvuAP8WdMVRWEUyeZTF6nnJhFHss
         U0TEaT4nQzaE4899HD5Dd3hCAJnCb5S4MyQsOSefl949X5eADiVZxh4WPnztAfGtpnaB
         hGZxqYZo5O6PqoLWt//B44k922jmXwCoq5/4/VMBAfd3pOMxYwY9PvYNya5rBk1fwnrK
         huRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIiXv/g6As1hSUcSU08EbVqu/M/kPsUSeyGZ8qtSpBgh55qLUGADUc+a6u2AGDE4hdk/ix+K+3sbT7aGzpgES2@vger.kernel.org
X-Gm-Message-State: AOJu0YwuskypOEtKv7WZuzDGZfzlxWAB/2MO6ZNOYEffXHLWIJxWejqH
	GBpUiJiPJfYTfXUlrdrScqvODtiPtktGBnm4LWM8Fyxv9rYcogUHKi4L
X-Gm-Gg: AY/fxX52sYOa9zx+AFUF5OnjrYHZFkkLCDjR9IsZ8QbKbI6lQlBR+7MkRepoZzAt1Op
	4mGTosXxh3TwdG3lBI5QNrkW0uGb2jzS9QIImQZK6+xGV1rextFmWVVv0BTQ6nePAJPKkeEjt8/
	3YaBgCK/xdPWtYHHRxopoIBdNXZCgy0vN4JmxgKOStUvZRE81Z2SAeZPosgqJJ5EounS3msGg0i
	VwKks5ThV3MYrgU7fxjeTu5elxNFhcz6zWVIObAmPG4ahwowE6h6OwQoErpjHlqxNzMFzosKZ1f
	0+uWXbFh+6J0Wv6wO6kbg8HOl2mVpZ+yh8tlqnkOnBkZxsRi57Y/zGWqu5z5Z/gnk2aGbamM6tP
	mAVzb8gZ6ym10JASOoroZ79ZIF77zOB8fNFthOBdqHfZy9YLLJ0Lpg8i3Z3JvpWF1CaoUIqahRN
	WV9Vv9/R7gz/NfJ7HM4Vw6qPRgORtGIagNKL5ke65+srgMBwh1Sp6XYiVDrQ==
X-Google-Smtp-Source: AGHT+IG4JQHRz8u15NNI7+ZEqrlBASdD2PZ02KO5GgCuk1w+mMeGkiu7QQHnaCFShxkCnc+Aeph4sw==
X-Received: by 2002:a05:6a00:330a:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-7f667546b54mr2883129b3a.1.1765558284811;
        Fri, 12 Dec 2025 08:51:24 -0800 (PST)
Received: from user-Inspiron-15-3511.. ([2402:3a80:1e0c:62a:e3f8:4544:2200:cbc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22851besm5783941b3a.11.2025.12.12.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 08:51:24 -0800 (PST)
From: Tinu K Cheriya <tinuk11c@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	tglx@linutronix.de,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tinu K Cheriya <tinuk11c@gmail.com>
Subject: [PATCH] perf/x86: Fix NULL dereference in handle_pmi_common()
Date: Fri, 12 Dec 2025 22:21:12 +0530
Message-Id: <20251212165112.855537-1-tinuk11c@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a NULL pointer dereference in handle_pmi_common()
when the event pointer retrieved from cpuc->events[] is NULL but
is_pebs_counter_event_group() is called unconditionally.

Add a defensive NULL check before calling is_pebs_counter_event_group().

bug:220855

Signed-off-by: Tinu K Cheriya <tinuk11c@gmail.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1e3ce060d..ee693946d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3397,7 +3397,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 *
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
-		if(!event)
+		if (!event)
 			continue;
 		if (is_pebs_counter_event_group(event))
 			static_call(x86_pmu_drain_pebs)(regs, &data);
-- 
2.34.1

