Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAB13B293
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202190; cv=none; b=LHnSUqseL+EQS0gbncHocQHOXJgpWsESTfAmQqI7cGVMIJhqpz3hEw08eabi+ERR8jnjLAW/29L6npp0aq8sOJOEedQtb+JPJBk2Va3i4wsJGTZ+cjGv/ZRxnCyCTfL/8PXqsGbKPIUlOOjYFFibB5sajkEhhyZxZDORaUSM8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202190; c=relaxed/simple;
	bh=XzDXuW7sU8rtcOd5zk/hMQc5CYYT30++tB7FfX76MzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9paTMFaxKh5DZtxi0iB/uX6bg1VNfVUZAgSfiNJcnx4A+knOqxnZm4Tm41+hq8fDDtAQOyjyZ3HjkV22MKtb1xo/PLlTORtjVTJYKHKdEEKtvcWpEknIrgJDRu94ilrvs2/vgxQnZtDYRgKlQDugALqLNo0bPAwHe2+1e2HZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fszfe2zc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fszfe2zc"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab395abf79so4441587b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 18:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792202188; x=1792806988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yiDiU01DIEHMV3YQU+fkAajpEqVu8gHxIrnBDEjtWE=;
        b=fszfe2zciNvw1YmntPOInLymoB+tMNGzPmjy4p4YTPNaKj27mrpWYth7eDjakjO1oX
         14RrqzeMloREl1DbjtrfiePVg8p+TRyGAVALDHAPvpr4KqlGLXlxRQ2mTACHEQ4ai8o+
         +LVr84QnKnt4OzF2ir+yiVoxWApplo0wNoDKpzBZuOmi9p5fYl/UDUFAaXmGIwnNiGYm
         nNqF/EGMJbaB2bB39shiSqd02sm69e72pP0Twq5rKX3x6koWIHRZs7wvPEEXjx/GGvsw
         uMJVWpdoBJmetjd2bL3UvzZIzv7xKZum3oHPESlNa9EVl77N8L3elAzea/4cqagO+jjV
         pdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792202188; x=1792806988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yiDiU01DIEHMV3YQU+fkAajpEqVu8gHxIrnBDEjtWE=;
        b=NUGlZqQWLhc45rdVXl+9yPZ2eFOGsDeJKsQlHbBK1epkLMgUzO7PKEQ0v+OC3G0JLh
         ZI7jJjWZNy4bagIHzIpLFWkkEQTu0jK19Ja4jk6klPAD+Ey0XRBw7XgLdXhi8tRnvoFt
         4trRkbwfM4EiZINDNKOEBP6rCxLbw4qYsycOJ5tCj3jv0sDH4/6jK4vrvQFCaH3cHvBX
         CjNtFv91o46jbKJpVQDO8JdL61jQqkJv+t7gw1kgwgQKUg6Ea2xChMqO7SP3LAdU3h4p
         6dd/NO2OBqHHqA9BKG/HajJBT9yq1rvaKjUuQ1Z3UK5w5nj2rZH9WLr9dQqQuMmhwGiS
         RwTA==
X-Forwarded-Encrypted: i=1; AKwUvBztCJw+7KV9m5Z0TT7p/VZixtb6HlaKwWNQbHMczQAhgB2PauLASiD3ZEXRMKcpISpogKo6IzCpmaF2m9EcYwiH@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ6Kep18JZuqYbBEvJVXuMqorDfHU9o3lCbviVd4aEDzal1+nS
	MBKgJG7EGjEkmpDPpFpqtgF82LP5WIjwljbzzVy4Mqhbp4FzuArAxa4BFyHUWQ==
X-Gm-Gg: AYBFou2zgWuX4vhceyqi5c0gBaXZLNxY3PLVUhSf9ozaKnaoJKpfBYQG5sTWAVjh07A
	P4FSpDcbupSetaeYoOHKGxC6c6PnisVDbyIyHsPEigblkEBuH0ihhpkYKDuDiUZoT109xOxUtcl
	RNpwG+8LiWuUui/paUpIt6/3HDf3NLHG1tibyRuzxlkqPi+2rv6N2FSJtgVOS80JybA51Hl+bfO
	y6yrCNRSujYZy2lZJ2l3h9u0L1ZEP12ZZ6/JgiUKRwKQYt22NdnVYZy9cpuUcdMiSx19YPpCJFa
	VTUUxstWhbYbD3spd59RrDz/vDoZFpGWVFPIXGCElRedmxsKERFtZ5A5UIynX00hKuj9o1aZR87
	wroeSpIJQWIeS4tQWd/8FNGVpUoOMEAhplsrTyhVVIeRn9KWL5m/pGLC9VC4/pN9PgiIYTPLeb2
	zAz+igwQR+9pZxdcM2S2NbrBTFBy9P4jwKrFfjBMjsWvGmRDZwn1rkMsB2iUgjGif+5d+CEut6T
	2SImworPaL7tviRKQc8x43bOTqWTb8nJWbJ0GXCtyFdwfNwS0qTscsP8trAuKLygVGLPyBtOP6p
	rlke3HdgEBRJ61QHXnV8iXyK4pTO
X-Received: by 2002:a05:690c:c68b:b0:8b0:6d14:23fe with SMTP id 00721157ae682-8b0f2202eb1mr4915017b3.52.1792202188255;
        Fri, 16 Oct 2026 18:56:28 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58f84c3sm16439187b3.28.2026.10.16.18.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:56:27 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 21:55:51 -0400
Subject: [PATCH v2 5/5] alpha: fill in pc for software event samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-alpha-perf-regs-v3-v2-5-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=XzDXuW7sU8rtcOd5zk/hMQc5CYYT30++tB7FfX76MzY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIuXV3McGFl+7mwrwp6NzzcLjky9fEnCTSWbbKVTfrdu
 kCZJbyv4yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK45w8jwV9aXW2KKpO
 wFkVt84gfZwvfbTbm4h0//4nrxQK3jN8Jm7WVk+NUp2qN6LOJCXAiPIb87+6MXm1srtpqHNTzVv
 +zQ/GYGEwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Context switch and tracepoint events have no trap frame, so perf builds
one with perf_fetch_caller_regs(). Alpha does not define
perf_arch_fetch_caller_regs(), which leaves that pt_regs zeroed, and
these samples report pc as 0.

Record the caller's address as pc. The zero ps already marks the frame
as kernel mode, and pt_regs has nowhere to keep sp, so pc is all that
can be filled in.

Reported-by: Magnus Lindholm <linmag7@gmail.com>
Closes: https://lore.kernel.org/all/CA%2B%3DFv5S8-Zk8-LUpZnWiBfTGSQXthepmRc_-a9O%2BpEPmVW0mRA@mail.gmail.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/perf_event.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/alpha/include/asm/perf_event.h b/arch/alpha/include/asm/perf_event.h
index 5996e7a6757e..72536566014a 100644
--- a/arch/alpha/include/asm/perf_event.h
+++ b/arch/alpha/include/asm/perf_event.h
@@ -1,4 +1,11 @@
 #ifndef __ASM_ALPHA_PERF_EVENT_H
 #define __ASM_ALPHA_PERF_EVENT_H
 
+/*
+ * Software events have no trap frame, so perf_fetch_caller_regs() fills
+ * in a zeroed pt_regs. A zero ps already means kernel mode; only pc is
+ * missing.
+ */
+#define perf_arch_fetch_caller_regs(regs, __ip)	((regs)->pc = (__ip))
+
 #endif /* __ASM_ALPHA_PERF_EVENT_H */

-- 
2.55.0

