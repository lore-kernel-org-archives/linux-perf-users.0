Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCC12C544
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596890; cv=none; b=BdsJjTFp4CY+dVXKEDuOvEui3jRduKQA8+iIAu89oNsjsSEyZHU/klBD4FpJ5iy/1GLNwjqqw+isMht0eUpLPcrCvE8X8VNf1C2FvXUrZnl4BQrPJZhLeK5/Cq1lRGr44qoyh5yQVPcdF/3EJGKZSXMWp7OsH/Ke+fGxp5tbpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596890; c=relaxed/simple;
	bh=NM8corU8iG3XSLf0jLK81K8WAxwZt1U/2PMRRRV5dg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJavKeWEe4vm2b0BtCcwRAFO5cguGBhxjxb1uHc8L0dl0kKXJPQyQHRPbz1Nl6CkMEhcdl+VkjsBgXMA+Bl4YA4W7YKQrvJXbs94vTeEPAzD31alJIUs2g/qS9ggkfeGE4i7utoag4ERTJuG0CnA9pxHBUIZqnYwqh3A0jkok/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSKEvCe8; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSKEvCe8"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d5bc35ed3aso220805ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745596888; x=1746201688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4Q5enwWy2Bh63PX2HWpj7DvEc9JEml5VEzzEfbUzYM=;
        b=aSKEvCe8RVmWpaC6iTJpgnCvgKAmWffDCUb8i893jo326z1TGqVb8STmeAXpQN9bUJ
         jx6v5Nf4QA7YCa79cJWKuUqj3/cgKZ6xYDLV0ktoGboewwBkEJunSE1opAfPZPLS7Vct
         bBQozQFIhNrLp0In568c7AVSy2IFMFdWWSolPTQvT1AATSXJXOKkWNsgYAlEOGR5NYmz
         +AAnY+wZi3EFXdGbdw0qPLJ0gU6n39ZjUUJr8wIlJFEXBIzFCRb/pJTJBNNr9KpB8Tbi
         TRz2GrsYjtK5lK01aUXbYKuZ0z8tGSPnocR/eFdvweEd/HiY2fu/tYcWDSfKPurO1Kg0
         RnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596888; x=1746201688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4Q5enwWy2Bh63PX2HWpj7DvEc9JEml5VEzzEfbUzYM=;
        b=kpwT7hFDG6LEFG17ZA0wOIUEf5vdBVWPecgfTvrAOebBZ8aFhpPU7azrkV8e3r204+
         GOLgP2Kn8/VU/rii8+XJ0pXTQk427riQT5OOSvuxpf8vYbCScPTlImnWQYH3BrFtX387
         MdKaI0yrT1Hen1SeGw8XofZ7c2/toYUGUH7tE04U9oswlwfunxYMNfve5P5T6kkqdYka
         +NMnhLfl7w3BCIYwMATEFsng28ZkLC+LB2LOnQNCdVIlxbAJtmVgvZbOsSDiwLVC9+o+
         SBAWk5aGQrJ+WWLIaDxAUPpu0T4smlmZJKYpM2lazSAh73WBQlsu7TrcPaS2Sd/DQNU7
         rldA==
X-Forwarded-Encrypted: i=1; AJvYcCUt59bVtBpVN8EwzZgfItKsvOHpBTcZ1GzTm37Hp8m1uBiA6+sM0htKQM9vJ/ETO9537dmT7r+Jp34F4RcZTrjJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+gILnmOpnDw4ADfzzu1O8gJKfy35b02fU9CneGKJ2T8l+byj+
	qF98JY0FRabsARgdEURi4gGXjw7zwS9KIHqrapItDjXZeGlZPihquIUoqRnAp3VeQN7d3XPBM1V
	SgIqgGHl3tchSuof9Nun7LwiP1gnyZig5HnYu
X-Gm-Gg: ASbGncvDBvA7mYSL7/utAQ3oek+0juFvjrt3EWP9WAttiLxpuJSHPRMGSU1n+tghdZ8
	Jw3MW8au+i9pdxfYUpxWlyM+9VVmkZREM62SYBoYP5l9tm9L7Kfs285XSxwMEoHutWtgv1ZQG9p
	vN1azhwMriA2wXN7Akcn6Vihw=
X-Google-Smtp-Source: AGHT+IH3aEe2XhyQ8kQeASDAcTJLkKqPyqPR9OvyFpipcyath5p0woO8oV98VdbziVnpYPoTM8/N3ge+6eljADCuHI4=
X-Received: by 2002:a05:6e02:1a2f:b0:3d2:b23f:a1e0 with SMTP id
 e9e14a558f8ab-3d93982329emr3740865ab.16.1745596887809; Fri, 25 Apr 2025
 09:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424195831.1767457-1-irogers@google.com> <20250424195831.1767457-3-irogers@google.com>
 <aAumWUWXB05qLez6@x1>
In-Reply-To: <aAumWUWXB05qLez6@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Apr 2025 09:01:15 -0700
X-Gm-Features: ATxdqUFawm7sW-e1SCW6vhRWPwY3DGm8LO4BtVMxeRdcSpC5bUntlT1ZcNSG0lk
Message-ID: <CAP-5=fU-+r8VcGPXGYmzei=S6-Uqqy2Y77eVK89q6fEBHSyEEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] perf jitdump: Directly mark the jitdump DSO
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	James Clark <james.clark@linaro.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:12=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Apr 24, 2025 at 12:58:25PM -0700, Ian Rogers wrote:
> > The DSO being generated was being accessed through a thread's maps,
> > this is unnecessary as the dso can just be directly found. This avoids
> > problems with passing a NULL evsel which may be inspected to determine
> > properties of a callchain when using the buildid DSO marking code.
>
> And this patch had to be moved after:
>
> "perf dso: Move build_id to dso_id"
>
> As it uses fields that were introduced there.

Sorry for that, my mistake.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/jitdump.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > index 624964f01b5f..b062b1f234b6 100644
> > --- a/tools/perf/util/jitdump.c
> > +++ b/tools/perf/util/jitdump.c
> > @@ -14,9 +14,9 @@
> >  #include <sys/mman.h>
> >  #include <linux/stringify.h>
> >
> > -#include "build-id.h"
> >  #include "event.h"
> >  #include "debug.h"
> > +#include "dso.h"
> >  #include "evlist.h"
> >  #include "namespaces.h"
> >  #include "symbol.h"
> > @@ -531,9 +531,22 @@ static int jit_repipe_code_load(struct jit_buf_des=
c *jd, union jr_entry *jr)
> >       /*
> >        * mark dso as use to generate buildid in the header
> >        */
> > -     if (!ret)
> > -             build_id__mark_dso_hit(tool, event, &sample, NULL, jd->ma=
chine);
> > -
> > +     if (!ret) {
> > +             struct dso_id dso_id =3D {
> > +                     {
> > +                             .maj =3D event->mmap2.maj,
> > +                             .min =3D event->mmap2.min,
> > +                             .ino =3D event->mmap2.ino,
> > +                             .ino_generation =3D event->mmap2.ino_gene=
ration,
> > +                     },
> > +                     .mmap2_valid =3D true,
> > +                     .mmap2_ino_generation_valid =3D true,
> > +             };
> > +             struct dso *dso =3D machine__findnew_dso_id(jd->machine, =
filename, &dso_id);
> > +
> > +             if (dso)
> > +                     dso__set_hit(dso);
> > +     }
> >  out:
> >       perf_sample__exit(&sample);
> >       free(event);
> > --
> > 2.49.0.850.g28803427d3-goog
