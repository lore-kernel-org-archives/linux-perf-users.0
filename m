Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B8369998
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012078; cv=pass; b=RFeCtVWg8uSezN8XQDu46rX0O9juzYOYt1OhncADaopzRZdg6G26Vi4e837gsv2t62Yr30zFRX+2A2TfQw5oZ48XKeWQbK1mupH1NYxZFc2zN3Hj71Vf1zmd+hfiqGUqZYawt8izTWTtIw1J7LX0e5YPjmoGxKlE2AyNkVmSl9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012078; c=relaxed/simple;
	bh=he6k1QrRKlKP5zMoRbbMTSbEndL4HL80WArN9x0v9pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3WL5rA9Nb4vqQxwEC3blh6dmpKvIFh/4dRSLhNx7bMhNNaPRJmGf0ZtfDYGfbD+7dATOTF0jjHovCniAIhPDrAwe/jYL6u+L6zc6gO7DE6+wBLuyeO+k4DaaFt/rWRF/PdLxflJGSInkkiWXoid++P/mOuFYWy4GN+cd30jisI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRntH0cm; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRntH0cm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a76b39587aso102395ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 08:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012074; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3uzku8NJsxjS9uTOpyFg38dmUuoVwXMhI3Mydcg76DpeNIIRW1hyT0kHH0S6ECscJ
         UrLx1vEa4scNIN8Ul2LLyhcQRpmY9d9+ygriOijNJp7XH9u77YFO8HaDYS0GfcJYuwPp
         3iWsv1LNSuQC8fRaXamxhj4j6eoRVE+4J3Kn/BpcZU7NNjWfs533iT9NqMY4+/rlOexE
         +577vJiY77HdrV7KqYcGh3KO+zKcHndaXZ+tbCRhnmAphcP+902Fxwi2wZ+Algb/gM1A
         jBBcsBNRrR1fw7OUQfWanlPPWfdsZZfHIKv2YxpuF9EFY9l4XSb5sg7omcTX0zl9n6dQ
         gXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YKh4wf+cz4QIgkmdUqpnXSOEUQsJ3NCDQUL1kzv9Zw=;
        fh=BlfXtcqjlc1Zjj2zZy2yadBMVP18schJpRWO3eLlo94=;
        b=DTm2EDRlZ8oCenMI/g+AaV8zkjqgUXZzQNPe03lHAuw2OhNoC62iaOpe7yQFGiVnM0
         joXQNOWjjTgmRbzT+K/4Z1w08Gt2jkDQLUMcT9uLUEBVQPfW0b8hn5bazlnQ5i8vSvm5
         0tEBH4+XI7Nbvxf5yKGK9DyiUaX0Vom5keitH6ghJ5qjCTyog/vB4SUgV9d2PJfISwsg
         Gl1GRYWiWkW2ce7K+Qpbr7D5cQkKIvInJaNlPtfImbZ51amZxj+GmlQAjqa1u7Qym2DF
         7ryeUZ6U1LrLOVvzxEtDYNqx44dprKQrqBaq+aIMFqbJslsjMiTL9V6inVWoK0Pnv7dC
         NeeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012074; x=1769616874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YKh4wf+cz4QIgkmdUqpnXSOEUQsJ3NCDQUL1kzv9Zw=;
        b=pRntH0cmjndtLj+rYi60YHjDBG29sSppKmY/bKPfC7WO0kbD3tQKL4uc6muujMelkK
         OD6RXY3XQH+GP6aziepgrDG96Hz7rkS69E/67NhRP40HWLiiFglOwHxM+NzCz/jVZScX
         3ffBqoD4X9vzM5gi+RoxYwVjLxusDDukCgCLFAJOlD0nSAMBFnqlRppmDALemAMZEWPH
         /AGEsIPDOS0CiqJy4sviX/zxBuHJfr1VvTYkcSC/Ffazud5HspBbhDcalsXV/X8njaeI
         HgN6G+DOXGHXT8ynisJ8XIb6eeg3tLNn1r/Ycc1LtMcUbAKL7zn38whAS0XFjwMCuKDE
         y6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012074; x=1769616874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YKh4wf+cz4QIgkmdUqpnXSOEUQsJ3NCDQUL1kzv9Zw=;
        b=fu6FW/DXq4dDwI4ECK2cGF1roJ4Y7LFVhw4Ls/A1XCu1UeMAzHNO1kZ21BQjggQPyX
         cYKDx4bcROzAWbsGVm0/UnMMF+pAK4Zw4mMJeD3TVBx/etunRFm0SDRF7tnXUo5V2aml
         DUiRyCwU439h8B59Ha0JzOo7YxPMYQKGWsVEa1hEL/6KFhOiBAD1Ct0kLygYRMIn2NnP
         pbE07WFhpDmToLRgtMLc5ed1blQZLZ4I9nQCm7rVofiQ0r/6459p0ks2LN2el8wLcbjV
         rpsavfrwuy4B2XycNVUq+z7KeCZSzeDJDlxUZFLAbEDl9WWoVGg/2kRWLNDIHvWhJoSl
         Xx4A==
