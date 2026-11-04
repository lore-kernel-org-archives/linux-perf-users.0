Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818158;
	b=EPUqlDn5G1Rgky0+shkZ0gdS+RfyeAb755tgrKUyZD7E51v9y54o/uD9EdUmrix5OZpy
	 9rtp2vB5pU+CnEVsAXFC62QmVquOX28uDrBnHcQhJBlTCxSOUxmTMlbqEH62j/l/dZ9na
	 xhqvvzOXXzbYStXrV8wWmLXEFWBlzYH8Hn6K4YMqjiAh9O5x2owUVH/9sx5pZWnJB5o69
	 MCfDAzCLhW4QLvLEu5kkmkehtYmKngYdD7Wgb1Ss5uV3koFIhQyDum17qtqL2IeecgbdS
	 KMGYHWR5CuQJUVbzaQ/nhp71Lz8SYlRWhK0U5GBwKS24YSgA8RJSrVU1gCndZQ/o1fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lhZd1t2G7AvaovzNOMLu3cKSuGjs5Nw8pSZMOe80P/A=;
	b=TKgru8eDiduvmhaFim9fCrHNcx9Z3qxiCCx/VJkMEgWLTyAs621mOeGX8matr4n2aerX
	 p2CicuS6eaVS2orC2Xn4a7SrQWcdkVvCIbeUC8wB2W9kt/Ar+D/bTRgXQCcVb9vs72oOd
	 Nm6Ng9Ol7EI+fkJn/ruKs8bnLQCRzPBBnM7FHrDbA1lWwz7zjPjj3byX21sR+S/27X9IQ
	 DCDZIEA/PzitpsUHgxaqJU1JTKjgbQpOEveTIXsD6iiZk+UhiN8qMNl6IT1G+KlbOg4GJ
	 0h5bvWCd6o/wXCgbTUHXmcKgZMWD2AwnBdMFMVnhmzr5BlmFqU7c8GoMW/zbTKrsRGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oedZ7HaY;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C46606D81A
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05C46606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oedZ7HaY
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b309147589so11286277b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818156; x=1794422956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhZd1t2G7AvaovzNOMLu3cKSuGjs5Nw8pSZMOe80P/A=;
        b=oedZ7HaY0yKhCqbH78FFEJ5a8z+oN3kaY0BpcEyEVA3Jh4UhTYIiibsrYyA/5cv4YI
         +wjV6lkJZYz6PVlyFv9vljdcPNgpkOmP4TL4Yg9LY7gwflGOAfvatB5uIA0z73ivH2q4
         dZ66HRjgcAEZP21eqTEFSe1hcTen2dA1SBvQ7iETF3QtPr5M/nep2V13a+sj+qHHisMd
         saUkiaNDCg1UL3+ZhH4I2zOdZyo4yMH0JdTE0hhfCbbHVMrdFcL3HhSR+W71wjLzFyYf
         MWaaH+5SSOEBBI+XwOMcqOG3qczQaA0WabJofULkBUtigOB6QyTxVQoCoC1Vk5mQSLYo
         QFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818156; x=1794422956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhZd1t2G7AvaovzNOMLu3cKSuGjs5Nw8pSZMOe80P/A=;
        b=R5E95wHTfWFQ4XlBh78tNOJf08Zs9cJZPDtlROJmQFfBzfez0nVeONOj2SOjR6+MVA
         vS1SSXWmn6KalKyo24XjIjKX+y2LvL/IMQROfcmjVGR/JdNxUMFA/slv0yDk3rPLximx
         t5zvyq3aMTizQHezRU8G/jto2aXjRVyEF9R29vtExduSeQN9IT59NHA3pVobNsVV5R0e
         zTrGPhWrhBmuEjxGcGsTS1UCArFNNmW1YEN+7U/++HFvaLjwqFkVgOa6+ZWNMCOBwz+J
         zPZxoP+clGiZZftvyEqMgjlEvNKNt94ff6BjjB1N+0+gWKDxubsj4rvDguFgvzxvQ+qA
         wGUg==
X-Forwarded-Encrypted: i=1; AKwUvBzhiTmKlu/uVmTsFjnkgRvyUjCo6o39Bh28Ze2gwa8FXDfTR/2UFbfo9E5ICk0E1q/COy/PlRz2xHHnn/2Jm74C@vger.kernel.org
X-Gm-Message-State: APuU4Z8vgZo3yM89HJGRDzXQOt2VHg3fyUqeTe+D2+XyiyJxcKrTsQT1
	T/2oUO3fQSN+42mk75xNGZfyOPec4iQhqXS2WryHGgMo2P0CK8K7vGm6
X-Gm-Gg: AYBFou3PAffkXSz0TQmy6aaPs2m+zBbu+kgeuO9Js19pV1kFycLvtTj2lQiXYVt/ImT
	DSqWlv507u3k3/RL0sogesePHa3cez/glLD/ExacGL+ngGpAbqYKgo7O2XOhuvKu1XB5t4Cty5z
	PqQjXtaSoPBtXTOrxh8fGYuCYWlFjZA1rVSZG+HloVb2rHUm4eUEwMAPd+KZgtCbIR36S5og4dD
	uisq673Nj+PokJBMNskS+SQ/COsxbY95sOSAcHp824JtUw3cynsdeTDG7S6GrMej7UaV4QzY1pO
	K/RgEEEz7BpXeUkkw4rppDwkWTL46uYmEx4mD86Owb39qg8Eza6hVvBUXt0kEt4ltOEa283LVUY
	eebCwEMIe9jx7zlz/JoK5voZEQy3rhn/euF+w7OvbZ1zRXUy5cZ+uIpNr3VnK/7gTHSB66t7j+0
	7OMuv6ERNmFviQc0MPm8s9ajNBP9Q7N/qIInqe95+aQLKIGhJOqERSFdiIF53DGFDIJydOJ5rad
	v/AubqP5SuanrA8F4brCf5CFmAvYoiUYH1ONT5pT44ojSBiZNNkfTVKLtU8dwJcysnzaGoEEmaP
	5f5aQo5/iLlKdsdlCTpBFWmqlJ/E++ZQvU1DYFtFmYTyHn7WDInm6kFTG9Eu5PR+j1GSO+OrKTQ
	FUnmWgGq+Bho=
X-Received: by 2002:a05:690c:698a:b0:8b3:1c7c:1b51 with SMTP id 00721157ae682-8b31c7c1d7bmr10775137b3.46.1793818156014;
        Wed, 04 Nov 2026 10:49:16 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3099920b3sm24300167b3.31.2026.11.04.10.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:15 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:49:10 -0500
Subject: [PATCH v6 03/13] alpha/perf: clear PERF_HES_UPTODATE when an event
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
Message-Id: <20261104-alpha-profileme-v6-3-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe16k0q2z11DlnPeHFKiah9dc8mz5v/7Mwq68oUOoZ3
 8aLTs/qOj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaZYcZ/uc5fpdz/F
 pm9P1qWtPEj8cqb+5YJOBQaCfLuYxd/t3dZWIMf2U+SUtrsqRc3bj3eu7i27Nr2/qsrMz3fEzq2
 pZ93OluKCMA
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

