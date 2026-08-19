Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA06440631
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177924; cv=pass; b=ZA/suMoN1gPdcCYubipyrg9OgEziFVfBRccmRdSeX4NZ3uSp90AXtpJsXV/Mpo0Y+hX/sE/AVPQBBBWByQ06ji2lDxNuElK0aKjWYhUFS+Gl6Xzcwaj89jJyLrjsbLiXCdl4cTnnPnFPSRnkA9h9gYaQRoTmtNMgSUg7gTHEB7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177924; c=relaxed/simple;
	bh=7vDOf7xZu8sb5mcUwjB49djvSyUxUNxmjuy7MJD5oiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kmzu8xAUZNaEOVDy2J6zFurvwtEsVwZtN/hrUVQI98V+MSkM1Nig23GWtVEkklIYlP5/V5SiDzq9BFlbkwJ0ncsK8LezO+AusW9o90+z2Ym9it1OJOwHUAhxaPlE5vy5V8Hn5oZ/NkPh51scZFh/kz1fJ4sAeXSkpgmuXLqx4mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nx4ud9qM; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nx4ud9qM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10ed63c0so51101cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 15:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787177922; cv=none;
        d=google.com; s=arc-20260327;
        b=OYpexZ5h8MMgzwTJ3xMS891WAbc1A536HmX+6CoewhYA2+cWE2Q9tirK7Ce/CMJO+q
         FewcfiY2qGkqpFOg+MWyqElobaBD8G9Ps6YTltEiuFhScqJTr8MGABKDkudgyjHGGYoS
         zNPSibOtFluJJ6jHOTKrnObH3BKDtILs6LP0wftLNzqVBglgVO4cahduu+KiZnVjHqiE
         hhlN71/FPQPSUotl8sKnNTuDKw+IhAhWSeb27qnhFg1ZiolUJIm2poghPZEzreA40CJK
         Y+k85m4VsR13jF/zP3o1seliTnaSMO7E2RNSm0oT/G7jW+QPhAItqXO/Igt6MWgstZC5
         JzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7vDOf7xZu8sb5mcUwjB49djvSyUxUNxmjuy7MJD5oiY=;
        fh=stLtHN+9HrnX066H2LNGCXblvkQnQD/mwi0B9xWKhPc=;
        b=icPnD5P7GoCOxo5PQEw+3CFIx9neYqh02vJsx5hfpDZ580mIq5nurTbeXzinRIYEs4
         mGxPZ/45O0Rm9gIa1bNQBIyE378vL5EMaej1T9Ws9pT8Rmnfab++rZ9T9esbg6wX1qDA
         W78eeyBLXL5xTFajdhpxM/bDALDfFBOjtR+ZAFWxMfY3V5floqZIqgT5iPKhd+nxAgz1
         3fUBAovJi8HXV2rji1rx4RYVd1lhc+fMYk2XOfFuxHldMucdDbZl/RsuTx4kWgZJQ+pZ
         7MHhST7TZ1mF2tg4XBTwMtBFLe8k4Xdv/MfDEhdsN38rKiouRYtO584ryuLDbDyhC6+f
         Bf5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787177922; x=1787782722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7vDOf7xZu8sb5mcUwjB49djvSyUxUNxmjuy7MJD5oiY=;
        b=Nx4ud9qM7kUVhCNLBo4SQAgIiVRgkmat0pbUeYCJtSXQBtZKPfdpauhRTEMmlPXkB3
         EcEGvn2N1NoVritIuOW0+8acAIKkUrpvjSgBnQo9gVU8FNdZSnEMNSnTQbBnI0AeOZ1n
         0zBlHX9y37qsHkDETZO3avsmnKpTsBmB7g8qmuXxnJW7E9iypmkl0KKwgK8zUrhScJBd
         udZ1SxlxicNV2DdcFDKYFUpX7s49bKIZNFNCyMETgITOXyftPkG8Zewo9f0PrbIKAD+m
         CYvg+o1SsEISwNQGrCseVkmdqKZu3nSq27+tn4SMwk6d2sRM0RlXXiUL+gFDEdBl4XdI
         NlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787177922; x=1787782722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vDOf7xZu8sb5mcUwjB49djvSyUxUNxmjuy7MJD5oiY=;
        b=pr9jVMGr5h61/SdhqBDAWjDgqHhu04E+HRoYo9ATA6yBIPlrBPI9Hjx/ovzElY/YDG
         dvV+BJOxNRD2b+fF2OfvJ35rxCPP2qvtNZKcRV8WTcEh1V+htRxk/mwXS0oAssXoryxb
         jB056abyin7qsAMgt2ON1Hde5kKb3XenYvVH+dj81B3iCDyq8Tm3vv9AqkwbzDy6VW9o
         eD1cfmI1su/2at5oigvSuR2csldWgtzhINgdj2NjaPhHCl+jYDo7nk1ko2WBHAbvhtLQ
         PFekpjQWJ85eXfELIY7qs77PEXKEiBwXm4um6zt58gCKeMazL3cuol/LPHEsreuMRD/J
         ASNw==
