Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7AB1D172C;
	Thu, 22 Aug 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358662; cv=none; b=MWdD7o7sVG+J0AwKnsvlCgw0hlLHwwMP2jU8zopF4ZgWQ2ZFdbHPcmUXVergTGPRTC1k9KIv+OJmzdiu/EORQ7tHuxExYPV4PQBgdYnt8yp4rImor7jt93bmNu69HDdOu4WgmKxEERV7XgSWU33LbjPoVDYmmeRHqlfS6N+Rw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358662; c=relaxed/simple;
	bh=bQyoBVQ6FRzC3Co6c3/Ouk1T10YDtCedEW5E567GQhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzM+Cyz0ukSvvKePamK0KLn1Roskuu4yM2soP3UJ1eGjhOIoZ5dpBtscR2JzZy3ZcG7sS5Xi7x/xYlJ2vNrexP/niBrbi4JugoYnpXDbp/7W4ZWXLW0k5WDHcgB9mhekh14U7PpAA+LIAhoQl3N1U7fVOt4ikMJze/NeQty4aU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3c9a67eaeso964876a91.2;
        Thu, 22 Aug 2024 13:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358660; x=1724963460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqf7DXGdlYYXLU+hYuns8SO/NU7Ge2hE2YQJcv3SBko=;
        b=bPMbGMg9Oh8KocZW7dr0LsoYAx6GZivF5WCPIw0WROMAFpnFz9HZAEnIL/XW/g03GJ
         /m+q3nelTFoTAmWcuS2U5ILlHsiUVpK8Q6StA1Jo1oxYcJabolzQsKbN18sx8fLrfILr
         uH+9Ymjf7r8pm5FbayL5Q+/qafD3+0zgbet5GDnnEKwzWJek6S0RAk8dn2tiO+I+d52L
         a89kLezrA+6aQ3I0E5+pngOT8Bm9/1xKx1YqvEMX6/iE8sUYa1AFphgqiEaPqgRuJWPh
         wtyCwyYY8vHZrgzolXR/ttlbUH4GtjbmYSrmFSF7EHbvpmSVk27rdLwGUP4QQG2L1MBS
         dQmA==
X-Forwarded-Encrypted: i=1; AJvYcCUT3Zbgw+WV6Ka0+jRt6NAO0nKnQAsfgIZgofSEJ/AXT3ornfGrQGqPwvalIHC15WkSqL70+CPTR3mkXYQ=@vger.kernel.org, AJvYcCVmE2QwKQGexoEVwKXQAbZtvmytRCg3RqtzGhMf+XFKtg9XQUJOrwy3TPWpUAY3CEvSsLVx0P+0wL5QgeagM6ZQYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+tFTDT58FltrmTiyT0JBcn11fHnsdk6vRyvkgL2JJL+kfybt
	jCbhrIWedstkCR5w7jwY4NLynIyuYjpfsfFzXiORPVJ7CiOXRlsPKal55lXv9PT4hBr3oHvMboQ
	soYQu3xcaXY0VqUoxIvlB33aSQvk=
X-Google-Smtp-Source: AGHT+IFRI2kZ5+ZLzNJx+xuB9LStTLUS3gop2lUbhT0oFOE1uks6Y/0FI212w9zyh+ns9yKp2bmOjT1ysVvBFZM4KL8=
X-Received: by 2002:a17:90b:10d:b0:2d3:b976:e304 with SMTP id
 98e67ed59e1d1-2d617293febmr3224525a91.41.1724358660215; Thu, 22 Aug 2024
 13:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZsdUxxBrpbuYxtXN@x1> <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1> <ZsdzLmIFWRqsXeXD@x1> <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1> <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
 <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com>
 <ZseBZ1DIi4Y5zC2W@x1> <CAM9d7cib0JFJPM4KdFDPkw_2K0Nu79QGHBsVZ7XyR-Yz1ZBHdg@mail.gmail.com>
 <ZsefAWKrE7jdlxhl@x1>
In-Reply-To: <ZsefAWKrE7jdlxhl@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Aug 2024 13:30:48 -0700
Message-ID: <CAM9d7chAryBEq7NH_oKdBEg=VD-j82BC_1YTY7t1UH0xrs5L2A@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sedat.dilek@gmail.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:26=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 01:11:22PM -0700, Namhyung Kim wrote:
> > On Thu, Aug 22, 2024 at 11:20=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > > > > On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:=
00 2001
> > > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-ty=
pe-mismatch if
> > > > > >  present on clang
> > > > > >
> > > > > > The -Wcast-function-type-mismatch option was introduced in clan=
g 19 and
> > > > > > its enabled by default, since we use -Werror, and python bindin=
gs do
> > > > > > casts that are valid but trips this warning, disable it if pres=
ent.
> > > > > >
> > > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > Cc: Ian Rogers <irogers@google.com>
> > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0=
K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > >
> > > > Can we also add 'Fixes' tag to make this picked by stable kernels?
> > >
> > > Fixes what? This isn't a regression, clang 19 isn't available for Fed=
ora
> > > 40, the most recent.
> >
> > No, I'm not saying it's a bug.  But we may want to build the old
> > source code using new clang.
>
> Sure, and with the tags we have now, we can signal it by using Closes:
> and Cc: stable@kernel.org, without a version, I added those, the tags
> section then is this:
>
>     Closes: https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haF=
neX0C5pUMUUhG-UVKQ@mail.gmail.com
>     Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>     Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Nathan Chancellor <nathan@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: stable@vger.kernel.org # To allow building with the upcoming clan=
g 19
>     Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy=
3r2MzKXwTA5THtL7w@mail.gmail.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Ok?

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
