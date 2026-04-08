Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BD23EA8A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628714; cv=pass; b=pnSOt8xje6dWdRPfqIu4p1qFClGsqIxRV5E7rtemHu3dxBh4s0VybujGNozfGT9CI4UD/8MaqvIZ+FFNbE9lIT2kU7i3EPWW0uOmhl6ta+QizR+4BNyVQR9U1HZ6HQWyDF4tRHsBXB6PUaAIE6FKrzg9ARuO8Gl0h9Fr9RMTU30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628714; c=relaxed/simple;
	bh=d8r4vC2Psmtd9ki9qeJaX2mqMlw9JpSSK3rFBC9HuXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iat2X5FcUpLTUK33jBWhBtS1nQgaDVqEy3msnnSEADDzh+oQMS0wuIq0fwxqDCIfl/yZ6r3b55kiSmXRXqScRMZ/KsA2gc/EJXfZS1T6EygsZ7POJ+bVIFdZHY5N3YqictWvivN8XMp+gKJwW77IT22ubvG4EAMxrdqi4ghfGg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=am9QuaUl; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="am9QuaUl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b243198058so33185ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 23:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775628712; cv=none;
        d=google.com; s=arc-20240605;
        b=UodRz76ph9ms/jX6gH1mz8PmxvcO9EEyNreBZZKifYy/h+AB49/sjWZ3XGjw/s0oBG
         xmJXK+WmMkzIifGUJt4le2b8V2gyLhecHs0l3Bb1Q/42TQ5WZJyx5RoFh1sdt2wAZtMi
         9ZZrkhTLpPZK0fBR2ViJUczwYPZfKGR37KlHpKwQ+0J4JGD6e8OgxnSCSsCtTHLl7t4H
         JgBMgy6oQ4b69ehVy9y+OoJXCxZgXjt+v1pocWlJH2SWGwGj9iiv606Xwhhn8kdZU1uB
         GVnMJS3vpbfeHlRYIeDCt4HzizfOyXejidLmB015N6aFGr8kT4OraoZmcAHK9ehSQ8bB
         scbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3uK+tPLkSl9ANiO5LYE1+vG7slqSDtEHIZ+Ahv9m7KU=;
        fh=IcCb/O7xfFuMIFtUR3B/X4yx8D4CfgU81a3duAuGsBU=;
        b=gk6IF0fbHVXW/RvwM/lfYRL20RtAqAGlTyPIdNa0FR8xu4Hg64Zdsf6YwvMx6NMgD7
         elCQq7k1kH6wZYY9Vy9rpGqCwu+2+xLofy6Yifw+++LdWIsPAh5bOAveqw+ktpla6wpy
         2+p1enD8Xn+manfykDqznDVDK8lzhfPrVSxoyky3oz5ZdOShhSHiv1FeKs7vTuTE7e2C
         v1NUfxkLfCjMPkzn7un6t4ZfdLRSIoN+akwqqWJVr5PuApvLm6PmtuBCc21fZt27AlHp
         Zb7sAAeV7UWt3uP6fuOqtM44e/GPzJTexd2rXQpzwfSC78ypiOHz68ir5etIsV8QPXbl
         sLoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775628712; x=1776233512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uK+tPLkSl9ANiO5LYE1+vG7slqSDtEHIZ+Ahv9m7KU=;
        b=am9QuaUlJY8CkiMz13v30m5Fuqxde6FvfsGyb5mSDha6HhlXYJ1z173ek7/RFLQ7aw
         mb5cDRLF/joXKd2k9J/FRALCnIbVsdFdwYz1cOQTixnTNu7mDoqFuGFeZYavXlp2sXEy
         abkVV9MipqfaBcxmLUVtTbmJBm/cpXJpQncPtqu1YXO+7yFX3C31HXzBkIYD7xVz3d/E
         A7twwGOlaPfulY/Pz8/SaTNKxahvCSt2Wauon/Gj0QWSu+I7/sOePIEn06cVFNFH7RT8
         RL61Q2aA6X+f2oCdnKjvlXNV5U3U/7c0wMOFbDn+/N5EAZdSeybum+njxzphrR78CjqX
         pwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775628712; x=1776233512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uK+tPLkSl9ANiO5LYE1+vG7slqSDtEHIZ+Ahv9m7KU=;
        b=c3m81ikS59dSYag7NzaK/tUNzYoJjqCwa98YizZlAeyVw87u65R+O9uycb/GnzpsU8
         bKFZR+Sy/yTTeCkr7xVxIufELx8MoGtt4zl9EcTAuzhyl96ZNwSbElvFL0s9GO2qqfIy
         syvHT+AYgtoa9PCZSTv/NkP6n53JaIZZhDSUd3nb+/BC91A7itPn7d6XpuuMRz8924kw
         y7uIbj5L+Zg44wG++DF2oT9Tga466WFbqC7VuGELrGHVP789fvYgVqjNK6CXwUbZeMUr
         PjksgPArfnaZkhiK/kSnSx3wuUYzFz4y2xHAYwSzwBTPy0XzjRTKYbrB6xcruMKdHkah
         HvEw==
