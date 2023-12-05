Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CH8DNH1"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A7129
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 11:14:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bed6c1716so480e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701803698; x=1702408498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjNkOH41w29ta79KWUOUY4u7veXqkuV98gB+b0cOvYw=;
        b=1CH8DNH1Pl7iw9Uhwlvg7MOlt9gcDKO3YEKKvzRyqhT1Dqo6XnEwxGlswW7JYkMflR
         +6EY9CS/X7qaUCcU/3LKfiiihWctIh78li4I9TfcySGL8fxy+7I50fDHti38M4eDzI7T
         A7gjgq6CRziLUx73DqWfRA2fA+8kUGGG29FYfGSxwIf1h6Rhav4d+cRdWCvGN1zHaNr/
         1xlYsnNaL+4zlIjeaV2xAPtDe19Uvi8G1YWjyRgArStCER+oKBmhOftS47+bcnUbmm4S
         oqF61xy2NVz4LJ+DJ9g53WjMPSm8ah1ks/3xDwvTOSw7Fq9I5tctOThq+naTPXwHbq/c
         DUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803698; x=1702408498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjNkOH41w29ta79KWUOUY4u7veXqkuV98gB+b0cOvYw=;
        b=vwi5xQpAU5sxPDvhPMBNU8lGVTcgAqH6VeG6B+jHPEvwZeDlV+hyP4JhWEfZ+S48nH
         1365jK3/Up+5aWfjNY8niNeMOt26MsDxoWRm1qg/sKp2fLIMjEueAbjvdFbuGTv5w/Ql
         sNINc/82c6IspwR0YrRReNvEK99j1MycRAjbhJH93qPt5sg98pHJHd1qslfLMtMbVSg9
         HsOYjAYHCDJX9+lXc8ByLnPVlAODYcaaZ/d7ZRf/Yx5DsqjXQDqr3N7YW03u0VO/WtyW
         mTbGzVFkdhatZf4KOwjTkkrbfClUC7bfL7rwAY943bpHPd8WgMfwjkGutsLPqGVS9MZp
         Il6Q==
X-Gm-Message-State: AOJu0YzPONmlkFvMt7VCcL9cZLzNRbRRhH7DsZ9unu8Shaj3cTiD2NbF
	jKDLrp+k0GrxrQ3sKTNQd3aqRPV/i0TeCy/6aT05Aw==
X-Google-Smtp-Source: AGHT+IECevghSTxbCpO5I8Hw921Kb+KJQSWhdrSSOCD26W7F8IdQsEZHah0UJbWLkpKj8oahEcpogeAaeah6fypFdDA=
X-Received: by 2002:a05:6512:e81:b0:50b:ea5c:2823 with SMTP id
 bi1-20020a0565120e8100b0050bea5c2823mr9416lfb.2.1701803697521; Tue, 05 Dec
 2023 11:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
 <ZW9G8Clxwl6bd0H6@kernel.org> <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
 <ZW9whqUEILWMdcmi@kernel.org> <CAM9d7ciqm2NLt5kxjVdOP2y-KV30_CRsSjHpcQgntvNGWukx9g@mail.gmail.com>
In-Reply-To: <CAM9d7ciqm2NLt5kxjVdOP2y-KV30_CRsSjHpcQgntvNGWukx9g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Dec 2023 11:14:45 -0800
Message-ID: <CAP-5=fXpsGNVfz+jyu7A=uhrJVQ2xeQ_Forq7CJ4YSjFp-UWnw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Dec 5, 2023 at 10:48=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Dec 05, 2023 at 09:24:42AM -0800, Namhyung Kim escreveu:
> > > Hi Arnaldo,
> > >
> > > On Tue, Dec 5, 2023 at 7:51=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > >
> > > > Em Mon, Dec 04, 2023 at 07:33:18PM -0800, Namhyung Kim escreveu:
> > > > > On Mon, Dec 4, 2023 at 2:45=E2=80=AFPM Ilkka Koskinen <ilkka@os.a=
mperecomputing.com> wrote:
> > > > > > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > > > > > A metric is default by having "Default" within its groups. Th=
e default
> > > > > > > metricgroup name needn't be set and this can result in segv i=
n
> > > > > > > default_metricgroup_cmp and perf_stat__print_shadow_stats_met=
ricgroup
> > > > > > > that assume it has a value when there is a Default metric gro=
up. To
> > > > > > > avoid the segv initialize the value to "".
> > > >
> > > > > > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgr=
oup")
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > > > Thanks! I was going to look for the bug but got pulled to other
> > > > > > tasks. The patch looks good to me and I tested it successfully =
on
> > > > > > AmpereOne.
> > > >
> > > > > >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecompu=
ting.com>
> > > >
> > > > > Looks like it needs to go through perf-tools for v6.7.
> > > > > Ian, do you think this one is enough?
> > > >
> > > > So I had this on my local perf-tools-next, removed now, I also have=
 some
> > > > other fixes by Ian on the tmp.perf-tools-next, please let me know w=
hat
> > > > you guys decide to have in perf-tools for v6.7 so that I can remove=
 it
> > > > from there.
> > >
> > > I think we need this one and the Ampere default-metric-group fix.
> > >
> > > https://lore.kernel.org/r/20231201021550.1109196-2-ilkka@os.amperecom=
puting.com/
> > >
> > > Also perf list JSON fix can go to v6.7.
> > >
> > > https://lore.kernel.org/r/20231129213428.2227448-2-irogers@google.com=
/
> >
> > Ok, removed both, please augment the later description to:
> >
> > "perf list: Fix JSON segfault by setting the used skip_fuplicate_pmus c=
allback"
> >
> > The original description was vague, improving it a bit like that helps
> > when just looking at the output of "git log --oneline".
>
> Done and pushed to tmp.perf-tools!

Thanks Namhyung, there was a typo in Arnaldo's commit message
"s/fuplicate/duplicate/" could you fix?

Ian

> Thanks,
> Namhyung
