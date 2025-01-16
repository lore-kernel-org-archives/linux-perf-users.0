Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6D1DE2D7
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042491; cv=none; b=IzR2++b06z62EipdZOv6SQ5gFec2Y9C425MyhbWG75HJ4jiOfrqHDobEnrFA/jxT1QRmUL6ZzJiT2SKkTiF5d4KhZsbtIt3Fj0Z1/uVGfV4/ApbPPKR1qyFXo/PP+yvHWDGOswA+O9BKuldk2NmfZJBjlMYhzyAkIOAZDqocVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042491; c=relaxed/simple;
	bh=YRWCnWUfiS5tSL+VuowIR0MOyqI8J85raUn8Xsuiuvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT89r4NR12P9v5KiLlevZD+AT9Gf5QvndAnw9BchPCMVGcByFDufEF5ieP2nqCwWQGeoqPjQ90iPLmWEoTYTc1aJ2ClVUsQZhYVmPNcJAReTWr8clC2kNH9bVqEWM3Okb0VNZfOFnrD6MbAs1kATKHGE5eKuP6r0IeryhC1x52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ha+PYgjL; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ha+PYgjL"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so163545ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737042489; x=1737647289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bQI1R71tqnP5KfaqHB3dTVylNz0MJpkeD+wuywK6GM=;
        b=Ha+PYgjLaawza3z/jBprxW5he/EvyoQ7ZIWOZ5yhSk0NeNAjWrIa83Dt+5kkIKuBkV
         KzUfsK6ACd2Q76BuAGiZN2GQpEFUUgtqmHa1byd25yq9XDmb/sYA4c9+d291srstGiaA
         Dm8ePubE2O/l2K49fhuw0gjVVJIda2a0ZdcUKcLrsucPOnkHEqOeBKDbM3CR84Lw+Iik
         hIaAzRpPiFcUhaZimZ1h/BEh7ahGh1B0K3jWxxnXII9T7wroja9pUqT4rqGRQHNwb/WD
         MEHa2p5o2aMweB6PfZDVfz6TA1TqFkN3A2eAdjvaHkSUJvI13uAYhTNYjqoOTqe/rfPL
         zCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737042489; x=1737647289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bQI1R71tqnP5KfaqHB3dTVylNz0MJpkeD+wuywK6GM=;
        b=cSMCMGk83Ssp1P6DlD5HUx0fgfpNp05XwF0WfLTlD0aHoqYxp/UIS2cLpts6V9lq3P
         ybW6VvpPDVsyyyR2qHK0WDHvKsRv+WOdAJgVNrTRuwhqYZm1pcTtmMyswW8kbH1IUB+z
         2tBuE9XEbvw/VVUCQRGH07JQaczPEeM8APG9TNdiRKyW2VmlHMcuzA67KnCyvrbKilHr
         vY/X7gRr1yOv9g3LIXn19imQP/H0R3Y8G3iiSaigPuUF8WLUyLMjc4kr+7+ftqnUHeeY
         /bCRDa4J32+ThzJxCGtDpAscRwqADUeQ8FKmgH6eFnUfV7KGlMAUEgaS1kjDOnOrBWN2
         EQQg==
X-Forwarded-Encrypted: i=1; AJvYcCW41KpN6yds7aAGPmtYiasy4mEs3JbO53XwuJa7WBNTdhEWpolEkVqfFEJzsu5xLZDFaAV+JP4zcaYuknpcaIu3@vger.kernel.org
X-Gm-Message-State: AOJu0YzibGcS/b5IFJ7BvEKjZV8BSG4IqduzHyYckWWw2Gw30rRy0CrT
	AcN1Tigv6nV0lmP+Zw2Qu1dSvh9vDMrGAYsulw2NfZk+ECEO+GlC7axVboX5oqnPDoDWY8qqvFy
	sPddBeXARhZfZ20DNvo4XRqw2lvpf7wxe9gdN
X-Gm-Gg: ASbGncuKAnkT0281uoMCe6QYXqRbxo/piiP6PxNaH2+8EpU+2mxuBtLAAWfkvfGANuI
	xZhKFq1ZBMFd9R4KfaVw3UmOk7fb85uAG8Z5uahno60ppZPp8uvBVBnII9ripAuMZ/TOV
X-Google-Smtp-Source: AGHT+IEcoZQ7/3vCvEC7X+bK8emVkPPgO8vYB6IN2Adc+MzAb+5y6Qq3aXPPg1IFZTdAZqE3VFkSle1IQmHe0lQzRnU=
X-Received: by 2002:a05:6e02:2409:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3cf41fc9989mr3046155ab.17.1737042488733; Thu, 16 Jan 2025
 07:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com> <45f0bebf-6d4a-448c-8088-db2facbbfa46@linaro.org>
 <64a3dadc-7c37-4e05-8d42-445142691777@linaro.org>
In-Reply-To: <64a3dadc-7c37-4e05-8d42-445142691777@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 Jan 2025 07:47:56 -0800
X-Gm-Features: AbW1kvY-u3fzlr_koavoZHW5cEeoPBiZrtJ2StmtcyJwwrFT4cXqEjWW38kSHbU
Message-ID: <CAP-5=fXFhuQsTvefBSAo0p81LYPHdyFpeyLDaEZ_pGYScgiHvg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Mypy and pylint build support
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:58=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/01/2025 10:56 am, James Clark wrote:
> >
> >
> > On 25/10/2024 6:22 pm, Ian Rogers wrote:
> >> Support building perf checking the python code with mypy and/or
> >> pylint. Currently there are too many errors to make this a default.
> >>
> >> Shellcheck generates no output on success, so linking shellcheck files
> >> doesn't cause `ld` to fail. Mypy and pylint generate output that will
> >> break `ld` so change the Makefile.build to ignore test log files.
> >>
> >> Address some initial mypy errors.
> >>
> >> Ian Rogers (6):
> >>    tools/build: Don't pass test log files to linker
> >>    perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
> >>    perf build: Add mypy build tests
> >>    perf build: Add pylint build tests
> >>    perf test: Address attr.py mypy error
> >>    perf python: Fix setup.py mypy errors
> >>
> >>   tools/build/Makefile.build         |  6 +++++-
> >>   tools/perf/Build                   | 32 +++++++++++++++++++++++++++-=
--
> >>   tools/perf/Makefile.perf           | 14 +++++++++++--
> >>   tools/perf/arch/x86/Build          |  6 +++---
> >>   tools/perf/arch/x86/tests/Build    |  6 +++---
> >>   tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
> >>   tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
> >>   tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++-=
--
> >>   tools/perf/tests/shell/lib/attr.py |  8 +-------
> >>   tools/perf/trace/beauty/Build      |  6 +++---
> >>   tools/perf/util/Build              | 31 ++++++++++++++++++++++++++--=
-
> >>   tools/perf/util/setup.py           | 10 ++++++++--
> >>   12 files changed, 171 insertions(+), 31 deletions(-)
> >>
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> >
> >    $ make PYLINT=3D1 MYPY=3D1
> >
> >    TEST    python/twatch.py.pylint_log
> >    ...
> >    Your code has been rated at -5.00/10
> >    ...
>
> I forgot to add this:
>
>   :(
>
> I didn't know it could go negative.

:-) Shows we have some room to improve.

Thanks for the review!
Ian
