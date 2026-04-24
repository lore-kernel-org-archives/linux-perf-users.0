Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237F34CFC6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014136; cv=none; b=JN4KamiznsPalcqiHXLS54bPKNIzslpQdhzAFf/K09Xx862f4fHpM3UEzE58vzaoQxixVYYIp/uq5F1AZCfGP20fIAw+5BV4oDxDg8Qy0EcGTIhNWhFY7TyoXYCh3Kjx9F9gGmsi0BYwOfFJEWse0eOphLR8MtUnKNkE4pd2dWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014136; c=relaxed/simple;
	bh=AUoyGX1TBNbBccOtWj1a65Go1tacL1lZIR9aI7x5yVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AbvVjn245MGZZ2j4C6obSaTNjxkmoaKdfq/iaG0Rp98vN88MebalQoGU/D4Fj4weZB8AEARy2tmenjZuisWmDWZRrelY7bGdS3kGvMFh+ysVcWvR0z7JMYozh9oZMTsPvrOWuvbUltX/Ri1sfG5xoAFYSL1RvUrn6TXQIo8SlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiLQ9XT4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiLQ9XT4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a402b2d102so8399529e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777014133; x=1777618933; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mHFsXQ9X0wPnVBFJ7UXhxXebrhMMwwEW2KVI7g3J2U=;
        b=eiLQ9XT4VF9YUY8Daxf94vrQhzZeNHiqWWz/DswUpnFz3g3Vrb8ZMQpxCHE6Vq/pOz
         lhUqxOX9fGShwWQaBmgspul/ZzeYX9fp7oKyThp4OobliFKd3NJ2DNd0TJMN+t/DQsdq
         5WM3fSDEYGmVq1i/kxbtQAyIMpVxpHvz/KwGGhwjo8migVCUYjpvZzln09TNTyguC0ee
         xZhXs+NMj/0+vaOP0uSLcDzL0nXjmaBS4TVv5hsy8l1j/sXuIyVfXJHVyPhGLR4PrMcL
         GN0wXfZmcg+YVyhSNcvn1xhEvd5xs6R8c9iNGGeWWnmJz2pZPMlGL1Yo4ptMYXZOrQd/
         34rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014133; x=1777618933;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mHFsXQ9X0wPnVBFJ7UXhxXebrhMMwwEW2KVI7g3J2U=;
        b=ohmqu+jWY1SvA1Ae0/cREUEFM2E6UHZ9SFlPbmQ/LrWHgZxc3FRdwp/LONBvMVCw/2
         5tmGZFpLJlLnawQXCs9BVfR7xXySASxjQqC8JjambMl0jFVo5wWrNYzv3N1zr8zuKi/l
         ifJ57mo2HiGy6RSFstElSLecXJ6SGIAG/5XeYbIMTQrisetqDjiXCwsSKd4q+bSAdOCL
         Ps59eX7ExxEwmCYujmvlKKK4cto52z2Iwn4nPhSE8j0CyFZzKiILOcw1c8JbWD0hNwOu
         XQDzuU4IRpTdrD2Rs1Cjpa7fxSJ05+WyJykWuL61j+QMqg6eyu2Jr1/sQuqLl/eP6T+Q
         d8gw==
X-Forwarded-Encrypted: i=1; AFNElJ+LRqJ3iGtFq9imQdvWtnQPbgeT4ysBzGSFPU4V2Ia1O8Dm5EKO5f6VDM4YkBG/5rdJHPAP6IPEMGVyBEy5secX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1HIdkXG2DHEo5unv8S8IABVvciD/wWaLv3iPevggSECkH5zE
	HGWD7jafSxKL4r3alpjtB4sgZ8hR0zA++ZnYCle6khsx0FUH13EEhppfWkmReQFit8cUOA==
X-Gm-Gg: AeBDieuOy7UR7OntzI5MMa0qYF1uZj0Gsf4KEm2/ofCjkqyAzLV3rjyj07snRTaw/Qw
	jNNZsGqPvh2V5TNfNp1xgu9UF0NIaYELZN7VcNGlz8YuQ4TZ56hQJ9xpX7TWUkyrWTap0hWTA54
	x9JtrwYc+OfrqcI3CO4UwrHRXOXfJxax0uo0ct9O551wZvvyCMikyVVBUmXHGoytmMgwRj9AEs9
	RaL1srU78tw32SvOavJz3P9WeJgMMzZYIJh04Uii/emnmOEYxDDWx6xbhBf+mMW22dao7BbpsEm
	ri7sjjetSBes06Wi37SGml+wCg1rchQS+SSEz/FHBFe2oacrBQmrYoqX8pvlQHB9ne2OzbuU34Q
	GJIyejtjXBFCv0SPCHF6UN8e+jpver8QhI8WNnm2hxX7JryJU9DP+5btra0SLf3341cnhjCVmaQ
	eIfhgNu02ZBY9k57QgZkXq7pAV60IbQZtTQ5No+CQZYyVudwFBZqJf0c6vpY1cSTqKpCPRHSr9
X-Received: by 2002:a05:6512:3f0b:b0:5a1:3da4:e92f with SMTP id 2adb3069b0e04-5a4172ed499mr8762400e87.43.1777014132251;
        Fri, 24 Apr 2026 00:02:12 -0700 (PDT)
Received: from localhost (c188-150-77-196.bredband.tele2.se. [188.150.77.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc17dsm5739996e87.19.2026.04.24.00.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 09:02:11 +0200
Message-Id: <DI16XPYGNFAK.1G8WN64YS815X@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Guo
 Ren" <guoren@kernel.org>, <linux-perf-users@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] perf dwarf-regs: s390: Fix an off by one bug
From: "Linus Probert" <linus.probert@gmail.com>
To: "Dan Carpenter" <error27@gmail.com>, "Ian Rogers" <irogers@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <aenFGy9WDllTEO0S@stanley.mountain>
In-Reply-To: <aenFGy9WDllTEO0S@stanley.mountain>

On Thu Apr 23, 2026 at 9:07 AM CEST, Dan Carpenter wrote:
> Change the > comparison to >=3D to prevent an out of bounds access of
> the dwarf_s390_regnums[] array.
>
> Fixes: 1e452dd850f3 ("perf dwarf-regs: Add S390 perf to DWARF register nu=
mber mapping functions")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c | 1 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/pe=
rf/util/dwarf-regs-arch/dwarf-regs-s390.c
> index 310a37451bdc..f79216a7665a 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> @@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int perf_re=
gnum)
>  	if (perf_regnum =3D=3D 0)
>  		return 0;
> =20
> -	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_regnum=
s) ||
> +	if (perf_regnum <  0 || perf_regnum >=3D (int)ARRAY_SIZE(dwarf_s390_reg=
nums) ||
                     ^^
Why leave the two spaces?

>  	    dwarf_s390_regnums[perf_regnum] =3D=3D 0)
>  		return -ENOENT;
> =20

Br,
Linus
