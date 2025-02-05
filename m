Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60E944F;
	Wed,  5 Feb 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782378; cv=none; b=A4PqORlKNqBEYTXXSMFmu6JlZN0G58WqRgffETlMFiDXVaUGn8exeMEF2Oq3LNQSbG3RsEuoRlFFsIeuC+b3E56gt1ZGzY9RnJOgHkqKGlm7I1nz1KfwQZ7fcTjVLoP4mklcDR0ltbOIboi3zFAZT2YJVNyU2+vSaFckFjHQJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782378; c=relaxed/simple;
	bh=wv7QUcMqmQJcMdaqtvzsXi7KdkhOSU6Nucm1BVG+rJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJoDCQHjuD1YRPPrB7d4Cgb0sKhq6hW/KPBnIQNU3A88UsbbZTfOytEETmNiTaK/MtflQ96QgDNUVG0+n55DkhMC2RFBH7nnUOydjXHwRjsT/LNT/Hbx6LCTZDdRkFeXqUTDaGu9KVguyyKUbwQgZ1fLT3Q9leDMNRjp0APB/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE/vqXtO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE/vqXtO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb95317so3741795ad.1;
        Wed, 05 Feb 2025 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738782376; x=1739387176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XTZ2XIu3m9RP+qJyYD+g3KKohZkkqFE7uro5AlY+lA=;
        b=FE/vqXtOR1bXFzp2IVvlUZ0pUgiMzAOfX9OqJF7cXU0IH+w/wc+yDidzy1982rBMUi
         rRv01F2DtYahbgdj7D4m4nC+lspvA7PPwHlQgjyN0n+y2RJquqscerEcWsTh5ZzU6/5g
         pQoCL+fbB6lffHrewT9o8aHgnEadeHYuFK9dN5z29uKnylzEV9HWXmsQtWvbb1x0hwzl
         c/P1Re2UAUdFvIMxMycXNwbIjxMg5TvplpbSLahXc88EW+fYz8+KdgvH8wcmDf03lhiP
         3biBEMlzhCHbNwXkX1waZ2mD4zeOOdjuOKg+3Kl9hd8VUz1AV5mC9LdntGNa6kinZEhq
         GWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782376; x=1739387176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XTZ2XIu3m9RP+qJyYD+g3KKohZkkqFE7uro5AlY+lA=;
        b=UA03pL6pOUsPZkyg00KKdjHpVWIdYN6v3e1NopWKE+rSqEcmw1VzER0ep99bDEJyEy
         Rnjw67Ocjm7J9qu6eW11E8fVuaYzP3CsNF/oXu14o48HWbIvpRSzdbPebSDAOBKUdKFY
         4Eo2NT4xds7lYdwkjAdwKRolWNkeJnWj9D3DrN3bgXVcfNFr8Lw3oG6KfpBJbFF3ooaq
         hUwNb5ynWGr3nv5h6ZR8tNCzreqM6BAj8c+gq7GyPuNKGHlJYXmtXp6eHhnyFdEe17bs
         0oHZoz+vL/CPxq49EemKQS0yeF/uZ4Y2JcPlAkP6dsj+ZQTA109FVGjlj3AuVET808mP
         emvg==
X-Forwarded-Encrypted: i=1; AJvYcCU+omfGUaNIUheRIEKh0tTCK3gpE5xx6WhFYhKPUstBqMAGbC7uokAS5Mn2IKWkjOmXmUufNAwkKhBkPYs=@vger.kernel.org, AJvYcCVzk63DM8ift2kekK4EO5pMy3l1SoaivLMkfafD610u0QVivgISeF49DUVqlFPONh1eo9OyTdsrxIaceODHVLeepA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91sxHqOI+eLd11uiYCY9fp6syo1N37RghVU9+QzUoW+NibyHL
	4IrZP4mInyUY1TCdYSARGfbiBg9wKNtHf4zN5n0xic0vt2uH5Ul0
X-Gm-Gg: ASbGncvULWS0ld1WssGsHqpYX1vS7O4H1mbNP+gWsDL2sIyUVaybK4O86MZezgZWdEe
	prog0grVhmJrvs121jRujuW+3sqp0Brd+3tBpF/RW7LVQ8UKgR9sYkM6P8gUs2lxRtEkVJoyZ6z
	PNJAnKQTNKQtHIIJoqb9zL1CqTnaBHCer+4hxHp77Aq3P8cJMes0wKWBLeDnYK+ajnZX9F99hCz
	DJzZh0mz6e0bNT1xdS6EwqfvHyWAgL22+P6Q7WaiMu+cFnJQoCTyXTL3aPo/0F9u9fhYhhCgm2s
	CZmbmoy8YQsgPTfv00wFDE6nWKHdc/4taytLuhXLsdBVVw==
X-Google-Smtp-Source: AGHT+IHKqldEMmvfEqeRBZkBH83z+bWZgrX2UowzmDa9skIUAfl6ELjXshIVfFyh1cu/qWHsUGePzg==
X-Received: by 2002:a17:902:e888:b0:215:4a31:47d8 with SMTP id d9443c01a7336-21f17dde27bmr58334165ad.9.1738782376224;
        Wed, 05 Feb 2025 11:06:16 -0800 (PST)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:e6df:5ab5:fc4f:a680])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f07afc5c1sm34494785ad.170.2025.02.05.11.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:06:15 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: mark.rutland@arm.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	shuah@kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH] perf/core: Prevent dereferencing NULL pointer
Date: Thu,  6 Feb 2025 03:06:08 +0800
Message-ID: <20250205190608.93508-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to coverity scan check, there's possible cases where
"ring_buffer_get()" returns a NULL in "perf_mmap_close".

Use a "BUG_ON()" to check for NULL pointer existence, panic if it does
exist, otherwise it's safe to dereference "rb" and access its members.

The scan check report link is:
scan5.scan.coverity.com/#/project-view/63416/10063?selectedIssue=1636067

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 kernel/events/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..fe83d4754746 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6410,11 +6410,17 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
 	struct perf_buffer *rb = ring_buffer_get(event);
-	struct user_struct *mmap_user = rb->mmap_user;
-	int mmap_locked = rb->mmap_locked;
-	unsigned long size = perf_data_size(rb);
+	struct user_struct *mmap_user;
+	int mmap_locked;
+	unsigned long size;
 	bool detach_rest = false;
 
+	BUG_ON(!rb);
+
+	mmap_user = rb->mmap_user;
+	mmap_locked = rb->mmap_locked;
+	size = perf_data_size(rb);
+
 	if (event->pmu->event_unmapped)
 		event->pmu->event_unmapped(event, vma->vm_mm);
 
-- 
2.43.0

