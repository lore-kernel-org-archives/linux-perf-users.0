Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E42FFFA4
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340506; cv=pass; b=YSJ5aj2cu6MKYgwMLaR+TBWk2MUjVf8kigOlxptStI66kuVzy0nzAtclxT/gGuDVYO2BOJmTE8/BOAXgo5KpCubukaipNaouvxiuizNpeYailFhfobOC78oeqnZXBAplYjkZKxxFUZs1hT/3cNu5CMFgRTy6gmgBCMmUFEnhNrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340506; c=relaxed/simple;
	bh=IwTUVX1vwSCi8tBUvA3x0u0h7rk9D3cTbqAFDNJpQhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTELiLShozGZOLQIHtmrkvOuaLNwxOpWYRRARtPw6teApa77GQsX5BGjKC9+2UyuOKQkYCzCebabDHFP+4HWDoX+pzgh7m6uJha8ANVpSfQ7zbcJy55lpc6p/7kvYq/+B1r9RR7OkP6eKPuqNQR1gCAjm0MvGglR6BmA1NIJEY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ea66MK0O; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ea66MK0O"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10ed63c0so217191cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 22:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786340503; cv=none;
        d=google.com; s=arc-20260327;
        b=lCJGUFLPQYYcz8EGBx2IFKDSFFKRfL0geL4ahjVKKg3q8Qb/aoVvAhEEY+OjrbQGPM
         4Wr7LZYVSXk3xBxnKKVdmSvpkExqn8RYFESPU1QH0yJKhsfuUyjzC9lcHH8c6HvdVeeo
         X80d3bp1rZRuq0GXT3S/EXZRy6lRMyVk4lPKASJQa33/s6GQcQQJTsd7z4JNjBA7Xjq3
         lRW1zPRU++SW9OnC8q6x2AmXAPw/tqO5y3JRuMT4y89Qk0MDk4oyPAgdcMEFSe90Qxyj
         Aar8Z2dxcDpPZtVK/HUsyPFjwi/BxtV4eIuVNgOCL4l0xp84lv55WDBUps2imD9Q1YSk
         PUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oAAuX5vxjg2Pm+bU5mwW67u+Nu2cQ4w35TXJ6q+sUlA=;
        fh=lfrrQOjg3q75oZnrv6l/84YXIOL/0CSXXmxmwtwFtFQ=;
        b=roaCntE/YnfyiMljwSqNSNCRCQdnHnGkw6kckHRNbEz8KUxMXI6lGyxKGJgFjjs4VY
         Dm0dfKABtcWa9ORn+GAg0MoGNCg1LonjY+SB9OJid5XTM7xnmcstrU81inov64JfveRf
         zqN5ITxKY9V9or/Ycj5OuqhAcgkR3Smf78iwZotV+Opnw1pldA8rQxX8ALUVqYRqq7hG
         SJTu+bnM4jtn57nb4S5fpXbpbcygtghkDrKtkGvLr4/MNvkm5JMlFPO3RXwIGVg/q5aN
         b+yfiHEc9t7JGjMFep1GtD6VRQ+kadgIuagAamS4d/4JOI4Cx9Rw1c/+/QHfHXbuphdL
         pDmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786340503; x=1786945303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oAAuX5vxjg2Pm+bU5mwW67u+Nu2cQ4w35TXJ6q+sUlA=;
        b=ea66MK0OTCSdet84q5KRkN50Pisaqj09JfR5mrtqrK/+6i6yV/fo0IkNjthRR+HVzm
         D7IDCTIt7dCHSQiU3TBrl5DJW08R9WCSvZVw6gZIVJrOIsTFYeXvFZIcAaS4zMrGPDuo
         UvejJ0WkVi3uBZUIa0LqJFL+mBaL724xaNR58IrS2ymIRKjDKSAufZLl2zzyueV6qB7B
         ywphSJxoPKiNpSrCmUM7Vuq6Dm39TAwn7VOKHoLkE+wT8Ud/3nutA8Sc/2qaaQrnmoSC
         2+LfJjmAJjLRlryIg5QF2W0+ehWpfImy1OW8j5G7P8Y/LJFUK5f6f3AA1sZTVJaX9tCl
         mQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786340503; x=1786945303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAAuX5vxjg2Pm+bU5mwW67u+Nu2cQ4w35TXJ6q+sUlA=;
        b=ey/4i4qFL/RtJRK24euC67RmFNzkpEHareYC+cbH3j8onWO/H+GO0mKG63CjcHXkXx
         5QT5BKavb3YO8xR8qHc2bRvS3mkSmSJUuRvwTMN3B4pO1vtHfnxFwwsocBVcFEK4LSfc
         muym8wS3Gt5iH/X0vk+zsdlCm3yI/NvlKtRle/zszmLYfnZ+oLGW0cfOPW5kAkX2xEaz
         8uUH/IvJ0TzEeQIXNYCrjPmv2cjRyS3jo5bU2+qLG4cBDiKwizjwJJTkXdlWMTF3Lvv8
         gdGgjZGWhm61lLCGNP3X/mkSuaXwqM7qxL9LAyAL4Ka7ix8NysqkSVY0zJzcK1mch1UR
         VBQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5/DyVb3toTWhOC6DTI5zemFcqiO31zdfYQu6LdLvxtSyVjWy0b4KwmDI/EFUQ0uW28eFc7Wv7gfCmRtMn8p5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkRFlH4COr0pHfr2jWddJNo8WowhfE2LrG9G5ve682Ma4zaIl
	gb0Uo3Ug6aCvYbkB305DW1hBzis80pml6mPfZQsECMD9gJKBtp6WaxHUFtxrXky2QMs14F1tyIl
	CWA2hhWUDhFlamULuEuTKOoNdcxU5c5rLxW6V2t/m7CfncRPCGETgeDf9
