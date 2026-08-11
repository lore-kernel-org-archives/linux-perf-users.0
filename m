Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EC2DF6E6
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454251; cv=none; b=hA/PfxXfU9p3BsnoSd4exj2UFTTAdUGocQ99cZ8BObZSKK0DNCaFByblEVTD6qAsL6VKJnE2VwctTPeSYYhpHTPrXD/6LXWVODcn7dlx07JzRt9D4giHuEo4LixGE5rEAFWpgNHh4JoU/+5Z8dye2/23TKxD/53tw77wBTsUg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454251; c=relaxed/simple;
	bh=EN4TmAWmMd3/9ONnfr2HGaDXjNA44B8yv6tIURnlPc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlrZs0E5jetHCqCz3hH5Zj24d5Em0BbylLbSKymzmppy1XsPY5mXZ9B7JIWptkUFJ3UKDMypd7qRVlBUkbJjKR996mNbgIEAzdoL4ZD3TVwAQ+OfqGS+eOQbctbk0eEnU1aJMCp0DOstgmgd5uqIGmgyVJD1OImIvN/uaVsAadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bFaXlqNq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bFaXlqNq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce98cb8165so10873685ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786454248; x=1787059048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i9ajgtVhRkRu/fetH+ZVxgjeh5ygn/8IE6ERsxCS2jY=;
        b=bFaXlqNqF7YeOnue5sXbaH6ZRj/Z7xOtqfHfmZsWGc2E+VRpI7yUeANkIEO2WvfK+I
         m4WLM0kiUXyLlX9gfwpnSiqPYA+FsKeylp6YPMPMmKPUd/Gt0PQ3pKaXDWVkL5PzzJMX
         M6nmiSZEC6Ow2yxjoMu79XOzrx2enrjlilWrckaJSJ/0aexIBhktVRXEUOyIBgeOQVme
         ykJQX1VPhmU5zWMtG8D0QfdPgTfsUOq5XSHKUGDJAhbSQlyv1s5peuTPufB+I6eltt9p
         ClD25GOLPs3QfSy3LNBO0v9YCZlR8gnzEJVBijuTpOIhuNaphQONKTz0L1yQqYm7rkU0
         101A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454248; x=1787059048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i9ajgtVhRkRu/fetH+ZVxgjeh5ygn/8IE6ERsxCS2jY=;
        b=Tj7gAcEZ29C7NXeKOdj6oKqHuuqw6OTYbsO5p9mOwaEt9z8wFFUDDbfcN+WrSA59ep
         FUsn5bPXsgoLCIQnG+euO2/sktDgIypmIkjwxDKMJMmD0Hzl/HsivVNUOvvw8Qf+Wnvg
         UF+HMu2LvjX1mC89kunuzZZ7qnUEEo1zxIoAwM5sPZ7X98/YY40MLpoeNLuJiLDFKK/b
         n74UWaHBru5qZ7FARQTu4LREofJyUFM+CEONtC+RMOStu9OwxG/S7M09pyTjNh66d1lE
         FfADuDFg4x2+vQ6fZ6GHgL8JbAiUMwaIPcczF3OSxoIOV+lnjSLsyjTQ2oA44Z3gBHNm
         yk2A==
X-Forwarded-Encrypted: i=1; AHgh+Ro23ENJcmN0K4uuvpa8Yq/nWZNR9kYoft4Z64U0MU6KuMea6AHEPQxYae1FcyA8fnHDCGMx8XgtcdCFt644wUrw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9cRDvwMYmYLMWSnSginEhCIjTdFwWeu/9imogCiPpSk5uDUn
	W3uxsY//aVGtqZ1D6dImHWQnBVyH9Jelvmzrq+DY8d2zSg4JgEzQc9C9B5NxwMgLMGQ=
X-Gm-Gg: AR+sD10cP7uELZ351ZsAtKrN091T6fCfGsvhs1pgcZZEvQFrxEdqq0bBfuTLCcFnlAq
	a/RaPdGEEtXwpIO1tYuyWQpiw/gF+v3T3/++5zHEYHSwZ7K92kvdrk9IiaMpY1ZjsYhtsxEoeTT
	sM/VSllPbBkTniyW3hucbeDjWt6JZvWO3G4EJugsMZLhaXp/3o0q8Y9Rmf84d7w1MdA2/OoxaC6
	HQj+xkKet7Z9vOYciWXG6JUnB8CE6P6qQz/ZWb5QyNoi+Jx9PMZBX1u8qbumXHqm2kwD0QK1bBQ
	UWf0fl4XyzDLQL6Kbhxheg8/JLh1zwkv4pnt9y9tWI1ShELsBKI+Yw7Hjr85b8RMbnMLF/RrrHY
	YZBqBcEaIooQTXRuVUUNIFe3VGQUoDzl/zMa9UjRrw1zzBhmgyeNecYZv/9f1GTCPoee0DTYHmk
	vjQVRdvcclgxUYj0zlknWHtWA1e+BMgVtxKklb8JGiErD2AvL49LeVtAjeqhUcIU902ym6XLf3v
	lxkbEDF5XT2+nJ4K4DHTt0GQnfOwp6POggNpw==
X-Received: by 2002:a17:903:1b50:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2d32da4e721mr506085ad.9.1786454248223;
        Tue, 11 Aug 2026 06:17:28 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c64237e9csm5020593eec.18.2026.08.11.06.17.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 06:17:27 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v2 0/2] perf/dwc_pcie: Fix lockdep warnings in device and event setup
Date: Tue, 11 Aug 2026 21:17:12 +0800
Message-ID: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWC PCIe PMU driver creates a synthetic platform device for each Root
Port from its PCI bus notifier. If a PCI host bridge is registered during
late init, platform device registration enters the platform bus notifier
chain while the PCI bus notifier lock remains held, and lockdep reports
possible recursive locking. Patch 1 moves platform device reconciliation
out of the notifier callback.

The event initialization path has a separate locking issue. It walks a new
group leader's sibling list even though perf does not hold the event context
lock required by for_each_sibling_event(). Patch 2 skips those walks for
group leaders while preserving validation for group members.

The series was tested on a RISC-V system with CONFIG_KASAN,
CONFIG_PROVE_LOCKING, CONFIG_DEBUG_LOCK_ALLOC and CONFIG_LOCKDEP enabled.
Late PCI discovery and a system-wide DWC PCIe PMU perf stat complete without
lockdep reports, and the kernel remains untainted.

Zhanpeng Zhang (2):
  perf/dwc_pcie: Avoid nested bus notifier locking
  perf/dwc_pcie: Skip sibling walks for new group leaders

 drivers/perf/dwc_pcie_pmu.c | 161 +++++++++++++++++++++++++++---------
 1 file changed, 122 insertions(+), 39 deletions(-)

-- 
2.50.1 (Apple Git-155)
