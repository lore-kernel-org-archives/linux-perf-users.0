Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1224D8C8
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363317; cv=none; b=Tu1OxDNSBcvBoH82EYWyjGRoxhONwxEwutBOFciiTh/dUDQ7UJ8YrxlLRJ9Perv7SC8iVcuOzHaEFJZ//YzZvs22+dwXt6sFVTgx2O7ItU1PQ6D5hmdc//1fEygoIarQfGRf7/xbuiBJWzCBszRysRXUiemo1ru8Q+dV0bdrg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363317; c=relaxed/simple;
	bh=JyoyHxKQD9Kwr5fcs+xm/CmkChCRExnaujr9I+wRTUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+TNNKZrMBGdPh6uFqkfiFrJT5eNRwPdI46Y+qOa0r7EZDPsCoHSgDgMFx4hD0TfaI/IGBaKbvC6HcFPmFWVEIAsJF76AiLI86pUxv7pZakBmJk+WCX19KzDUmmBVod/FOD77CJKPo3yhmpEra/B++wbfnA90ZHFHv6xcsOOPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMUGnHfj; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMUGnHfj"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a1a662a633so293045ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727363315; x=1727968115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqw39FJ5N7iyzE7OldGM0QX15IjljmEHm7ZyQhjns8Q=;
        b=vMUGnHfjxrwmcmrTIgm2FOPDCTxjMtfuohR/TnruAKyrtv8Yyn6pq9cu2WbxvNpiDi
         z0qJcBjMjJHkgwgcyQv7ZfeANyofQ0P+R+OwvoRz1YGsr//q82GLHIVN6yXhO14UNN2B
         ++/plu8WCFQik5lZRlrHBupHF9e6B00H2o8ujvUP4ljAGoLmQS6Q83FPH7zlG6Dp6hTy
         GX5v7CeBTApiH0yD46hRGCjKGKK/ILFx3VrcE8tiwAJ/kihcUKZEVzXYU1EytviWeQpe
         nWsPW3i+/YdPLayjcj1j6Rtxza/HTEA1gnsunfBZ4hkkN4cXm6UAVsjfSZgzGsha+qkw
         AvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363315; x=1727968115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqw39FJ5N7iyzE7OldGM0QX15IjljmEHm7ZyQhjns8Q=;
        b=OEOrraxMFcq9QyaIYnXWJNdsDinYycSZJxD5v+ybRpFOF7HwgV8Dxoia0DOuDNHNzi
         e3AGFTHraofFYKk1+vrXbKQcl9+QeL9+PiOvM372lqfNEsswvzUVjEpknC7u0OKMlgRb
         u+Jdr6/wWM263IXNxYBue6w3XCd3vDpEPo4kfDXg/5ASTL8YYCeSMuxT8d+vtpFs3+eq
         BeSJYvlQByPStUeFOryRVM/7OqQeeDA3g/rMl3DxDfaXqQ0o7Gfmpj57I0qznUvjmpFV
         E/YxW9f27o4jxWmbJjlkQ//gByvkz6dJvNOwRZI8hqpoRZ5J29v2QAzQAYkjh572nbtP
         45yg==
X-Forwarded-Encrypted: i=1; AJvYcCWTKVv2aTw3um3qxePwK2vSEY3KxqsnWyOMGOlpibbt2ozkTJJzamfAHQ871rGo5OYZxKgexUJvjQTjcs1bQyW+@vger.kernel.org
X-Gm-Message-State: AOJu0YzOK1WAhVH7DxuocatYWDSAdv7O3NKf2ahAnT6KRDS9zPMNJrd+
	AawQ7r3ImJqj+xV+BQ1pqqGnzRhowUlkmcmZsRNCVeTmGwI1kmj9hYnYnh/BO4sm5/C+sCB7pXZ
	k3TSwCI0VlCXlo7gSXDQuXC69R8cGPICtmYuV
