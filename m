Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC434847A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158569; cv=none; b=Iu0t7ngV1g1dqcz8gja53o0VSZfKPuPuMyzhK3ByPWBYtFO94G9IKB6MMurFhpFNwevhrIwx05vPctpmgMsqfrHV5w6ekCqSJj0Avr/rvMlh06ezK1vvG/oGuKeikXDrxMWag+mGb/eUoF1ykt1ZkDl3JmN6DUId/gjAW5v5dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158569; c=relaxed/simple;
	bh=62Rd9Cj+tuLxEAc6371oplypJXVUPm0OX7f4j/blxSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHwjX6ykXXXh72BIOccVdt/Um/3m6/UZUeRx4HLd8ObKcBMSjy8sJKdjNAga737DjyEeTlRd6lnPcSqUnHRFzVAfVdJ3jhChFXtBACHqGcrIHNVvZvqZgEqsXpW7Wk+QaKHKn0t1KlQELIfuDDETApkyu3LtR2ZsK6RuXVUgHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3UA6Hud; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3UA6Hud"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781251eec51so5699648b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761158566; x=1761763366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OaDPVD10QzAGywMTcZ8MVoJwwj1EgOUaXLk9q2JTmq8=;
        b=N3UA6HudxvgWUIjXDO4j629xlo21BLNMA9iQWqfn9FTqvB9BOksUxpongzUDqLZnD0
         jrusS04akv5oqzG7Mtl+xg2W110DRcUv8zXlFlEpwxI4DY1kNEUw2mMYx75qTEe7IeA0
         0ffNl38nW8yWQ3pVTvTZWczwVWFGrOBsrI1WQ5RJGhehUqS4WhxDZepbfTnTS+FKnVz1
         gd+BxuWQqX2aHeVZDhg6uaZsaZ1oKYRKfzsjJnDQNBsdgjmphmQDBnqhBWIQLyKeq6R+
         ijSRz8d+iBHJh6ZYaWP5ZxXEZ4t+YWWLNQml6fP7ZjRw5ya41xuiTLlTHJVx+74UIetA
         7LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158566; x=1761763366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaDPVD10QzAGywMTcZ8MVoJwwj1EgOUaXLk9q2JTmq8=;
        b=DNsR55slnP8gSmdd3s1snF0E+fyaZVxHQRYPbks9623+llrQmGTFTWvqgVZNDKmnTj
         aLmXgV33TFu95YaVWHvl9rsYpRONpwzPD5vZXfcomom00vPT4rcpLtAoZtN9diqc+tKO
         vjXcN14hEYtFaBfF5+hwsnmZTIqiNy3gYxlt7L31qYnv/D+XWeJeTZjLS1rtOre45+2Z
         q1z+GGM6dyJE7CPIqhYNyAUgfVZfYVfjCPJQHaCGykd7VnM02KCEWF922mfff4WcOfGM
         nA7B7x2CIUBKz4Zp+EDOEBMpp1vzWFMk9KLKgCTtfVlbhKTwe78NYrlWadzD7jbPwecT
         sfyg==
X-Forwarded-Encrypted: i=1; AJvYcCXjBehip5SY5nZ87lyrw0ewkqVoCIDgdnMnTa9bnTrhOOAG8JlPcjMU3Qeq+PJPlFnQF2JSgDvl9yl7WC15yBkM@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaVCRHhXokb6Aexhlqwvp7TwmRWGohRSJGez3Tis9Lbxmbg68
	VGsYGK7aTxiqtX+BGUQ430aZaCBhFlQPzeYCSAq3zJitAYqpzrEdDhiO
X-Gm-Gg: ASbGncso94jlHR6ixXC6pUazHPls3bWBwgeYKxRHxGIkfNBaegN5HW4WRYPzvH95P/H
	quTOOB3gHp1bfVujbfRMy5DzMP4j+GAF182Qr9OwN3iSN6dhho7gQJPO9SQldfRIpGETED1Ec5n
	mDuJm06R4TRRa0SaZ1SSGDbPFEIz5eBw54feublbjkgC2autWVqU7ycHqAgIiuLa02+Gu15OMrz
	yfKLkaKXzfVEzYh6R/Taz0MLcXf61fpKPiwPOXfBAy0LcKWxCUNnR95CUIloyoF5bawtfs20yQl
	/Q+xeQos/keGsvYWLVz97Xk5DVm+JC/yeKGm84eNY2ZX3WIyimgUv7JeZF4aPHGlb4fGWEUKmgI
	0bdlgQ4PvS93QY+HGx3V8dMnDCMZhxDMJ52H+WBcqNc6rZqtZLMdWUpjR/43o1HZhDKYzhN/Odv
	DeOA==
X-Google-Smtp-Source: AGHT+IGEuNl7KxT0ZBg1REm9jtYV03SiCDzrf1MkAQZm9SCvvp7AAFvvgs3enN+dhrzrLl2aRLXWTg==
X-Received: by 2002:a05:6300:8052:b0:334:a916:8b4 with SMTP id adf61e73a8af0-334a9160985mr26107060637.8.1761158566294;
        Wed, 22 Oct 2025 11:42:46 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:bfa2:49f8:6793:8484:a709])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f7absm13489547a12.39.2025.10.22.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:42:46 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hpa@zytor.com,
	Shi Hao <i.shihao.999@gmail.com>,
	Smatch static checker <smatch@kernel.org>
Subject: [PATCH] _x86: intel: pt: fix potential null dereferences
Date: Thu, 23 Oct 2025 00:12:30 +0530
Message-ID: <20251022184230.124113-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add checks to prevent potential null dereferences of buf->stop_te
and buf->intr_te in pt_buffer_reset_markers function.

Smatch reported possible null dereferences of buf->stop_te and
buf->intr_te in the pt_buffer_reset_markers() and when i checked
both pointers were checked for null dereferences in earlier lines
however,after calling pt_topa_entry_for_page() where its return
value is NULL in certain conditions there were no checks for further
buf->stop_te and buf->intr_te uses which could potentially be null
dereferenced.

To avoid null dereference add checks after each pt_topa_entry_for_page()
call to safely handle null returns and also add checks where there was
direct dereference of the pointers.

Reported-by: Smatch static checker <smatch@kernel.org>
Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 arch/x86/events/intel/pt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e8cf29d2b10c..2b7d5d118b48 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1148,7 +1148,8 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	if (idx != buf->stop_pos) {
 		buf->stop_pos = idx;
 		buf->stop_te = pt_topa_entry_for_page(buf, idx);
-		buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
+		if (buf->stop_te)
+			buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
 	}

 	wakeup = handle->wakeup >> PAGE_SHIFT;
@@ -1162,12 +1163,16 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	if (idx != buf->intr_pos) {
 		buf->intr_pos = idx;
 		buf->intr_te = pt_topa_entry_for_page(buf, idx);
-		buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
+		if (buf->intr_te)
+			buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
 	}

-	buf->stop_te->stop = 1;
-	buf->stop_te->intr = 1;
-	buf->intr_te->intr = 1;
+	if (buf->stop_te) {
+		buf->stop_te->stop = 1;
+		buf->stop_te->intr = 1;
+	}
+	if (buf->intr_te)
+		buf->intr_te->intr = 1;

 	return 0;
 }
--
2.51.0

