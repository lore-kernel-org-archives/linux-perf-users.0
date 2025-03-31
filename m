Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FB210186;
	Mon, 31 Mar 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433227; cv=none; b=QrZKUivAhI0MRyvr6DaxYDv8tuxoODiVH4LRurpbaAtdTj/yk5T7qVsXpTcdWl38RbmpklWPFpavVDUcJwT/UL6wU9FfMZ3yyFd9fPWgXfspwkmj/8kMM6NBrpVF4C9ihSEP8IgK6ommAAg2upzBG0PVBuFuzq9koc0zD4LWAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433227; c=relaxed/simple;
	bh=BlHwWo/OKseWfoggWADzoDSruDVCELXc6amipdix5Ws=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IJiB7igqwzlQ0qDseR041L5XyI/t7gksuYhwUZ7PfyzKvlShzOHRoLMtsk2Nz1fTi2aV7jwd5w5ZN3qlJZqY8pwFKJykdAyB01bJXBbzYxfB1Lbx/PhPsBndSS66iPseC19QfxJ2X7bkB74pgt+nbr6gjm2YYmMPw34UqKwYZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wB+Cd8iE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wB+Cd8iE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743433222; x=1744038022; i=markus.elfring@web.de;
	bh=ONG0BJhYcdFcbdbbG9uUilO0npdYdFa1cy8TdF6a93M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wB+Cd8iE+DqToF1NS/R3/YV9BZsYuknrDQn3p5akJ0SVzAMCEHX0umWWZlMUhUps
	 W7uQGq/7H+hutF2zICuzeE/r5iN92kLrdaUILMhfECNYHrTOh1+6YYtjax8IbG/59
	 ElMx24D/63//ezeRHpxiXB8HyTMCtcj7ThqIwsyoL0EChx+y3aGx/lm6pHkqwukGX
	 xHXWdy6r1Io8y2X2eAC6DKNok/6Mxl3kRfdqQm1oDXNax/fiWpTCQ250ytfjNHdCx
	 HLwUm65mDLBPH5PvhuzP4OeoCF9Z6JAodzpeZn0xU86jHxVKbCvKx/IKPI9wfAsKV
	 dj89YU14+pnVH+oFTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1tfFjZ2Zz9-00Vc5g; Mon, 31
 Mar 2025 17:00:22 +0200
