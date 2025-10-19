Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D39221F2F
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760856650; cv=none; b=EBGmHcFaydXc9tZZ592RseenClTUj6gvXBNjBdtTr5IqBq7pdgQ/3vEi5bTp8+UqsQCde6y81VdSB/HB8oyIbLHW8lonQByMRmuVaoPTSccQEMJEqREn+sUuULOUmlG6HD/ySkSv8h/6HQ+RSNnGXeBu2DT4CWfuM+DLT79u8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760856650; c=relaxed/simple;
	bh=1lodjNJ9Ek6ngeCfRkksgVPFQSfWNwPjyu77UdFn6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tg9llHu+87u9a2A69UctQpxEaHZBoY9WxwLWkEHujBkVcwRlPN/hrVplDtn0a2N3fSqm8XKnnbnpNBs2KRRQ9lxKKTWoP8mjtUj3u618JpgLk/J4yBeA6hOF/wiA9RBHL9pyrzd0EEYOwNBgPVuOTqH++C0DckHjX3VlVZopzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbiKJwY7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbiKJwY7"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7960d69f14bso29006966d6.2
        for <linux-perf-users@vger.kernel.org>; Sat, 18 Oct 2025 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760856646; x=1761461446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDmF9mCsRe+/orhrJpq4zaFbeDKWdgz9gWT21V8JpDg=;
        b=BbiKJwY7hUC8xFNM0LNKG+tyvcb/JqZ4WzyF+Ba7GeD3kx6SInaij9X36Qcg1VdOvR
         BP0drj8UKCwO2LmJaU50ur+iclU91DUGtvLgkYRlvZa4KtH+E1ZHMEIQrrSUoQd2eKik
         Z3qpIGkGVoc+AXJyAR1yEzxlFCcAJM9NPCi2QRtHcO3iBlRvRYOZDx3pzZO64ZVJJHBZ
         4alT06nVhNLiYW8eAEhFId4conBH0tQvbY/LMueuD3ruSE7d/IPbMgiC4MhOLWFmw3Lp
         ke+11gAmoLqN2T+zxbOC+GKmLSQQbd12v6vCx/8DBW4xs205MK0ATVCaBdxTPpnuBp1G
         v/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760856646; x=1761461446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDmF9mCsRe+/orhrJpq4zaFbeDKWdgz9gWT21V8JpDg=;
        b=UQMccoKiJ3hRX71CSkDv6rKRMJ17SWWeY4Q7DSG+RRvcyJtVQfYFDfnxiLWYf9K/Tm
         AVfvp/83uO5g8sf/aFN9gsqoUjjNRKAx0+u/dg4Art+yRox1rJS5mVrBc9F6OPuDpn7c
         gASiVOkeHIcit+qFpuCeUG7Y3LbJd9FTfL7zJyEzRe18E/uOmd1n6cklGzb01afHK5ZB
         SqjKJFqKMLIwivuwJNN+HptLtVn6F8u8TyToj+Xvg+pFTVtEDtnvfsWLl5JiXcjGdv8u
         5rA9ZPbqtdEq9t8BCNoNy/P55hgC+Os+TbPJQ2uc9Dco4D2kObweknPd5q6PLV5K1hkj
         89ag==
X-Forwarded-Encrypted: i=1; AJvYcCXjfEPoLmiNM7CZKrR8HWXtTmk3bqXW/gaeOGnFiBhoax+TdLSmB3K9uhyr0qXxVsV8ve14XEni5svuV9yUlMqj@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbGuJzJIUgi3t9XUw5B/MTQTLMH52TzTVofvpTY1A7vFkf3PQ
	Z81s7/chfEJ+Z2y4qhdzEHNvzVI3Gzkun6eCljrBKZaoMD5ZfOKCSL2xy5gOAJr7VD30WWAtC9p
	KUrDYdTmrwL/VKYTbH5G60Lc2/mUMeqk=
X-Gm-Gg: ASbGncuIUnKejouKamHsrLc7dle3cPItqJCtcl3oHyg51J5m799ehDMTOlH/c08TzLG
	6vDej+NaAXxFO8CyyTW0LI09/aveP9Fpi13h9DOgMxVod4Zn/TbRGkFztoTUgcI5QfB2tN2N1sY
	dlU5oqYfBDdXWbEV1FY7MJ1UNeDOnpeNDM8w7ALKjgKN25C99G6QyZwdKbnA9KH15oXyMjrYy8m
	mD+pNUTuAUEoCm13d8b04uYb+y1dg+y7sTGaA/xCqCodfBeYee6heGgaPDkNYbNCIoIaA==
X-Google-Smtp-Source: AGHT+IEt5bL2PcGYOYONXJi4ns4YMSAsym6wWvejiLT7LX5IhL6HhqBCB/b7LCit93xy+9OOIg4Wy3uDx9Pgyf/kHaQ=
X-Received: by 2002:ad4:5e88:0:b0:786:2d5e:fdf1 with SMTP id
 6a1803df08f44-87c2054aef1mr141871656d6.2.1760856646293; Sat, 18 Oct 2025
 23:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222228.2926870-1-irogers@google.com> <aPRTQLcOBtHiTGms@google.com>
In-Reply-To: <aPRTQLcOBtHiTGms@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 18 Oct 2025 23:50:35 -0700
X-Gm-Features: AS18NWDFYnve9mYzqBDbDeR0ITEVqQiRu_NlyXjXqlKYXvzOaOkWEbrHH9ylBrU
Message-ID: <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Sat, Oct 18, 2025 at 7:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Oct 16, 2025 at 03:22:26PM -0700, Ian Rogers wrote:
> > Unsupported legacy events are flagged as deprecated. Don't display
> > these events in ilist as they won't open and there are over 1,000
> > legacy cache events.
>
> Off-topic, any chance to integrate this into a perf command?
> It'd be convenient if we can call this like `perf list --interactive`
> or some other way.

You have my vote, user-friendliness is important.
I think Ian mentioned that the major drawback is the difficulty of
forwarding arguments passed to the ilist.py program. A random thought:
perf is known for binding everything under a single command, but to
make scripting more flexible, perhaps some Bash scripts added to
.bashrc could be considered. After all, perf is fundamentally a
command-line tool.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/python/ilist.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > index 9d6465c60df3..69005a88872e 100755
> > --- a/tools/perf/python/ilist.py
> > +++ b/tools/perf/python/ilist.py
> > @@ -439,6 +439,8 @@ class IListApp(App):
> >                  pmu_node =3D pmus.add(pmu_name)
> >                  try:
> >                      for event in sorted(pmu.events(), key=3Dlambda x: =
x["name"]):
> > +                        if "deprecated" in event:
> > +                            continue
> >                          if "name" in event:
> >                              e =3D event["name"].lower()
> >                              if "alias" in event:
> > --
> > 2.51.0.858.gf9c4a03a3a-goog
> >
