Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YT2hWwDk"
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563459C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 20:25:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so7444a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 20:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701750333; x=1702355133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgAMRXqQYaDBV6wyGUZmXuMtTS9bHHBbShJFrMu8R94=;
        b=YT2hWwDkCsSBKNE+L3cHL3odpQ/ysz3p1n0KHksRmx0c9wisK0f2kffYTjeEN3GFVx
         PxEbsOQAZWIVRsnkFU2xu1XfjGTL/6uPsJmrE60HZD8tx0PRA3EZjSgt7oJXLI8XfFId
         +pa365/hEKGsdndv7dYaU4677e3dK1WEfrMZnKHXlLM+50ssxj7OFKhC47JiWfJijUTe
         ZYeRFNo4WFUAdjuPgtGWjFCs004vB0zLHi2IZ4uIwsbO5+frcCg+H9V4EeKY+qDOVCcg
         hXkfpXdqzFUtbL387dvLw68Iv8NLk9AZ94G+7QTob0mnQHWUIkHEZaKtbDpySBB0+sgh
         H2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701750333; x=1702355133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgAMRXqQYaDBV6wyGUZmXuMtTS9bHHBbShJFrMu8R94=;
        b=rJTFJ4J0Bm4Hs9c6jVJWO+vBoQEcypo2RCERdlQMsDvC0ETW4ZmnEpVnmo5WtX0nmT
         +TUhQ37/7auKAagRncqcAlrM0qfDPrC3Su8hbMlREIUxxILTMQeEfC3uLPNvXjp6Iq0B
         BatM0vq7vCs5+h7dhzxDDjufbYeF9HE/MvwqylhWgm2NapAM9hVyOkKndm+4HGKgJyGq
         M6uOkyUi4iihLfDbm6OAC3tv5N2gddqluZa14pe0E3oMkHPeNEZIsiFn1cGT4xMdljvi
         U1dmQ9foP4UEZAhlqpHAa/i6iE2ABBecmYua/IHTnQsD7qcUR++SaIKbr8cCnWlP/YVm
         GNOA==
X-Gm-Message-State: AOJu0YzQN+BwdYYVbegT/I5/Qwx9OV+aI+iwhEyY8pRYSE3HeEAA9Gn/
	Mgn6pMh+xYUD1QTkiPKWeNvLYhC+dKQwjtoUa6sBag==
X-Google-Smtp-Source: AGHT+IG1Y+SWJHsHsHJOwW1bKr3R8/Za5N4Jl0wjRHmEmgTElx2KScn7AGso+1h60y3mkkHPPuEMnYtymTYPk0maEV8=
X-Received: by 2002:a50:cc82:0:b0:54b:8f42:e3dc with SMTP id
 q2-20020a50cc82000000b0054b8f42e3dcmr490832edi.2.1701750332278; Mon, 04 Dec
 2023 20:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
In-Reply-To: <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 20:25:20 -0800
Message-ID: <CAP-5=fUBGLPdFn4EfwoAamQ=5nX3LOM1v8LZk2ExEDckm+6fhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Mon, Dec 4, 2023 at 2:45=E2=80=AFPM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
> >
> >
> >
> > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > A metric is default by having "Default" within its groups. The defaul=
t
> > > metricgroup name needn't be set and this can result in segv in
> > > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > > that assume it has a value when there is a Default metric group. To
> > > avoid the segv initialize the value to "".
> > >
> > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Thanks! I was going to look for the bug but got pulled to other
> > tasks. The patch looks good to me and I tested it successfully on
> > AmpereOne.
> >
> >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com=
>
>
> Looks like it needs to go through perf-tools for v6.7.
> Ian, do you think this one is enough?

From a user's pov the json fix is nicer as otherwise perf stat output
for the relevant metrics lacks a heading on the left. This fix is
smaller. I'm easy about which to take :-)

Thanks,
Ian

> Thanks,
> Namhyung
