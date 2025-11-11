Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62E350A0E
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881974; cv=none; b=uHWaRTQ/myYEWy08/s5sr6kvo0bFVxHO8bcRN5e1+rllMpuJaqADF/kJYQPMq7x8TJ2qhFNTMaYqRFlGVJMPQ6yqP5wtvjKtBr5iWHRx5L8Vk6jJ/qbM/j7dckGc/wHMZ0lUATRrM6ZiWj8UEW+n9ki2vvHFhSVmun2ru9rWNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881974; c=relaxed/simple;
	bh=OrK+haX6Yd07SpPVxj6UV5S1o/OSO2ZmHWjLhGgk/Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPTdyQJA0Q4yjOk0sZaGdduka3g96J2WuPl9yHLXEXPQj2Fmfbf3gCymaOgYTZD4FWujVNqIaTpATPCPfmGi878c3qvgRyX0U7IOJCmbqSQr+OlglDyRKmdz37cFJsaB59Y+0Jt1MYE6MBhuZKAi/hVXnAylzo9CenKwKo1Jc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3m+D8EG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3m+D8EG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295c64cb951so254305ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762881972; x=1763486772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+5EUL/e4sYH9knyhCSW4pZd9EqYsiH1tjIH8scm0/o=;
        b=r3m+D8EGGy5DLmlRFfXtJqRYFIiFcB3rBzjXS8m0daUBrXUgr+sZBjnaHsEzhEYlFB
         l9miUDtTmbMmCcYfknCx/gklKCT5ZFuEEsLRWS6ZoqrpjoBU7WEG9ZEdQetjmcYpYlmu
         eeZ9mJ+HcIJmQ9FfkNXwGRjGPsgGOsSIxNGH+lw5Jf1C4rroYPZJOgYwl5x7ClGbohi3
         FVXYP2moFw4cg/z7glV0Qrk2zTn0Yj9onwu06++YmxGAKSRBh1xh5xAI8yow2hra4tdF
         Ae+GGHEwjsDI0WvtmhOgo/qFf6wvR15JqBMw+mCMqBK07yXj8M1IPmEDXIwoys6emKlm
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881972; x=1763486772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+5EUL/e4sYH9knyhCSW4pZd9EqYsiH1tjIH8scm0/o=;
        b=ux8oTD0NqrnM9iNaHwiLLSrn9D7mA19P1I6/eViYZ+fzH8RI1dQ+60XrU07GfkXHKv
         w8TVKzN6r5gFQgEB7LSB7Ix/BbV+Thm+DgDKkX5ulJLWq0UDoLuO+/km0vk06kxHPsTK
         PHOp3Gh+jRSZESB1p5ABIUGoUZwRNGDtqOzYDB4BNgVuuZsnez0pyrxHCihoGU+/cAdG
         pO9MisLH3Mf9v4RfQYheVf27b/jn9n7U1Pr1d+wcWiYNzBZGZ5fo/7oorCxvpzWI8JB+
         t//xJwv0QylZqP2eAg84VJ1ES6FSpppXA6oyCWzYn5W3aWl8ZOVVuq/EQO/lUt9y1JF6
         ytyw==
X-Forwarded-Encrypted: i=1; AJvYcCV0xsGqmQHbnJ2+RQ+qfT31jFlGaV2LqWHy2207jSaoXuaEWcMhiqG+/B3hq3UjmP5kOKvldFUjHYO9WbNxCZQt@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHecY8exMeb7NWU9yc0UAhNsnk6RzOOuMVB+Noo1ZwgSBATNL
	1bIpdF+IrufQxM5OhvAWq+2AzeUAeZ3O480SX4Premy+ofRy6plKIJfmIt+urMWFT9QEz1Z5Ogn
	Xxe7JmhhTUw1lIyWs6dY5/kaXrLFkiT1E4Gjmagz5
X-Gm-Gg: ASbGncv0qZ5xM4qBnS+hAU3ovI2AImhDyEizKRQfN9YaPYH4TZl0nMf+WsOAi1ZZR+B
	JPpBOOzXvk0+4Myx8eemDJFjcxLzlrW10MRtU4hTiCBGzvBalEOx8JeKvX0m7Zvu8leSi9WPBgG
	xjnTnp3aacNcppmBIEJ7YEnPVxW6S9xk6T9EY60reV4CvcD0CP3vHgs/XPLOPrChbgf55Ax7lr1
	vdwhth/zU5HkTMlRo8GUm7JLpbJd3Hx/RTKC8HVuQ7ljhoGXZzreCj9IEtRUtvk4c/lS0zMmHMJ
	OvWsDMlvv/ECleAQaDGjXLwGbA==
X-Google-Smtp-Source: AGHT+IEKDIfLO7Bh20qAVAuiYvXgPCUN9IoSOTY18rf3ZHAN++8WIdg8fTuBo0AUXnfuOVrzuWNtwoSveTncrwUZj3w=
X-Received: by 2002:a17:902:e84d:b0:298:3544:aa72 with SMTP id
 d9443c01a7336-298427243b6mr5116995ad.9.1762881972026; Tue, 11 Nov 2025
 09:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106072834.1750880-1-namhyung@kernel.org>
In-Reply-To: <20251106072834.1750880-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 09:26:00 -0800
X-Gm-Features: AWmQ_blSROezq79zJcfpyPRDobQvzdN8Wg7B3b91yEGbThw17u-4zWuLd9CI7B4
Message-ID: <CAP-5=fXNF3rKhdAKKU+rEtEYhTT66mDW2EX0=SoH49oi5V7Kow@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Align metric output without events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> One of my concern in the perf stat output was the alignment in the
> metrics and shadow stats.  I think it missed to calculate the basic
> output length using COUNTS_LEN and EVNAME_LEN but missed to add the
> unit length like "msec" and surround 2 spaces.  I'm not sure why it's
> not printed below though.
>
> But anyway, now it shows correctly aligned metric output.
>
>   $ perf stat true
>
>    Performance counter stats for 'true':
>
>              859,772      task-clock                       #    0.395 CPU=
s utilized
>                    0      context-switches                 #    0.000 /se=
c
>                    0      cpu-migrations                   #    0.000 /se=
c
>                   56      page-faults                      #   65.134 K/s=
ec
>            1,075,022      instructions                     #    0.86  ins=
n per cycle
>            1,255,911      cycles                           #    1.461 GHz
>              220,573      branches                         #  256.548 M/s=
ec
>                7,381      branch-misses                    #    3.35% of =
all branches
>                           TopdownL1                        #     19.2 %  =
tma_retiring
>                                                            #     28.6 %  =
tma_backend_bound
>                                                            #      9.5 %  =
tma_bad_speculation
>                                                            #     42.6 %  =
tma_frontend_bound
>
>          0.002174871 seconds time elapsed                  ^
>                                                            |
>          0.002154000 seconds user                          |
>          0.000000000 seconds sys                          here
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
