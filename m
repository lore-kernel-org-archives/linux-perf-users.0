Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28730F932
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971084; cv=pass; b=WzIkVXjkN1OM9RP5G1q/48yR8ztRUbmaZyNj/zhkzbxoQKNQ7XEegklLa/tyQv/KBZcgGsmvp+/79KrqQwZ/28u9v6gLU87PfDcGUL1UXZebIShFJ+9g/OyvruZLFKBj+c1t+EGMi1Dh5NCluD3ThQBVBbqqzB65bacq3WiZV5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971084; c=relaxed/simple;
	bh=KqDyjDYalqm5cWQyIOyyfajB2bGZoHO7irbOfhFRwq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF7+YdO1CHcGPulVqeqRqRFD01BUdFEg7bApmtSRCyd8VfEEyRnTlPwAMkrH06h0L4/jRTnLMr5fKXrPVRdztbOIXNbNEx6dg8LrodxrBDH9Um/YlrOLNatm9xWut7KoEjswQPaJa4tCxLbOisU5PoXg78EE4QSEDIIWpNuxnbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUdE/loY; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUdE/loY"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c01c79467so753211cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 05:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971082; cv=none;
        d=google.com; s=arc-20260327;
        b=Md2N7k2NUK8vYI/A+tmUi6+2jXENNBfg50o17cTN5HrSQO29bptRSe10dVEUWcrc/y
         nu1mJokJms35AxYc2HU/w9X/DwD5AXA2fcZbmcwT7gwC5OQzP+9l3F0pIiPhlt4N8KfL
         ZJxZv+duSN2jnKIT/5/Zky3C0JTi3rHwRzoe/nu38uYFgpICVIeihxjYzElL9TUj74pP
         RibixZK3c1PVSZkCywsWCEz1lNAmBBqWo4lI5Ew0+etUyd/8MyPQDLXYUD/B6x2CUF2U
         UFdXu1IgfvYnwGsgTTBnjdgHW8zfCo6qSKl1HHC4UBw0KXT9b81k7tsyTyH3pxcyW77D
         q20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KqDyjDYalqm5cWQyIOyyfajB2bGZoHO7irbOfhFRwq8=;
        fh=z76p+7gKSYGl/rdYFuxUDUG/LcplcHlmBEka0ujcVR0=;
        b=ksGcMrj3Mw5Hn6A9jyX6OHykLxhvTNtb7SaXV0vqyf1jy5JOKjJPdsxwY3ac78gDNl
         jaMmDPZU6kI1UmDxGSeIBmhlk/S/efZ9gY7ff0jBOEDH94BSoKA8VAFvsvFyzdHUL3Xi
         jrNB3R646sY2D9fpJkv2DPG6jmoUr7di3AK6xItZrefxtwiIVpZGihhPBAhrhL/rsKRK
         9YVd2NZwaCepwWkWUdNaBaA3lFejflaVeG2CH+yX4jeKtbjPekCwQzajidBTao/R7Xts
         R9fWS/+hmiWVzY9j2++BI3+akLIfIHI5Xcc7S5Zh35l6TMh8MLLVWPm1aYGLMaSicTdE
         NoRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786971082; x=1787575882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KqDyjDYalqm5cWQyIOyyfajB2bGZoHO7irbOfhFRwq8=;
        b=IUdE/loYZMqYdRFWtexMkYB6VT1kjkJbkn/xYlfdoZsTSaLTAvONh9BMaN3i7p+Nqb
         N3Sh9VXd7/bk+Cuu6h+qgCX0hVDIGIyCm2AAkEFMeSnC356tZ7Z9lSA3DSE0uvgp1c+t
         dacJjpQEWKEeLFzw+oll5fO0+/fsvRBQXO8LxEl8pDxxOsiHNokMmVLaLsZUPOpWutdN
         EdTnQ1qoWcxrJBE8w1iZ8tCiZ6Wn7sxM47UodBVP0u3QSH6eAm/IJC5O4kMLG+o+inRH
         Ffal2PzGOvB/hmDfvgc6KRnGMrZdcr9F8zqaspfdfbSHLi8L/RILt3BfE8ky+Czmip6v
         nY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971082; x=1787575882;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KqDyjDYalqm5cWQyIOyyfajB2bGZoHO7irbOfhFRwq8=;
        b=seOkPUAWmFXEmjLhrG82qmqMV3NRNWAZtVF8lloLJrbnRjaJHD+B0R9r8AgAlmazqS
         Kw3MVTtaXu+duLFNzUdoHM5WFt39CEXwhm6GIsLyBd0PjCRLz7RgL+VsuHS8a5kUA8cQ
         iyFc7sTGNK5aNaF44RZ9zO7dUQOCZTj1w5rJ8xyEkkp/FqG/boCFgTGZpt19LItuzcPe
         H6Clt30oY55pMNfYJTXi52eCJgLee2BkTG3QETovcvRhZfL9/N/uyx0mWHjb0DpXWyJa
         tOFL1hRfyziJXRsNkXLv26q2/+59geoxRtnJ6LGEv9Whxk0j3gQu11JkLdUzWeES+d9+
         IFQw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3JXYpsvLI5nmfYDC+Lay+eHJ+Vco51phTZ7JjT+r4R31zz/COW2fA7baofHI3p/y7WtxUgXs1E69Dm8M1aknv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gafMmfAG6/samiGpVi+50PqIiEK+r8wBavb01333WauKWBLh
	KJx6XdBjpBUvItBJxYORvW0JliEYTTxE3cqlEKhzVepNMbG5+XmTNA0Tlmh6/52vdsbxyAMA17P
	HD3o27UZjwDO+GULDt0V249e7Yh4pbyPpUjvNpkmd
