Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939433;
	b=HztBR8fsA/HU4RHI+ZYIA7EKEoTIo1JzqbwGlb0C1PVvNC9EuAdMzFx1nCL7Dt5M82gA
	 21WDbFqwenjdWjh55WPdu13oO/HHGm4XMPhOO1RpNi3ljUeQOjzlnUoOHo1KSHGkvhyxx
	 U3mdXfPt52gOwjzba7d81/3HnGEQkZcT+HG31VRBFAcMZISn0tT3IFF3OKnj1OZGT9wia
	 rpzexiClOUMOhNh7e/rQgx8g7LNwF/BdMZ6eChW2HJRGWbhGsdlF+kq27LDexmiwCdWQo
	 M08HaVgKJxMgxXuQmE883XyzJJfHBvec87kN61iD3iOBcMQ8BwXWvxGMWIJ3rTJRj+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=LzJY0luqtloZAAaphnX+RabnxBRYxAVQ9ITyuOF3u2o=;
	b=iNev+o2XHcfFx4asADlEGmE0NAW3jcSVpn+/v+iIb5duvx+ne2HRSnYZyUjaBBeeIKWR
	 Q9uccifTRTRg6TrrpTr+jcWjqItz5ufhca/HKtyKSa4Ai5TdIC43PCiVXHJJOEzMR2mep
	 aOXsJJ5ctK8F9DqzQvNJNkI8Snt+F+NMGk6FuQmsUBG+/MveeGaWOUhkqFcC6KSXAf6jz
	 Em3f4WGr3gkAwUgZwkqMAPyavF4M3ft3Q+iNN0b9aYAN9HBLYf1dvfza06tYjyfj3GzKp
	 fZCVMhl2eczhtp44+iAnT9DD3+zjPCQq/RSeEGqI4oCInFh2G7Ay1Fr9JhkOsmXChGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EHCN5P+4;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45A606D803
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E45A606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EHCN5P+4
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b31ca7e0bcso1334087b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939432; x=1794544232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzJY0luqtloZAAaphnX+RabnxBRYxAVQ9ITyuOF3u2o=;
        b=EHCN5P+4rOJf7GuzzLmYedYlU3EjEU0PyQVmKqXVypZ7Tu1nSgPC1FmEnPXTdlAayy
         UpB9YSnx1Ib5mBwvuRVh/oOzlxoTTwE/aMd6ulZySy/NugzBd6X1vRkdyDXIV4kXwxIm
         cXJ2/2B9u2e2p7u8xNbN+OJ3Q8obyq2i/Klt/TgivKRe8AA4djkjxAjd6gENB3gLZ0X+
         tjh32wI37EsuoRYA4nZf3HkTDz+4FKCeJIqPHvHO3ALJTKuuup0+/Q1FA+aI+N+8nIYP
         ryhvbkt+U5SmnP3FDzWPHkCZYqM95CvUWVNAJGC7V9RQiUIQPZY6tBBc9C9t25RJoqLt
         Loyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939432; x=1794544232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzJY0luqtloZAAaphnX+RabnxBRYxAVQ9ITyuOF3u2o=;
        b=LE6Pw/N7A4IGpjrv2ikbq9dCsJyB+l1kON8aO9xpP/Xt/uWtpBQVm0fRHPuC+ZDO3s
         sHrm1aoC7mCNsYxpBWVPlxdspFuwQfO9BcPAWLeJVS8kAl9qQO6UVZlyWljKFJLvaNzm
         bPGp4MBtDTfc0aT2igSRVIxDTh3zswQ1C8+6qXMXq85DRDoEp3g4X2Ciy8TjavWYPDqW
         hb04J0ILBjOWBqPLP8d3s8hcRwTkAOPI1WoBOEVjctAc51+vK3WM4N1TQJuelcjdUnSn
         gcaC+rKnrCknz01vngKqtOC98sYY9SNGFqgOu229g5TqDuvW/MZn7+24DzPiI+/IO6mj
         ROpg==
