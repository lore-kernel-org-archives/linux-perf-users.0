Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4C3403EA
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791844823; cv=pass; b=a5oe/wbnAd5CLqhER64ud0j51iWYDX8m08pcfwGS8lSEQJ6Ye+Pf/daM3Jq8aNaMa5jAPw5JlYt104l4woQ/QxzrJuDi9xSsF3F+uukHqFxo+QGE7w0v9ZDmyKoullb8boqTpTDAcRPUf2RO6GyGuqx3sL5J/dxAloukde1btI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791844823; c=relaxed/simple;
	bh=CFhoFjD7GvPxBDPjUjStqpBpMojlj/Tky/SlADcDkcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSckkSSV3gbTiaMld8U5go1bxWWbrnUvUFesKn3Mn2tbRRVWqyqtfsUkjXFHomq+TNsk7DTHWm2/pXEn2UIJzsuaf6pGm37kaRmNsi66EaE/RxnLaoLF9JrNlzmf2SzZFAp44c2dU26m+UnsdQP61HJQbgM02rXa4sdh9I/bwqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B50bR23g; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B50bR23g"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337c7b9937so553421cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 15:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791844820; cv=none;
        d=google.com; s=arc-20260327;
        b=k4M7sMO1387L1zSB31om74oADL2BspjxndNtNQmvSgxXoIlUYbTh6IWPL4jD7b2ZHW
         3ZS93UEW9GnMDx4LnvbC7TB7xvSy7bctSq9Xmjc1MWbDxY2sHrYi2cBwo/LI7w/rXkJe
         rQeX3QnrxsiGIUAcN0VjD2UmB9HAer2jqcUT/J41xQVXnUWG1GKCTIR9DsOlUEQu5m1J
         MWPnM2tzBpWCVSekpBKh2VM9CIi2BmM/S3b5RFugQtI2DyJCESykrNeRtOYKNoF7uyvz
         qjDt40S2vKJTgIizl/97vH9GOm0c+C/QDn0k9M0YEkwt0a8ie2Xg/euCSTWgmMWwIA26
         lO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bNGYidXZtaytiL7v98iVEO9jLb4pnmAyRJWu+GLbhwc=;
        fh=69e+w7jSy3hq8JCe21uL+fY5eitoZRnXyidRGQZMH70=;
        b=rjCBwWci17ts8OPNbc7zqlavGBbJNTXqk6N5k48ch1srvy/0MzJeVKmE22F5in8yLD
         pjpcDLq/bP9cWkvP5Oucvz92tM0KDL7s4OPojFLgK0O1Ghfj4YG+FBLM7dJk2H4/Gc7f
         rq+ozeg9cVnlarZyZAr87ppoZi76dHbj5DbX1esqeXb6yoi1A9pu48lJF59vR8jufynQ
         TuawLsl2GlLmsJlNvQUKSJWBBF+rnpgfFEpsGyjIPZUGDdFbmTefbJXXEtGajmKMgyi9
         0wWewKXbahlYdNFhmoX7NvVu6EssER87GTxjuAafYeQOGYEwIhrfST5+PaHRlGm+RGTw
         xSqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791844820; x=1792449620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bNGYidXZtaytiL7v98iVEO9jLb4pnmAyRJWu+GLbhwc=;
        b=B50bR23gJkaUih23V1httXSI+5wMU7zt8eUxQczEsaCSv6V8AIlHUVzvrGDHEIYEKG
         fUi4B1ycR5ATrXroCrUsY+vffsYVU+WkAW0z2mNV54NlFJMm/6L11tOm5zpDhjUVnztg
         QD9EdiZRiFi9dCZ6UZbETU8Wv88xij7qCC6wY04Jjqx43CM0S5YZOGCk5GVfIThDU85p
         5c6suovmb9XtDFDCh4hv5ZM2nrVfh0HWOws5elH9hTQHjcmZ2EFPaIqdn7qXSDAD38DL
         E0v3e1PXxeD0aVSDG/n+NQGRGsNCTb0cc0mZo0HUpd8LiBtkhk4j8Cxujs1cmcF8mptb
         V9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791844820; x=1792449620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bNGYidXZtaytiL7v98iVEO9jLb4pnmAyRJWu+GLbhwc=;
        b=Mzf10C8ZBMw+7jGEW1HVU/agM4h5Ae6Xvyt6+Fy2vQOnsqw/OIM6zcIU4LBUdXjdis
         1UQU7CP5HgXvTkymenpuCeeuo65R33hQ57eXyDDAV5znc/fM1GeTs2T6FVGl10wiXW0B
         qS+zcQlZd840Qo942H8TROp0ZSMeZ8WYYYIUY0Iz060YgCDXGCkiq4m5T0t3qMb6NUzJ
         bKarLU0Oz673/lcgrBvj319iTvbYNSQbtunvezg5MxvA1emmnzFxOi+iz8GwRNhHRcB0
         Y86WjybvLmVmuOUpreKQP4Djp5xxrJvJ5B55uZMseSkO30spby0TtcjTwId6Lc3P4JrL
         13iA==