X-Forwarded-Encrypted: i=1; AJvYcCVbsfAoI6skyoI1qkiPBNnFYNMHlf2GY6mfCtg+tIOp+DTOwVbS8RyxLdv6LvKer/hOGIQfU0Zi3QtaUVoJViQq@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7758H8LTtJxleEAhwi6IV/5hQzNN4SFGn7hUc5Q9RK1iYCXH
	5qJ/6BvPx71kzt3NEtsl5e8OYG0eR0Eo3da2sqzyR1d7Fj0oSzJ+mkng79tk0PRFx8ono3FTd3k
	XVSrrsZ/GRY3KChw+KjmcfFL7q/++XqsXkD1outwl
X-Gm-Gg: AeBDietWFIF/uTTgqo5cncEMI/2BAgeRBNl5Sfq2ezH5jJUOAwt6vEWIoVNiImKKHei
	9auZjdEq1jMWDid+NxnaW07rOiGY0xd3w3i0LwMNQRSsTcf2QKWnKR1SsZevLvCewz7dqw04okV
	SOL8T4MwBTrUjBZ2YX4gdcr+Hx3Z8iXbPVdDYsS540cWz3dbovEPm6JTACdVYVV5gDgDES+teJv
	sZNannpKQyhTKwKQt60YdRr9S3pJ0bAfwq8t6AD4za74PQzMXC08oIgvMiSmgo1lBj5N8c0KYTU
	QC65vCc7
X-Received: by 2002:a17:903:3c27:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2b2b98435bcmr1389885ad.12.1775628712065; Tue, 07 Apr 2026
 23:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408055259.374744-1-namhyung@kernel.org>
In-Reply-To: <20260408055259.374744-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Apr 2026 23:11:40 -0700
X-Gm-Features: AQROBzCIZRFkgzKvk939GsXY9-5QBl8W2uQyJtp3-5_ytz1FzwnVUud-0d5jVLc
Message-ID: <CAP-5=fXZLqqyWiadB1AtPP6Oi3X4WxpK8zYs-=4YVM0KfuB0QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Update error message for BUILD_NONDISTRO=1
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It should say binutils-dev(el) instead of plain binutils package as it's
> mostly installed already and can confuse people like me. :)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index e6686641761fd0bf..ad5401eb720e9e78 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -923,7 +923,7 @@ ifdef BUILD_NONDISTRO
>    $(call feature_check,libbfd-liberty-z)
>
>    ifneq ($(feature-libbfd-threadsafe), 1)
> -    $(error binutils 2.42 or later is required for non-distro builds)
> +    $(error binutils-dev(el) 2.42 or later is required for non-distro bu=
ilds)
>    endif
>
>    # we may be on a system that requires -liberty and (maybe) -lz
> --
> 2.53.0
>