X-Forwarded-Encrypted: i=1; AHgh+RoIESCPZoWnYmPLfYo0TYxdHpE5U972LwRt0T3nwsHMsgl0wKPK4q3XLn1SUSiHwDFcE0HJCiJjhnEOTLBRnP4d@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkLCcAhQR/ZQ0aR6OYfHcK6DWJs3ZLiE5tJGanZgTnqNDQuwU
	80cSf2doBhAQ8PP/mHOtLl1FfH9aX8T9WgwR17O2tVXSv7iIJTKBaEh3weP2bBc9ah9QmOBUR/a
	tLteNMGk3HOfsxURCXPC0CzYD56JZHbuiWQje6HqU
X-Gm-Gg: AR+sD11DVGJwQtLBnw5KXSGyMb1YZCz9m/qbSnjomi1+eeUCv7lM5jQhQQSFQ51Ytdk
	IpIKE1irzIirKhYv00Lk11wVO9URjcrD0cAcnJSVzu510SKYSaj3iSELWtuERnF/tr/gr5F/H+v
	EJuFxdcSStfix0tA5+17tE5m10IDDZZBAm3BRIKXeuSC6K4quFvJW4w6+X1DzZ3BdWHStva2v4m
	JxQn2yMWYOZfiIFCPQPdpZrqDDt8siwOAvEPzBDDvO0iaRYf/AQZ8h1+lERd4CO/pn01lPWG1DS
	EsCJYSHe5Ilrg4hvHMcituNTcLj0JnNaBTBDfWj0XtIaQ3thkWgpLyD6bgvVolibvUGFKo56TSY
	=
X-Received: by 2002:ac8:5cd6:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52de42ee25bmr5878701cf.10.1787177920934; Wed, 19 Aug 2026
 15:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo> <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
 <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org> <CAP-5=fXLe9tqR7wHh9auRxqX82Fw6zYh1EoTOXjPhOXcRXB92A@mail.gmail.com>
 <aoXVrD-Qbhi5qd2D@tassilo> <CAP-5=fW6a4MQurwVeL16WWFnO0VQPRm992M==DP9zVza3wgdfw@mail.gmail.com>
 <aoX1F_V1pS9VCMjF@firstfloor.org>
In-Reply-To: <aoX1F_V1pS9VCMjF@firstfloor.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Aug 2026 15:18:29 -0700
X-Gm-Features: AcwNN1Xa5xa82vGd4vzjyrNPh3jLTPJHDZN1GD1Cwk9ddVn1IHO-xXL5s_jWM7s
Message-ID: <CAP-5=fX547ve-LuFXca2QxtRiR7_P8EgnxzPm_pH8N+2xBjZzA@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
To: Andi Kleen <andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:25=E2=80=AFAM Andi Kleen <andi@firstfloor.org> w=
rote:
>
> > So I think we can add a json field to indicate mergeability and set it
> > on legacy instructions, perhaps things like branches and
> > branch-misses
>
> But the current simple check already works fine for them?
>
> >. We can also detect a hybrid system and switch from
> > cycles to instructions as the default event when merging is desired
> > (like in perf top).
>
> instructions rarely gives you an accurate breakdown because
> the IPC varies so much in practice. cycles is a much
> better default.

So maybe sample on cycles for the leader and get instruction counts.
Then we could multiply the period by the rolling average CPI for the
PMU type?

Thanks,
Ian

> The other things are reasonable I guess, but all not really
> needed initially.
>
> -Andi
