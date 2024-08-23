Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F1188A1D;
	Fri, 23 Aug 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425414; cv=none; b=MKB5cnF7cc1vEC1hLhONclD7Ip1OQwfTFPw7JCwBFuHtWhuR8kiHrcy/vWgFwPO8ItN3kWGPIlVcKGgh0qyIX9XiDlKPl2sTd6iTQRCuJI4fraCMwggpPusDKdVD01cMf1wrIWsmHrgFAk/ogVm4bKHNAfmrm+ZZa2hzJe7VigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425414; c=relaxed/simple;
	bh=gykgH+6JWBbff+zeRNo9D74pHYYr6Yy/NsNQ+aGR0Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0jJhUQNWJzJ4lvZ0gocjur3KUUZInakvmRDigZUtHVo73FPnTPajzIjGZkziCTPVU8hKa1/eQgSjM1VXMlMjSixCKHpkjpTvGzwIv9TMT6ugoF49DLST+zyt0KVfU+zXTl9LGlghx04Jlb4c1wr0b/1957I56wS0Qu7ZTiGm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso2245616b3a.0;
        Fri, 23 Aug 2024 08:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425412; x=1725030212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fdc7YPwMv5DLi3k6hItQO4DUfLZWrss/h9+026P/6Fc=;
        b=WqW4+Y6QFxhTShrZgHLHR6qViwYytesstjnBNT67FubTTCoBtCBrkVre2Ka1BwnCc5
         ORmI5Z/E5sGjDRHxj65zGNNlISQTd1EQAeDagsK79/IZ6qQyt3v3u3KG4cFtlKuayuLt
         drksWHcPmwvrfHSh58BLgD+JEf1rt++FhM9l+0248uU1+CfKFez0lPBIwClf+oDtTSHB
         uEK9vANH/LF3bLqRf6MpvkATiePojmHICPQV1rRH3uhKoHWL3LUoKqtHbtHUMphUNwdS
         OQkD3g+s19+AB/OIsKDAk/woPAHJaTVsHGwqLAi7bT006B5VYz/HlHwFBJngPKC7Bt+t
         f7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVk7iYIu41nAEur8UncnZ9VGlD5nhgYxfJfO+21rfUP33qQPPZeqL/Fs1Ywk7P/+TKhkp2bWK/ArXNSHc=@vger.kernel.org, AJvYcCVX1EIW1NDNZtmYIb3KoxKHx4QsZEKa4qRxbbo4qiIVQhk7J9ytI9yvzltSLbQkVk6c151XMqjGNOkvTaKXSnyPiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqg0VJlTf+p0utApTftCS+z1snbcMMJ5Kjp/T28cvFAnh2mn4J
	BAAsZB5ksDBTM9KC6QEvztYKXyH1qoqowuj5Tg85Cgy05lTx0NwHfUl3tGOr7KgFQ9xokoj7VND
	1EvBFmzIgjBmgUpDRDmlL7VIbT+c=
X-Google-Smtp-Source: AGHT+IFEoz0JT4PpFagbOargPSg0CQqxTNRJB+tiFmyoiR3T2et4lYVe7mTN31g0rSZ5sgvGwkz9NQMgplj4D0PqJDk=
X-Received: by 2002:a17:90b:3907:b0:2c9:a831:3b7d with SMTP id
 98e67ed59e1d1-2d60a9fd3f2mr10630608a91.18.1724425411713; Fri, 23 Aug 2024
 08:03:31 -0700 (PDT)
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
 <ZsefAWKrE7jdlxhl@x1> <CAM9d7chAryBEq7NH_oKdBEg=VD-j82BC_1YTY7t1UH0xrs5L2A@mail.gmail.com>
 <CA+icZUUazXQVzf1AcuFSvT2FAL2Ag=xTFYxM35tvw8h-ix+rXA@mail.gmail.com>
