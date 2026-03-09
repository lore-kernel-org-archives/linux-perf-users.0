Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64501E834E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035843; cv=none; b=pj/fnxNUP4c42DEBIV+8PPqOq1+9NpTUFSnElZVuARPRK6bVCG/c73aOM6sbsRhaqhKAU1R2eGd/UjaeOtLiIT8ZiH3Fw6U2K5Vx/lIuAw+qY0EYuK8JTGpnIO18S3HsfSUZP29kGqy6hvVBCs+BWPXtFAoJaQBRL6tTynZqPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035843; c=relaxed/simple;
	bh=IDobI1pDjrGRdZtvjoHObpqdEXE9nzpesJCQXLD08jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBiwq+XPAsK2/xOzgm91XRfudrgHFquznc0pD10MV8xijeCvE9TgI9fQy5cgjNvDjTotQE94oE5PcLx/RrE7o+ftQWyWu8lmHcXEC8VUcodZHUzUrM120VcQA++HZ6yVi8buVy1y7WPIw+S6qJa+cVLYw2NxTnENG0CThgqWFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZcWSSK/; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZcWSSK/"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82987437624so1878087b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 22:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035842; x=1773640642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdJCNIl+oeGF/8sQ4BGGljXaAZ+trWveif2W1l3CCuA=;
        b=TZcWSSK/1kzqbgwGDl7PD1KZTMF1sGKXdVZ/FgeLniLVyATYLNnu1cRlRQ+X79pAYY
         wti2wvMmepX5Vtj1L//h34M5wG3IQiwIioET1e4fuYdyII8ZQcV9VLtYXdn00ADGDnjN
         +cpu1SUvS2gSxDUw3b0csHBqR2zra8yKnpasQ9Ty6IrFavg/y0GsaVegrjaG52OecGmJ
         gNjobszl9mlcP1PN6OUZ4PsAT8QBJKsjI4DOI7pJ2nzImDsLE9/ySujn6xUT0M0PEpvV
         BoqL+KCJriqLXYQ4o0XxnEFWrLQ0Dp6VMevXV01Wj2COZ7KR/OWTVsyWwnS0wcjMgkJA
         WtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035842; x=1773640642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PdJCNIl+oeGF/8sQ4BGGljXaAZ+trWveif2W1l3CCuA=;
        b=cHCL6QHwKWmYE/fkrrMuD5x1LVIeY1mXNU52BEb2HBfs/aRdoCujj8FlWDQVR45U2d
         ax3YpS7OHhC8f7dYU2m5iZqbS96PNMu2+7nmNBqQ4J4mJKz2NSRSchuAnVksTjcXwQi3
         tmgyJD05mRWgKAHIdVV9ItHm/Jhw80W2HUmDlRDDe23cGWJdatAEe/JveMEJJ/v0+9ao
         KkPz0tq2FDT20W3biZX4E0iQgt7fo0rHfp2+brg+zGDCeGVC7EtsYB1N212XpHaYVxe6
         zG60C08H5ZyI2RIWSQ3jHroWSEc9b8c5P+m62OXZozWMmQGGjJDg74xrb6x4JpF2XsXN
         GiRg==
X-Forwarded-Encrypted: i=1; AJvYcCUnbYbf9f5WMsvjVg0bHdCEBGosGN9eDAXohzukFM/aiPF98T2yStMfLBjt3BVJdPb96hnFV9wC++g5/hYxDV42@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrRxJxMYzxZC5DmCJ0xrc1YUuCTRbzHvT8ttK7Lt6Yxy8kJZZ
	C06XI3fESmNq773Q6PiP+Cfkvdli2UHyNthJYW8e6mgr52J+c6LQOILD
X-Gm-Gg: ATEYQzxQdg47RNJ+n+c/zPVsUFWcET8rqkvip8Jr9EoUNK0yajb2BC/+0SNbYmEUOwM
	Jy9wTEo2eQ/U94WXietO/xm3nQDni5PbMvOkBgfYfEn0RCCJRnwD+Hp+YOgnfV0BDnDBy3kp4OO
	nJhUKDoxuPMkNJ2hT7/8RiWIn8ArxD+k7lmVrOWYxHpyQ17LOLOJrcSzraEVAGcIu3B7FRZR/uE
	L6wAxj9G1dWmaB3fEjmEVfWVtBaEJlsxCfRWFb0bmWurhBFGK/qkCYOiX2bKZQ12OS7PjURbtAZ
	vGvsyRV0AIChJ1sl0W+K91u6xhheVepNzcKrZzs/qUSqWYnL9rDBqV1Q8ZJ69XT9nqS8+1kBwSp
	80HY2670sCxxEOgOQ13QFwLV29MNA4EcKAIbzANBaJgi6nef0FXTPM9EW+UFFTu4dcvjQkSefH+
	TA1hpnm77KbdI3wlzQi+uNapJ0PrlOknLrvx+P1psq2lkrCxo8tg==
X-Received: by 2002:a05:6a00:ae10:b0:824:a466:7470 with SMTP id d2e1a72fcca58-8298583d0b9mr10115856b3a.17.1773035841984;
        Sun, 08 Mar 2026 22:57:21 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm9181602b3a.5.2026.03.08.22.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:57:21 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] possible deadlock in refcount_dec_and_mutex_lock (2)
Date: Mon,  9 Mar 2026 13:57:13 +0800
Message-Id: <20260309055713.1938024-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69abcb61.050a0220.13f275.0040.GAE@google.com>
References: <69abcb61.050a0220.13f275.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..accf23545d78 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7485,9 +7485,12 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 */
 		ret = map_range(event->rb, vma);
 		if (ret)
-			perf_mmap_close(vma);
+			goto out_close;
 	}
 
+	return ret;
+out_close:
+	perf_mmap_close(vma);
 	return ret;
 }
 
