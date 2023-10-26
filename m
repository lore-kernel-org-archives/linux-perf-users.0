Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166272E413
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7791;
	Thu, 26 Oct 2023 10:12:53 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-578b407045bso974905a12.0;
        Thu, 26 Oct 2023 10:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340373; x=1698945173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xjTyS1vijo1P94Xy5yA9q6MBSGAauw3ddDa3HKjOR8=;
        b=ZdupCeIIfIz8LS0ixTkXUiNGP8wP8LZXEp29vXYQVMPSIkwIQUJ7Sh5d772Ewa2fy8
         3rI/lthZR+jw0PU6bLqW8//eT1SQ1ahgEFGpI3Aqveya0yE9xlYKe1PZPtG6Tgx+OOoG
         Z98rOjel6ynzE5vY4azGV+E2Nyu9OUtdVsomXbkEG4HSenecmy6FnTKSuQxRiLf0oVTI
         hCNg54fwFsbKMhbB4kno13KBrvD/sGam8Dx50c8ZK1UE/YMCHxEvGsc23t7FlKHrU/ZX
         wyoXs07DtXl0YsB1hAF8EzkdR9Eqno49fl04W3rs6aHsxS8IAV6D8YX8vFYx1XnleWOj
         MTKQ==
X-Gm-Message-State: AOJu0Yyb0L3O0+k5ys01mCd537AcFzCpSnQk7ldzT8pFeg6pJJ+ENzLq
	P6oMwu/l8pfBkb50HAgqOOkAk+ryZRz7ttEen8g=
X-Google-Smtp-Source: AGHT+IHgjiNg1j1AhPBDzyo+qnZt0ax/qeDt64bMszF4TiTN8l0zH/l+Ioyx4kvSmwxe1ddF5dX/pBFnee/lAMF6vQM=
X-Received: by 2002:a17:90b:3117:b0:280:c0:9d3f with SMTP id
 gc23-20020a17090b311700b0028000c09d3fmr48309pjb.34.1698340373235; Thu, 26 Oct
 2023 10:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
 <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com>
 <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com> <CAP-5=fU5W=97NFvL1yUKw+rrbBrcd8c-S_y3=86SYv+pszNjmQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU5W=97NFvL1yUKw+rrbBrcd8c-S_y3=86SYv+pszNjmQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 26 Oct 2023 10:12:41 -0700
Message-ID: <CAM9d7cjRac8i9+VWYNfWxNr5iz3bUUxc0-Phfcbk0RdfwXqr6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, Oct 25, 2023 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Oct 25, 2023 at 2:56=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Oct 5, 2023 at 3:16=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Wed, Sep 27, 2023 at 6:47=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com> wrote:
> > > >
> > > >
> > > >
> > > > On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > > > > Broadwell-de has a consumer core and server uncore. The uncore_ar=
b PMU
> > > > > isn't present and the broadwellx style cbox PMU should be used
> > > > > instead. Fix the tma_info_system_dram_bw_use metric to use the se=
rver
> > > > > metric rather than client.
> > > > >
> > > > > The associated converter script fix is in:
> > > > > https://github.com/intel/perfmon/pull/111
> > > > >
> > > > > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell =
variant events/metrics")
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > >
> > > > Thanks Ian. The whole patch series looks good to me.
> > > >
> > > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > Would be good to pick this up in perf-tools-next.
> > >
> > > Thanks,
> > > Ian
> >
> > Ping.
>
> Thanks Namhyung for picking this up. There were two other patches in
> the v2 patch set that Kan reviewed:
> https://lore.kernel.org/all/8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.in=
tel.com/
> that I don't see in perf-tools-next.

Sorry about that.  I'll take care of them too.

Thanks,
Namhyung
