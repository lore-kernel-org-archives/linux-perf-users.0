Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91F339859
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2026 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767999713; cv=pass; b=pfjRiXTKoaP/vhLuHA9wC7kMXG9hYyRigSPP6XstXr4Fx7oJr9c3+whGSPUqkRAgrtjp2dIbEtIYrGaecQbaIEtHevJM1/sw9KxKwp/k3tj5+7Ox3mIVoNIyUw9FrosriilbrrR5uDtuv09bXOdfjYqqtBkwuvbCMzKamlH7Erw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767999713; c=relaxed/simple;
	bh=U9tva8lTjQdISG/CJ/LSd7eL7nIQehnC7lYG3fYDlsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPb02NCdVdyi+Zb5bgriDWhgS4A00/s8FKzoBYGpwov8f96EsEje08B18N/Th0PZxNzvKFNilImyHd5pMIOAOQSlnUrm5ebAqo9YTRefanJPutcpDyPQj2KW9eUJ14ucTUtj9eXchw7cAZWuZMW088aSe6ozY0CrgbW0xRYs3gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Khnige8i; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Khnige8i"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1462573caso29065ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jan 2026 15:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767999706; cv=none;
        d=google.com; s=arc-20240605;
        b=KPTq9kb66GcUVUeU0s/rAVenuHTVj5/ANxrlH6Jq+/SyNVrUP3naky4wAM/S/wrUhu
         3Is7VBjWn3yug5yo1G5mo1MTLHwbgIsu5uASMAbWuPNfRswQTqRGhrlaCd3cd5g6clO9
         BpdOdDIRRXkB/IqxV6oo6eTzAT7IYrifEf/dF8wm9QYn4i4aGfg/VNQG7vLjU/O2VX0z
         jgmHW3aDiR4Nm0hZcNAACysKrCJ/ML3MHjwi2c7YzD2tAzUdsHxcKyqv8r3W0w6Wrnnq
         qfTT6m+JUD2hLILghm769IZTYhQug1g403oR79Nvd38h9rjN79EEfUB3Cmdsga46l/s1
         JMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEQg90fihoKJxjeHTB3vyUUEM7iLnr7LcEi6BiW1JFw=;
        fh=ttGRNhkno2wTukFsARaT3Mhu2YMhCiPrQHb4g6UmbhI=;
        b=HhCdrxY2CgrMYK5yG7qEASACmzC+wgPYGUoYFCxBMS2bC8O7WxN+FHAIgIpuGralp6
         Xs4DdB0jm4rUGK80VTZ+8k1tWVdtj30Gkj4P8+DdjmZzz0CBxjs8kIWChnuBMRPVBezH
         i7v+3xruExsVjen834OXBmc9FSWYXyvIOPXnx35ppDHNpPtePl9AbAdCeMZiI6PSsK2k
         8g0xaWPhsu41T6K+FUtxfFVzMa7q83/jmfp9Hl383O6LcbHdAaPvdvxhA9BlQNhLSJRG
         mR64AvSNDFaOrPWOAkyFzEJv4DhOzsfO9ZwH8WJDQuzv1A2+SCxcplpJBgenEtekIJxs
         NALQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767999706; x=1768604506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEQg90fihoKJxjeHTB3vyUUEM7iLnr7LcEi6BiW1JFw=;
        b=Khnige8iRGFcsYykXdDLnf/8pQv9tVSGl3m8v00GX69Jo6bozXgCqcd2e2cp1jEdO1
         2Gb9yc6e7CF/zQftqKVsrzmcUQ07syYKF6rvKpWFqn6rSWdKvZ0kJAed0ASotm4xvbJf
         f2FW81npSAX26xdXGDU0Kcp31X3SHmVTZRL9f78heOFSGYWcjTuaK/iQ8P+LxOvp64Eb
         5fCzKP/RKl3dW6kI6dk4X+MxgNsaRDOkeNjgWh0C3YEpK6byy5V+JTh2+m6b+06e1f/s
         7xW/9S1+Tv/uP/gQUsR95niGQCIS2fI6QEzIcmlSb/12m3+tBWhJNfSYGSpuRnpd984x
         XRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767999706; x=1768604506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEQg90fihoKJxjeHTB3vyUUEM7iLnr7LcEi6BiW1JFw=;
        b=Bek3rqKAf5QVqusvbp2wOF6jSjczFn819Y+bZ8UUeWqmlZD2lwOR1oOlASHzYwfMAr
         mKsxBDwxuo8QhafeEXue3ijgWOLXdk4XIHZ+CBXx70TjyVHG/nGjjVKVhu0Kii0FQrpy
         Cpc1tsD3Uv5ya/IvJKQ7bCHAhPFK/pQ0rAJTMEdNwZGH0uQK6RmLVGepc6fNUVoIW9P0
         YxkCx+RPe3NGakY7YwxpyXJuhsIw41JAODwKhvXJ1kCG78S5/iDOp2ip7x26r36y8sqj
         jaF+ArDwKaO6MoSMJQNqQs/Lcg8/WUMgcnGJygCxLZO13LuAs2lZzbj1TrGUu7BdFFyi
         sjGQ==
