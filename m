Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B42FE071
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752951; cv=pass; b=akKXmcPBThsdIjpoWKGBzdZYvXpiKkHest80xZohC7GVNtQ8Cbwelvzk8N6IApcM3ER5caCjG0HubfOHGnumNRmg8MJ8VQOY0zYQzZ6svQzmSk7CJi0A8BKPAspSul/GL82Ct6+IvSIzx2u7mpNv8yghQCuffW06G/5apXjSyVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752951; c=relaxed/simple;
	bh=2eVQGWFBreoTY3DhkBf1mzhe/IRY74WoiKd6EP/lYIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/oLZY/yF4Ej+X+eclUDW4ILzF/2GDkxxO7fjdrTYwgC6Ri+puiu+aZT7SuqOwJu+FDK/rNosZ/HT5K8nvyZOAX29awyL8FmDjKDQ4eyuQSgU2hpxr+ruuEQx3yJpjqvNwakzpjG7WIepqeg9vGzTy/jlu84Db9K+Gcy2uYas5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGOqflKV; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGOqflKV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso95ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779752949; cv=none;
        d=google.com; s=arc-20240605;
        b=U701wSXEm7Ewv50iWZ9B4d3m0PPiVBk3pn4ZvMJjuH3jnSVGWfkqNfwKYConQKRoim
         Vm4o69uG0ZGE81X/Q/xMpuqdpomMEgnsJQ691dUCX2ORPrvIy8mn7uDMh90QgwXe0+NN
         ucd2lh+LgwBB57wQqL1Omjwbm1fWz/DlSaTDcuA2dC3dDTOpIGS1ejUgYtgTNzWKOkNL
         mArLDd3o+cVFp2pwLM8NdCD6wxRSV+20kqagvdg3FCt+i+9EdyUJ0w0/Hib9UO1ChuDb
         lgkvPJimHFba8BOwc/BQRhQ0M2Rxpd/X7D1XqorYxiIQjFLbun0Cp+Gq19RlMUX3HSya
         NDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZiH+MGvu0Z7vNxreKv5jMTminTfZ+qVR3qbpU0wE9W0=;
        fh=Fp1p/KIUCCUkxshT6ucUAkq3Kbaio4WxZTHj6OdyR4k=;
        b=IOodSRfVENNSI4LHtCU3tkVz2ntsCj4eijrLDyrPhTOWJ3cbgLaaQkIvA6EyT6zaJT
         yQfxPkSWvelIWE/kvQP31SmtkQBKjCUEteQiEz4KlYVkH+jPe9bLF24JTZDm/7lEET5J
         sq2snbbHRyFjtsiL7ubtchvl5W8EPJGFsrinaRgHV6d8BKjDng2o5KLjHscoUpZacRzg
         ZZ8+Nq9G8B7hpY70devJKr8A4DeEZ+vL0Rj8ezp35ORbL341/iwZEKzxPxKySnNNtR2A
         9o2WrAN3ecfWxLhD8Cg2g35dVkmrlDSQ9q3ZvMG9x5VqnUjaZCTDb7F+Ep4jTMH6IAhI
         x96w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779752949; x=1780357749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiH+MGvu0Z7vNxreKv5jMTminTfZ+qVR3qbpU0wE9W0=;
        b=fGOqflKV2kebiyN5jJLf1ruuUG2WDZLXJIDzOqiQgXrePVSOsdu06GLFVvpdVUQLU/
         pwjWUJ3Ru1fiWeOOhNHrIe1EAA1X24Bw2s/FfZW5RBEcBZFNRsfzdqe6EZK+VDuw08Wd
         kATIKEF9wq940RE904U+P32S/D284qkzY4Mxhz2ir83U2iTD33SKRpnS+MweNbi9jdas
         dC8wWDQdEa8Tr1xU3qtdru191UbpwmuDnbCGsJzvgaXBzDVBB9/3Wx4jEYIuup/OwRAq
         XMaHTgno1cVzN31YA1kBRojp1jmqmNpvOj9ZywlY5TyYgsmcJTpGedjTgYoWJjvGddPA
         Y1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779752949; x=1780357749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZiH+MGvu0Z7vNxreKv5jMTminTfZ+qVR3qbpU0wE9W0=;
        b=rlXzx/Yo0uHAnpBIoXAVea047ze6ItbgTgw8H3cJfb/LIIYv18/n+qcF4vwmajRU/C
         bbyblgFb7XSmYLdc5MZ6QqclS/XPScps4cyQgjN2U60Uth0ODFX8i7wN5piHsnldL7s6
         gOmvCgxsvqh0LqEVJNVoM3YCKfpxoz0tF7RGwUaKvQjPCaSYXM4I2c/Bf2kIqouDX3nP
         uorTLztitwRlbUlxvViA/32zVbGOUCKGO8PIaKRVxoiJh8WwVafBrS5RpCDmeW01jkAi
         bYenLiALT1q5hVIziz0U9gM3NDBCDAr41b82VC2z/XH3pSiStGgm+ySHaMOvHpqnZpua
         aDEQ==