X-Gm-Gg: AR+sD12vLSUjPLUY0V8mRkScyl3QEqrSOBnZcdNeRhQCpSJtLFQBQKQ9EYWqbTp5tIp
	d9xWTsVWx0dorBfqLnzHKMLCz+0uqph0c4KrcCs8VN8r+Mi+PZmZP9HapemB6ScpcHZAKGBeZ4b
	QTnibIT4sYUEQhwW0Lr3XZAJ7VxsPYKMpggk85A8CqQsKTpRpQdYB+rkacUwM5Dv76o3cqF6cLk
	uHNV+F1eT91uTieALcCAb2R0NRK4MD+K+U96YN9bcff1G0pJxDFQevTi9HeBXVFDbLD2QZmwAId
	EFc62KN+HvZpHEl+EOynoMNDxtyLan2ohVMS+c68SnN98chFh6wuaMaP
X-Received: by 2002:a05:622a:4d09:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52db08e1769mr14092161cf.8.1786971081628; Mon, 17 Aug 2026
 05:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
 <4998d0ca-eeb0-4b04-b3ac-a1f97c1829f2@kernel.org> <CAP-5=fVffrRgO4OM6u=JTEUwBY0np+fUExqOpbiYU1JgyMr7Rw@mail.gmail.com>
 <7cc71fbf-425e-4047-94c5-3f06d3ed8905@kernel.org> <CAP-5=fW7yQmH+4+x5QCqr2vO_MNSYuPW4T8X8qTns=GitOUN8w@mail.gmail.com>
 <caa08751-a578-45d2-bb2e-349ae201d4e2@kernel.org>
In-Reply-To: <caa08751-a578-45d2-bb2e-349ae201d4e2@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 05:51:10 -0700
X-Gm-Features: AcwNN1Vb7EJe5R2kD5uuB4FYZwV9wD0fQxaTG7o-LUTRhBuld8FH1qKVVX_wPuQ
Message-ID: <CAP-5=fUfQJdQ-GeEB3m6XnTy=LadzG3dh9KU=dQy4Krgw1ckSg@mail.gmail.com>
Subject: Re: [PATCH v13 0/3] perf: Add Raspberry Pi AXI PMU driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: florian.fainelli@broadcom.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 12:54=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 17/08/2026 09:46, Ian Rogers wrote:
> > On Mon, Aug 17, 2026 at 12:26=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>
> >> On 17/08/2026 08:57, Ian Rogers wrote:
> >>> On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Krzysztof Kozlowski <krzk@ke=
rnel.org> wrote:
> >>>>
> >>>> On 15/08/2026 19:27, Ian Rogers wrote:
> >>>>> Motivation & Background
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> Currently, Linux lacks a standard perf-API compatible driver for th=
e
> >>>>> Broadcom AXI performance counter blocks on Raspberry Pi platforms. =
Prior
> >>>>> out-of-tree vendor solutions relied on custom debugfs nodes and ad-=
hoc
> >>>>> kthreads, preventing integration with standard Linux perf tooling (=
`perf stat`,
> >>>>> `perf list`, etc.).
> >>>>>
> >>>>
> >>>> Slow down!
> >>>>
> >>>> One version per 24h in normal cycle, not 13 patchsets in two days! (=
and
> >>>> even rarer during the merge window)
> >>>
> >>> I'm familiar with perf-tools which was set up to follow BPF's example=
,
> >>> both have -next repos. The -next repos merge into linux-next for
> >>> testing. I agree that cherry-picking shouldn't be done straight into =
a
> >>> pull request to Linus. Is there a principle against using -next and
> >>> linux-next?
> >>
> >> How is this relevant? I don't think you read my comment.
> >
> > I think I addressed all the points in your email. The -next
> > development is relevant because it directly addresses your point about
> > not sending emails during a merge window. Except when the -next branch
> > is becoming the main branch, merging patches at will is acceptable and
> > you also benefit from the linux-next testing. Not sending patches 5
> > times a year during the two-week merge window, it is nice to think
> > that this timetable fits everybody.
>
> No, next is not relevant, because I am not even speaking about applying
> patches. I explained you the rule of one posting per 24h. Not 5!

So, when a patch series receives feedback from Sashiko indicating
issues, it's natural for the author to address those issues and assume
a human won't review further given the existing problems with the
series. For example, this series with 9 versions posted in 2 day:
https://lore.kernel.org/linux-perf-users/?q=3D%22perf+build%3A+Add+target+t=
o+install+devel+packages+needed+to+build+perf%22
The author then requested human review once Sashiko was happy:
https://lore.kernel.org/linux-perf-users/anyrSMrYWJz-TpBE@x1/
Sashiko has an option to embargo/delay its review for a specified
number of hours and you can see the small number of mailing lists
using it:
https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.t=
oml#L79
I sent the versions to the mailing lists suggested by
get-maintainers.pl plus RPi, the Sashiko reviews were only coming from
linux-perf-users as the others haven't set Sashiko up (their choice
but seems not desirable imo). As already shown, it is normal on
linux-perf-users to send >1 version per day, and I think this is
preferable than having mailing list people waiting for the next patch
version that fixes the already spotted issues. Waiting >24h per
version wasn't something I could do with this series, I didn't have 2
weeks to spread the emails over, so appologies for the inconvenience
receiving an email has caused you.

If you have constructive comments, particularly on the device tree,
I'm keen to incorporate them. At the moment I don't see anything
actionable and the feedback has been similar in quality to feedback
I've already chosen to stop paying attention to.

Thanks,
Ian

> Best regards,
> Krzysztof
