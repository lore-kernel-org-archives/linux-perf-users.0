Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738263;
	b=2EOxRsPy+5TiIR2ZIiUKhv/76Luqu7CyLASUeciBSbPQHaYsJOaIYF1d+vw9I+XYIgKB
	 TV6aLpT7i7XQ1a6dVYjXwn8Fa9LsJ7XdkpyfLn4HEvPbatvSy3l2RR5fTTeoci6wDDf3d
	 bMa0+lLgTvUdeke9nz8uCGpQk0L3zLm+a5JszEkWwpU5V/ubU3EE7I8RnwHNKfiJjCrA+
	 vhDfTr4hS6zPEuq3NVXtf7vTZbTsFgdRlGBUH3SVhzxPMvwJey8AQgEZ9R1Cbtq1DcnsK
	 rrw1grNOHJ0+cGjJF4pJfnLZmH9JTsaEm+//eywQVJ4hwowCgYL4X+5MGrKB8Kn152A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lhZd1t2G7AvaovzNOMLu3cKSuGjs5Nw8pSZMOe80P/A=;
	b=LOUS3w0xH6uxw5XF8SK6+3qEnlsIWh470fP7CBYkyvsD/JKD8bMgfF/s6TjwFsS1RPkl
	 Jj3y+Fje4YPiNmi/ynYhVX5q0dJfh8GJoDhVu/4X6pOVq65xPW40LPypqiM4XoEoRUgQi
	 R92qObyhU+VS9uCzG/P08kqfDJkdarGfEXm9WvXYAcN5PiDz71WmAu2h+Wj57kYmYYz8X
	 d+tu0ivuxtBB42YbTsRQkw0pV2bJvXymPGV4I5LqFpqaZPixbwITZaRuoa8vLW6MJxwrB
	 uyYwWT2A9/JVDSSEpDiuFTes3yMnC1vqRKZmDgMyZWf0VjkC8KNO/PzYtHqhgYxjxlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoj7xcDo;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F5606A338
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1F5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoj7xcDo
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be1e468a8so64329d50.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738262; x=1794343062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhZd1t2G7AvaovzNOMLu3cKSuGjs5Nw8pSZMOe80P/A=;
        b=qoj7xcDoVGs+ZdC3++ZqYU4+l7V3xK/w98SopOz6krhVhmGa9+f/nuFXj0mld3Bxd0
         GoifG0tIXHQq3CNj2luySPbPfbtBEkgaVAU7ER7rhLIbzmQ/grJCYSLNW4Sqf6GqgeJm
         GH82O0TH6mgKfd09VO/9VDCJItAxDLSeWM51pxR37UMUYf4hUimrTiBzW36wFR5ouK7Y
         Zjzi6l69PDpvRSw26Fkg3J4d2jqLhsuYyK/9eGjsAdiH1ss5vokMAngJMUQsgacnwZ74
         7495G6X0GrHt7gAb2OU9+AGsQIO6rcGAmRkOlXsUt5E1YUm/12nonJjYNwf3zPMfkghU
         TBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738262; x=1794343062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhZd1t2G7AvaovzNOMLu3cKSuGjs5Nw8pSZMOe80P/A=;
        b=eJ0OPX69uS6sPY38VNGjz5CanDhvLR1l+0PdJ/Oi+nvuqPy0gcb5wSVY2kmONo2i77
         pbg8U21LqRjVwMKyFKliVOfSBvQAbmnCJIXlIJ3IBO0PV6vsYPFvCUs5XXx/CMl23mfp
         g5S+ha5z+Wu7ysArNz4vbJ4e9d6TxJxhKAoF6kq9sF6g+mhMifSAJYEVHPl4+7xOwSSQ
         3nd1K6g3JMcFTDNJ5at+81pVuwp6J86HlzNuXz8b+Hp2Tdte8VoLG2G7AlbsQh7jAYvq
         MtjgNKHf5KlwC9+1nxfLK4KI+2kFkW+NPAlyyaPGOuOGKa9GGNyI1ARtrmGt9zel1ARh
         zoWw==
