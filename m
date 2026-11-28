Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838121;
	b=Rfi/wn8g7Kl5RaSj7X3RtGKJhwcNXHFOJ4Psz73D5H0PL0q3/6apLaofzEo9mr2npXXb
	 LRkFRQDvxdERWmaNFd3Kpj8gh5YpSyM4bQc9laFMo4hmY8guIl6LDQQsLD/QAo32B7gLy
	 Tc01gMInHOl62thaGMtqX3SP4rAol592/l1nezJF5Vke3hDvVvggb+fbqsaWmCsDW6dq1
	 nvwXFM2EwlPCp8BJXBfvIWZZVpgsDsvjuW1BmhVLUXXSCoby0PsAGad0yPXZhAM78bVib
	 uyF9mqnfc8dVyLiWSAYA83CxpF3y/50nmrYP7g8qTHaHCpiwXWxSyzC2DaVyIqLVDvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=enxt/986nFOJL/Kw5285Yz3R6sMYq7dFGHkTphEST5o=;
	b=s9SYlnmxlfvHEdE8gz+ZITUTM5DM1VBXcXGcZDEJIIy48sGnXeXFT64UENRqY7bOa9e6
	 Sa9lhqjL6LymmwRMMSwB1/CkxXcwhu56Phjmgqdm535zxRmI0e3ATDwsojweh73qaSE63
	 +dKkAuyeBk+rZ0ezCJqIJ+ZRmSTaQIqx7vw4LbXOKUpnS/sv+eTscOP8NtuBJuISi7Mid
	 o/jDK6cZzAQrj8LBHHMX+X9ObEejrq0BQl/x7iQxYbMqrPnx6Y0aeYbRoVjPpaYpkwY8X
	 4Iz4O4K6WYXXiaz+KvdWwKYX0iH7yusE70a7mqLbQY/l/1/fH8RPPN03wtgEqU5nmVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBlWkLK2;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86B606A323
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Nov 2026 03:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A86B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBlWkLK2
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f01f296937so64899865ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 19:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795838121; x=1796442921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enxt/986nFOJL/Kw5285Yz3R6sMYq7dFGHkTphEST5o=;
        b=uBlWkLK2waP/TSyi4w4kaGHKIWiiFOGOwrqCs/uxDqONP5YWBZDqvVdRr3eFUy/zUE
         zPQ3gR/OSMtJrWvrt/AxCXtnohJbmjUfHYkBsYxJFo3E8ZjdBlt6o2ezX7t3BT/7XVLS
         D2zjik+AszPtgtXNxPkQF5HwyQa4K08lm9y9FLIqk68KnBWvusWbO5QsZ9XXmikVGCCh
         IXRL1jti3zy9+Y52Ee38/msXCuZcjM67dHd8NcmJS1CVJcaQ6FQ3Kw2H8cz4THlyIylH
         hzAoTSvCGwqccxQgBPtHVfRXLzXMBoPUumqxeRSc9NkGvfj4sQZ2paXDvJHVCsThjMzr
         ILhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795838121; x=1796442921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enxt/986nFOJL/Kw5285Yz3R6sMYq7dFGHkTphEST5o=;
        b=yDLg6l01vc4Eg3YW2Ah6ErzqovUQwISCtlcYnBUSv8IGgbRFY698J+7NS552ux3tuv
         5gHOeykBUhDmMtTY5SPf4EwrF2KCNJuJaRTAvwzTyCUVyX/fB+B63LW+qgr45kMoDG6G
         J6y8R32SElHDyuY17QTF6jFcDIbQg6lpjTYD5TyyBVjrSNU0Le5UNmPayo4Ic1jLx0JM
         WIY1MbjeRCZrDCepGRCL3KaSBgXILeReuTqAsDicA4FUq8CAxZ2700z4IQZXQkil4vpB
         UsoD26Ns1CcKI9r+/2HcQ7Tqih7ZjlXOrKc2Q+AflvWihJdzFBrlL2GN/U/D16aPUQ7X
         ddog==
X-Forwarded-Encrypted: i=1; AL+hErFXGGCi9+eoFSGlI2ip6tPBRnGmwVHKy5BmtcSBpIHZ8pqjgX1hOYQwo2tgWJdfYw3b5d6BsdVbPzSwT8iM/ZP9@vger.kernel.org
X-Gm-Message-State: APuU4Z/C66pEPZXRlPS7NYmQV36LNUS2GnLFbrhex/b/OIdXRmxaQR08
	Wf+usq9yp0BrNhT9p0VyB2mTUk5x6mW8qJG5Yww/94kRy+77mtQRnFWY