X-Forwarded-Encrypted: i=1; AL+hErGtxIN6T254I+0olnXxj6L4ogHYtFLGPZFPxZ5BjnUcaTa/Iz7BnhiY568FXaxNdQOZquVmKQugr+w/Yi4gupbZ@vger.kernel.org
X-Gm-Message-State: APuU4Z//Q3H8jMu/C2xU2Bz7MSPF2g8tcdK83bjFmgGBe6wcRq6cLbi0
	7pIBwXqkB4C4TYAy2w2N1+2MWYun9swCOXsQH2XWCxjST6PX7XJCAwtj
X-Gm-Gg: AYBFou3AbmbnLs1rje7Pri1QbL/ChBHD9E6JizsbIjB2YU13x21riKge8bm0zbPt+Eq
	a/qtmS7ErYOtHoStCFJaWdNv44uuWKe8/6gD/FSUhQzWSYIY6gzYyRl8iIvE6W/wySWJ+etXxtR
	wge99s1MJERh2w0RBEBVHj1o1bu7T7TPaTnOwjpQkaunhBz51gZSa9qyEsCEJF5jTGTPDtkpYGe
	YBlDj3U/HnKPbI2saxGoq+K/cqcjn500CSK1HGZPmvQaebHMzG+abg1DolymXTzLWl8mNyT+x0m
	Q+bYTJN3IIQXHZXAVD/hi31h31xN0yjX662RmJrfcjZbjd1svMYUP55WDJjnIGdSTGPjzKButaj
	44BUlW/mbp7fwP9Wt+66mFuhWWkxrPITdQEV7brYbXBR4Jik3d1GHsof/jzRARip58d/iFeq00K
	mV6qSGk+zHzLUQvtwlXgoHi+ADza790DOCFmxuqaHtAvLTGJceO3EFmS7HH7X42r9/EO44l6zUI
	tdv0QKEWD8s+l1aVpIhYFIw61Rz973FvZ79CLNswRSHm8qr2BrracQ0mzw24+v+qV8vyhPodlnN
	gTJY7H9SMhQYm3svDc+25OaKhQl5i7YtYt+izlNzGX2CvMVKKgB1Ifun5hioixHYFD7ROqlDKom
	om+odGYRwMg==
X-Received: by 2002:a05:690c:386:b0:8b3:3f94:1645 with SMTP id 00721157ae682-8b341ac80fdmr7767697b3.43.1793939432259;
        Thu, 05 Nov 2026 20:30:32 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8394b9sm11023307b3.31.2026.11.05.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:31 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:23 -0500
Subject: [PATCH v7 04/14] alpha/perf: clear PERF_HES_UPTODATE when an event
 starts counting
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-alpha-profileme-v7-4-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=aHNgrfFP2CuVv56lCB6mGHIF7R/cw7eOFv2YpF7NsVo=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht/1XJTCMunMcZsVfR6Mq5WeLKtI9BTIcfvRdWhHu
 qT38fM/Oz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaak2sYGVZX88QfbT
 ZoKvCauDTCYdnRELb5FfsOR1dXb6nlrzAvOcXwPzaycYtPTY/VcVe1xlkWs4vmFVq8y57GUS888
 ZFLWicHJwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
then programs and enables the counter, but nothing clears the flag until
the first alpha_pmu_start(). In that window alpha_pmu_stop() with
PERF_EF_UPDATE skips the count update, because the flag claims the count
is current. Since the next reload rewrites the counter, everything
counted since the event was added is lost.

perf_adjust_freq_unthr_events() does this on the first tick after an
event in frequency mode is scheduled in, which is the default for perf
record, and it then sees no count to adjust the period with.

Clear the flag where the event starts counting. alpha_pmu_add() cannot
do it, since the event is not programmed until the PMU is enabled, and
stopping it before then must not read the counter.

Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 2a00c4b86223..13108510d16e 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -456,8 +456,11 @@ static void maybe_change_configuration(struct cpu_hw_events *cpuc)
 			cpuc->current_idx[j] = idx;
 		}
 
-		if (!(hwc->state & PERF_HES_STOPPED))
+		if (!(hwc->state & PERF_HES_STOPPED)) {
+			/* The counter is live, so hwc->prev_count will go stale. */
+			hwc->state &= ~PERF_HES_UPTODATE;
 			cpuc->idx_mask |= (1<<cpuc->current_idx[j]);
+		}
 	}
 	cpuc->config = cpuc->event[0]->hw.config_base;
 }

-- 
2.55.0

