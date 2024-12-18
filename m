Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F2BE6C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483346; cv=none; b=PH7X0DlXaiylc0VUq5DroZ1vsmK1PPfEf+brv+in9G1fuuG9mDDDS4/x+8iA28fNGSOajC3iS3pN/ani5J2sZtwpD5vGfIUC870LlXFHEnOzIX0fFYY8E6pU2q3RAK7xZlkfU6KsKmiDBxDyEOzo7s+Rkpt6okhCl6IyOSUi/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483346; c=relaxed/simple;
	bh=Qn6U2asXnY8pkOcu/aPxAShVMCIs/vf/ioNa+e+YFgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNGMo2V0+X/Xj8abKLxpBUUYujjPrJQlY2xr+V2657NHTmZSlj8tQ43GXYY1EbMc1snSsdVLAQjP6EpvI7K2QSgZ5lKGL0OB4CdQIQZOzD4mYvIaBG7+VWj0lQQ/FFbA50GN+P++DxVZ+83SZaAnXgqcCPhZ3dwjhY0h8n1ldf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=neL+7bVZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neL+7bVZ"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a814c54742so38145ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 16:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734483343; x=1735088143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA5AofWr5GSYflF6+I3hbm4qPSjZIXYxDpZkR0xiDPk=;
        b=neL+7bVZNYzrhX4gI5iWhQk6HltzXhdk0vsmc3svfgg9xBpcpENAkWvX0FfU3gvGzp
         5aYhSGCS3ga/HCM+yxjWA93JnPfk3opI3yHKaSsakFkOhBUOI/ca2EoW8pcpHGD/b9mE
         QkO4tfEvx0eO9bJ9oyEJ4gF39C1k5kWEelMhNRHyYGBiw7PkyGi7fVjq3NPWGSWSEwtR
         cBbfrvi05FPxn1MoI7RlobfIifHSzAN1BG5/8atpufFi8Sd4w5EywZ8igL4vFXMNmpGY
         wod55rQ+kR9TqSprZwnbdV9dmpMW1IvHrDk+QuFDQE3oiEx1W2VSXJNtjALonvn2LRbV
         +eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483343; x=1735088143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA5AofWr5GSYflF6+I3hbm4qPSjZIXYxDpZkR0xiDPk=;
        b=Mo7sdHs/Rf2wSu4bhd7rjn53wwAzDuLN5uMyJSg2joL08wzhEDqMHwd29JMEWi/ayf
         Gg7VTmFoXWilsqKQpy4kakhCBKJTgR38B5KdtIgC0baHS15Aso9yO4XZowuJlZghi3fp
         LKMwvFJirAG/HNZKRekSxxPflyAfdD3Ge5xw67dnZsKGijb7Picp+muQTqvX3lb2uh/R
         95L5tviqKZWL1M8atMtaKQiFRpGRHMK046kmSiRiXRIoBUfINGOWY7KrUk0VF2kYH8vG
         bH2o8eiASn+Omnqx6cm0ecQvc4CCI0o4p5f6nm/NkGGBz6haEmQUGVg17PvZ+q1cZLoO
         3vgw==
X-Forwarded-Encrypted: i=1; AJvYcCXdWPfFWA7yrdJqs+lxKdQYQYiA+1yJY6Rtb19POGl6uvc3JNoa+5GtHV3lB7sq2YihU7QjOD5xvy99oSf1tW9v@vger.kernel.org
X-Gm-Message-State: AOJu0YxMaC+qpS6337+DzXJg1Rx/jfU44ZJdMyZBmFwg0VyFI0/8OHSJ
	8NiPivIwD8uq2CY3rZ+Gb9BLJU6K2baf9Cl0kIwrERQVF2pX3ks56g72TkKXVkPiB2/EI7aDvln
	Ayze9ulrn3lTIBOcSHS71I9LV59kZ0CvzO09w
X-Gm-Gg: ASbGncs62JtolxBFD1EwuL0ri83lxllrvGtZLu2pRQ4His2VJ+kShB7yFpLkKwr5Omh
	YiF3zRhxdDIqZs77bRPaFFgrk4nAxy4PqW77T2bE=
X-Google-Smtp-Source: AGHT+IHwkmkKSwBW1bBsKvRuQE7csGF2fmrEZdMaG0n2s2039ybngebg2ODDRWHlQCtACc0FmnNxrqqX7i0nPNraaJI=
X-Received: by 2002:a05:6e02:1d0f:b0:3a7:e616:8d36 with SMTP id
 e9e14a558f8ab-3be373b3533mr388085ab.9.1734483342525; Tue, 17 Dec 2024
 16:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com> <Z2IXl5cuKQJInJb0@ghost>
