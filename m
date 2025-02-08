Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09B1624D0
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011213; cv=none; b=QTHrnm5hecWEy/7zX+QCMtwPVpnatLz5RDpTRJbP8pmamkuZZOCY4t+m64gFTyW8MRq3mdGGf84In56b5IWNos3oBVC2oLjSIhc96jUbpNlFE7VY8XawUAhmkbrO8IAySH1MqTHil6rHYIsu956sHayOxpyKq8KWkN634Qr5X4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011213; c=relaxed/simple;
	bh=D+4al5bpw+xslToZvxzJ/o9q863peT9z4PAuWSJBj5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPesZuSKYfrlnHqpNi3ce8md1KaxG/SMBqf47UndRErrD7YlXjWAscGPhoIxJg/9Uptta/kP4n5KjPhdD69tt+uYeAtdxQkWtAPhqUifD6BGAU/gD9K33oDOYXGuVNcrWHuNM5gVrwBA3ItnoXyGVUpbfp9rkJ0vmbtZWs/BdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZAUlXGxc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZAUlXGxc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f6f18b474so3617555ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Feb 2025 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739011210; x=1739616010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KovnzCgz7AwVJ6lEFg7h+ozZOwfcsBPGYDizlK0um/Y=;
        b=ZAUlXGxcV5huqWFHRZTuWhTY78d2tYM9yFvPaCASkgQr8OcjEVjixVeoe3D/YPT86e
         ztnJNFZ33hBTicsQqGxzjGGHP1xgR1m3W4zgySOHj5t6WnNmFc1LtPL6msq65k3EWh6b
         VISlh1GcuFMUr864lX9ffA4AbJeAJgRFwPWwr9oat/dNmJfDdG9nQQ5+3JqdJlWVjFQY
         50sYHCbybZWWem+K0/ihJM480nYBkA1c1WuBm8yDNR5MeZnrHWLiwWgmB1XGvxThgzDd
         hPzkr6ORxfBdWrPjnVJb3/8T2ZBM7i4LCdBy4E+/F8ay+xciwMphDLo/fshljr7TyxU3
         L5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739011210; x=1739616010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KovnzCgz7AwVJ6lEFg7h+ozZOwfcsBPGYDizlK0um/Y=;
        b=b9RG04Mj/9PN/gUtc8ogkaZ76yZARf9pS963P2HMLQXvsXHcN/dF7vN5qaLXKLY2Oq
         O1/rrVtbppIcSxgMhK5rtpuKRWo+WU8M7jS808BkCFtp5LKiNiUR20Ohh6zvVrFVl+KV
         XSIveR9zrrHOGtLiVqkybIXXStIpVafpnBgUZyA1nOm7N0Zk8MG1VnjzUZ1irpTHP6ie
         vzj3MeTJ2nspHj1mydKjuUCqE6aT2xOiozArATsL2lxIUA7ia8LwvoyNSNnssaBykdIe
         CmQmwYFC1bYMihv4ZlbEqPJsprI9xosI9lBDZH6wUq82EA/WdhDFxxbjRRu782APdbqi
         YpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVL8YGP5KOfc5XaYqHdbvXLyKyCwOoYlM1VmuSz/p7ZleOFkKTBsZ+ssGWHOx/ks5QRnIyZhkqlJYG1y+52B9SE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QdPnQfs1XJSEJfpqfvOpENVqXNX7KJajECQLh+WGy1VR4cyC
	LFSboT+yZA/KEzxdcr3yUOAx2jfnTR6qVld6dq/eZPX5cEVeATdyBGbwhNIvHsrJOMwUcJIn/KG
	WUzw=
X-Gm-Gg: ASbGncu39DBAgFMQ9EhO43ZdArdY+nYh1c3+jSodBdKY7NnKOX1M6YFixi+wWHk42hb
	/iVWlcL8ARnG4lwiG4K0aBLGHJJO6DLMAbpt3pa5/Ad1qwOiefV1rOJgyt7sTYlLNuf10tYwU5T
	MkAIBXji4cB1Pn7vTb+s8gYmDHj0itygkULz0QFsZ6+9nHbWG5J80qTTnzlEOWAxhwVH9Vc8z88
	htClCx0V0Ort5LB5Bsx5UhPrVy/zFg7En+tkXFNoQbsgmtcD0V21zSzakldMJEgAiehnVuHmxpH
	ZcvwA8Dsf6STyFtZwgG9PGn43TU+STse211o1dmEKdUwe9vFBw==
X-Google-Smtp-Source: AGHT+IGSPFgo5QCYcimkb+XiEeh3bQEyqeTJJssvf5CdfYBuqY0b4jRyXxCKJwCm5DVcccofry+Jsw==
X-Received: by 2002:a05:6a20:d704:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1ee03a41bd3mr10089837637.17.1739011210415;
        Sat, 08 Feb 2025 02:40:10 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5460b8d4bsm216325a12.11.2025.02.08.02.40.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Feb 2025 02:40:10 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v3 0/2] Fix dwc_pcie pmu driver issues
Date: Sat,  8 Feb 2025 18:40:00 +0800
Message-Id: <20250208104002.60332-1-cuiyunhui@bytedance.com>
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
patch[2]: When pr_err, also output the sddf.

Yunhui Cui (2):
  perf/dwc_pcie: fix some unreleased resources
  perf/dwc_pcie: fix duplicate pci_dev devices

 drivers/perf/dwc_pcie_pmu.c | 53 ++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 18 deletions(-)

-- 
2.39.2