X-Forwarded-Encrypted: i=1; AKwUvBzp95FUJoFOplQ3OeLZ0EOIkWZuZwGGtQBSSkFOTIq91xNO6Jn0/8g5id5EoOV+LZ/WoBMQdi4kLtUW5X+m+30O@vger.kernel.org
X-Gm-Message-State: AFq9FYIUUfGFybNr+ihqh8Z4IGE8zKVOE+Fw0IE3/OEApWda4di71S1T
	4O4G1La7bFhgt+lhIbWGUwfYP9Fnt6C/jYaX43rjCbZEg42yENiPn4I3lxuTbM6BTapGT1XOVzx
	pRVxYAj8247hkU3dTzl8z+H+CTAkwEnQrJ0P7mpRZOPfz6Pe1AdXLugl1
X-Gm-Gg: AYBFou35eVE0gmqfqErxqfAyFM1VhtqxyZ2BrvmqZqbBe0zCkbs33nuBemLLaZ1ieQ4
	Oq3fo+PhT1pxSEMWszBS2F4rxVFktcwnEnIx8tvWoja/YMbKJ78HYlbk7jpXFtL+2ji7DlDNtMp
	Eq7YY5EZ6ClEmCNJvnnIN2gMyHsoDDwAOuuW4TDJ40tBLnNRxj4ns1bI8dn1k+zv+mrafY5uxkq
	1Limqa78AsIqzNlShK4YPrmPJcc8K3r26dNnNyGAIeNjiDfL98uIpb8rDwmyAWdoVttT2jQDhTq
	fE+urOU3M9SXtkmioCG5b6WzuKgbDIGa9k2ph/wi27HXupJLKGdeeq3EMBjL8p0ynO7OEZDbaqx
	j5e31UFi1Aw==
X-Received: by 2002:ac8:5a0f:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-535b2d9b1e9mr37970391cf.1.1791844819458; Mon, 12 Oct 2026
 15:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006161309.3078488-1-acme@kernel.org> <asWLmvF-3YtoKJ7j@google.com>
 <asYDREqTrh9ZDUhm@localhost>
In-Reply-To: <asYDREqTrh9ZDUhm@localhost>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 15:40:07 -0700
X-Gm-Features: AclHuK-H8y7Po0uJuwabFCXT24Vopb_793VT6i4gOliUNjQZCmpiBVVeoFB13og
Message-ID: <CAP-5=fURC_-ez2eNXjcT378ttO7iKMHhjrexxekqDEDU-suRpQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 v1] perf test attr: Fix the re-enabled test
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:31=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Tue, Oct 06, 2026 at 05:00:26PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 06, 2026 at 06:13:03PM +0200, Arnaldo Carvalho de Melo wrot=
e:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>  > The test passes with 'perf test -vv attribute' on x86_64.  The AMD
> > > encodings come from the amd_pmu_event_map tables in
> > > arch/x86/events/amd/core.c.
> >
> > On my machine, the current tmp.perf-tools-next which contains these
> > changes fails like this.
> >
> >   $ tools/perf/perf test -v 82
> >   ---- start ----
> >   test child forked, pid 931585
> >   /home/namhyung/project/linux/tools/perf/tests/shell/attr.sh: line 20:=
 python: command not found
> >   ---- end(-1) ----
> >    82: Perf attribute expectations test                                =
                 : FAILED!
> >
> >   =3D=3D=3D Test Summary =3D=3D=3D
> >   Passed main tests : 0
> >   Passed subtests   : 0
> >   Skipped tests     : 0
> >   Failed tests      : 1
> >   List of failed tests:
> >      82: Perf attribute expectations test
> >
> > The below patch fixes the problem.
>
> still without your patch:
>
> root@number:~# perf test attribute
>  82: Perf attribute expectations t: Ok
>
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 1
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 0
>  root@number:~# grep "model name" -m1 /proc/cpuinfo
>  model name      : AMD Ryzen 9 9950X3D 16-Core Processor
>  root@number:~# uname -a
>  Linux number 7.2.7-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 21
>  18:25:57 UTC 2026 x86_64 GNU/Linux
>  root@number:~#
>
>  I reproduced the build failure in an ARM64 Debian Trixie machine,
>  applying your patch to try again.

For the change to use PYTHON:
Reviewed-by: Ian Rogers <irogers@google.com>
I think we can fix the attribute test expectations separately.

Thanks,
Ian

>  - Arnaldo
