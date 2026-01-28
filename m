Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A72C1598
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769582602; cv=none; b=Gy+f9McjHLC4FAGEBQ4/wr5Dy4BKccV1az7LIRED3ZHpYT831TWYsb72UOkWiYnnD0HTaOjJk3+XFJUYhDCRM10kj/YoO1/wLAJR4AUEvsgmMbx3rppDktEdS4jcAV991aOo77SxDHhAd6GTuqkOwAceNcK6FMojqjl11FeRKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769582602; c=relaxed/simple;
	bh=H37FwGBS1XecfHHxKKycNVzJApXTDP8at+KHdU0e4oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAkM+WJqXY/PcRyeQqEqIX1nra8Y0XzSWjsxcfXesHKdS6Z1+j8EhP+KeAwUJCiGvirEeRXfjjyWvs+fQyVPgIJQq/fijdujdZOS7I9k17hNVzvXeJrv5gY0ns18NmU7bGhf6rd7cOZb4Eazmvq0nTzKFKy5Bgd6j9eanrTysJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9cpGt/G; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9cpGt/G"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2500498a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769582601; x=1770187401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H37FwGBS1XecfHHxKKycNVzJApXTDP8at+KHdU0e4oQ=;
        b=B9cpGt/G2WfAIVDtBRc79aPUs7yDdsWF/imwDqC/C1n/eMfSM9Yp7OIHt0Ai3Mo5hq
         hK8tDlaRxN41z05xyQ4kyilkCB4rFzMkcpslFXPUFRxBaZcC44A5ARvei5dw1Xi1zHkb
         wfDOdXAPfguudJ1dyBQGEYrzZx+3Y6pdX+MpBwFKssJEiPllr9WY3Z34opfDvyKz9qqm
         L2+R5nlmVQ7ppMBdrMlOWn8BeA04JPNUBP9UHCnOi5erfV+x+dk1kByxRi62QiSgXVe7
         BQRMm0UWE3OdvwePmKTC29sVCEQaK33AzUokyvGGjJ96BlCrSkftsifbcwqZJp541XeH
         kEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769582601; x=1770187401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H37FwGBS1XecfHHxKKycNVzJApXTDP8at+KHdU0e4oQ=;
        b=W2XQvzOSnevczXKAuFU93L6QWphIZbG9xxAcbV5kJAeemkpsMdLqQEkEbbxDU0jRMC
         2iZZteZIdykfrfS8vsp+nlacjiJoGYDNg3SIrBQ4Db4DdwA3bENeyn+eGMg+kfIRLjdT
         L1Lca7ZN0T1L1fZvbYbWzOZU+7LDAtH4RQCdLJ9iidltSGjS7G6sNWMUsiS5Jx8rF9sk
         EKDMGnf6DJm6SW4OLw5PW+y3jzktC6Ny3cgdj8a0lHMwGTasqwXAoi6IigvpQYMbFP5+
         SfCnu1GzVSJrnH1t7InjWpUte0AnuzbNDugO9cBWkhCB7/QS+X5i11EIxoOBXgAA1S0D
         CoAg==
X-Forwarded-Encrypted: i=1; AJvYcCVS9ZLBVC4Wx8GkUB2Bm2ESdZQn7wQmGsV94ZPIl+8oGgecYfNxV15IBkv1Yk4ikGEMz3fGHNa7rmUlZXoDw/fM@vger.kernel.org
X-Gm-Message-State: AOJu0YyFzQhyiEoyOcsXjJGqUurGg1CsnxYjwL5Um0kP/7gafaNzSlN3
	2W3xuNIr2GGM+YSRf1vBLxxUqNpQ9RNoGw9c4L2hrn5sxoKLskkixLaR
X-Gm-Gg: AZuq6aJS2zUORbHurR59O4wzwhUbHRmDOFTsRRCYMSZkaaxmbX68Ddn8hcCGeDC5sbv
	Pc3SFUp3gDUguw7IKqcHr5Vcsjl04d0sVLmmio7fu5NPOHyrxjSBJ+mqyVavZmpk5pB+dUQvndw
	g81BB7XJ9zFPb+Y1MBRteRFCMnch6YczCcuKjWA5EUIkPRH531iTV4pcUcPaUwL8QhX82Tiz7T7
	5gMYwDG72vypIm098E8onnjG6+cr4SR4Vdw+qA0bwQ2P0gWoouyzN0V1I7lwU/GnxzwLU1jm6S3
	SXhX8WzDxLerFqtoIoJNJS9uke98N3r3l/okzFntb9/JHzcO17v5NIZPOPFO92eC33koyIlGg2N
	Y68YOESFU10RkSEad0IB6KapHNs3aKMrw0uAJu3KjIMlZeCuFXOfnDDupRy2/yjeU1FzgfHcnla
	NUT6nL91BAM32zdr61FhGK4vQX8ZSTe5bPvN6CVg==
X-Received: by 2002:a17:90a:dfc4:b0:349:19a8:e00e with SMTP id 98e67ed59e1d1-353fed87ceemr3281740a91.31.1769582600873;
        Tue, 27 Jan 2026 22:43:20 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eec9fsm12283345ad.8.2026.01.27.22.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:43:20 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: wangqing7171@gmail.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	yeoreum.yun@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/core: Drop an unused parameter 'ctx'
Date: Wed, 28 Jan 2026 14:43:10 +0800
Message-Id: <20260128064310.1863829-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107064351.3682174-1-wangqing7171@gmail.com>
References: <20260107064351.3682174-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry to ping again, would you mind reviewing this when you get a chance?

--
Best regards,
Qing
