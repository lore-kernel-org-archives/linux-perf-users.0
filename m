Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455E2E7379
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789274019; cv=pass; b=ime6OkT30l78oyn1Nyj5A9XdRjlugfsJEoNzbFxlesTFyLXX+CkZEJVaeoIPERqHreIAv7lcXH7dtxSPlw96ZnlVZPApbNGhjNE2o1Q4/YICB7SvFiQK0NswVrsmnNEF25qHLcULr3/w76zjAuz5Uaq7CwDFa+0r3+Ykk/vqT7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789274019; c=relaxed/simple;
	bh=L0jgPvnCMirLxxp9rsn1UdXIaPofz7zSVCpJKhbP6IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIxGTgmLKbNY5hnw2j1UNzvp4j5rfvzxe5zOOX96h6S7U0n9t8luoi1oHQGNsMZjstd2rMoGQQHm9a0oPFM3LeXNuvwTIfD8hbuGa0fMwhGT//lmVIt+JjjJwhdLMw9L5WVD0rAdN/kBeonvTQLNdjrjAy1RoZmXDJm//Ck8B80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9a535HE; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9a535HE"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso126181cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 21:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789274017; cv=none;
        d=google.com; s=arc-20260327;
        b=AZZAOF6CBUfxGm6Ro6878fK/+I+wFkqWMrOh9BMKeGQvrPdi2iK1EirLnRbD0xGZvK
         6N9tKC8sszzaX+gKzoEf7Xy2efLcuK84b9iqL5Lydw15+2akeYjSi+XBo3KzZi4yixG5
         x+74CR3PXo6jLtFUv3vLaeLf0aO4KO+wvniEDbJPGFS/D0BWogRvQV1H9vPNeMZ40fMA
         JZOjOpfnMFP4mOpvKFnDTYox2uI2FaqW+J4pSnFXgmLH2w4sbwaq+zSZnvSjZmIwZonP
         /IEV9OcbPys3gQTFTnGah9ACYDbrVF/CH/AcE3Q2vo3QZj6DbUIsyeuIhXkLytW1npGu
         EQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QjAmbmQNigeFVk/WoVuEvgrcNPjUMDUEIO92FYiCnpg=;
        fh=zdM2YEWUjcBhUaFNt+qilgXm9RdK7O9JLpi6q/hI02Q=;
        b=HyU8O6U2oNH8O2/aRROK1tErPvYHTqWdYl7rExg0SOKp85kJrha0CH2r8D+kzQz2kh
         mCKyNADE2CdzmW2crH4ctULFNfLIalrbC8/W+tao4iOMOS4QkH5eQ6QgIbJXS9uCftDU
         oCZYGHgarsPfv5zBZ9e3xB8NDSH+QxGVOTkH4XQ4uC/ep7ic3zqmZOfiHJmF3kTLt34e
         QKbHQoajT9FjdkS9Ygnhv+R2psDmC96U2rqOjtdEbev9Fy7mryQ2tTRyoNjgObAwsL93
         vGp/d61Dr4apyKDQlS3J8oPQ7yF0cNKt6JPqhYi+4MDf8TgNWd4Z2nG27iCOraKHoYua
         xZvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789274017; x=1789878817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjAmbmQNigeFVk/WoVuEvgrcNPjUMDUEIO92FYiCnpg=;
        b=E9a535HEBJtaZ5Kv1IZ0V2SggaaNttSs3itKTyeSa6xUmWIsN5bZcJtt3ySVXvcDte
         GhBRcp1OE5l3FZhO3nicZmfyxuyiC6BF+npM8k5Ep1uFS9l9ZDaz4iAfHrRcnGdVAnEx
         7MFNCqfIfwMzs/7WGdMyX8v+pMNDMsWt4jd3Y8ady18L1AmwN2WhbmTSRj6i9fYpxa3P
         +kV0wo9NhE47hztTrYn7hAUaPWfgD1z5SOoZ2WiBVX8HIoeVRBvryctn3rT4isv3TPuQ
         cc2AVOQwin+t5xDV2KPc5fox+Eo3I0YLNJvOp4oWRyjtQ6hwZ8gDdKOGOplBTDhm4N8e
         aTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789274017; x=1789878817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjAmbmQNigeFVk/WoVuEvgrcNPjUMDUEIO92FYiCnpg=;
        b=SRSMtyS0+ili2/QC9FFfiZPCnYfPbykXYEniHwHJC3mHmJWt9iBzUUi32edGF2O5GM
         A2c3bMjmgsNQkT3EK9BktCWWrQ80MPjsZSMYTa5MS5uU6jBk1d859DQDcKyzUBuEwu65
         z2QH/9YQS2vWJxN3Nhiz1qbJZmdVzEVV3yOUIRnDk+/TiM4t4VtnO1ur+E49b+G4z5pj
         3pSkr1LgKdSJ9WldKLSe+s0mQcnTfR2Y6T15RCjyWVzRz8ZZ+ZEdr9E4qXE5Nu4Oqklx
         eqritL8BeJy0vVeVMHfrAmOeuDWeAuejh8prQkMprvYon3pwM4+2Ge18DHUikOnsPdym
         n59Q==
