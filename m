Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81828EBF1
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696679; cv=none; b=py9wjm3Y2Erw7REshFPohlndT+b20Cl7utESyomcAzTCOBIl7gs1CjlycTfXpcownvzaKs9JA4Rp7/roztJ3ik/kYew5Sq3honEb4wnyevsojCCglBhDMDbn2n2EPXVJ6QHGpFxLa9K8SL9xgXH/mrjDLZJzcmAeLdpCtaQZjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696679; c=relaxed/simple;
	bh=JS1FG2qENkQ353/qm/Vo5hQuv0HIVwdvuruB5QR/gzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVyjDJc5y3CQYBVoNHOzIzm0GX0HdtBvKvRH08BWDzTfxW7b0DZOn4kBdLBcHmXTmt2iyr91M0RZVsMcrogboISEQvacwnlncOc3KK2gkIkYf7RS3ogQ8W9pGLYLOcIINK3ZfkVuowdjtVqnSrziAOr6uAam9HHpqC09ES2lEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6D3KXE7; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6D3KXE7"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so2975ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750696677; x=1751301477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri3+Ap4cqoeDbRAUlcrZd437nBvU+XraT/8Lh4iGeK0=;
        b=B6D3KXE76BIQVNqRZxqzThbRtp42uPjlR5m8BSm5LHuALEPl9XbKFwNYU8vsCVLhb0
         2tmz7/W59rjp5YJublF2o/0rXjl5PNDa2+iIDhvVpM4ZgfET0eGLASPLtrgUpP6XQCtk
         T5AWPvPQqM4bKiiZVcSqIRc4jjJvRECd4W4l7Mo5/V0jZy8jAMdAfLGp8BjADQWXFF8L
         1jIudAeHFR/LIBLuzw+Q7HvJZAvZp9Yk8ekG8A7h7fs8td7/ev5Wleu+iSvTISxokzju
         vVhLM/JFaAgTzNt5pTy+Ts6HuaAS92Z/09SLc9pYWEofCWMhKRywlQhGPAHSc9VX+H5M
         BeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696677; x=1751301477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri3+Ap4cqoeDbRAUlcrZd437nBvU+XraT/8Lh4iGeK0=;
        b=ebU06Zblh6hgcA4Mh5HMheZnMhypFejvRHkc4L8oBOo9WdtC6LSBP3wDPW54MdLzAJ
         gBvjwkPb9EPORjGYiBxU7wczn70+uy5K4Y2VDkC4m/orbSSSH/sAH3Obwa+1QezT3i3T
         mgjXcXa8w37M/yU+MFPjIaqpNAWOxPQcsh41PE2Q7Xkp2Mv5Lukov3S5t8MWl5wzXJg5
         lP2O1lHUOBFhDthLkOBF+pFVDdmIfTppb/J1bVFW4H48BRDumvQKuTQS3Zf5CABACEJd
         EC6xhxxzL5w7NaWmpBPr2GlWIiWG7dUjtEsnkK6wlkMtDwy1pGhxg6czULkNX+BJzM8X
         2qtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZO34iWzgykg7fk7SDuQ9mQnvs7wHb3AEaeFivpxyfQi0nOM57yZwpNB0RshwEmDUHgEWiU4KPhlZgjl292NA@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmDyF3sCGgQB3uk4/8msr5aLlNCoUPUcSvPxhWGB6aQ3JC45m
	3JHWSDsQXXvmvp3JKDDUUOzrfHsQiVpBs/3uoFNH50m9ObN91jgQHX98UHEac93XppDAJylYBW7
	Ebx1YJCoTQygRUyjCZzQ/RGAAdCxCKwtL43wnTYeR4IoDXQFPtWP6z6aVG+g=
X-Gm-Gg: ASbGncukPbV7tBvAIMfJfBpeNtnBbc9UgFuCxCKgHxt7mhTTjGPFPWDyuUj9+9yGRpM
	HHttxWXUCixJ5L6vklvpI9ZW6Toi2H/eraKduxema6JWiLX27+7Eun38zJw87tFdvs4Cgv7z2b3
	M/OTUENrI+vwjZNCXwQuEyOJBOBrGJU5h4DS9S7pM/fVDqsEl97eWZY1y/DLdSvCElhH2+u/o4
X-Google-Smtp-Source: AGHT+IGdxgr8P+XalPte1GIMEXQlB83/Ff2yJxb0FI5ykWekoHN3CN4Qry4jy0ooIKs9GE80H/Wjo6lwAjGkNsxfkb4=
X-Received: by 2002:a05:6e02:3c06:b0:3dd:a7f3:a229 with SMTP id
 e9e14a558f8ab-3df0703957amr6032785ab.4.1750696676770; Mon, 23 Jun 2025
 09:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org> <874iwa71mo.fsf@gmail.com> <6f524405-a9a7-45c4-bf4d-9ae33e52bfbc@linaro.org>
In-Reply-To: <6f524405-a9a7-45c4-bf4d-9ae33e52bfbc@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 09:37:44 -0700
X-Gm-Features: AX0GCFvasLURCKicqFzCPNy0SCLEOxEQZz8PHex8H2GTWGdkfSVmQ_yM79QpXxY
Message-ID: <CAP-5=fVoya-X+BBBuVwZQ527WKyGwC8tirk=gj37t2H_BBmwVg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash dialect.
To: James Clark <james.clark@linaro.org>
Cc: Collin Funk <collin.funk1@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:10=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 20/06/2025 6:40 pm, Collin Funk wrote:
> > Hi James,
> >
> > James Clark <james.clark@linaro.org> writes:
> >
> >> If we're enforcing bash style with static analysis shouldn't we also
> >> change all the hashbangs to bash? Recently there have been changes to
> >> change sh to bash in some of the tests so presumably the hard rule for
> >> sh is no more?
> >>
> >> In the past I've had to replace bashisms that didn't work in sh but it
> >> would be nice to have only one language to write tests in. I doubt
> >> anyone running the tests today is running somewhere without bash, or
> >> that changing it will break anything. If anything it will fix more
> >> bashisms that have already been written.
> >>
> >> Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in
> >> tools/perf/tests
> >
> > That sounds reasonable to me. Writing portable shell is a hassle and if
> > we already assume a working /bin/bash in some places, I don't see a
> > reason not to use it for the others.
> >
> > Regarding this patch, shellcheck will use the file extension or shebang
> > only if it does not find a 'shell' directive in a .shellcheckrc. So tha=
t
> > change will still require this patch.
> >
> > I saw it was used in other places, so I assumed this patch was fine:
> >
> > $ find tools/perf -name Build | xargs grep bash
> > tools/perf/Build:     $(Q)$(call echo-cmd,test)shellcheck -s bash -a -S=
 warning "$<" > $@ || (cat $@ && rm $@ && false)
> > tools/perf/trace/beauty/Build:        $(Q)$(call echo-cmd,test)shellche=
ck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> >
> > Collin
>
> In that case:
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
> And I'll send the bulk hashbang change separately.

I've no objection to switching to using bash globally. It seems
sub-optimal that we've copy-pasted the shellcheck command across many
different Build files and that this patch will cause the
tools/perf/tests/Build one to differ. My preference would be to have a
global definition probably in Makefile.perf, then use it consistently.
Alternative all shellcheck invocations can pass "-s bash" for the sake
of consistency.  Fwiw, I think the 'tools/arch/x86/tools/gen-insn-*'
which is to some extent taken from the kernel's 'arch/x86/tools' is
okay with the change too.

Thanks,
Ian