X-Gm-Gg: AZFdTZf1/7Rw+sam3YLBvj3QFuShBWauxaBJdrQZBxPjzFsQctiSfEJhLJsKy6o19K7
	8geD5jnWRxR5QtOfykLr8oxy07CcL/6MPXKcvjXr+kFG+nV46fpcqtXn07AR73nEyCqpx5GnWzS
	B5Gtjo86O05Qb2yqCGHfeVvHhP9z5w7pG6OXZ2hu0EhH/cVimghc+c9Yt4R8rRu3cnbfD6sRjLs
	Aw2JpNN+Pl7vQ/vXCqNSk0EVoQpEf2XlmWH3Vxsykn4qHYFlzpghQzIYquwSOKolINAg1+BE7O/
	FjNccqTpZdBN8qpRQ6naxPcWSl/rVfgsvewoACXcHBTfKFlv2sea5a6DdLjThQjnhhs4+bU4iVP
	vHzOI/Pz2tgG2IZii9CEgXOA4pkoWQTOhUAxKgtFT+3b+8+lffLEnW8t9eGNkgoGYGo/aZ0YMpB
	tQOE8MYp1hMPoE0jIgdU+P+6EU4VoxeokoCSVdTb5uhn8BtoS+lYKYcd3TqJ8YXEi70aapdW0bD
	F89srbrHzxOLq0CU2t+h0QUh6d0XtAjDFn/7IbE7hXFbaxvaVpmZ+vM2GgIWqxF07Y6ApAy5xhG
	neCBYIFE5mH/OstmTuGjoC9ZpBk=
X-Received: by 2002:a17:903:4586:b0:2f0:1f25:a4f1 with SMTP id d9443c01a7336-2f03f1cf6f1mr284743595ad.15.1795838120840;
        Fri, 27 Nov 2026 19:55:20 -0800 (PST)
Received: from debian.. ([192.227.246.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f099a4d875sm89190595ad.37.2026.11.27.19.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:55:19 -0800 (PST)
From: Harry Bit <idleassetsd@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Harry Bit <idleassetsd@gmail.com>
Subject: [PATCH 3/3] perf: arm_pmuv3: add Phytium FTC310 and FTC664 PMU support
Date: Sat, 28 Nov 2026 11:55:04 +0800
Message-ID: <20261128035504.760778-3-idleassetsd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128035504.760778-1-idleassetsd@gmail.com>
References: <20261128035504.760778-1-idleassetsd@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Baozi <chenbaozi@phytium.com.cn>

Add PMUv3 device table entries and event mapping initializers for the
Phytium FTC310 and FTC664 ARMv8 cores.

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Co-developed-by: Harry Bit <idleassetsd@gmail.com>
Signed-off-by: Harry Bit <idleassetsd@gmail.com>
---
 drivers/perf/arm_pmuv3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 03359e0783..42f043444c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1559,6 +1559,9 @@ PMUV3_INIT_SIMPLE(armv8_rainier)
 PMUV3_INIT_SIMPLE(armv8_nvidia_carmel)
 PMUV3_INIT_SIMPLE(armv8_nvidia_denver)
 
+PMUV3_INIT_SIMPLE(armv8_phytium_ftc310)
+PMUV3_INIT_SIMPLE(armv8_phytium_ftc664)
+
 PMUV3_INIT_SIMPLE(armv8_samsung_mongoose)
 
 PMUV3_INIT_MAP_EVENT(armv8_cortex_a35, armv8_a53_map_event)
@@ -1613,6 +1616,8 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "cavium,thunder-pmu",	.data = armv8_cavium_thunder_pmu_init},
 	{.compatible = "brcm,vulcan-pmu",	.data = armv8_brcm_vulcan_pmu_init},
 	{.compatible = "nvidia,carmel-pmu",	.data = armv8_nvidia_carmel_pmu_init},
+	{.compatible = "phytium,ftc310-pmu",	.data = armv8_phytium_ftc310_pmu_init},
+	{.compatible = "phytium,ftc664-pmu",	.data = armv8_phytium_ftc664_pmu_init},
 	{.compatible = "nvidia,denver-pmu",	.data = armv8_nvidia_denver_pmu_init},
 	{.compatible = "samsung,mongoose-pmu",	.data = armv8_samsung_mongoose_pmu_init},
 	{},
-- 
2.47.3