X-Gm-Message-State: AFuF++nuBk0oApkw7OOUQLWHuRnV9PZ2atydC5bCTu00tSNn8MxG0kXH
	h6a6U8uPZhAVUSTGj0/J8qlpjFEVXnnjZLBuCGNVWhiD0vKSA4hi188robmFQKhijWtZ3j+iVhy
	xk4Jvg/IKyWGTiKC6DkrCLPK3fTq77Zm3sE38CwqokYEfMIJ4fwbPC6VglbA=
X-Gm-Gg: AYBFou1t6JwtXuW04s/cEoxHT++pn3Ww/hxA5a9XaC7sYawO7lPz0hkvwgaLYVQlnDj
	epFqZ2ZmxWqMmkpiVFoVYVjvpwp81DbcAEiCOq4W/KjWjxHf1aTJ9kF1PzKLvt1kM3XAtBC4X3i
	YuvvpYeMKLGVL/ssWOU9+SWzDehUNLjb6X4xGYoAxJTFwOZp1CSaTAkttb+yF50C8dXB8Gfin1q
	VdZ+hIm1PTSEdstkUWH6l8D2/XeYBNBtodjNqa6uO3lwmDt8L0XwoSUc0EJdrViqcLkDa1GtZT5
	fyBm5LY+CegSxJ85koIBw1WgTlUe/a3zQ34oVWCaG8ZvspAMJOD+V0no/jYPmFbxng==
X-Received: by 2002:ac8:5995:0:b0:530:4182:5a95 with SMTP id
 d75a77b69052e-530f8a3522cmr3179721cf.2.1789274016948; Sat, 12 Sep 2026
 21:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910174420.3002597-1-irogers@google.com> <20260910175151.A0C8F1F000FF@smtp.kernel.org>
 <aqWz6HTIzoMmnLP-@x2>
In-Reply-To: <aqWz6HTIzoMmnLP-@x2>
From: Ian Rogers <irogers@google.com>
Date: Sat, 12 Sep 2026 21:33:25 -0700
X-Gm-Features: AcwNN1ULgUZ3hTehg8Ta3y3IFJJQ2xQ63BnwrQOg4ido7uHc8fTiZZKw_qA5XLs
Message-ID: <CAP-5=fU63+_u5wYKzYb4AV5vmDZG_RR7BmLmSrQYCvNd9r16Qg@mail.gmail.com>
Subject: Re: [PATCH v1] perf python: Fix ilist TreeNode string type drift
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:19=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Sep 10, 2026 at 05:51:51PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] The use of PEP 604 union type syntax `int | float` in functi=
on parameters breaks runtime compatibility with Python 3.9.
> > --
>
> Waiting for v2,


Thanks, v2 is here:
https://lore.kernel.org/linux-perf-users/20260910211539.3157204-1-irogers@g=
oogle.com/

Ian

> - Arnaldo
>
> > commit 79e3c05b8663765b4c4ea91366e2819e32834d75
> > Author: Ian Rogers <irogers@google.com>
> > Subject: perf python: Fix ilist TreeNode string type drift
> >
> > This commit updates Tree type hints across the perf python ilist module=
 to
> > prevent mypy strictness mismatches. It also addresses minor stylistic i=
ssues
> > reported by mypy, pylint, and Sashiko.
> >
> > > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > > --- a/tools/perf/python/ilist.py
> > > +++ b/tools/perf/python/ilist.py
> > [ ... ]
> > > @@ -343,31 +343,34 @@ class IListApp(App):
> > >          if not self.selected or not self.evlist:
> > >              return
> > >
> > > -        def update_count(cpu: int, count: int):
> > > +        def update_count(cpu: int, count: int | float):
> >
> > [Severity: Medium]
> > Does this new type hint syntax break compatibility with Python 3.9?
> >
> > Evaluating the PEP 604 union type syntax int | float as a function para=
meter
> > annotation in Python 3.9 (without from __future__ import annotations) r=
aises
> > a TypeError at runtime.
> >
> > Since Python 3.9 is the minimum supported version for kernel auxiliary
> > scripts, this will crash the perf userspace tool immediately on startup=
 when
> > IListApp.on_mount() calls update_counts(), which defines the update_cou=
nt
> > inner function.
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910174420.=
3002597-1-irogers@google.com?part=3D1
