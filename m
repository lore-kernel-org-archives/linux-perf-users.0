Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81D28FC
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018034; cv=none; b=GV3hNYxdJixTe6KDjNIwNsFZBmirbq8vAgMahZuckTqN+msS7/b7msezG8Zk/G/QwkQsIWI3wpj9JsGwEJIlKEqhdG9sA+OxUtPvSCaGkV0DjBHoEG2b4kFRcG0i/NhW+wgJe7V28Y/HBa7rn4lUaozuM5BU4d73bzG3GdtZlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018034; c=relaxed/simple;
	bh=xXlTjxsjzpWoKY1/3S9+MsmoSzPZRCZxPsG/1f6Vnf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvuPFeWon/e5CbDe0rfhjXKTyFJ1AZsBambNBxEQSY2z7rrdmglRR3hUzU4mxP6WWCBDKNAStjBaQqVC4cqlVKv2J5hg3ht5gzWT/AaRGVq29cbrgPOXWTl+mDpiSUnHFMcYxy34iRyaQ7u6vArkJxUWYiZ5l9FdjLkxjn3yJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB1aRkf4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB1aRkf4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829a9c03780so2179094b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018032; x=1773622832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Npg7zsgmfHY86YOcXFkvoWsvRPot99dvgJ+7QRwG2Gs=;
        b=UB1aRkf4MMqQAPHcnRfYoFwc7bkGaDKnKnpZphRYzSpnz20VCvn7Wyrg0P4PPBNt8X
         FN980RtLatjsJB8despVLAb3CJhAPwHddGiDE05hCNVW4oFrdhx4BEKPKfvMV4ZvGIFn
         voNNscpJlol4+Y4HcnCABBAwgVrU0/kd1aW49lcsIH9i9PVTeOCNJoZXhYr76/V//BSF
         H/T8Vds5GiiPX272CYkpC+hSMcOIreV/bsuJ1DPy1kwvGTHOIjcZxQBEDzKO1g1IXwft
         /5YV48XMHhk51GDf1W8s+vhqF/ergbpclXeA80VPSzqCMJXcGYjatCjlqVPST/pnsF42
         x8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018032; x=1773622832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npg7zsgmfHY86YOcXFkvoWsvRPot99dvgJ+7QRwG2Gs=;
        b=bo02rcnEAD2XFQ7Bo4P7QyV7X45yGN6wOUUI6Qwz/VGmbFWXm2hkXkKeJAZGC6rGwV
         haTPbF6IaA1P1pw4NlUROAGp2JJNRz5gWJHD615ZQfbjL5hTzZTYUK5ct7Vy05WtX+Wn
         /2EBOlmnFE9EFHkEhmSu1iCPAmOMR/KKbCTNe9gC1F9P058hBatic05EH19GKY+2ZUvs
         yfHuhMc5YF2Z2ticw/mXpPY09qpLDE5kpVlENj6q6u8FkmsZgO99Iium5N9qPV1wG84x
         I2MywO2NyXKzRQrTjhYAjxna19wXpHpRhATQnWSC//SuLKdJ1chWxDQ/mSf9Z0rMsYDV
         tWlQ==
X-Gm-Message-State: AOJu0YzYt+KA+WCQHZHbDDmSIvEKhJWtG+aP5RyzJRvv2lTtH82KZO50
	2OaEH6TPZQgKdgK+rxXqDgS+c7Tgmdius3rur8h7DWnaYqLjlEBj4WhpvIGahw==
X-Gm-Gg: ATEYQzx3jjV8Y3eRySk1yiG5xz45OkHa1qg8B6JT1x/ZPN6uGdbyBs2sL2X4FeZmqLq
	RDrOmkvhy8i8pxnnfm7HkEvtOOwyiVfbR9qoQevAIf4cUpm/9vzT5e0BrX6IghaUTgrMrglahiF
	fJz97OvMkBBssOgAC0o5i2i66fpMW9LwLBjY+Rhks462RfrEQjJutjdMO39pmrfQKshFtCMftcV
	FlUJHVmP/sRjlgTjR6KGNJnH8erMuFV6Fn5F/2W8Cy1FMwsuryh0L6P5HbmNb0Lymg0IL066St1
	0s7TYFetTZW4feDniJUfqy1Y4pZAu3PFQ4h3QkYUyOhL8Zvb2dGb/YiZMYYeiq5tPMg0rG/PQbB
	Mr1bpk66vSBgplsRKxOQDKM3HCjxn6ILhKRr6junkfZZx49GBYQjQpsjXs1lBg331ZZzliMyvH5
	4JBw1vKEr8mr4N8WRTCieT18bySDdtpn6BURTIfg==
X-Received: by 2002:a05:6a00:a21e:b0:7f1:4:66b with SMTP id d2e1a72fcca58-829a2f5a6d8mr8061973b3a.44.1773018032173;
        Sun, 08 Mar 2026 18:00:32 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:31 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 0/6] mm/damon: introduce perf event based access check
Date: Mon,  9 Mar 2026 10:00:03 +0900
Message-ID: <20260309010009.11639-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON currently only provides PTE accessed-bit based access check, this
patch series adds a new perf event based access check.

Since perf event-based access checks do not require modifying the PTE
accessed-bit for pages representing each damon region, it reduces the
overhead of monitoring at a fixed granularity of the page size.
Furthermore, this patch series also includes a feature that allows you
to set a minimum region size for each target, enabling you to monitor
at any fixed size greater than the page size for each target.

Using these features also requires modifications to damo, but these are
not included in this patch series and are currently under development in
the following branch:

* https://github.com/mita/damo/tree/damo-perf-for-v3.1.8

Any feedback or advice on the patch set would be greatly appreciated.

* v2
- reintroduce damon_operations->cleanup()
- introduce struct damon_access_report
- use struct damon_access_report instead of introducing struct
  damon_perf_record
- remove maximum region size setting

* v1
- https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita@gmail.com/T/

* TODO
- Currently, it is possible to unintentionally specify a perf_event
  that cannot obtain either PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR
- Check if it works in a virtual environment using vPMU

Akinobu Mita (6):
  mm/damon: reintroduce damon_operations->cleanup()
  mm/damon/core: introduce struct damon_access_report
  mm/damon/core: add common code for perf event based access check
  mm/damon/vaddr: support perf event based access check
  mm/damon/paddr: support perf event based access check
  mm/damon: allow user to set min size of region

 .../ABI/testing/sysfs-kernel-mm-damon         |  10 +
 include/linux/damon.h                         |  63 ++
 mm/damon/core.c                               |  77 ++-
 mm/damon/ops-common.h                         |  39 ++
 mm/damon/paddr.c                              | 105 ++-
 mm/damon/sysfs-common.c                       |  11 +
 mm/damon/sysfs-common.h                       |   1 +
 mm/damon/sysfs.c                              | 399 ++++++++++-
 mm/damon/tests/sysfs-kunit.h                  |   2 +
 mm/damon/tests/vaddr-kunit.h                  |   5 +-
 mm/damon/vaddr.c                              | 654 +++++++++++++++++-
 11 files changed, 1332 insertions(+), 34 deletions(-)

-- 
2.43.0