X-Gm-Message-State: AOJu0Yzz81+uw/2IAPcGO4OXpZZYYZp7uaylSkSUdxyY6I9PfUhUAyD8
	r+cqJdaTfMBOskd+NZs3U3mMSht0pVqMadZhP6bk0AiAGZJ49CY+W30vHQav70t5vbPQr5i6kx5
	kVhwYO+ogi7p0DXpp3R1mF5q/4HGMvMr9aeVGT3u3
X-Gm-Gg: AY/fxX6/lbEjrn8crhjY+JK5MM8diCC/8QFtb+OIchugcPC0hItcSc08X5MVZNdWEq0
	pdvTkp3jn25flxaHsvAxZhD6TzDcQyF7tV8l4x/ScNlD/yU4gnSQWg5tOVmzuhfuBKGSQ9TXah8
	aGbd6y/M7cdHChotV8S8dODEhX8iZf4BCtujAHgJD9ACCiq9cG7yFoauRPnJwxOvtmU0L9fK6F6
	/M2waFf9865jxbE606L3Tgsgj2DyuAGHb4hdy0zg6JmZ/n2sOxIQQJPvo4RMxdXZSvoTCCiJiVG
	a72sAwGlWej/P0Xa+pH9Rf9i7g==
X-Received: by 2002:a17:902:f682:b0:297:dad6:fe58 with SMTP id
 d9443c01a7336-2a4146cbf36mr1038005ad.0.1767999705739; Fri, 09 Jan 2026
 15:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122093934.94971-1-irogers@google.com> <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org> <aTtVO7Iykc8oTl8c@suse.de>
 <CAP-5=fUbZ1pjvcbF0do8BrC0NAzkOJeQUAozQhXKpGuosrW3ew@mail.gmail.com>
 <aTxECtpK3wdxd9uI@suse.de> <CAP-5=fUd95Hw8opxtCA+5aO5-6V6_Y0FMPOCCSmfwsDP6YnzeQ@mail.gmail.com>
 <aWAxpIBX4mddAdBm@suse.de>
In-Reply-To: <aWAxpIBX4mddAdBm@suse.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Jan 2026 15:01:34 -0800
X-Gm-Features: AQt7F2pYmMz_JvZBlsnwyN-VdFtvEm6C_BVlIWXwnup3vJzQ3eatCOdYdxklVsY
Message-ID: <CAP-5=fW48iybWBvdO-9mB6Mkj8nrZF95O1at6Ra81RygG7kqQQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:37=E2=80=AFPM Tony Jones <tonyj@suse.de> wrote:
>
> On Thu, Jan 01, 2026 at 12:17:08PM -0800, Ian Rogers wrote:
> > On Fri, Dec 12, 2025 at 8:34=E2=80=AFAM Tony Jones <tonyj@suse.de> wrot=
e:
> > >
> > > On Thu, Dec 11, 2025 at 09:20:35PM -0800, Ian Rogers wrote:
> > > >    Thanks Tony, those are great performance numbers! I'm wondering =
now:
> > > >     - do we want to land addr2line with libdw given the wrong file/=
line#
> > > >    problems or wait for a fix?
> > > >     - do we want to make the addr2line configurable like with objdu=
mp [1] to
> > > >    mitigate the problem above?
> > >
> > > I think we should spend a bit more time understanding the former befo=
re
> > > doing the later.  If only to provide some documentation on why there
> > > is a deviance to explain the configurability.
> >
> > Thanks Tony, did you get a chance to look at this?
>
> Not yet, maybe next week.  It didn't feel like a time critical issue
> and I had other more pressing things to look at.

Thanks Tony, I dug into the issue and it turns out that libdw uses
module relative addresses (possibly used as a way to shrink
debuginfo). When looking up the address a bias needs applying and it
can be gained from the out argument of functions like
dwfl_module_getdwarf:
https://github.com/kushaldas/elfutils/blob/master/libdwfl/libdwfl.h#L468
What's working in this change is when the bias is 0, but when non-zero
things go wrong. I've tested adding the bias fixes the issue so I'm
working on a longer series that adds libdw addr2line support, makes
the choice configurable and tests it. I suspect the bias maybe missing
in other libdw usage in the perf tool, and that'll be outside of the
scope of my changes.

Thanks,
Ian

> --
> Tony Jones
> SUSE Kernel Performance Team
