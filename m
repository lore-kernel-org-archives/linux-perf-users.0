Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FD1DDA39
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779325; cv=none; b=HvoJ243ma3EitWm1u9OIcUEtF/G4ATsxUzMiGk/fN9ysEczRJaeWoz0dWEGBGsblV7JCtoW9VViifXJQ8gXcGMG47X8EoCR4ctX0ZvywCDTUcx16NmtubupuQnI5+Z45Ex4A/LThqeiQE1ZZr0hgHOhrUtbUDq3e8XjBgpANaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779325; c=relaxed/simple;
	bh=iGzJGe515CUur9bWUcIYGZiPyHtVU3RqmfKsBAUtwhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eQcW3ep5qwF+f7Xii+F0QpVmlgXUmGgW4HaxKhFj+PWAnvUn+aQ2hbMiH3Y2pL8YdLIceeCdbebR6dmjEZ6jLc6ogmppYb4zVK/IddkmI7anBDcvu1rM0odC9tb82jT1KL5rnFYJZveSRNl4EKgkILZfiZme6R1gg6AheBwFXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Mm3R3GLv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Mm3R3GLv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234bec7192so16885435ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 13:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740779322; x=1741384122; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFuvdTQZPIN6OkYzDzsbA95MHpd2Xc4kGPJKgNu6mrI=;
        b=Mm3R3GLvdQogE2fT52CMFCyZe1Ia20Koavlw/6bA6fiC621YOGJBu4ZRfaETLlu5YB
         uArBeuGiGPj438RY6pPGeICRwbDpJatdBfCVfF1oz/nC/PcKbBxX0cSme0y5+0a2SouQ
         KmStYQ9fP7D/6polTnXxPjbuqISkO4bSFdO4OCsp7BVqPIVsNEH7TqHUniH5FgfKeM8q
         NcAnx0gzKL9gwG/Vn00hlPmighH5Nee9NAuvOh/Bq2JfD3HM8kX4eyT4N10ylDih0qPH
         WDJYgHRGSZIzXVmOmWBWLRSCtr32kb/OypgZs6mP/Jl42u30idDS+58S7jSNaRyewNK4
         b/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740779322; x=1741384122;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFuvdTQZPIN6OkYzDzsbA95MHpd2Xc4kGPJKgNu6mrI=;
        b=l5uvfOEZhIKzI01A3fAKCZtETQQUtbuuHNlOmykp9jfqbvrcSNcL3xJsTJA6pmIxhN
         QbTBZiX0rxhcq73pwnNOswCjvEZ49EfbztB6r9eEtEk3BtNVF43KqVvLizCXrBEnEDPq
         yjIIwDIqi5Uu3MI2xVw10/fSfaYPCDnexTkXj7bfY2LwfeFZY31tm7L5KXeJPzvjP19S
         4F8/i7F7Kjf/dF9vjOFiUY+mXAVnVXc9W5lkguZyr9hgGgDGkiHHvL05puNPdyxsC8gw
         S6b0I58Ud1hen2yuCHQCp7Re4m6SITwSVOMSecIbgx4oRRzEjvJhAdh+rE0ryckxq7n4
         /OnA==
X-Forwarded-Encrypted: i=1; AJvYcCWgXyCfxT3r+hoS3BHFcYAYIMuQfy60vWlaGVTxUgVXsEyQJmLeruxEvtywJ7LHaA9b6DR1B/xPguR/Y2AlT1Sw@vger.kernel.org
X-Gm-Message-State: AOJu0YxFx20X4DPTLkmk9yxD4q/Ua0+qpJznpletRpaKw2Wi6HfzctI1
	AZQRFh25rln3g22V6PT1hgcbg2vXDj5TsbqqQNBCi7NFtZhHvaN5EM7XzMHKThQ=
X-Gm-Gg: ASbGncvzaW5R8tQBzgOnOQmfQNloG0rW9aF4E71k5WsE2pCLLjYdMDcvqb11XMuIla6
	m3jqJiYkyrxTAi0gnIQXKN+QES/vrAh4epJFWzrZmH1XWWLHpTgDuJBm+LlUsUK68Cbjyr5UdYy
	Z0CqikscbC7mpgW79pan5ClNa05/9F24o0OYyRrixi5NYA1vzWyLlm0OZEvYE8RDABq/HCKVr3n
	4y/jG8h4MkQ7SXr/hFYnjucATYtpRXsQdQ9/fRe/o+mcXH4FQ8ukO/qRL5GjGtgANr9W0j6h5tL
	500CdBkdOZCj9k6vjAMgwPoBqqlsX/djbK3RdwmWWnUX6nEFYnWIBlNzy8IF
X-Google-Smtp-Source: AGHT+IGLHFibCf4rR3YeNi/hxAYcmyn8P5xU25tM116D7BQQhjBZlmI4MLoRZukQW9m3LFy0EK/MtA==
X-Received: by 2002:a05:6a00:390f:b0:732:a24:7354 with SMTP id d2e1a72fcca58-734ac32d058mr8494619b3a.4.1740779320282;
        Fri, 28 Feb 2025 13:48:40 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48882sm4251180b3a.48.2025.02.28.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:48:39 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 28 Feb 2025 13:48:32 -0800
Subject: [PATCH] perf tools: Fix perf object dir symbolic link
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-b4-fix_perf_symbolic_link-v1-1-3ad734838929@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAC8vwmcC/x2M7QpAMBRAX0X3txVDPl5FWnPdccNoK9Hy7pafp
 845ATw5Jg9dEsDRxZ4PGyFPE8BF25kET5FBZrLKpGzEWArDtzrJGeWffTw2RrWxXUWDWNSFztt
 KI8T+dBTN/90P7/sBUi2HIWsAAAA=
X-Change-ID: 20250228-b4-fix_perf_symbolic_link-8cc373a195ac
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=iGzJGe515CUur9bWUcIYGZiPyHtVU3RqmfKsBAUtwhs=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/ohfcOHer7M02bKHcyfOr+jh4dD+nD4Sy0ZdTPFJ3G/V
 nvPea3VUcrCIMbFICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwESuSzEynNx57Os17VOxu0I+
 RgWJ5gmX8VY8ZIve72qq/X/3q7WbDjP8r23gOTX5GeOURve5u267PLFRlW5fHKN4PUFuB7/IsT5
 LXgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The -n flag is needed as an argument to ln to avoid recursively setting
the symbolic link when OUTPUT is the same as $(srctree)/tools/perf.

Without this flag, the perf binary at $(srctree)/tools/perf/perf will
become overwritten with a symbolic link to the parent directory.

Additionally, remove the forward slash after $(OUTPUT) since $(OUTPUT)
implicitly includes a forward slash.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc..0b6f9de6f222da1181402aa33e41ec3b05f9189e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -158,7 +158,7 @@ ifneq ($(OUTPUT),)
 VPATH += $(OUTPUT)
 export VPATH
 # create symlink to the original source
-SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
+SOURCE := $(shell ln -sfn $(srctree)/tools/perf $(OUTPUT)source)
 endif
 
 # Beautify output

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250228-b4-fix_perf_symbolic_link-8cc373a195ac
-- 
- Charlie