X-Gm-Gg: AR+sD12ucJROEqp8OjQ5hZ/n2eUFdF2e9ZKrzDcqGefF8WeQt9k/dKNu/rukR3AZQg/
	xGjhp1CezDEBH/0OC+JkkO6yX/hcNT35IQW6Ghl9sa0b4AGiElxX9NhTRGEeyz9R5dMRvhLwTiI
	uNeU9WJC7Y/IppqUfqlRLaSxgTMbKEgZRlyeD0kQGHs6kryB2QHlGQgxHtFSKBulE6kmOEVhjXT
	ik+ys8u0Dy1YiycsXSSDfXLgmmzC1jyMOOwJU7x5ahan5aiZVNxlLKGWbSsbi8fJAvK62zGNprD
	ns8+suUeCkJoO18T20G/OTlOeRaL911xZb+B2YpSISzToQ==
X-Received: by 2002:ac8:59d0:0:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52d23c8a773mr28134111cf.12.1786340502880; Sun, 09 Aug 2026
 22:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
 <20260809071455.1221514-12-irogers@google.com> <20260809072810.3B94F1F00ACF@smtp.kernel.org>
 <anlbZhmuJIj1Wm6E@google.com>
In-Reply-To: <anlbZhmuJIj1Wm6E@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 9 Aug 2026 22:41:29 -0700
X-Gm-Features: AUfX_myu5PDh2hgDPxNeb1_yMfoowhnD-JDOeQjqiPEPd-Z0MddptEnva-1WuKs
Message-ID: <CAP-5=fWbwZWppYLcuFhxJ18BtXJaS1+DDo-U2C1UD5zKF+828w@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] perf python: Add thread and PMU uninitialized checks
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 10:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Aug 09, 2026 at 07:28:09AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] The newly added `CHECK_INITIALIZED(ppmu->pmu, "pmu")` in `py=
rf_pmu__events()` causes a Python object memory leak of `py_list` on the er=
ror path.
> > --
> >
> > --- Patch [11]: [PATCH v3 11/15] perf python: Add thread and PMU uninit=
ialized checks ---
> > commit a381b82bb0eb00b93be525bfa1c265b574c03a5a
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf python: Add thread and PMU uninitialized checks
> >
> > This commit adds CHECK_INITIALIZED guards to thread and PMU getters to
> > prevent crashes when accessed before proper initialization.
> >
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index c70b151428f76..fe5afce173330 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> >
> > [ ... ]
> >
> > > @@ -1730,6 +1731,8 @@ static PyObject *pyrf_pmu__events(PyObject *sel=
f)
> > >     PyObject *py_list =3D PyList_New(0);
> > >     int ret;
> > >
> > > +   CHECK_INITIALIZED(ppmu->pmu, "pmu");
> > > +
> > >     if (!py_list)
> > >             return NULL;
> >
> > [Severity: Medium]
> > Does this code leak py_list if CHECK_INITIALIZED fails and returns earl=
y?
> >
> > Since py_list is allocated with PyList_New(0) just before the initializ=
ation
> > check, it appears this Python object is left orphaned if the macro eval=
uates
> > to true and forces an early return.
> >
> > Could the CHECK_INITIALIZED macro be moved to the beginning of
> > pyrf_pmu__events() before the PyList_New(0) allocation to avoid this le=
ak?
>
> It seems this is the only issue introduced in this series.
> As it's trivial, I'll apply the following change for Ian.

Looks good to me. Thanks,
Ian

> Thanks,
> Namhyung
>
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index fe5afce1733306be..36c5f4b0d0bb15e7 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1728,11 +1728,12 @@ static int pyrf_pmu__events_cb(void *state, struc=
t pmu_event_info *info)
>  static PyObject *pyrf_pmu__events(PyObject *self)
>  {
>         struct pyrf_pmu *ppmu =3D (void *)self;
> -       PyObject *py_list =3D PyList_New(0);
> +       PyObject *py_list;
>         int ret;
>
>         CHECK_INITIALIZED(ppmu->pmu, "pmu");
>
> +       py_list =3D PyList_New(0);
>         if (!py_list)
>                 return NULL;
>
>