X-Google-Smtp-Source: AGHT+IF9qWP9inTYXeDlp/TQlxeWo7WHjsgYEXiJOQnoVVcu9AxstnMs++Fq3OP8K7LV8MxYBc4EhVYOhRFAIdUYH3U=
X-Received: by 2002:a05:6e02:b28:b0:3a0:926a:8d35 with SMTP id
 e9e14a558f8ab-3a31b665b0amr3914595ab.17.1727363314902; Thu, 26 Sep 2024
 08:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-8-irogers@google.com>
 <ZvSrAv_6NUOVWJdD@google.com>
In-Reply-To: <ZvSrAv_6NUOVWJdD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:08:22 -0700
Message-ID: <CAP-5=fWvCoDx66xJhZ+bB0jC4tYOjqZh=jCf+APNg+hGvfyMbA@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] perf probe: Move elfutils support check to libdw check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:14AM -0700, Ian Rogers wrote:
> > The test _ELFUTILS_PREREQ(0, 142) is false for elfutils before
> > 2009-06-13, but that is 15 years ago and very unlikely. Add a test to
> > test-libdw.c and assume the libdw version is at least 0.142 to
> > simplify the build logic.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/build/feature/test-libdw.c | 10 +++++++++-
> >  tools/perf/util/probe-finder.c   |  2 --
> >  tools/perf/util/probe-finder.h   |  2 --
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/tes=
t-libdw.c
> > index 71c6f8e3b0ee..2fb59479ab77 100644
> > --- a/tools/build/feature/test-libdw.c
> > +++ b/tools/build/feature/test-libdw.c
> > @@ -41,8 +41,16 @@ int test_libdw_getcfi(void)
> >       return dwarf_getcfi(dwarf) =3D=3D NULL;
> >  }
> >
> > +int test_elfutils(void)
> > +{
> > +     Dwarf_CFI *cfi =3D NULL;
> > +
> > +     dwarf_cfi_end(cfi);
> > +     return 0;
> > +}
>
> I think it's the same as test_libdw_getcfi() and let's get rid of it.

The point of doing the change this way, and I think what's being
ignored, is that I am trying to simply replace an #if with a clearly
equivalent feature test - clearly equivalent as the #if guards use of
dwarf_cfi_end in the code. Merging test_elfutils with
test_libdw_getcfi is another cognitive step and I think it is fine as
follow up cleanup. Combining that step with the change here fails the
minimal meaningful change and tbh I think this is just bike shedding.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> >  int main(void)
> >  {
> >       return test_libdw() + test_libdw_unwind() + test_libdw_getlocatio=
ns() +
> > -            test_libdw_getcfi();
> > +            test_libdw_getcfi() + test_elfutils();
> >  }
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-fin=
der.c
> > index 78f34fa0c391..7434b38596b9 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1379,10 +1379,8 @@ int debuginfo__find_trace_events(struct debuginf=
o *dbg,
> >       if (ret >=3D 0 && tf.pf.skip_empty_arg)
> >               ret =3D fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> >
> > -#if _ELFUTILS_PREREQ(0, 142)
> >       dwarf_cfi_end(tf.pf.cfi_eh);
> >       dwarf_cfi_end(tf.pf.cfi_dbg);
> > -#endif
> >
> >       if (ret < 0 || tf.ntevs =3D=3D 0) {
> >               for (i =3D 0; i < tf.ntevs; i++)
> > diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-fin=
der.h
> > index 3add5ff516e1..f0149d72310c 100644
> > --- a/tools/perf/util/probe-finder.h
> > +++ b/tools/perf/util/probe-finder.h
> > @@ -63,12 +63,10 @@ struct probe_finder {
> >       struct intlist          *lcache;        /* Line cache for lazy ma=
tch */
> >
> >       /* For variable searching */
> > -#if _ELFUTILS_PREREQ(0, 142)
> >       /* Call Frame Information from .eh_frame */
> >       Dwarf_CFI               *cfi_eh;
> >       /* Call Frame Information from .debug_frame */
> >       Dwarf_CFI               *cfi_dbg;
> > -#endif
> >       Dwarf_Op                *fb_ops;        /* Frame base attribute *=
/
> >       unsigned int            machine;        /* Target machine arch */
> >       struct perf_probe_arg   *pvar;          /* Current target variabl=
e */
> > --
> > 2.46.0.792.g87dc391469-goog
> >