X-Forwarded-Encrypted: i=1; AKwUvBxAQce8Y6tPdgx8dwI2kXw3RCkYPVDM7IjHC3LsuUXasaXKmGnyUDgrNs+TMl6nDvgsndv5lZNr63MGGThvzfCn@vger.kernel.org
X-Gm-Message-State: APuU4Z94hRZvoIs4NtUqZs599YOx4r+d+vx8NLDTsF477wqCrO+iaivI
	JpqNfZB74K8QxsuRBaJiUfTwkOufxNhJa+f9ObqLIGAPJfi9otYf/cjX3LGKLg==
X-Gm-Gg: AYBFou2l1/XCb726+hbvdrFIAzuY3aagA6is/xJPNMhSG9aJRG6btX84RbRTAUsvWYP
	e8lDVtICX3i/HjtH0nGKJf8eH4tegkTBZR+MY+fm3xXfn1Iq1pfINfjhr9u/xTfr7YwbXnT5NFC
	by07LYbcXfeP6iRkeICEHI6G6hzKpFO+w0jFOWFHU/wRGTCS2qnQ4M2TwgzbEIJBCpOKo8/4vuG
	ppvxwAB5OxIZwnJ7sEvXAVhAO3izoLsaHN8gm/igKB7KFoEkm08KoOQHUMrPtLznsHzdHAv1Ry5
	TAgCjYWSef/2bMCsUHWAuYecmemg9CJ97eqb0+Jdkh4R09jWNTASKS3BReDxHGY6Oomn8xqsE/W
	13EvIE2DaJwzDPxYrYmVjat4rrbTNfhRnjaNupNO2oeT46roKU+DB3YULb0PEp+F5N+SfHCRJy5
	HefIIct8lhxAqiOYjf5c0YNccSHIoLAbSQqDjDQ4ZH2gxVO3DkY7rufNp4/Hqdfkoau/do3Yo/M
	GvzBEK662pMV7+wNzF1WbDUfaPrKNSn1pZOJRKpMk6d7SXZ9Mqwy+myBmsEih66lHdLMbXLmqUq
	+DDPkqCsh1FnN5rNPH8vppGuk2Tu47uSUe8LhHECQdZwQQ1o68A1K6UOR9O/e5/1wcZTu+IDLfs
	hNARIezaSmw==
X-Received: by 2002:a05:690e:144e:b0:677:d9d8:d927 with SMTP id 956f58d0204a3-67ba4f9c349mr11752027d50.74.1793738262448;
        Tue, 03 Nov 2026 12:37:42 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee202bc4sm153422d50.4.2026.11.03.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:37:41 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 03 Nov 2026 15:37:36 -0500
Subject: [PATCH v5 03/11] alpha/perf: clear PERF_HES_UPTODATE when an event
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
Message-Id: <20261103-alpha-profileme-v5-3-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
In-Reply-To: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=wZUlbKAGrvoUbANrdNAR0BiYRrf0cYY8VBhZDQukJto=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeufF5rNflmjeZq13KZiJz2MnFz+YfL6669GD+315Rn
 cxXFf1XOz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaat5MY/jvNaj25pc
 Eg1VXqZfy+aeaCc69t3yXduEz2ed2ar0XWe/4zMjTzeCrWm04473+s5yX3oq55RjU1dmtyarebH
 9R12WR4jRsA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
then programs and enables the counter, but nothing clears the flag until
the first alpha_pmu_start(). In that window alpha_pmu_stop() with
PERF_EF_UPDATE skips the count update, because the flag claims the count
is current. Since the next reload rewrites the counter, everything
counted since the event was added is lost.

perf_adjust_freq_unthr_events() does this on the first tick
after an event in frequency mode is scheduled in, which is the default
for perf record, and it then sees no count to adjust the period with.

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
index 70840c05d39b..ecec78c355cd 100644
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

