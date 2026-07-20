Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E693B7B6E
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532138; cv=none; b=qd26lXA1oBnRTYBZfuxfmL8M2H+5Wp7Vke0r7qLZcH7l8xI184nJgiCpO5YUfVoNWzAJ9/+zJ7zx5fyAmd42jDwexAsnuh3VvNnd8XkW8tv7R6cL7ta55mDEhKX+sw8xZ5WOjn4EqvI6uv+bUjpr2s662bAxq66OHVLxvZl2bCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532138; c=relaxed/simple;
	bh=WLNuylhDoT/T1nhVqbXxx0oK9SVpgxKx6NkmkPvsdCI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ls4yGZ2Hwm6lcjnrQe1yMfIjJnIBaw19CBvsVMYKmGPa/V+f+SI3HbcUG7iBxC7n6R6UcagogWUD/3HdorZ1YxgPEiFc0cKqIqMT6ZzU5o9wPgQSqLY243swmFE6Hg4re2YwkrVRW6s/vm3jZEAUZyQ+sW7PMoYG6u66aUBn3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0VTaK3p; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0VTaK3p"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so7487721a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532132; x=1785136932; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VOacMlllEAiItNG+TLG1ZIDGtvtY1fzk11Q/F1WHU44=;
        b=M0VTaK3pc953NSA527OcsiY8dPWjJjGBfobxDGht4SucD1iVha9gRX9z6Rv+uvjB7Q
         SVuTd/vINkjIiGpYjYPWpw0TFAVWSGjewgxSumRFnImfFZZMc6R660DHWa79DDhcFaOj
         xGGZBaO/ND6VSgbH1L3tQ5NEVr8AodKeJ63ua1x8UBDQuOVVxJwiWayP/bcJqs2wQhGp
         ku/q7LwMLpPyrFF5KQcwTdh/1Svi893tgsATmC6OGHIto4iFHtjmuL3Ux87/gBdiTqAj
         N2TiyGx/P1b/ojgS4LWV3SINCKMxSETCpGQVO3LRkwjKzYi6QSVvSGHRruomzMuujBhc
         OIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532132; x=1785136932;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOacMlllEAiItNG+TLG1ZIDGtvtY1fzk11Q/F1WHU44=;
        b=A/lc1dK6LXTUPAkqRSJSa7jxOVCrwGDdT+WS/XyXqPK5mcV8MsfgxfDG/R1oTddQAb
         3aqet/VcVtzj1EjqfLaHcNIVYROoidrolsgL/mxF00sVlITa9ErhEjE8OQBLh9f4+Rll
         hgsMpC1g8w0AhFJtY94ox4HqMn1+97XIAqmlJSJBkM2Hrr35eVuFBaR/DTlqFYl+Eyx9
         DPtmWstvqpNLXGtK4UIQ0+fvDQq+bfFdZDk++kI6zZ2tw4Bm7bMdeYx+PX8wRr9PJ9wu
         Ofj/HYas4vEFhpKtRIsnHasBfxIh139FvTz672I/lpGsY3JrBDuXPruNfTas2zRrdTol
         sTDw==
X-Forwarded-Encrypted: i=1; AHgh+RpL3aw5WAZkMQT5ufPy0WdAGpi/vNSiUtWUxsaqixWd4jLBEf8K66c4bsipT+tL0WCWJY0Qy5gGCidoLOgzYKjS@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZphMTQY/uyf16pWpKYgVeQ/hNv/uvHM9vAKui1Rd2QM019Di
	OYK7sjauD6QVqUi78eIsLkLe+PNB+0ztTrtpHrmDCftcggSG2nEkRyU5
X-Gm-Gg: AfdE7clfSuKgj8PgLh+pqxgxrXpfmZYTzrrskNHDzbZYL0Uuz6q/jWkMlu6+ta0oT5j
	jvG81+N6JLtMLOgSkbXW5VNRLUxETwU2czVaVhffPlRwTyx7gcOhkr7bKlNPpAIDOXSfhNlaS8u
	iWuAvEpR6KrW6s5fvb2Gn4CBXYKgC62VkqZLeHUzHuQUC2RWFr3jW5WxWrepNtSjBLXgbEPHi4/
	bx//7GVgcM4v5W9DAhq7QhuQJh9HmHnw3/tbH+VmEzYpt0BsAaIUXhf2Og/T2Z4319W+Yc0h18/
	C5BdNMKnWfo0LvMXeEbQBHj48J26BoJuLW65Edgz5T7e1WLzY1zJ7zuP2o42uC9vFOOlfTtcC5m
	Wrzgas8FQo4FSTDvjCzHCBEzDqV+AQc9i+vZYUJrcYHHDfIRfg3nqMXkT6X05X2TGrGxWxXirVf
	7CYP0gX/kDBRBO/8QMRvn1VyPdOJxa
X-Received: by 2002:a17:90b:2f0c:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-38e4b431074mr14088269a91.8.1784532132492;
        Mon, 20 Jul 2026 00:22:12 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 05/22] RISC-V: Define indirect CSR access helpers
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
In-Reply-To: <20260701-counter_delegation-v8-5-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-5-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211935.543975.13003104709969920617.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=337;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=WLNuylhDoT/T1nhVqbXxx0oK9SVpgxKx6NkmkPvsdCI=;
 b=2xcWmRRAqDjGQXqwGbJnB+31tbqeAGCjzKohhI1vIvF8YponJ3EW8uJz4jNw+WI3VgGyavSGl
 gtdiuG9MO6vCHj8LYZ52PlJfVOl0LaepzbRROI9Qgxlnq4ieSx45ld+
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:46:53 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> The indirect CSR requires multiple instructions to read/write CSR.
> Add a few helper functions for ease of usage.

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