X-Forwarded-Encrypted: i=1; AJvYcCX5yhlaztvcMLVIL/+Mm8Zl0ED7vBZWldIU1O5EpRCXdUeL2zvyWsAyDjfnzpcGTvjCaJNQw5/ygGkXfQXFNeHS@vger.kernel.org
X-Gm-Message-State: AOJu0YzlM6lz2MMRCSR9+BLpU6Kb2qsh7SwNSYJDaV1jE9wAvaPd1iHI
	bQV3UWYH1Illq8he0tUxL0A53QM4jzJGPOu8oLFMyRQMJWzEjz+y957iGpYVDGK2RHH8ocUfhAU
	qsb3yHmhjKUs+9nKbedytKKZgYMw34DUMGSaJJoY3
X-Gm-Gg: AZuq6aKtUIsIkhyjpcWQBmWgaumDH/rRN3UV6UOaZRtRMinwhyZHKkMgs++cOCZAibe
	4zza0XjrQjVj83vb3iBkJ53AvL6cLram9/fuIZZkyEgPFyUixdBdnSTTM24I22l7tWWyuACmc0O
	SePo5vMrsbWtcpzGvuMdZT9umYepoHNiR10JZQDoR68zZcaD1gSbadf4+/dZTEy8hnT1K6I26ng
	+3fl79w6rjuWE+HQxFg+q6dbikuIzR/CPWT8YSTAstXPDR5JryWgX8Yp72ZI7F/lbXMSXvKTUfb
	cYmIDRd4BfhJj/tfphqzoAO2mw==
X-Received: by 2002:a17:903:245:b0:2a7:7f07:340e with SMTP id
 d9443c01a7336-2a79a3b948cmr3243715ad.4.1769012074058; Wed, 21 Jan 2026
 08:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121082402.2311962-1-tmricht@linux.ibm.com> <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
In-Reply-To: <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 08:14:22 -0800
X-Gm-Features: AZwV_Qjrczmou1z4XeWYuSuAhLwzJxk3rivR5zSTPtKkcNs9xW0clGNshOXeuYE
Message-ID: <CAP-5=fWjzR0WqD7RyDE66ChUQnt4_qwauEPiDsrhtL02u_zo4A@mail.gmail.com>
Subject: Re: [PATCH V2 linux-next] perf test: Subtest Exclude disjoint subcmd
 names fails
