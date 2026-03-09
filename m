Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADBBE5E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018036; cv=none; b=aGx5I0NPxcriWyq68/iTl8NV3lxvM1q6eVpakV7m0/H9d0wAeI1vY37PC8Vf5qyHiK3pS8qvSXEBVALyC1dTmg6wa8IF678LleYsDjKDozMYQbuWWRlZzKZy5nO1Vz7Al2Q0PlkxznrqMMttzxpSlFEdr6jYwHQTtCZh3IZxD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018036; c=relaxed/simple;
	bh=CBq1WzY+CfbSlt/zpeDKPph0ZRMfd7TiyTs16daTZEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjP+EJJzQ5Pk88YNaThYE7Bg/f6KuIsA+MMN7jcjnCWiBC1OdGIel0DstE1S6CunCXnD4tUDOK2qGtTiI02/6Z8DoAJ9LubD1e0RaRaOHplRZwpxdL/goLBRp3BBKiFHCUyvLNPfxcBxfRFxcwtY5qXdRZ5YLLoaVkhgzHTjVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfh2bAQJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfh2bAQJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82990763921so3358049b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018034; x=1773622834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn/2guCKRAgRRAybhopaktEdBkVkt8okldP3ZxdUvNk=;
        b=jfh2bAQJCm0LpC4ORGAkMZpzSVxr1Ks6rBaLALZl7b7Z9hoN4eTAHQsXh/NAlUdabF
         V/pLaHNns4HdmhcbDQozpzJJDnVb9EwTP5R5kjhfETReiFOt8t+JqyY9KlJ0yR+otP4+
         5VjReyi/LPjFYInRiXTBHvC10U243OTO1PgAlyuBgC1RxuN3PDyZj/dmEU9DIbLYcBNL
         vMa3tL28SfwStBtuY7NLpfhLWG4RA+LgAqrJzmtLVgxkl8GUtMYpVVaMBrfApg8jkfTG
         Hg+qhJcUxY+6257c7ukn4nvVlldTkcrexqw1pTUZYzmtqzyXZkqoa1OiI1pmMM7XuSTx
         Jt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018034; x=1773622834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pn/2guCKRAgRRAybhopaktEdBkVkt8okldP3ZxdUvNk=;
        b=T1fPMX5ygRGumXwANsw7rQanRpiqp5exyww7JYJ8q8jXxHCflEglslJfZL5CETi0Ei
         +6AcmR23ZWzewx/vyoP0TwiE5ZHPrYNOZKYqMR8s9Vwwvxe7W1cBZF3D9oI+aPdNbrYp
         simIMew+36dBbQp/Nun5gYHf1aOgzV5732lEyYML/eRdY4w599a5/jL2nnT6b20AyVtU
         c0C/Cs612xqxSjtn7jX6VvxKed4qwMKKkLJRDdG3d0rKb7Tkbx0720dObGzHbRRborQP
         vQqVNBOQ4fDJiQq0q+UJebxfGb5T8ALue6SJYrUDEqiRwldLm7wrte+HB+FZRnPiL/8u
         042Q==
X-Gm-Message-State: AOJu0YwkLx379RKPkecvyJx9vzY1GSkPdq+hjUsCF9KQz5YdvOtbuIJU
	5JU+S1fZGRgj19LncbBNoUYOKCsNRCUVJPTTcNR/mtojU+8MCmDG0igS
X-Gm-Gg: ATEYQzyD9QyGIxRBzaDMtJqlQMWu7xDlG5u28s/R/NlcJ2nO1kBt+JjfCXzkT3gWo6k
	fQ2c6+5djM5ZTMjwA0UsfYoI7DDlaLskpiJYfSwXKJJYXobg2ke4qPWP9za4kecCnv9GzV7BA3l
	mmVPc9EiKIi5jbJwMyR6NZm/AXFU/sZk9xOG4NI5zEzH9P63ziWtE61O6PeqWiQeiNsbzz6v1rM
	UPAVCIlC9aRcGXulzryxAoax1T/v27ZAjW9Wx2yb32iXiPruoz+/GvdKsO7sBNAqWJOxXR7sP4A
	a1pKdDN0xPDy4pkhhGBuAIIMDnWFN9vKOuU5b4vUPp85TRqDSaff83Rd78Q9uauFj13FRpdr9wK
	AcKMu9RDf58Hh9puGqsdCVRkyF0XUjG7qFVlZbLsGzqaMeO3dwtlb/al1Qb4g6rXrUq+71fAMg0
	6vhx7A2Y/rRPIQST38vKzwa3cejNtNC7qdbccrxw==
X-Received: by 2002:a05:6a00:2e1f:b0:824:a20f:17a4 with SMTP id d2e1a72fcca58-829a30e41a7mr8391334b3a.64.1773018033494;
        Sun, 08 Mar 2026 18:00:33 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:33 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 1/6] mm/damon: reintroduce damon_operations->cleanup()
Date: Mon,  9 Mar 2026 10:00:04 +0900
Message-ID: <20260309010009.11639-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50962b16c0d6 ("mm/damon: remove damon_operations->cleanup()")
removed damon_operations->cleanup(). However in order to support perf
event based access checks for physical and virtual address space
monitoring, damon_operations->cleanup() is required to release
perf events created by damon_operations->init().
---
 include/linux/damon.h | 3 +++
 mm/damon/core.c       | 2 ++
 mm/damon/paddr.c      | 1 +
 mm/damon/vaddr.c      | 1 +
 4 files changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4fea23da857..49d2983af4a8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -607,6 +607,7 @@ enum damon_ops_id {
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
  * @cleanup_target:		Clean up each target before deallocation.
+ * @cleanup:			Clean up the context.
  *
  * DAMON can be extended for various address spaces and usages.  For this,
  * users should register the low level operations for their target address
@@ -639,6 +640,7 @@ enum damon_ops_id {
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup_target is called before the target will be deallocated.
+ * @cleanup is called from @kdamond just before its termination.
  */
 struct damon_operations {
 	enum damon_ops_id id;
@@ -654,6 +656,7 @@ struct damon_operations {
 			struct damos *scheme, unsigned long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup_target)(struct damon_target *t);
+	void (*cleanup)(struct damon_ctx *context);
 };
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index adfc52fee9dc..d0d9659658bd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2841,6 +2841,8 @@ static int kdamond_fn(void *data)
 done:
 	damon_destroy_targets(ctx);
 
+	if (ctx->ops.cleanup)
+		ctx->ops.cleanup(ctx);
 	kfree(ctx->regions_score_histogram);
 	kdamond_call(ctx, true);
 	damos_walk_cancel(ctx);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9bfe48826840..4c2c935d82d6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -373,6 +373,7 @@ static int __init damon_pa_initcall(void)
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
 		.target_valid = NULL,
+		.cleanup = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
 	};
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 729b7ffd3565..8a58aa912112 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -1013,6 +1013,7 @@ static int __init damon_va_initcall(void)
 		.check_accesses = damon_va_check_accesses,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
+		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
 	};
-- 
2.43.0

