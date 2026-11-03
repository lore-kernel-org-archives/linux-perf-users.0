Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739642;
	b=HUNFrXxXuLXFCePa8BQ6lDDUyYY8sMB09cQq1BQRQXo9BYuqLvqorR9bgpdKCETN8vzW
	 ETiDSep9je1kBUNmwJt5lwjC2e1QhqyeAvy3qxppdeOC4mcPqNtNhm+gQ6hT/vhxRFzNl
	 qf5ddXQkGnXpYfbtxflIjbfdsRg9/tqxitI2yn7YXiG0SKFdu5M1Be16h1N1HCptkGpAC
	 UYtrSw84JSqK3JSXFjam+P+yBAPAif2LdE2U5XHBDbAKChLwAdmgvMbf0szTX7ihZFIi5
	 T1ETFu3EAJazEBIQx+zSKlOe7Q69d4Wb8YOxlR8B5uO3lpCPmlHgD1+U5Hw7/xyy+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A5NYbIJWpJmoCVf2yBASlToOhio2ehmVnXsOleiohOg=;
	b=XKFOduze+JGLtvb8w08Ozibr4xlCansqRxjnw2KtIy0A2joWAVtQnUHIVfpuJdSQOjAX
	 KHw5FVz89DtAfRLciMSywXzqFtKwyCVzDxzmkyby1v/HZEwOO7ONWABnVJK7965wkgGOX
	 ydFih0xL8DzD0rkCn1cAAUDG41ePQxCbF1QVDa2eTP8z7xjWV7qpaAHeBb/y9x8y6/qt6
	 nTfQ9nRYpMuCjywmecft+jHp+XXy3grdJsLKoIG8RxFzSg+AdTu3nbWnMpKIK5rAMv1YT
	 MuUTqTrNCp3zdhjhN68z6kb1eNepLb1KZmg0kXU5LFNItAujLLSMkgL+smRefWgd6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCLNX2z2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3C606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCLNX2z2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E561F000C1;
	Tue,  3 Nov 2026 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739641;
	bh=A5NYbIJWpJmoCVf2yBASlToOhio2ehmVnXsOleiohOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCLNX2z24qQQuaVqFxROMx1D0mJ7id4MCDvL7qjqj3SXY6RBXmpE5kjca+iJZctSJ
	 QsDSwh2GugE/xKog6KQew0Cjfnmz9+XE6+Udzv9kjx4U/cVKDkmS8FwNSSTA3W7VsU
	 hcJlp5v8lNHMYxQcxj6yDpfk7PghHJgRhdyS76nXZsmQaVFNoJCeA8SVBexInMAerX
	 RINbWT7hpjrp7T0z4Z0TcObnaHRSbLtVCVLdp4AmbH/3JCgdaVGJ+c+Rfgpqr9R1xa
	 rM+SC+eiVIScL3ZkeDHrld4Pz2y1OA+q2/ZMVmQJp3MFVrJZFEZcr50heUGKjMWunR
	 swzKAVJlPFCog==
Message-ID: <sashiko-outbox-196022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-5-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-5-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:00:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] alpha/perf: pending PCTR1 IRQ misrouted in alpha_perf_event_irq_=
handler()
--

commit f0c418fe426066f6a450b4931c312c3fa2526930
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: implement ProfileMe sampling

This commit implements ProfileMe sampling mode on EV67 and later Alpha
processors, selectable via the profileme config bit or precise_ip. It
attributes samples to the instruction address latched in PMPC and handles
counter parking and rearming across mode switches.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index ecec78c355cd3..546e30d46c61a 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -869,6 +1118,10 @@ static void alpha_perf_event_irq_handler(unsigned l=
ong la_ptr,
> =20
>  	idx =3D la_ptr;
> =20
> +	/* A ProfileMe event owns both counters but lives at index 0. */
> +	if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
> +		idx =3D 0;

[Severity: Medium]
What happens here in alpha_perf_event_irq_handler() when an Aggregate mode
event on PCTR1 (such as cycles, bcache-misses, or mbox-replay, which
ev67_mapping[] assigns to idx 1) overflows just as perf multiplexes it out
and schedules a ProfileMe event in?

When PALcode delivers that pending PCTR1 interrupt, la_ptr is 1 while
cpuc->config has EV67_PCTR_MODE_PROFILEME set. By unconditionally
overwriting idx =3D 0, alpha_perf_event_irq_handler() matches the active
ProfileMe event at cpuc->current_idx[0] =3D=3D 0 and calls
alpha_perf_event_profileme():

    alpha_perf_event_irq_handler()
      alpha_perf_event_profileme()
        alpha_perf_event_update(event, hwc, 0, alpha_pmu->pmc_max_period[0]=
+1);

Since PCTR0 has not actually wrapped, doesn't this add a bogus period of
pmc_max_period[0] + 1 (1,048,576) to event->count, subtract 1,048,576 from
hwc->period_left, and emit a false sample using a stale PMPC value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D5