In-Reply-To: <Z2IXl5cuKQJInJb0@ghost>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Dec 2024 16:55:31 -0800
Message-ID: <CAP-5=fW9wKgBN7vn6gK98iNjt6TpbGV1qhCv_qup_30iQP+o3g@mail.gmail.com>
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:30=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > On Tue, Dec 17, 2024 at 3:52=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > After binutils commit e43d876 which was first included in binutils 2.=
41,
> > > riscv no longer supports dumping in the middle of instructions. Incre=
ase
> > > the objdump window by 2-bytes to ensure that any instruction that sit=
s
> > > on the boundary of the specified stop-address is not cut in half.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > > ---
> > > A binutils patch has been sent as well to fix this in objdump [1].
> > >
> > > Link:
> > > https://sourceware.org/pipermail/binutils/2024-December/138139.html [=
1]
> > > ---
> > > Changes in v2:
> > > - Do objdump version detection at runtime (Ian)
> > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_r=
eading-v1-0-b75962660a9b@rivosinc.com
> > > ---
> > >  tools/perf/tests/code-reading.c | 84 +++++++++++++++++++++++++++++++=
+++++++++-
> > >  1 file changed, 83 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-=
reading.c
> > > index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..7e24d10a543ac18ac2be7=
0b829d088874e0edfd5 100644
> > > --- a/tools/perf/tests/code-reading.c
> > > +++ b/tools/perf/tests/code-reading.c
> > > @@ -1,5 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <errno.h>
> > > +#include <linux/kconfig.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/types.h>
> > >  #include <inttypes.h>
> > > @@ -176,6 +177,66 @@ static int read_objdump_output(FILE *f, void *bu=
f, size_t *len, u64 start_addr)
> > >         return err;
> > >  }
> > >
> > > +/*
> > > + * Only gets GNU objdump version. Returns 0 for llvm-objdump.
> > > + */
> > > +static int objdump_version(void)
> > > +{
> > > +       size_t line_len;
> > > +       char cmd[PATH_MAX * 2];
> > > +       char *line =3D NULL;
> > > +       const char *fmt;
> > > +       FILE *f;
> > > +       int ret;
> > > +
> > > +       int version_tmp, version_num =3D 0;
> > > +       char *version =3D 0, *token;
> > > +
> > > +       fmt =3D "%s --version";
> > > +       ret =3D snprintf(cmd, sizeof(cmd), fmt, test_objdump_path);
> > > +       if (ret <=3D 0 || (size_t)ret >=3D sizeof(cmd))
> > > +               return -1;
> > > +       /* Ignore objdump errors */
> > > +       strcat(cmd, " 2>/dev/null");
> > > +       f =3D popen(cmd, "r");
> > > +       if (!f) {
> > > +               pr_debug("popen failed\n");
> > > +               return -1;
> > > +       }
> > > +       /* Get first line of objdump --version output */
> > > +       ret =3D getline(&line, &line_len, f);
> > > +       pclose(f);
> > > +       if (ret < 0) {
> > > +               pr_debug("getline failed\n");
> > > +               return -1;
> > > +       }
> > > +
> > > +       token =3D strsep(&line, " ");
> > > +       if (token !=3D NULL && !strcmp(token, "GNU")) {
> > > +               // version is last part of first line of objdump --ve=
rsion output.
> > > +               while ((token =3D strsep(&line, " ")))
> > > +                       version =3D token;
> > > +
> > > +               // Convert version into a format we can compare with
> > > +               token =3D strsep(&version, ".");
> > > +               version_num =3D atoi(token);
> > > +               if (version_num)
> > > +                       version_num *=3D 10000;
> > > +
> > > +               token =3D strsep(&version, ".");
> > > +               version_tmp =3D atoi(token);
> > > +               if (token)
> > > +                       version_num +=3D version_tmp * 100;
> > > +
> > > +               token =3D strsep(&version, ".");
> > > +               version_tmp =3D atoi(token);
> > > +               if (token)
> > > +                       version_num +=3D version_tmp;
> > > +       }
> > > +
> > > +       return version_num;
> > > +}
> > > +
> > >  static int read_via_objdump(const char *filename, u64 addr, void *bu=
f,
> > >                             size_t len)
> > >  {
> > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename=
, u64 addr, void *buf,
> > >         const char *fmt;
> > >         FILE *f;
> > >         int ret;
> > > +       u64 stop_address =3D addr + len;
> > > +
> > > +       if (IS_ENABLED(__riscv)) {
> >
> > Not sure if there is a consistency issue here. Elsewhere we're just
> > using ifdef, such as:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n69
>
> I don't have any strong feelings about that. I can change it to be an
> ifdef. On other lists I have been told to use IS_ENABLED whenever
> possible, but it's only a small difference.

Agreed. Let's see what Arnaldo and Namhyung think.

Thanks,
Ian
