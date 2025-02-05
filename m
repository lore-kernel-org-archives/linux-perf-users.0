Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCC2135A3
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725280; cv=none; b=SERvPovJ6YzAU8a6M5LIdUQAg0nl5f8kHH9B7z70t3+K/tNsCENVfNLgLfSRuvShDHd5FLQStoj7h+kmoBvCHP4wmrRp9Td3ohahJwdVCmcvY5GQvWJ/Nk/lEZ9AoCRlG8kPgTQvpNjYQISjyb3WzyW9m7msSPnJXiSUXJ/b8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725280; c=relaxed/simple;
	bh=0Sn9GaXZFrryUTSxKfT70QrPR+o+tlFtxRyHWIRxPwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXE4PmU2mKTvEmBeyi/CvgSza2+QBkgoBXKlsErPljA/bDrWNIehwCXQVyePokVlt0O0pzPev4+86Kb4fFn6utKowUvOL4lyhlG7qxF6iRV5gcBO+C3MmzZpMqSAW8T6iNsCxTCpQi6sHx3wqKCnyw37YLG41sgR9j7jyNzQ6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C9xe+vqe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C9xe+vqe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215770613dbso86533785ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 19:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738725277; x=1739330077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYMUDf0U+sam2c6CFInFyZHHseSO9b7zpf93O7tAZgA=;
        b=C9xe+vqeoMHo+e+IykpYffj4wbx3BXw3Hp+tALsKwO/1af9zIiB8Gn23gn0tjZSIpd
         BFzMSNlFlZAy8xco99ZRb3QQlyoErZQ1U7BHXXBzPU0XjDxOjYCtAK+lsM4blWoPtNhG
         VS3AT8Nj+uUJrO+4NSrBfmE1ni0bNmdTXx2XSRQxg4RjcEfseiEpxCSCDUoq9O0BaoQ6
         RkTJ3sLOha9omwjAsqEKWFTQxKkvenDv0Iw97+WQzpSOyFZVoRQQb6OtlGUyr/sxzGjQ
         6vFnLIWcEqT4zc9kWRXtf5ZDgaE1eig3O8y8stEUwhkQ4x09Jc8q2i10YkQQggsCLSQX
         0bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738725277; x=1739330077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYMUDf0U+sam2c6CFInFyZHHseSO9b7zpf93O7tAZgA=;
        b=Q88YVu7EzeUNFYX6DqvmJu25I93cdbKjB1YTDPvOjRkFG65sCvXcQT+nqESzP6wPki
         0c5SSkQhkbVecm9z2vRR2AmM4Bo7ZgBkt3dfIExMg70U2te8NDk4GE9J0zG2b/NQDSL5
         ZAIkZwSMWEmmeGaUHsMnPC8//C6T76BaCNobAPAJ3yxqKw9rQUPM3Tz3FqT1gxg7yGH5
         fN5WZt0TMvP/TMGHh+ofKHvaqbNhiFqYRZVG/C82bAINHbM7E1nSDduStwnfJPgYVDCd
         ZOqAf1pKgeL+K/kGAGtAl/jZpAiGz94y4LWnuUAVPaBW54HTFv8bpei4SVkUUxKrMxbD
         cv2w==
X-Forwarded-Encrypted: i=1; AJvYcCW+4SugaXCB0T+u3cfIpMt1uboqYn94C85tcy7PY8jNtm02BRE/B/RQVAsvtKka/GR2xgCCUGY6Y5nj82RpfZHF@vger.kernel.org
X-Gm-Message-State: AOJu0YyasW5zNSt9FTXr7hkudcxQ1isJHpiqcMcqOLB6TKkDeXzWZ9hF
	X7CaSUr1SW+xudC78tlKq4U747ol2A24EqzxR4nKYx0WW3Q3nF1KY7tKwfKhhew=
X-Gm-Gg: ASbGncvKy/jMzBYhFo5YVqSfdAQz0kw0IV4yDxmZvb95n1vx759P8i4X+MKZoKUr6Xy
	Af6RKwaGYdcOGimdBCuEhRwqCWKnWdnKd8GBnb831SwS2LBJIBDupG8CZZl4pwOpZ2RvMORj8DF
	RQ+o0yqJwhY3K02VyEMHgZgJdG2y6r5UmyyaysdMnBciL2NhsI6h28onlevQh2SoW5DZQmvYpIG
	m+XA+hmZjJFIDEVOqx+ODhI2HEjDL6sGeK+HvNZrmX6xxPqsUS1tv49qlz3VLvywePSgxSeVGe7
	JHJnRrORjlMLviCVzUu2Yjkmix6ZkHIqxM4ZLIAm7NvvsoM5VQ==
X-Google-Smtp-Source: AGHT+IFDPCWHUwtXqg+k70YQs3UcC9V7LP3BF4/Ea4bhDSCyvX6XTQ9pdwUU2CcxAcZ+siU2q2RAZA==
X-Received: by 2002:a17:902:cecd:b0:215:83e1:99ff with SMTP id d9443c01a7336-21f17e48cf6mr17420455ad.27.1738725277309;
        Tue, 04 Feb 2025 19:14:37 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de330342asm103509115ad.193.2025.02.04.19.14.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Feb 2025 19:14:36 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 0/2] Fix dwc_pcie pmu driver issues
Date: Wed,  5 Feb 2025 11:14:23 +0800
Message-Id: <20250205031425.67265-1-cuiyunhui@bytedance.com>
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

Yunhui Cui (2):
  perf/dwc_pcie: fix the incorrect reference count
  perf/dwc_pcie: fix duplicate pci_dev devices

 drivers/perf/dwc_pcie_pmu.c | 62 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

-- 
2.39.2

