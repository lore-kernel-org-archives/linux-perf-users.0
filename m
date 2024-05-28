Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF9171676
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909268; cv=none; b=J3qE9/q9PZqdFujgdSei51OyxPHLfIDE8baxIS3G7Ufav5V4/7CLk/lWXNJY/f128EgT6ly7lWT9ZUz1WDBG5T19e0c+LRGMf26y8BBzm1Z3+zTO/VkHObJCW12bH7Fqa5Rw3oVuAmUn3zbgqzIP15Fbo4YuxAA7p/tHd4IUxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909268; c=relaxed/simple;
	bh=7zkV/QiMvzWQFm6NnJjVGe7wPYyMdu52nuGtEcAhgFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff316rANbGc62B4l+5AcQBMGt1s9Y9hlbQVYJJPm7vATIdcrgg92/tgddjIN5D9lGGE5zdmwP1dpjQ+9h59mzWVkMI1lElBl577m7HOUfHQm+NL+Cvwm6k3MGZRv5OaB4+LYByEsz1IF0uRvmOOflNYi8FXcWhp8eUm3Y50os0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZJtQSBg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZJtQSBg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f48e9871e2so353595ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716909267; x=1717514067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOq1EEVKQaCb9aX3l6DWWD7raLtaTMMF6DMvMc5Iem8=;
        b=IZJtQSBgkzsZ/TUscEvr0i50KMg5jxxFv6yBmvYQM2094dGujl12H2iUomqTamFlHm
         Dy5rfTzr9Y7C+K+cd9lhw2IJmV1/ZGpqxwIEh/ySkZg7N5PSGEMWxvVYFwzXraP15IR5
         YnRQvehyf1b5+mZjVz2we5TmR75GlIq5bbiwPD1z4RQCx7l8XeLy67H2fuUrHv7tjJtS
         60+ZDBQapx+YX/46deLXIAuxMx9Ha5W68aBlF1Ss/txf6zIhWI84iIFRq3fy9PT9BQMU
         hNuMCr6MC31liem3JeN57p+fKenZiwZJwKfXnudIEc8O0gWLVWBKbvOOUKMsC2tFvo2C
         QVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909267; x=1717514067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOq1EEVKQaCb9aX3l6DWWD7raLtaTMMF6DMvMc5Iem8=;
        b=T8LWcQVbUFVkUsadQwWjiV8U1DLxau1S5B6GIkJAX6Jc7/utuYHWUCEK+daPtjBITx
         nZEypSEj/h5DqEH/lFfi6rtb5Xjw9kD5dR6p6mIE2z/BZHzkEFVh3xFAPtrA16KOFOmp
         gBscTxjytlEzCVMXq0E45GQ88G5OzyFgHk80cBrs2eUtYz7h5B/Kj616gu6bryR2QBZF
         4Ja6KiYG9zymnGmL7UIKzYK+WBSt2VNPbbVkeYgTDku4+j/UXv7nJYzGSXStU66sRpAm
         KdSGn0x7dCRQyP7EpFsS10ZxDgzdysXysVh4AyA8pqIUHcJJlyTHdcVmVMvw3m2uhNSW
         4m3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXwDlE3h+wBuf6XanIP08OtbYurY2qrBYOCBx4zj37d83QxrWUhX44jn9AxisEy/SQoW8rZjclTDB+cfEX2UQjLhiV6fySskDnAb/FfK7UCQ==
X-Gm-Message-State: AOJu0YxjHlm9Iv+vr7uQb6rAw2AzT2q87gntiknWFjdkemunRYyN0KB4
	mVYmpsSGbGu8eEcWm489eZ96AlZa1qs5o1D/ivYBUdoM75NbugsotErlogU+SSZWr7J31AlXsdQ
	cWmPB3FTeACVDg2ySVMqUgOlIL9NQNmfkmwQm
X-Google-Smtp-Source: AGHT+IEha5xjBFdu0Tm0od9AENlIKbc0aQju8WJYZG0W/5COt2X+dDeelI/K8FDkd466ZllWl3keQuk7t4jcOuUKAfE=
X-Received: by 2002:a17:902:c3cd:b0:1ea:2838:e599 with SMTP id
 d9443c01a7336-1f4693f832dmr5209955ad.17.1716909266517; Tue, 28 May 2024
 08:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-1-irogers@google.com> <20240525013021.436430-2-irogers@google.com>
 <a173525f-33a9-43ee-8b03-a277810025fc@oracle.com>
In-Reply-To: <a173525f-33a9-43ee-8b03-a277810025fc@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 08:14:14 -0700
Message-ID: <CAP-5=fXXhmQNSP1aRzT7Kd27vx60HQ+0PjL91c9Jq-zufthfQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: John Garry <john.g.garry@oracle.com>
Cc: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:01=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 25/05/2024 02:30, Ian Rogers wrote:
> > empty-pmu-events.c exists so that builds may occur without python
> > being installed on a system. > Manually updating empty-pmu-events.c to
> > be in sync with jevents.py is a pain, let's use jevents.py to generate
> > empty-pmu-events.c.
> >
> > 1) change jevents.py so that an arch and model of none cause
> >     generation of a pmu-events.c without any json. Add a SPDX and
> >     autogenerated warning to the start of the file.
> >
> > 2) change Build so that if a generated pmu-events.c for arch none and
> >     model none doesn't match empty-pmu-events.c the build fails with a
> >     cat of the differences. Update Makefile.perf to clean up the files
> >     used for this.
> >
> > 3) update empty-pmu-events.c to match the output of jevents.py with
> >     arch and mode of none.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks!

> > ---
> >   tools/perf/Makefile.perf                 |   2 +
> >   tools/perf/pmu-events/Build              |  12 +-
> >   tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++--------=
-
> >   tools/perf/pmu-events/jevents.py         |   6 +-
> >   4 files changed, 562 insertions(+), 352 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.per
>
> ...
>
> > -     },
> > +struct pmu_table_entry {
> > +        const struct compact_pmu_event *entries;
> > +        uint32_t num_entries;
> > +        struct compact_pmu_event pmu_name;
> > +};
> > +
> > +static const char *const big_c_string =3D
> > +/* offset=3D0 */ "default_core\000"
> > +/* offset=3D13 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000"
> > +/* offset=3D72 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000"
>
> Please remind me: how to figure out this number when adding a new entry?

So this shouldn't be generated by hand. The old one was, this one is
created by jevents.py as maintaining something by hand is a pain. If
you need to add entries then they are in the
`tools/perf/pmu-events/arch/test/` directory. When you build with
NO_JEVENTS=3D1 then this file will be used. When building normally
jevents.py will be used and used to check that the empty-pmu-events.c
isn't out-of-date - the build will break if it is. The fix is just to
copy `test-empty-pmu-events.c` to `empty-pmu-events.c`, which is
hopefully implied by the result of the diff being shown.

Thanks,
Ian

> > +/* offset=3D131 */ "l3_cache_rd\000cache\000L3 cache access, read\000e=
vent=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"