X-Gm-Message-State: AOJu0YylPgu+u4S8yqVQP39+ds5J/tsw1m4FTcB8A8biKOS6XuHxj0oG
	ECVPxC+4iZdKG6/WFPPqQfhen6QgRASgL7FZOvxYcQNfUy5yphT4fYJRB9vFNzcTXwzOlNxMRdB
	PQlvO+5Psy2GRwVAdY5+OpfCuaruHT9STy8HBrHTF
X-Gm-Gg: Acq92OG0iq1L8VTzagPX6uAI7qGLjOVeE09/oOEC0n5Ii1h5+3msDWo45Fz7HGmAP0B
	H7AjBfmzfzDduI0iMxKNbllFcuzkfDDqPRYn1lC1rNNT8u0vLmA+FJPT/V2XdJDmqAR5qxfiksY
	MR8BI1IulFHkGze1hMH2v+HgpmLWgDnTbrD7O43cdy8pLhFlffeHj1QPCt9E4EchywjCtVcb4PV
	0VujY70hlA2DCcqcEx6nGMduPu0M5WH9oHzqly14dUjkmjmSr1mw5KPDT1fbTjtrOAnQt25tA5a
	rsQnVlJV52Rw+SX6cOY=
X-Received: by 2002:a17:902:ebc2:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2bec11d3e79mr3342285ad.19.1779752948405; Mon, 25 May 2026
 16:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
 <20260525231900.3527228-2-irogers@google.com> <ahTdcAqLUH_Za7qe@x1>
In-Reply-To: <ahTdcAqLUH_Za7qe@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 16:48:57 -0700
X-Gm-Features: AVHnY4JXsbuoIr6ER2TaMKRM-xlOUmvDdUSQFtdM-hlyliqcGdYtbdT7zyTfB4s
Message-ID: <CAP-5=fWoetmpFuxAwWyj5cMPn7rsJjPBdK-MvJxw06aVj=DNKw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 4:38=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 04:18:47PM -0700, Ian Rogers wrote:
> > This patch introduces the initial infrastructure for decoupling the
> > perf stat printing API. It declares the struct perf_stat_print_callback=
s
> > interface and the core traversal driver perf_stat__print_cb() inside
> > the newly created util/stat-print.h and util/stat-print.c files.
>
> Can we avoid these kinds of reflowings:
>
>                 OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> -                       "Set the metrics level for the top-down statistic=
s (0: max level)"),
> -               OPT_BOOLEAN(0, "smi-cost", &smi_cost,
> -                       "measure SMI cost"),
> +                            "Set the metrics level for the top-down stat=
istics (0: max level)"),
> +               OPT_BOOLEAN(0, "smi-cost", &smi_cost, "measure SMI cost")
>
> There is a lot to process and these things gets in the way.
>
> I'm trying to make sure this doesnt' happen in my patches with or
> without AI assistance :-)
>
> We need to have this as a skill so that AI don't do this.

Actually, it was primarily from running "git clang-format" to clean up
the #includes, but also for the layout of the AI aided stuff. git
clang-format likes to think that if you edited a function then tidying
up any style issues within it is fair game. I can resend with a fix.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
