Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60C450F2;
	Thu, 26 Dec 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735203141; cv=none; b=JiWRCcHBCwZkIKaCF8S7uCawAtSpRgdqk+TW37FGPLg1EHz09+XtLSlOUNT0OoE4boYxA9GFosY/FjIkc17mbd5QxoGfHbh5oSeninfty8U6zralwGf8irAIREdfdPx3QcoxyxTa9Ex6mgWcBlkped1KdZMF6PUc9lrOQXaVgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735203141; c=relaxed/simple;
	bh=y3MDnf9APRyVNkUWNScj2N/lT/NU+GSm/yqDaOzdfQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgY+jKSu+59P8hbL+iI0kdNglVtBG8cVtADYc9crnMYfn/889xwHgvYz5RMv9lP20yl5yBoYY19BgoQGZOOB5bvHTBCMWZnpZpV8UWeZ+9QY6ttEgnA8JNH6PN2UdC98pTTo9cBidqMefOBllUfpfIJHWgL4WD+6r14H3z50YJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEMonk+o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEMonk+o"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166651f752so80275505ad.3;
        Thu, 26 Dec 2024 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735203139; x=1735807939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1/FHK21TiSzpXyc84+XjMopVnuyAMmvHiyjJ+iz1woo=;
        b=BEMonk+oqlwjZX3bt9ql43rap5703g3Efm3pO5x7832nU29HH0mRS/c3cG5BIbmlS5
         YQOfzD1XoAAMxI5GzOzcO6jOTdjdMg0PMnedHH9pwNxTroENihQu/i7KWU+yCgJEzkZS
         vQw6uvSPDS3q6Z7P5MyBMH+7/hNls2lUT70EiUrf+vKKBNXKAEnhFZa1InKYKdVAQqj/
         QWwGnwDxY+OAie6Tfa+uNe3x1rFPJNu5u0KSCO6pkpN3xGGJVK+uUVpUFKJicq6Xyeth
         zy1RyzWb7BUOCEfChmwrndVVptKxBGXkRoxX1/fBXKIz7YRvk3JPozZr9LyI8P0gCwcl
         LejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735203139; x=1735807939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/FHK21TiSzpXyc84+XjMopVnuyAMmvHiyjJ+iz1woo=;
        b=iNKcrRWpyJ9Ha2IpYZkK62iAh6omrxBP4f5YtxDseaNnriWeU8rhdTFT5K5RYQ+LQf
         oZqRJXm/HyWXT+TCKCyC4y8ROlus9Nz5CuyYFkjM8DfBH69yscBteh0fNcg1HDq+UDTW
         vZGZ1LVp3tEvlPk3QDNPopm8LFdsYj460GNfj6efE6Zn1tDFkYctcZIvHa5c/gBiC7x+
         vIr7ou4sLiE2Rd5JxLqZmDsWEnkBs7QuB1S6uwabWTQIse9M9YuCVZUqSEL4CJrVm+FK
         g48xpiy8qmYgZgYXYeWnDk374R5RP02lbOmU2yRnd5q8CH1JJ8VTaKgSQbqnMF0BuNhQ
         TOIQ==
X-Gm-Message-State: AOJu0YySw1hEjYAxw0n4xaQ6mZZNBQHXFUiXZff8KpmqkV8z9fMcbpim
	CSqFs1CiYIQ/QMBEpYzEe23rUOJzd9aqV+i/POnqTJmJMoYlAIsF+I9tjCKGdPB+Jg==
X-Gm-Gg: ASbGncv80HPw96asUMTphrt+kvs4RnBHlP5uGBY5dlc51/9zUHnNlpgikxMtIAtZ+rK
	yEpKDoMcjfa1VfgXTik+PO3WINoYada1QpsMapKW34BnQyIbR2cHa9pGREVPB+XMNfm8TB4EqI4
	eH3zwyhdesDpYaMKKxisFxSargwBYz1I1glRi0YRuccZOHiT1s0Hdc9c1lVwm7afv0npQSsydbX
	ktASUV52Y96mv144PkoGLjJhtjIRFAHzBdAtW9Rc8I/MJbk3gWrx1QhrevPs0TlVoF/9TtWJ21F
	I2nViirtCGgw29LF9kLF8mdKEyJbSfGF
X-Google-Smtp-Source: AGHT+IGXtdDx9kJp5+dCkDVMifd6pDRRWa3JBPmpgvM4tfgi3HZjepBGCXQ07+C72hp3KImSpH5BcQ==
X-Received: by 2002:a05:6a20:6a20:b0:1e0:d99f:7ad3 with SMTP id adf61e73a8af0-1e5e084b3f5mr35687006637.44.1735203139360;
        Thu, 26 Dec 2024 00:52:19 -0800 (PST)
Received: from victoryang00-ASUS-Zenbook-S-14-UX5406SA-UX5406SA.. ([101.87.29.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90b2dcsm12419474b3a.171.2024.12.26.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 00:52:19 -0800 (PST)
From: Yiwei Yang <yangyiwei2000@gmail.com>
X-Google-Original-From: Yiwei Yang <victoryang00@ucsc.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	hpa@zytor.com,
	bp@alien8.de,
	tglx@linutronix.de,
	kan.liang@linux.intel.com,
	adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	Yiwei Yang <victoryang00@ucsc.edu>
Subject: [PATCH] Add support for pebs fmt6(Lunar Lake)
Date: Thu, 26 Dec 2024 16:52:11 +0800
Message-ID: <20241226085211.42872-1-victoryang00@ucsc.edu>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Yiwei Yang <victoryang00@ucsc.edu>
---
 arch/x86/events/intel/ds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1a4b326ca..0c001844d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2516,7 +2516,8 @@ void __init intel_ds_init(void)
 			x86_pmu.drain_pebs = intel_pmu_drain_pebs_nhm;
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
-
+			
+		case 6:
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
-- 
2.47.1

