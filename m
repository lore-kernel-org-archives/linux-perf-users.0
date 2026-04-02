Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA536C0DC
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163266; cv=pass; b=aWAyxQdyps/NGqfahOBS0qFQyGWoY39WRS0iaXitpTzYUMtlOJWguo+mGwOAkh4raq9FvXaeelYVS6CYZKLAR4vIDJq3qkshTXncd7OrOetOxsUBbcLgMzdd2omxhFL1g2znVh9FxfzTSxRAiQoxEF/pJTxMK3S5h51uoie3GCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163266; c=relaxed/simple;
	bh=zag6oPpGlVWWBvt6+o6MkUolWhDH4y6qS68Ot37Lgd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a85F0KLS9htGDAETUPmRz07MhLaGHEHFbVUlKa4zH/8AffhppwSI1UcLO7St9/FuLvMgXk/ZZ7kuugeNvqQY6RoT27mVi1xxeEJRD3xzY11MfWcZV9Xe9t54I45w+H9VqPe7ApszwK/+6AO+XBi2paaKdusrV98ZhJpeLlYKsFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6yCw1Wa; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6yCw1Wa"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1274204434bso2104932c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 13:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775163264; cv=none;
        d=google.com; s=arc-20240605;
        b=aYmpHcHtnhj60U+zNcjpfSfxuNUhfGKNf56QCOUHXvMJyKDJy6cv00bp/l72fnRU3B
         oeUjnS/NZjd/nMw+v3PHnDpg30nVOYeS7xiB970fB8SwMsKIDDln9rNSyUoEhsYBcnKD
         s+dl+baFwXE52HTwoiaem1bkgqJ/Co/fSv6CR1Z2v3rg80ry9tA3DSC9Uw1Fr2KOYxLz
         Y7ijIDeFIOerm6tu/DvIWKJxKgeULz1ZDZCvnzxeTEzvRgqb7jRkuwoLDYqo3EcR1nEc
         U5+VqkU8+u0v09EkkXdskIXjvQMhPKAisr6V8Mb6Yrt/mh17pPMhw8NHRjBpI1vcusHI
         Y48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mB8XPEZ44g6CyKuVrN6P7HoWPd0iBABl3evH57/syeQ=;
        fh=g1G/uXQAxZRhWxgX3tJ6RI9SEsClVLODHndY8s1QQ3E=;
        b=gDlx+ZKvK5Z5wSEkAG1KLL6O1wsH/tNCFPQ7k83g9W4r5CVqHBPcbLwm6wPeg8tfBn
         KZqADxxRep2YNXeV5VoJ/mNROs2FJR4z9vZRW9GLykeL5rcNk+dbgYT38utzte4F08Cu
         sBgWjLJZcCT9wtxeSx2UqGlRkKO8AU2ggHP2Lj6CNuGrmerIFlEwg76dGI7uPAMXTMgi
         mKdVRA9zdj1Tj/zPGHHSr3YbBHHsSLCFbEYPWowruOlD/gc4v3x/DjwF6L5tofGebdxu
         7i/wEeFEkGggcTW+OrEMZAvZS9vTR0g2/HcyigOeZ8ltUBpppoD9I8Rx70RqMYVS/thC
         +rng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775163264; x=1775768064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB8XPEZ44g6CyKuVrN6P7HoWPd0iBABl3evH57/syeQ=;
        b=n6yCw1WawKEtzAMfYj7tbKZKLMofJ+hz6pJ0nTgeWkh6Or8C+TY1pNm8zWKQ0tuMOQ
         QEJYej8Wz1E+kIuvq4uZk/AxlSgypnYKjYte0hU6+WTmuuSazi7xFD+pmRs1L0tz/cHI
         72YWAyVdla2hbQLakmQw/Ubkfin84qO6p6lWiHK9M1VsBjbdaVuWgW9B318hJZJznsin
         I1QdDioIkUC3kHUfBKBxI7XYPvHRuL4dutD921O/R7i7miiszbKz3xpbuUUYNByyPbtr
         zQgrsUYrpcaCOVGN6EXma4oEWcUg5FWzCi2lY6Qvz1sRVJHmmncaHo0KI9CPtVDhEGyo
         da/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163264; x=1775768064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mB8XPEZ44g6CyKuVrN6P7HoWPd0iBABl3evH57/syeQ=;
        b=DaTvJF2KzD3rylHOVj4DX8LC9FrKa2YqmAUJBACKC56ZDwtA7awec/Y1nxUG5mhOue
         E2Lvv2QiBqEIxkJj8NSCiRD4ISPFfd4MuKDhbj5lp3rWAZINGQBANsEvbuWbOcJbrLZi
         5Q0bUEL+nUCgIkgiv4Tl22Jh8Zpl7HtvTRT/cgHYiQHSjaBJjt/s0D0A9FBbY7BYrBQ/
         A802Kznzsiyutogq7DChtL279X2pYZ8ANs8NVKXSfZLHR3MLonCrTOD2RYD88kpDXJiC
         KwWN/s+RGtjIdscAAklbgOTkQTe4l2ryRZg/1RWZ1DSEi2j5bY7g+LIRAPlnsWuvfbTb
         OedQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV1ilhj7VWdS4a7vkktFEHAm3e2w2yoIP6Tqi0cpsniimUC3MZfXfOEsODhCBD/FbF46wUCSfbUmGv0BwOQxlw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wC8W/NbMnSa+I8b+kAdAo9Z8wHChNauB/Fe2a8k6iILzEs9T
	dGsEP4ZWrC0gOYpevJ4XUIv40cnaYmH5o37NuEmTCTR1717uTx4UXOGQe2FOH2FIxgES7DirzfK
	PXdhBNQZUErlW6c2CgoY7MkDVJTp1a5t75FmzWugu
