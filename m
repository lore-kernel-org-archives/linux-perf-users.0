Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B3199D2
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529FD3;
	Mon, 30 Oct 2023 12:01:05 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso4190599b3a.2;
        Mon, 30 Oct 2023 12:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692465; x=1699297265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EccxOXdyEiVBJR4JsYbksdY+qQDRXxpoqTxDKJNnKo4=;
        b=l4XL4OxzDoWFtuzkHBAIuvmkACiYrAg/vaulctmhQSwwqhESM/y+aeBSuAuPWwAa3W
         uAl8I2GiY0xX9vfCytstw6QYHEGNFVJ3s07gc2AtNySXw+fXJyMbuNEZe7Gh7ZBYhlM8
         VvJMqbrC4fQzr5DOSVW/YXR2OrfXXOaghPjxFrDqatuqjWz3wbf2ts7bdh5/zkTyLVde
         +2ZuCnLXtv2Hkf5VujLyghO1Sr4Mmw55vv6nHEmVqRrGxy5OlKns+BB1hx3diqeC8qLV
         oLKEoBMKIil/Hfw5pEFDVgsm8Dht2PYHTTSuLAVG40LWGvN+gKIux6uPPn21mgPywFI1
         oZog==
X-Gm-Message-State: AOJu0YwyQPlKTDR4HClaQX1T42PRQrn2wZqW3lxfMaZLUqUP8GZsYm5D
	C4P9Xqyd+Tspubp4czbKN9NmmuGaEgPG8lAofyY=
X-Google-Smtp-Source: AGHT+IHFuyF4BbsT4e0KeVL/IIS75StuE3RCihAqdEwed4Pg2vmvC79HcXunyaMZjS5ueT6lqx7J8grl7zRSiTzV57E=
X-Received: by 2002:a05:6a00:140d:b0:6bd:3157:2dfe with SMTP id
 l13-20020a056a00140d00b006bd31572dfemr9835694pfu.7.1698692464997; Mon, 30 Oct
 2023 12:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
 <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com>
 <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
 <CAP-5=fU5W=97NFvL1yUKw+rrbBrcd8c-S_y3=86SYv+pszNjmQ@mail.gmail.com> <CAM9d7cjRac8i9+VWYNfWxNr5iz3bUUxc0-Phfcbk0RdfwXqr6w@mail.gmail.com>
In-Reply-To: <CAM9d7cjRac8i9+VWYNfWxNr5iz3bUUxc0-Phfcbk0RdfwXqr6w@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 30 Oct 2023 12:00:54 -0700
Message-ID: <CAM9d7cgihtEmwOXhs8xxD4b6BRLqx6Kcg6E=K_JFQH__=kJUiA@mail.gmail.com>
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

On Thu, Oct 26, 2023 at 10:12=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Oct 25, 2023 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Oct 25, 2023 at 2:56=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, Oct 5, 2023 at 3:16=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > On Wed, Sep 27, 2023 at 6:47=E2=80=AFAM Liang, Kan <kan.liang@linux=
.intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > > > > > Broadwell-de has a consumer core and server uncore. The uncore_=
arb PMU
> > > > > > isn't present and the broadwellx style cbox PMU should be used
> > > > > > instead. Fix the tma_info_system_dram_bw_use metric to use the =
server
> > > > > > metric rather than client.
> > > > > >
> > > > > > The associated converter script fix is in:
> > > > > > https://github.com/intel/perfmon/pull/111
> > > > > >
> > > > > > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwel=
l variant events/metrics")
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > ---
> > > > >
> > > > > Thanks Ian. The whole patch series looks good to me.
> > > > >
> > > > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > >
> > > > Would be good to pick this up in perf-tools-next.
> > > >
> > > > Thanks,
> > > > Ian
> > >
> > > Ping.
> >
> > Thanks Namhyung for picking this up. There were two other patches in
> > the v2 patch set that Kan reviewed:
> > https://lore.kernel.org/all/8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.=
intel.com/
> > that I don't see in perf-tools-next.
>
> Sorry about that.  I'll take care of them too.

Applied to perf-tools-next, thanks!
