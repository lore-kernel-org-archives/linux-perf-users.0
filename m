Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E021DB34B
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053881; cv=none; b=TshQPMPhs12I1SQRveiVnX2DM+YEnvNr784sSxlyRyCaNED8p63NCJa0ipLj9p/ZJ5O3eC73RcIP5jIu8GcNFSExB637yPpc1dJM6+920wcD+OZJ9f9yGSBEvFttRxHJUusmPSKg4IImvxw93RYisXJeOp+nbf2bD+Msg8H/dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053881; c=relaxed/simple;
	bh=ovInfsJ96+xONzJYIftLY8ItKnYcVc+4SXbTYAmQao8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y1P7FDC34sD5hOBBmXjlZ7kXUPBW/1NlHsjl36TNU8U7T1FDSdPzgOj6pCuCuv2XD3drBAISwSI/gm37WnDj/zNyY/J/ZXeXQpuq/mPqPth0t3cuiHV6/L13qk8Iypn63M8hEf8pbMUbXNvOGijKwzXzxwTOxQKvYax82LKs1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SjZ+KiG+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SjZ+KiG+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso15514915ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 04:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740053878; x=1740658678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mhxc0Zvns6Yn1JJtRPi3TJJp5srNdU12f0u9NFGaDA=;
        b=SjZ+KiG+85PWwNTuFGrqjAvwy002TYPYJWUiMSawMdMnB1+5PITTJvks6tIMBrEvbb
         wT4uX8sdYwMM5jua464yjhOIJn6MCPdj4uptitZtazjIp5ebEbwD1op3z8ConAI4gXsE
         WNJY49wb+xWUTve6pvzjQvwgu7mRQkPErqadiebR3Gazu8dbZ3qkGptA5ESGJWoVQ++7
         akmK+NyAJcY7yUO8fokZ/d6D/Z2L6aEUvxIxtUfNE4akqdBa4xVXOTpnofBRGz1GdYqF
         ZTGVssazxVwB0QsTs1Ak4HL/WHlQYyh92LSeOE/PecG4dmGDlB//DgcLLy89IYN2LrQf
         sPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053878; x=1740658678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Mhxc0Zvns6Yn1JJtRPi3TJJp5srNdU12f0u9NFGaDA=;
        b=izSvfme6eA9e7i33bFb1FXwAYJBEWnoUtj7d0eTxj0V/EVVz6OAkvAslQqS5PeD123
         4zjpuVk2tgE5tO2JNeORVci9fClEpbm+T3ahfI8c01oewlrdU2jQNdadIK9qdvMIX0vi
         g4XPKUfKszzkGtxvKg9wnM1rLKWJWf5QjAqx4gOCnHqpfApz/CXT/DgJgYB5B3331tuj
         uqqEuYintz2J3cmtUzooRLteiorvhMwJep1GRYymxXjGa92Xrb8Gk7Va2OM7IcAT5Mc2
         uCGuvYCaoJQwGne9ZN9vgoL/lv3j7L6po1h8FSUvEi4qR2r35ke/9HveOa2Tb0me7fMG
         Cevg==
X-Forwarded-Encrypted: i=1; AJvYcCU25c+9uFY/HUVUHl9tou0wBJpTXJEkwtM86KPmMuwXExg2GT5xzS1FiUpNAKi0YXtFL8aSH89RQuPSMUyvaehn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1bwnYNsEfrsuOXGy1mvSX+x07kOH54kGs3VlwTe2sjhjb70d
	fxiAbKspMbV8O/9tdlyEYACrd2UNIKWsBFFItf16ShxcPjPvGucC1+kLGG5Hclg=
X-Gm-Gg: ASbGncujLAiTsrAeSaeQqh7Tw/GiSwgERXWDW9R0juoO968tkhhWcooaPaGbUfMCFbQ
	YyaVj3TRQatEGc/Dk3TSY5zGHmE6lp6Nn6+51eEO2qGOmirz+Cb62UL+XlpExUg3HdOdAbDGl9G
	gzXv94uin5Ztr8UuBmDccBicVD/kXiDDcnKjYXIrTSqufYLx/QaGqzYeVg/whoe93WbfprGbC34
	GyIryajz7I6DiCvMieUK3Z+HbSk9fapbexUMjrA36GlB07knSMEeMutuNoiuY4IZMW7uzTKmfyh
	wEjIclAA08J5cO3e/D/AOA8OMGY+/KrSfd1hbjvZL5BJIVG84w==
X-Google-Smtp-Source: AGHT+IGDJ50LQRWaa3WO9QsRF4eufVt9fyhtOZXwrn91dXqUgW/zlEdNiAcm4tKuEZGfurYEc02gAQ==
X-Received: by 2002:a17:902:e806:b0:21f:81f4:21b8 with SMTP id d9443c01a7336-221906a6c10mr37088815ad.50.1740053878554;
        Thu, 20 Feb 2025 04:17:58 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-221040434d9sm87773895ad.196.2025.02.20.04.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 04:17:58 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v4 0/2] Fix dwc_pcie pmu driver issues
Date: Thu, 20 Feb 2025 20:17:14 +0800
Message-Id: <20250220121716.50324-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
Only sent the patch titled "fix duplicate pci_dev devices".

v2:
1. New patch: "fix the incorrect reference count".
2. The "fix duplicate pci_dev devices" change is made in two places:
One is to remove the modification of the PMU name. The other is to change
"for_each_pci_dev" to "pci_get_domain_bus_and_slot".

v3:
patch[1]: Remove the logic of "fixing the reference count".
patch[2]: When pr_err, also output the sbdf.

v4:
patch[2]: Restore "platform_dwc_pcie" to "dwc_pcie_pmu".


Yunhui Cui (2):
  perf/dwc_pcie: fix some unreleased resources
  perf/dwc_pcie: fix duplicate pci_dev devices

 drivers/perf/dwc_pcie_pmu.c | 51 ++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.39.2

