Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9052AE77;
	Thu, 22 Aug 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351397; cv=none; b=SY0sdqrZZObhppL80NhXtY9lGKVBUu4WVXbn2ItfjZVzi7uHJI33/qea+MenTf6RKzM1PGdqOP/h2Ou8/0hhDkryFha9qKQ/1OMDJexzRwjCGIoyE1K0mMl3xZQsVn4Fjs03WQqlAR8xbyxO4qbf0en+uaZt9CHgMmCyYF/nBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351397; c=relaxed/simple;
	bh=4VQZ1nKAqmZY3C0LHWDH6tVHf0R2awT3hntj19h+MXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quHoGungpk2fFfZWMeJva34RkhVoHN6Jd7GXnVnYsivqypLY6IzJOvV6hGOk9839aYTOO8g7WFynHfTpTZZqN6i4tHCtsMgEhnQkOXV85u/zwYZ6xzREpkjdlVBCmNzswQxMRUYtGWNNfN58jzOQ0UzkZAYs8IPQTUz3zveO7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKcge+rG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKcge+rG"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso8689911fa.1;
        Thu, 22 Aug 2024 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351394; x=1724956194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eq0Zc6Vxfr46aaR2skl2I5AqjzF0NL14ez30VtrVd0=;
        b=YKcge+rG87/SadC5/0l/r5rh4cHIEJVnlJ7ltRvAKyl6n7g3wBOktrRYA/x25E49qz
         rs6/RrETf7YCXnK3N14xOID/vXKb2BuE0rsdEnp/otQQwIpi9STbm4rtd0F6TBWUTpB7
         NlIVP7w8J7EvqHsLZo4i1+peWMKSpxMFWXjPuRIUplatmPGqUQ9KRsgCRtTOsUbzM+co
         lDgbrUwrQGDkEvoU26V7uWgnMmB7Jl1f0n13sLDR8i+oV2Wam+fGkSApPjG52OgX9r04
         JCzBrT0U0xyHkK+7h9/xMbHcQ3y8504zWX4kwqXDHUd+Mdr+b7XiVAyY7buNkgj2Gal+
         lZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351394; x=1724956194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eq0Zc6Vxfr46aaR2skl2I5AqjzF0NL14ez30VtrVd0=;
        b=mav1+utRifPuwj0/rKHABt2XRbuQ5qCXtBDpe0Fd7tQgPJ3RoqgUyAtV3xSOCN8tYd
         w+3BxkZ8Z1Qq9vQa69kIQnhb8A5+Ul81srVdhY2hZn/bgRaMXO2Aal8IUZ4Gb6s1Hh6i
         oOmDuEYPoaduM4JFRPfjeEuDCPz0OHjvnCjhTPC8Sbg3/+9WqFGbQTCzqsUbuwTg+owJ
         B2ykvZbeRV2dE+KClkc/+nwqFqp1SurSEXAxqGKqCrcHAov3yyc+/1TO9Athmh/PN/NT
         j1+oASOcr6Qi9A/0ItG52jzboJFuTmINWtWE3CDfp2sUK3MBgVPKyg8S+W5gMzKMHT1W
         YpNA==
X-Forwarded-Encrypted: i=1; AJvYcCUocLOpVkk4P1Xv8oK4lKg/mky/1GcUyLosi3CGvZE8fwOp6nZYyHchRe5uYqn5AxjoPzDxkTzvtZSKezg=@vger.kernel.org, AJvYcCWwwonOi4dNG525iED4pcA3BUJ3b+8abGBW+mXAP0RoHaKV3jaJULvYLgBIpkBZJYoAMNvGJesTgviiPZQCv7dT9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WfLiS4ZA5/XTgChlZN+kkfNgiXiUKXlQfNAYk84O1yhLrTjq
	Bfg0dL1nWKg68Lm29zGvc3WtP6W5xlCie2OFdWvjNruh9UO2eA6Wim5MBqmeOwJd288zXaUta9B
	aOhAczxfuI1GHTVK9bzWgdcGhyhEbvpQSrlo=
X-Google-Smtp-Source: AGHT+IGkBeDjy0yQ9wegTiaoJJqWpW89C0016X6i0GMs1w+V/QuMO/F33Sjtzf7J8+eTEt0NcYsr2rRhSBJbyZMd2EQ=
X-Received: by 2002:a05:651c:198a:b0:2f2:b1ed:4496 with SMTP id
 38308e7fff4ca-2f3f8b570famr46210591fa.42.1724351394252; Thu, 22 Aug 2024
 11:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1> <ZsdUxxBrpbuYxtXN@x1> <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1> <ZsdzLmIFWRqsXeXD@x1> <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1> <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
 <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com> <ZseBZ1DIi4Y5zC2W@x1>
In-Reply-To: <ZseBZ1DIi4Y5zC2W@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 22 Aug 2024 20:29:17 +0200
Message-ID: <CA+icZUWt88VFaRON5j6+MQNgndiopmdpiWu+sopHW6usrpBhiA@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:20=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > > On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-m=
ismatch if
> > > >  present on clang
> > > >
> > > > The -Wcast-function-type-mismatch option was introduced in clang 19=
 and
> > > > its enabled by default, since we use -Werror, and python bindings d=
o
> > > > casts that are valid but trips this warning, disable it if present.
> > > >
> > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9=
uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Can we also add 'Fixes' tag to make this picked by stable kernels?
>
> Fixes what? This isn't a regression, clang 19 isn't available for Fedora
> 40, the most recent.
>
> - Arnaldo

From [1]:

LLVM Release Schedule - 19.1.x:

Jul 23rd: release/19.x branch created
Jul 26th: 19.1.0-rc1
Aug  6th: 19.1.0-rc2
Aug 20th: 19.1.0-rc3
Sep  3rd: 19.1.0 <--- XXX
Sep 17th: 19.1.1
Oct  1st: 19.1.2
Oct 15th: 19.1.3
Oct 29th: 19.1.4
Nov 12th: 19.1.5
Nov 26th: 19.1.6 (if necessary)

-Sedat-

[1] https://github.com/ClangBuiltLinux/linux/issues/2040