X-Gm-Gg: ATEYQzx/P6G5HiUel516/DdUC2eRzRUIjBX1hUy08tsfAvSks5Vs812HhnZuRO65PWa
	sQP+G3kXzhZuyUBpk/FCte5MMNi7vny1IblW3Mi7F2/86Ab2rGz4JveK2GfrEwt1OMH21veYe3Y
	/eAOLHtz1bG6Ia2V5IqZirWsJ2m52kjEIJl6Hct5GS3mSR65YGNR2jWMdG7XUA4V1ktMUWFVnPt
	7Fc/buGS9aN9A4+OXLhdKZCEsZmZXRZDGy9fmfKCnDOjqriYhVte9qcPSIEh5VJdvbTH5a5UXB3
	kSeqWadHFv9soCJG
X-Received: by 2002:a05:7022:e25:b0:119:e569:f875 with SMTP id
 a92af1059eb24-12bfb07a978mr302699c88.18.1775163263368; Thu, 02 Apr 2026
 13:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212223942.3832857-1-ctshao@google.com> <bb9a1471-6996-47e9-a81e-8de58ab32fb2@intel.com>
 <CAP-5=fXFzmKx+buppcNBQWhEP2UyCobPwYRC-L-unpmDL=2_Wg@mail.gmail.com> <ac2zXqAgWqKqdSyr@google.com>
In-Reply-To: <ac2zXqAgWqKqdSyr@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 2 Apr 2026 13:54:11 -0700
X-Gm-Features: AQROBzBF9XXBD6wQJ8B2gXEJRITCLkjOqnG5d2NNKkWs4AhhVTW-iiys7zrTYIg
Message-ID: <CAJpZYjVSgK=pnpn9pqLUq6VdZ_HF5Z2NwobfVfMFNFde-74Uig@mail.gmail.com>
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, "Chen, Zide" <zide.chen@intel.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please check patch v4 for rebasing.

https://lore.kernel.org/20260402205300.1953706-1-ctshao@google.com

Thanks,
CT

On Wed, Apr 1, 2026 at 5:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Apr 01, 2026 at 09:38:24AM -0700, Ian Rogers wrote:
> > On Thu, Feb 12, 2026 at 4:08=E2=80=AFPM Chen, Zide <zide.chen@intel.com=
> wrote:
> > >
> > > On 2/12/2026 2:39 PM, Chun-Tse Shao wrote:
> > > > Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as wel=
l.
> > > > Adjust cpumasks as the logic for GNR in [1].
> > > >
> > > > Tested on Emeraldrapids with SNC2 enabled:
> > > >   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -=
a -- sleep 1
> > > >
> > > >    Performance counter stats for 'system wide':
> > > >
> > > >   N0       30        72125876670      UNC_CHA_CLOCKTICKS
> > > >   N0        4         8815163648      UNC_M_CLOCKTICKS
> > > >   N1       30        72124958844      UNC_CHA_CLOCKTICKS
> > > >   N1        4         8815014974      UNC_M_CLOCKTICKS
> > > >   N2       30        72121049022      UNC_CHA_CLOCKTICKS
> > > >   N2        4         8814592626      UNC_M_CLOCKTICKS
> > > >   N3       30        72117133854      UNC_CHA_CLOCKTICKS
> > > >   N3        4         8814012840      UNC_M_CLOCKTICKS
> > > >
> > > >          1.001574118 seconds time elapsed
> > > >
> > > > [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> > > >
> > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > >
> > > LGTM.
> > >
> > > Reviewed-by: Zide Chen <zide.chen@intel.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> It doesn't apply cleanly anymore.  CT, can you please rebase?
>
> Thanks,
> Namhyung
>
