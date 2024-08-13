Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89156125AC
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560219; cv=none; b=iUyCcXgm93dncQ6A88qP/XO4q80dym0o10laANi2QHYLY2Xyei/kf6Ru/krVbs6h2hbGUxZqIHk9+K142fX4vMkpCmO0MsE9BB0Ws5T1X5LwSwMwKi7zPZZwD0TdVBq/lL+Nu3CA1063z5JcYR4bSsCDFy8wqJjQRuHRAbbNiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560219; c=relaxed/simple;
	bh=q6oSzUFiDXU6sb1gwxb0Xe8K0QMp5sQp9KTa0LWgEoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwII57GjWesltIiB6kgtBT/Uy5BAi2wZdNPzBByH1Yymtca8cZkIFB+CCx5WR43cSNV4bgo1njdfdrsXBko+l3LEMwtNrCWSR1PPInffiBQ6Ib7ndY8cG3/QyeXuDhXkCW6ixePzW1ozNwiMR5s2xXHRLDpfV6Pxf7eZds8NWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsLX0O9I; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsLX0O9I"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd7509397bso103125ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723560217; x=1724165017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cR/Xi862m4wv1x+imOVcT0OpC1BwfHPSxUTD6Av4G8=;
        b=KsLX0O9I+Zb0Vi2yh9fYX80kDOY8enGLQjqLuSQ9EE5N3NuG5CPGtbXjlpqkPq9I6B
         v3BqR8BtxvXZBYYbTlrjqHgXxWuidyXyfjguhBb53UeGpebnUqLOrV2HVOlVA9qoVxsE
         rmEZEhwPVjt4AO89UrnP6HRFF5tKcMnTOdjBqaQhZDUplYWuju8EKREQEIy2rrk4oTee
         4OojbkNGhe2nkSoq6AmtXJL3VAKhP0ufpY0KbNtEYUiJfl8DfIwXBZsIg8r6qvraR0Hk
         rcNiAA9NqljLpL8rhpsLnD/Nj04BRfqsw8Rd10L1q9EQK0n8dLlPJpIc18+C6eTCq+ll
         nxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560217; x=1724165017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cR/Xi862m4wv1x+imOVcT0OpC1BwfHPSxUTD6Av4G8=;
        b=uaPDhK5POfVJYFncqvV7KpU8VcVyFlX9YDc8MjUuJjRMa7DHc/o/lKZVjpiq53Oa4V
         lRvdiak8rROfvrkf8FA4sY3zbq8L0+mfhTErIRrFf8+dHCIGWkCPQfShFnGbb+cTfsXp
         pXOfmios0HJ4KLf/IW9Ni/RWUA9yziRlYPZFvb/2X9LgUL7aIM/PzOBoyYrhg24BzWuq
         YUm2WRwdgvThqeP3NDi1LzibL59SZlHdyj7F0pEYYdNQV7ck0NyKd99/zWaZTiAhW08+
         0+LvcEo04bJq+HpTDpFlToQlJuSGYq6GuhiKzf7h0AmrlJ+xu2ip0Qau3aIAWxqjgdHa
         PfHg==
X-Gm-Message-State: AOJu0YygJA2dWN0BgtlXTj5ivu7kMSYAF4h6qatf0sXijBZI/C2QeE3F
	MGCTbWqWqwjWO+HlvgUYaTWJ933URo2AP+6hBv0GIYk682lB9Jj2O8Ca85OzoBFtfYuftNpZnDH
	mHMJ6QE96LXMyfKG2Kz075M5JbtGLlFTkivXx
X-Google-Smtp-Source: AGHT+IGbGc7mQIcdVXjHr82Ozw+3Zn4Na+CsusTCkuRohM+ag2duxL5TDSLYzMyTz//U5PHfImCv2gu7u4+b68azLeQ=
X-Received: by 2002:a17:902:e845:b0:1fc:719c:5d9 with SMTP id
 d9443c01a7336-201cdc64573mr1304685ad.25.1723560216507; Tue, 13 Aug 2024
 07:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132323.98728-1-james.clark@linaro.org>
 <20240813132323.98728-2-james.clark@linaro.org> <CAP-5=fX-m3mhi0sGsGo9biWmFV_U=35Tp7h9X0reg3zHMEsy_Q@mail.gmail.com>
 <76ee9150-36fa-4dfc-ba9f-8a10df580c92@linaro.org>
In-Reply-To: <76ee9150-36fa-4dfc-ba9f-8a10df580c92@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 07:43:25 -0700
Message-ID: <CAP-5=fXYSLH9QcvdgV0D8Z-FoVxO25F_SN0BUdge4G_eCDDjZg@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf stat: Initialize instead of overwriting clock event
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:38=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 13/08/2024 3:28 pm, Ian Rogers wrote:
> > On Tue, Aug 13, 2024 at 6:24=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> This overwrite relies on the clock event remaining at index 0 and is
> >> quite a way down from where the array is initialized, making it easy t=
o
> >> miss. Just initialize it with the correct clock event to begin with.
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/builtin-stat.c | 7 +++----
> >>   1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 1f92445f7480..a65f58f8783f 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
> >>   {
> >>          struct perf_event_attr default_attrs0[] =3D {
> >>
> >> -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_TASK_CLOC=
K             },
> >> +  { .type =3D PERF_TYPE_SOFTWARE, .config =3D target__has_cpu(&target=
) ?
> >> +                                               PERF_COUNT_SW_CPU_CLOC=
K :
> >> +                                               PERF_COUNT_SW_TASK_CLO=
CK        },
> >
> > Hand crafting perf_event_attr when we have an event name to
> > perf_event_atttr parser doesn't make sense. Doing things this way
> > means we need to duplicate logic between event parsing and these
> > default configurations. The default configurations are also using
> > legacy events which of course are broken on Apple ARM M? (albeit for
> > hardware events, here it is software). Event and metric parsing has to
> > worry about things like grouping topdown events. All-in-all let's have
> > one way to do things, event parsing, otherwise this code is going to
> > end up reinventing all the workarounds the event parsing has to have.
> > Lots of struct perf_event_attr also contribute to binary size.
> >
> > If you are worried about a cycles event being opened on arm_dsu PMUs,
> > there is this patch:
> > https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com=
/
> >
> > Thanks,
> > Ian
>
> Hi Ian,
>
> Is this comment related to this patch specifically or is it more of a
> general comment?
>
> This patch doesn't really make any actual changes other than move one
> line of code from one place to another.

James, this code is removed here:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

Thanks,
Ian
