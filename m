Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F153D3481
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933736; cv=none; b=iecZmY0HfdwxLQA5zZLQP18lCgCXppGBQs1UqRSOmCSwV2HIR8nAZ+fxLlZ0+Ce99zjFi20bmNczVxU/3hRmIIW9qoG5h6Bme+ppPE3vFdC9AivEJzVSaFtbK68ciReSlf4VZjR8+cY3ZPipozA6WYwJOvG65x/aMMoiUUjas4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933736; c=relaxed/simple;
	bh=53PD+YgOWvG+t6jY0mYLmozhCc3JR2zLfkumITTClGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOEfnH+XcZEQaBFrzIKDHsmi9vUx4k6TxH14OhIiptgnJwaltBoP57tvdiPBXsYATTOGR4JrYNcxrub5Xz0wiKlbSce4UugWSPayegYQhzhrhiPtueLlvKIZUg1XW92uAoTaoaVIxEwJRXowPQ+zDSC0qXMbVxLnM80mtShJrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aju1jS2h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aju1jS2h"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fd27754bso3546815e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933732; x=1774538532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgzhtROcSy0GjSIJM9ZevJQSmFHvUeLdqzObywMZV+Q=;
        b=Aju1jS2hi6dqyyehWyNnGiY8mPUafsNFaDVZRmNZfNpS6rbkUcN4XbSDJ3dnM4kC4h
         /O3s7gCoKOLq1RMP696UU+2DVuQa6VWQlu+QF+0WKOCoau1pXR6rP+YV2NV0x0UIs7SZ
         q1/63Tq6tuwmNFp4FmfVaFdlxvc7g/C/aoFYAjNvdbOT7Gtcrk/9RM43fC0TLukwF5fl
         V1XQsaqi+qx9BCJ3tTJ9LH7BVORwI7unMf8Ka7dZJqdLW3b6qu3B4gTfGDekJsjWhuts
         CFHSv36QgffV8SeifF6twtmwRXXQ6Xd7UQGYRW84TcoQb1vlGZ2UT94aRYoUMl/w74D3
         8Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933732; x=1774538532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgzhtROcSy0GjSIJM9ZevJQSmFHvUeLdqzObywMZV+Q=;
        b=Ck521HOoAqR9xrlqhSngRVRaCOp55XN0Z+6K5j2nAuTL5TmdG1VUAI7new1Wmg88lM
         83Vu22sBYD3X+8XzVl1wKG8gQtZrg2CXtNixxuJCnMx4wzqNeqHN4klJ0f8dGSGRraD2
         Olo1ykq38RCeMNEjlwRag3nuMHkUaC+8I82CkB6LJYbBp0crzPwddmUU12MieJjF6A6e
         AJqOHpflKBLf0lDhkjVX7ANY6T2HhvSFlzguwb9NMainWJ1j6iu+Yl7nhiho4KPVoTMb
         XujeVFPi89q7a3g6rSDjzzvsGwScRqFr6ALrWbdze4sLj8rhIQqW2p6Xrc6/e54cvJ8k
         91oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVJ2JqVN8Lf3pesQkX6yAzeiQ561gypQuaDtSikjHKU8PsT3QfZWcIStaAEeKHmEQCqG/J/Ejg/0P217pjWl7W@vger.kernel.org
X-Gm-Message-State: AOJu0Yycr7WRX+yXzXZOCbad0aY6bCRdBb55vgYtwd+3t96RYT2WMT8d
	SfBLEnXNmbtAwDVHr3SAOmBthfDeisgMDgIHp5xAfQk/KbLxRIC7n0Xf
X-Gm-Gg: ATEYQzypM17Ai4xQvGR4Eu3cczicAkQdvg7QJUAaStuu1gddeoNl9x/5E/AEkrFCAyz
	GXZbCa52A9rKAaoQmf+e/CDezYgeCvxSIHdoXoXSCJGkWrZ50HhXOTA2kvzXAa8RwbP0u5UpjKT
	xdTnwLtp72ElgqWSrCr7n0oCwTt0XK4HKGOzp/pUXjXTivZRCeSUOuc87vEsE4ApuW8unuP8cj8
	lSBXA/EtejTFwSVzfqpopHZWRZT808+8Foy+mOMkHqKS3r5DPO8zwf8LVRzKn32s+va4aXpygAP
	5tTDVmWtkrCKAjtAyFR7hfXcAhqRNKg1/R2eRhxICJIP8wpljWEhuSI12XER+Q/jVVKuqJdDo9i
	83hXpS+kfuD3ic26gMDAbtM6FzgVpGWCESCjXcR7fVZottel5+chT0thIHbr8FzT3qdLPoc+MlE
	tgTbL4/C8har8Sgt6pMPJ3ttVQDniorpwHay941ddn9G1PuifIK/+I
X-Received: by 2002:a05:600c:6c0a:b0:485:3471:cffb with SMTP id 5b1f17b1804b1-486f4446343mr100334615e9.15.1773933732137;
        Thu, 19 Mar 2026 08:22:12 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852097sm16808860f8f.9.2026.03.19.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:22:11 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	hpa@zytor.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] perf/x86/intel/p4: Fix unused variable warning in p4_pmu_init()
Date: Thu, 19 Mar 2026 16:22:10 +0100
Message-ID: <20260319152210.210854-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Build the kernel with make W=1 generates the following warning:

  arch/x86/events/intel/p4.c: In function ‘p4_pmu_init’:
  arch/x86/events/intel/p4.c:1370:27: error: variable ‘high’ set but not used [-Werror=unused-but-set-variable]
   1370 |         unsigned int low, high;
        |                           ^~~~

This happens because, although both variables are declared and
initialized by rdmsr, only `low` is used in the subsequent if statement.

This patch prints the full content of Model-Specific Register
via `pr_cont` and so both the low and high part. It is also
very useful to have the contents of MSR_IA32_MISC_ENABLE
in dmesg for debugging purposes.

Running `make W=1` again resolves the error.
I was unable to test the patch because
i do not have the hardware.
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 arch/x86/events/intel/p4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index e5fd7367e45d..dc2866ed2495 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1383,7 +1383,7 @@ __init int p4_pmu_init(void)
 	memcpy(hw_cache_event_ids, p4_hw_cache_event_ids,
 		sizeof(hw_cache_event_ids));
 
-	pr_cont("Netburst events, ");
+	pr_cont("Netburst events,  (misc_enable: %08x:%08x), ", high, low);
 
 	x86_pmu = p4_pmu;
 
-- 
2.53.0