To: Thomas Richter <tmricht@linux.ibm.com>, "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 8:12=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jan 21, 2026 at 12:24=E2=80=AFAM Thomas Richter <tmricht@linux.ib=
m.com> wrote:
> >
> > V1 --> V2: Add linux next repository
> >            s/needed/unneeded/ in commit message
> >
> > The perf test case 'libsubcmd help tests', subtest
> > 'Exclude disjoint subcmd names' fails all the time.
> >
> > Root case is a special case of sorted input which the exclude_cmds()
> > in libsubcmd can not handle. Assume the following inputs:
> > cmds =3D { X, Y, Z } and excludes =3D { A, B }.
> >
> > This leads to
> >  ci  cj  ei   cmds-name  excludes
> >  ----------|--------------------
> >  0   0   0 |     X         A       :    cmp > 0, ei++
> >  0   0   1 |     X         B       :    cmp > 0, ei++
> >
> > At this point, the loop is terminated due to ei =3D=3D excludes->cnt.
> > The for-loop now checks for trailing names which had to be deleted.
> > But the first entry points to a name: cmds->names[0].name =3D=3D "X"
> > and this is a valid entry.
> >
> > This is the case when all commands listed in excludes are less than
> > all commands listed in cmds.
> > Only check for existing names when cmds list was changed, that is ci !=
=3D cj.
> >
> > Also remove an unneeded if (cmp > 0).
> >
> > -
> > Output before:
> >  # ./perf test -F 68
> >  68.1: Load subcmd names                           : Ok
> >  68.2: Uniquify subcmd names                       : Ok
> >  68.3: Exclude duplicate subcmd names              : Ok
> >  perf: help.c:112: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL=
' \
> >         failed.
> >  Aborted                    ./perf test -F 68
> >
> > Output after:
> >  # ./perf test -F 68
> >  68.1: Load subcmd names                           : Ok
> >  68.2: Uniquify subcmd names                       : Ok
> >  68.3: Exclude duplicate subcmd names              : Ok
> >  68.4: Exclude disjoint subcmd names               : Ok
> >
> > Fixes: 1fdf938168c4 ("perf tools: Fix use-after-free in help_unknown_cm=
d()")
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
> Thanks Thomas!
>
> I tried to apply this on a perf-tools-next tree but it fails. Looking
> into the git logs I see on linux-next:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/l=
og/tools/lib/subcmd/help.c
> the last patch is:
> 2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empt=
y
> In perf-tools-next:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/log/tools/lib/subcmd/help.c?h=3Dtmp.perf-tools-next
> I see:
> 8 days libsubcmd: Fix null intersection case in exclude_cmds()
> 2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empt=
y
>
> The test I wrote was to give coverage for  Sri Jayaramappa's fix:
> https://lore.kernel.org/r/20251202213632.2873731-1-sjayaram@akamai.com
>
> I wonder if we've put the test into linux-next but not Sri's fix, well
> that's what it looks like to me.
>
> Now that we have both your fix and Sri's fix, and they differ :-) I'm
> wondering how to resolve the differences.

Sorry, resending as I got Sri's email address wrong.
Ian

> Thanks,
> Ian
>
> > ---
> >  tools/lib/subcmd/help.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> > index ddaeb4eb3e24..1ce5fe507687 100644
> > --- a/tools/lib/subcmd/help.c
> > +++ b/tools/lib/subcmd/help.c
> > @@ -93,19 +93,19 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
> >                         zfree(&cmds->names[ci]);
> >                         ci++;
> >                         ei++;
> > -               } else if (cmp > 0) {
> > +               } else {
> >                         ei++;
> >                 }
> >         }
> > -       if (ci !=3D cj) {
> > +       if (ci !=3D cj) {         /* Verify cmds list only if it change=
d */
> >                 while (ci < cmds->cnt) {
> >                         cmds->names[cj++] =3D cmds->names[ci];
> >                         cmds->names[ci++] =3D NULL;
> >                 }
> > +               for (ci =3D cj; ci < cmds->cnt; ci++)
> > +                       assert(!cmds->names[ci]);
> > +               cmds->cnt =3D cj;
> >         }
> > -       for (ci =3D cj; ci < cmds->cnt; ci++)
> > -               assert(cmds->names[ci] =3D=3D NULL);
> > -       cmds->cnt =3D cj;
> >  }
> >
> >  static void get_term_dimensions(struct winsize *ws)
> > --
> > 2.52.0
> >