In-Reply-To: <CA+icZUUazXQVzf1AcuFSvT2FAL2Ag=xTFYxM35tvw8h-ix+rXA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 23 Aug 2024 08:03:20 -0700
Message-ID: <CAM9d7cgbP3WV05hMkaoNrD843NYw6pTyP05JRmRuoMTX9hoHBg@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: sedat.dilek@gmail.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 23, 2024 at 6:58=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> On Thu, Aug 22, 2024 at 10:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Thu, Aug 22, 2024 at 1:26=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Aug 22, 2024 at 01:11:22PM -0700, Namhyung Kim wrote:
> > > > On Thu, Aug 22, 2024 at 11:20=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > > > > > > On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de M=
elo
> > > > > > > <acme@kernel.org> wrote:
> > > > > > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00=
:00:00 2001
> > > > > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > > > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-functio=
n-type-mismatch if
> > > > > > > >  present on clang
> > > > > > > >
> > > > > > > > The -Wcast-function-type-mismatch option was introduced in =
clang 19 and
> > > > > > > > its enabled by default, since we use -Werror, and python bi=
ndings do
> > > > > > > > casts that are valid but trips this warning, disable it if =
present.
> > > > > > > >
> > > > > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > > Cc: Ian Rogers <irogers@google.com>
> > > > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-Ws=
wsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > >
> > > > > > Can we also add 'Fixes' tag to make this picked by stable kerne=
ls?
> > > > >
> > > > > Fixes what? This isn't a regression, clang 19 isn't available for=
 Fedora
> > > > > 40, the most recent.
> > > >
> > > > No, I'm not saying it's a bug.  But we may want to build the old
> > > > source code using new clang.
> > >
> > > Sure, and with the tags we have now, we can signal it by using Closes=
:
> > > and Cc: stable@kernel.org, without a version, I added those, the tags
> > > section then is this:
> > >
> > >     Closes: https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz=
2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com
> > >     Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >     Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >     Cc: Ian Rogers <irogers@google.com>
> > >     Cc: Ingo Molnar <mingo@redhat.com>
> > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > >     Cc: Nathan Chancellor <nathan@kernel.org>
> > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > >     Cc: stable@vger.kernel.org # To allow building with the upcoming =
clang 19
> > >     Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8=
U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > Ok?
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
>
> Hey Namhyung,
>
> are you aware of ...?

Oh.. I tentatively added your original patch to tmp.perf-tools branch.
I'll drop that and go with Arnaldo's fix in perf-tools-next.

Thanks,
Namhyung

>
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com
> Subject: [perf-tools:tmp.perf-tools 1/1] error: command 'clang' failed
> with exit code 1
> Date: Fri, 23 Aug 2024 18:43:32 +0800 [thread overview]
> Message-ID: <202408231822.dWGP67uY-lkp@intel.com> (raw)
>
> https://lore.kernel.org/all/202408231822.dWGP67uY-lkp@intel.com/
>
> That points to commit:
>
> perf tools: Fix a build error with clang 19
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/commi=
t/?h=3Dtmp.perf-tools&id=3Dcf36d63d7cc9a9770f69f44a10904e9fb0895fa9
>
> That is fine with lLVM/Clang-19, but breaks previous versions like
> LLVM-18 as explained in [1].
>
> The REAL fixes are:
>
> perf python: Allow checking for the existence of warning options in clang
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=
=3Dtmp.perf-tools-next&id=3Db81162302001f41157f6e93654aaccc30e817e2a
>
> perf python: Disable -Wno-cast-function-type-mismatch if present on clang
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=
=3Dtmp.perf-tools-next&id=3D155212c965b5b23a90b8558449dbfd1c60dad934
>
> Unsure if the commit-ids will change.
>
> Do you happen to know how to feed the LKP-tests bot?
>
> Best regards,
> -Sedat-
>
> [1] https://lore.kernel.org/all/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKX=
wTA5THtL7w@mail.gmail.com/
