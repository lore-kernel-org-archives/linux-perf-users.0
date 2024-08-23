Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214918858F;
	Fri, 23 Aug 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421535; cv=none; b=Jk22iGIzIfXDF2rzNOBW90k0TxV8RLR61F0Q3hrevva+XubFrur/OtZOnuZg/3ABV3j7iTshge2mwQey8Toa7zq+Uxf0aSG8JfLNF2ksQQpc2v68cnUAllwP2aweynPMxTO99TcWESX+zxtdPfjP9vcdcOIvRe4Sqs/o45bkP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421535; c=relaxed/simple;
	bh=jok/ayaXz3RH912HnR9CfD6YgMfbD0UuWfpT4gJvTX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMy72ZHBa8ropOFShkTqM8NheNJhbTxEHtPRweJH4IQosbQ3mOb7XgHbhZIFHnGtUzkQgSNDmHROKE7AVX7HuhPrum8XDS6rvNFtGYRFA5BST2OlG0jtyzU/+teCH+TBdFn0aoOdaal0AejeRFeA6UOb+MgYxmlm1NlJjZjg4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWZBQCm8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWZBQCm8"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53438aa64a4so808857e87.3;
        Fri, 23 Aug 2024 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724421531; x=1725026331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1+PqPCb4SHP134+mkwnKvWNpUDBEVwhdl/u4hb7mt8=;
        b=UWZBQCm8RiMrWZ9aCJYyd6Vnm8WDSpZnzGOOW1+KAT2huJ5Wk6I2gu8hP8lDyNsCo7
         xTN5iTXhAxoSoVt+Z4wIJbsiwQ0D3xKzkWX2UJZcxdKtw8HRUfJqIp+WN2MyAFxxZjfD
         6LAj3vDXTwPR2AwygOeImsupwegPTENrxHlypkV/RxhjymGHLmyNaDYvnj0nmXb/j6gp
         SOQkSEMWORlMD2iZdnZGpywdqfeijSgW0Rt6wCd0OQEqEPne90UiOqgGBxj6exHcW7uO
         vWd/JLxwFN6w0fzdcZfkPhw2bbrX0Kb0/bLsOLrsl1td/sRHasd/hVSlrFqAR1369gzc
         4PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724421531; x=1725026331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1+PqPCb4SHP134+mkwnKvWNpUDBEVwhdl/u4hb7mt8=;
        b=HoE7UuH7XbxAYQvwDrJrueOF/5Q04qQn2TIRa0mA3EDMb1H6JEhdqYn0fq/2PNhHfw
         rDy3RNN4+97CvfsswW0OStaQzzRpjh1hOioPasK1CWo/QLLJwwaS+a3TxSAdMC6PwAsi
         wUiSjb05Z0LRXiACEXSkhy6/ZyZCmIK0RXLN+UJS6ag0xH0Yhlp2OvytwvK9CoOmFkuT
         yWisWEBw11RT7xJ64ygeOaG2IT6kI5v6CugaWO1XF9qemTBOSaytKGpFZIb9QWM8boQ3
         WBjjD4nQUdP/Gt6+UsZvSzpApCWNam9T2aUQ+UEP8uv4zRp3FZKujaaRe80vB2lWwbWt
         yjiA==
X-Forwarded-Encrypted: i=1; AJvYcCUoO8TR3rVPIgZBq4G7TmqQksFA7iNAi88cMVFqUluJe+AmrksydvxxhcWxDpDYyAz7uDTiwaOVZrXPr3o=@vger.kernel.org, AJvYcCWj6Rt5H4i0QsJwkMj+Ze0JNHrJkjoqydstS5aA+jS7MiJLHWTj7ugDrPJEvms/DO2L08vz5/XS+3NNOL7S3KFHvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPqs1EyxuJgQ55SpJUcR5s+B/fYuak8OAfU6jFxJoZgMMw3g6
	NHZhpi3Kn8ZtIoX2xEKiZFz2e5IgSrzvAYZuf6MM3yWzK6i6ThbByj7VqsW1smoRzXxcIvtNHdw
	OiN4yeYorm3Hb+lGVGr9YdEeJ2cckayU2ryI=