Message-ID: <b1749989-ae58-4b1d-b228-62c996dfe87d@web.de>
Date: Mon, 31 Mar 2025 17:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <20250331144324.12940-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v3] driver: tx2: Add NULL check in tx2_uncore_pmu_register
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250331144324.12940-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kk9i/dDmIdF1mDcszJt+OqM6Us9gi274qI3kCBdJbalGiQIIJUi
 cnj5SZU15ThuDoXnTCc4+50LqBRM1qeAqJlnkrZKvk8hSECSzOAxp+dYPwe+ehMJVijdxQH
 aaa5aNCNyGNHhyRMfn9rJG957R67+ydkg0hvIYr8G7h5yRIdUA0T8rzOE2ZAZml7X0lRQG0
 1oWNjZUXcweWzSgerSJqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5wmAebdhJ6A=;DEPTNbWInGLhXRlQgnpQ1+Q1V0s
 NLDq0/gV/aPjY/DxmczBTdB85kA5Dd0cmkzI7pJ5EcP1hyi6cWWQpoBOx9CyZCSR52+FCb3Oe
 jxidFSrMeUQOR8spo0ETqUck1iPGfOGo7wVhkA9WcbOjwmkfi2tewgnI5VDuD6iFMGYXFwGql
 Y1QoaforH7Eg6b4yITKRHSiHzi7ZXiABHcHOEvfD0j1t6whbK7AAk0K2KIcbCQlCnVLxagXaW
 yzcL0v7fTr8ua1ENQvZFkWOoRE3Y8ewWnVni+cUhGvlbheoxJ5FtDGxSL+HwEud0nW1OpKVnE
 Y4CvbT9wzq8/Vu1RhAVk0HzuR7vJ9qPJb0mt21gxwL42+IL0rqQ5MWawEAckFmjBwHTxNjeBW
 HL0iwBJFMTB8w7VeQwqBZ0A15u4hbn2XVZPOk+U3pfWVMja0tfzB5L10A5sWCJAvThT7J2mtr
 jlFCEwe/Nn4OWDBzGN0uHXZIJROM6VqcE7nVyDC1f1ZDodgwgdn5E6rWbAlGFSjHkKAIFAvfa
 aoIbQQxGVztVge3CE1b68P6lXhUj1RyY/fhJFcXoCAj1tgxAxSFOxfL3DtwBNv/LbVRcWm0C6
 UtZbxuu/3KkdC+RSmCfQyq4eHQtrpgG7qSNn6Pcbe98xXaaJdxTUyZ28kys7/3UsEUQiWFwMQ
 ghPpW3GgprY0bg0QeE1somZRTiPl02OFblGfnkP/7ZQfoLAPc45sJuz4EMrMDeXs+fCJrDg42
 8PWb0IXz7fiUELX7PscK3kDdxFHI30bpXlaud12IsIGBjtonRCwbyMT5HLxzdJskL9Ambl1zy
 wkQdKrjPXgWObYB2+nbky5pcJI0rZqCSJzHpMHER9LkZRY0rEosdSEtqlUAmVzaRTCuPk4axc
 kOB4l5h+zhciijlhc1k9PDwZD0lpmJ3kg3NkY+vCLlm2cuQPg0JNTJo5OrThwYHrQLQMhvthD
 mAomd63icEwafFTGnSPhrydakAWv2MaCfX6Q5s56Prvgnwi1vSKw3AvkeeNL2iUud5r9E0H2C
 RXg5bVEiHMOtT5GUv8tJEqPjKUIEgkgm8uONKNAd9gREyQ5uW1VYQPHOxnAZs56oF25o+vUPJ
 DlB2NubSuNWyxYAeKyPZSu9+yNhBvUbPsREdj6Wpgo+fIRqlqUcubaKqiS4FUxl7anj9JZBWX
 HRMxQ6kGfuK/948/QuFcJbSJJuK+gn0GTTg/W7mlaLpTx6sDoovj98vzfd/D/uCKpsgNgbo7A
 fT+cK5iRJ5lyk0BfsEumOFA4myjuzxM6AtVNpSLp/gIKa7nMO20PCL/g+yFPus1YTh8kcEW4S
 kJzmef2vKRd9AGnuxIvK7P45/0C1cylTTG2kROoRZQ9X/rM4AbHR3MQEpi+7B+5YLa9/1I49Z
 DS8gf/Hgys2eMFTkL8IXuyrDEBZ5fgFI5rnZJ7pVtZ3S2rPWkpGZu0xKAYCNeNCrcID4WfOiw
 TN8QN/TO9pGPHWyAuxnEtHJ4QGqQfLyhMUdm28CMgxyWSM1JV/AcwY+H3oopk6gfMCPJkhg==

> devm_kasprintf() returns NULL if memory allocation fails.

                call                                 failed?


>                                                           Currently,
> tx2_uncore_pmu_register() does not check for this case, leading to a
> NULL pointer dereference.

This (temporary) view should be reconsidered in more detail.


> No automated tools were used;

Further development tools can help for such analysis attempts.


>                               this was found during manual code review.

This approach might be misleading so far.


=E2=80=A6
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -738,7 +738,8 @@ static int tx2_uncore_pmu_register(
>
>  	tx2_pmu->pmu.name =3D devm_kasprintf(dev, GFP_KERNEL,
>  			"%s", name);
> -
> +	if (!tx2_pmu->pmu.name)
> +		return -ENOMEM;
>  	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
>  }
=E2=80=A6

Should your source code analysis approaches take further implementation de=
tails
better into account?

Example:
perf_pmu_register()
https://elixir.bootlin.com/linux/v6.14-rc6/source/kernel/events/core.c#L11=
859-L11862
=E2=80=A6
	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
		ret =3D -EINVAL;
=E2=80=A6


Regards,
Markus
