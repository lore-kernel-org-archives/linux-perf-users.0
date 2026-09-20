Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FA3DCDA3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887337; cv=none; b=o+PTWIaO8tm5HW0DMvxpdsVqV69CFe8G+ymh15uKn1gJCSsXJMAFojZCgxf9pV/F+L7LROb0x8jZHB77ER6rfwvUL0hkLBepA3zU0SSg8p47xSsxrxOPeTzuUUWBN9NEngUyLiIieFy7Z/fm76XHtzShke0Ao7LIZD3yp8gmcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887337; c=relaxed/simple;
	bh=0VIJh85HxygJnoDoON5bocAyZefHxJluvcfKFtk1vg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/FaTZEYe9akcPyGIBmQAKTtW2me/Plql2Y7PWaDZJOreqztHEXHkURHoixmpQajzihS2O7yIQi/QAQPqkR2MfjPt7xy8wDIqmSQl/j3X1uhxlILteGrYOSVx89Sq25dGPK6dro5t2whzVscA5AbIh8V+yoIHte0ULNBkt5aXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B09u9cwR; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B09u9cwR"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so1058001f8f.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789887334; x=1790492134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M78s0H8Rd8+nOr7J2QsqNabn6ZGw1eXwc/smiKNA8Bg=;
        b=B09u9cwRashfpaH1wwuBNhfGQdJNRZPlW89UDYAQlUoSqkHyb/9Om4yVFleYED7fpX
         QCyRVUF0O4aSb8x4trX9hTchftJX5lv3TBFHn5qhuQ26QtHsJexPbIx1b/1/sQJNVkzo
         nYKyDMbMne8r+ElRmsxyvwIDu8Bu1YOh2peIQ5GC5YfDxOvskvNOlaG8m2446r8Veviq
         tRPeJLi52bptQxrcZZOHRiqMYwI3KP4wlv5D6MsK+FHeas4GhdY6b/cpmR1YRjF2EFY8
         BExSfLUWGmD/2KQIcPqfXUe7EwlWcBkLFKqz7wmM9fn6ABn9xOrX1donlWQfzikhxoAL
         4aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789887334; x=1790492134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M78s0H8Rd8+nOr7J2QsqNabn6ZGw1eXwc/smiKNA8Bg=;
        b=Uw8ttI1931sNHFMZ+w66LrAs84XY7wIHLt54k7dISqMwGdGuCVolHuLU2Frxgv59cL
         tdtfn6KoTYrGWs/f+V2nA6NeaoDaISvxEh0/CbGCjsy9X6Lv02caT3VtwdE7hGEJtMvD
         AzL6lTp6B9V8sFFYBweqGgsXCjQO3neDgVM2M23CTQnPQ6YC5C5+TrN5nhkCLJMFHimM
         fDVYfYVJOyo1Pfx3Ixh8W1eZ6ckltX6clRkBfoh1dqi8GuS4E0PL1BuflCeMMCh56GSQ
         k0DcpGSrF2RfkQQ+107wUTLozLzg9b4tyZwUmrAAdDVqyl0/LmYnfffl/C7kIPt3dhAF
         0FPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtSi9wXshHZ0ipLm8dzOi5lAyGSia640YHKUoFcYMUBEpo1c1/Hx7ZQDLsY6Kw0FElPCHok7L23AN/Ap/kfWk1@vger.kernel.org
X-Gm-Message-State: AFuF++kTch2mjjNdGFhGMWz/FrtMUsxy+AZJgQr/0hOfDf5YciRfnPFo
	cyKpxUM6TvCoVN4BGAXLyN1Qr+slDFJlge1n16vT0GlYe6jqKMWcNuJY
X-Gm-Gg: AYBFou2G76IKZwlnNKvHanv8dLS4tQe4E7F8e56/VVQOpgQIBPPsRD0Nqx5OUyVwI/e
	P9pCnn8TW7hFNudrnOtQ3n1M+gbY7Ay44xBFJVdRjfP3KLU1OVYQTl6EBKTnbJiw9M6xXI8bOWG
	h245Em7fCDLg8HIk4Enkh/TA0Pvq3vhEcFSruVBbKumSeY/nKYZRKDS+xcrto9z65hMKkT7ymew
	jd/O9cWANTToo+m+pjvSivO5dd4cu+2xthSj3QZY1ofzxQfWd+eHxhGTJbs0mF5Z6tIlCxqaW0a
	x3LNEFzb7zuOFRNaky0xWWOOkrL2pj1Mc0mxTj32QykvR4d8J1cbKY4NyHA4V97eKy8GfZMFbJ6
	ZTZUDTphkuzTgjcp1AWddWBkKt0oRfN1B5+1bUVQ8TOMrxZyI1YuFIPuql3M9eGt0DBwykE/wwf
	IAl6pfqsF3iC9ZDscIv8rP/4bnmFSOU9hrJ/Z6WR6HR1Y+wlc3bDQwrKcRKfXlo7yy9zHU6KTWc
	OXAhYAJcjDQR6BORB7V4jQ=
X-Received: by 2002:a05:6000:2405:b0:487:bef:31a8 with SMTP id ffacd0b85a97d-4871dfac13emr11120143f8f.0.1789887334516;
        Sat, 19 Sep 2026 23:55:34 -0700 (PDT)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724596604sm12443626f8f.30.2026.09.19.23.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 23:55:34 -0700 (PDT)
From: Bramwel Barack <bramwelbarack89@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bramwel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH] perf/x86: Fix missing error code in init_hw_perf_events()
Date: Sun, 20 Sep 2026 09:55:10 +0300
Message-ID: <20260920065510.15362-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In init_hw_perf_events(), a fallback block intentionally clears the
'err' variable to 0 when a vendor PMU driver is missing, allowing the
kernel to fall back to software events safely.

However, further down the initialization path, a second hardware safety
validation check is performed via check_hw_exists(). If this hardware check
fails, the execution control paths jump straight to the 'out_bad_pmu'
cleanup label. Because 'err' was cleared or initialized to 0 earlier, the
function erroneously returns 0 (Success) to the initialization manager,
despite wiping out the PMU configuration structures via memset.

Fix this by explicitly assigning -ENODEV to 'err' before jumping to the
cleanup sequence when check_hw_exists() fails.

Signed-off-by: Bramwel Barack  <bramwelbarack89@gmail.com>
---
 arch/x86/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d1af33d96d0a..81873eda5b17 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2164,9 +2164,10 @@ static int __init init_hw_perf_events(void)
 	pmu_check_apic();
 
 	/* sanity check that the hardware exists or is emulated */
-	if (!check_hw_exists(&pmu, x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask))
+	if (!check_hw_exists(&pmu, x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask)) {
+		err = -ENODEV;
 		goto out_bad_pmu;
-
+	}
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
 
 	/* enable userspace RDPMC usage by default */
-- 
2.55.0