X-Google-Smtp-Source: AGHT+IF5h59xSIyN0k7rgm5Z/TTUv0M5YzKxA7IGqfgZvrCG81cPfCo2pFE7bIt0sE2bBP3SSLUeE7LHTSY1B2i9w+o=
X-Received: by 2002:a05:6512:3c85:b0:533:966:72cb with SMTP id
 2adb3069b0e04-5343885f659mr1638297e87.48.1724421530927; Fri, 23 Aug 2024
 06:58:50 -0700 (PDT)
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
In-Reply-To: <CAM9d7chAryBEq7NH_oKdBEg=VD-j82BC_1YTY7t1UH0xrs5L2A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 23 Aug 2024 15:58:14 +0200
Message-ID: <CA+icZUUazXQVzf1AcuFSvT2FAL2Ag=xTFYxM35tvw8h-ix+rXA@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Aug 22, 2024 at 1:26=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 22, 2024 at 01:11:22PM -0700, Namhyung Kim wrote:
> > > On Thu, Aug 22, 2024 at 11:20=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > > > > > On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Mel=
o
> > > > > > <acme@kernel.org> wrote:
> > > > > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:0=
0:00 2001
> > > > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-=
type-mismatch if
> > > > > > >  present on clang
> > > > > > >
> > > > > > > The -Wcast-function-type-mismatch option was introduced in cl=
ang 19 and
> > > > > > > its enabled by default, since we use -Werror, and python bind=
ings do
> > > > > > > casts that are valid but trips this warning, disable it if pr=
esent.
> > > > > > >
> > > > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > Cc: Ian Rogers <irogers@google.com>
> > > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-Wsws=
O0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > >
> > > > > Can we also add 'Fixes' tag to make this picked by stable kernels=
?
> > > >
> > > > Fixes what? This isn't a regression, clang 19 isn't available for F=
edora
> > > > 40, the most recent.
> > >
> > > No, I'm not saying it's a bug.  But we may want to build the old
> > > source code using new clang.
> >
> > Sure, and with the tags we have now, we can signal it by using Closes:
> > and Cc: stable@kernel.org, without a version, I added those, the tags
> > section then is this:
> >
> >     Closes: https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2h=
aFneX0C5pUMUUhG-UVKQ@mail.gmail.com
> >     Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> >     Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Ingo Molnar <mingo@redhat.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Nathan Chancellor <nathan@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: stable@vger.kernel.org # To allow building with the upcoming cl=
ang 19
> >     Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9=
uy3r2MzKXwTA5THtL7w@mail.gmail.com
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Ok?
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung

Hey Namhyung,

are you aware of ...?

From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com
Subject: [perf-tools:tmp.perf-tools 1/1] error: command 'clang' failed
with exit code 1
Date: Fri, 23 Aug 2024 18:43:32 +0800 [thread overview]
Message-ID: <202408231822.dWGP67uY-lkp@intel.com> (raw)

https://lore.kernel.org/all/202408231822.dWGP67uY-lkp@intel.com/

That points to commit:

perf tools: Fix a build error with clang 19
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/commit/=
?h=3Dtmp.perf-tools&id=3Dcf36d63d7cc9a9770f69f44a10904e9fb0895fa9

That is fine with lLVM/Clang-19, but breaks previous versions like
LLVM-18 as explained in [1].

The REAL fixes are:

perf python: Allow checking for the existence of warning options in clang
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
tmp.perf-tools-next&id=3Db81162302001f41157f6e93654aaccc30e817e2a

perf python: Disable -Wno-cast-function-type-mismatch if present on clang
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
tmp.perf-tools-next&id=3D155212c965b5b23a90b8558449dbfd1c60dad934

Unsure if the commit-ids will change.

Do you happen to know how to feed the LKP-tests bot?

Best regards,
-Sedat-

[1] https://lore.kernel.org/all/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwT=
A5THtL7w@mail.gmail.com/
