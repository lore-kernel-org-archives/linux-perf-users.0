Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F4A29;
	Fri, 24 Jan 2025 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693039; cv=none; b=TzsGwPw7X2Txnk9zqqNrOe0Dmm1Dd0hGP+EJIGU2TcYw8Ne+rtFCBC3irRO0/z+Lg2wtSVYapSYBDtDdqVJahf8ZrK3XQpxK+jqIfQFt+d7FWJ7xei6u4tAqwxDr2WeGjxGktTtenXlZdd/Jv69frYkpWk4TQZUNV5MdefVIKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693039; c=relaxed/simple;
	bh=xWKBCJ4/F+C4iPpN41/rfGAftSrlHoSrBjTz1DBlqAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHPWe7MPDNDTgFJJc18lhWtkDi04hzJKIeHjc/86xzgzOE5uRnoYqkiSzZAdIQh0PMZlKfKVOF6yY09u5JbIBZvhAvsgCfRzCju6ta1pWAIGVhBhyrAi4Npt4As7kJWBjZISpSorPrpme9DfXU8ow1f8OyYoUzJZG96cC5tOzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpmLK9CK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpmLK9CK"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e573136107bso2875000276.3;
        Thu, 23 Jan 2025 20:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737693036; x=1738297836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ3141s7bYtALogaTO8fTKNutJIlVaw7DyLO73zGOZY=;
        b=bpmLK9CKYemhXG4mqk7m+QNtLk0iglZrG75durrnPU1+jvdE7MLnAWZ0XPy1mGVO50
         ro5sU2zfF/nCKLWdHP4FPZ9rfAjbD53fFg1Rg3RYP6dfbwXQblhMYBBkFzvxvQzwAoYD
         I8QdBpEKG47QfZghHtuNRD72Us+Al587Byom1/Zqd48CyPIEv9KP5YSTtQvgKBGdEXGt
         BMiJvnvFZy90jdOBjGgZlZz2NRS/NjG/0wFpiSLKx9zf4HvcEjZN/M+oJxkmubPPcbip
         AwycmhKlQS0v7Rrv6tv1WYwz7eWz0611GYvlF1eKTyzzjSiDFav3LECnZXNny7lA2shg
         BaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737693036; x=1738297836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ3141s7bYtALogaTO8fTKNutJIlVaw7DyLO73zGOZY=;
        b=JkLP0T3F2yUGGtV/AG8YhaQ8LGUUqjQInl1/pbv4fJ/EF8oKWSC9IrTd3mvHgJT62G
         7VnXqmTH+cXvrorNlwWqcC0FUObxoD54ryMNLpOt0QXHFXQIfvucgxH6Gl4DEJAeoZ9z
         YdF+Y+mBcpeC/7By53pNCWLsdPLyuz65w5Lb+jDYXyoDDrtIZX7Y5cPQ0TQYBYrSqHWk
         0Eyn5WtuENTD+3P8DsXMTQzhgso25UfnowzWAWQgSdqrJiJbqZs+Yp9XYi9+Jy0aHzxY
         JA2xCLaBZWIoCFQpIPWLy0xgujhjN4WnseoW/C8rOckSbmuS0s9trpIcpYTBdk0fvCqS
         dvrg==
X-Forwarded-Encrypted: i=1; AJvYcCUkHOjszrGsM4410he8FZ6itDcG174trWIkVqONdUuKDGj5VaY7WlzLlm1L8V0cVwRCyoL+25An7hhd1eU=@vger.kernel.org, AJvYcCV4vmz7P9yo0+0DUH1rb2Rnp3wD7nwyncTX0dqx3eVKQiDpk6V5JzfCxxu+luqKOS/9b6RphEGPsJLnDXSy+v0JYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yT2c5IajLD0cnz4Wug1SrPecQXaJZiCw8SONB1xhqyLLyP3t
	RzQRyPIA7opJDR2il2iuSmBp9cDhl4avbnijhWtFBC23ziEO5vQ2TJ9nLzNAmrs//e4t8mQnpjn
	Pe1Ne++IJ1j9Hmk7oOU3WFpJ/95PgNKWZznc=
X-Gm-Gg: ASbGncuFIsHL6MKRlwxoaloDqtGFcYR2kBQugGVt/evtE4G2fZAf473N7UXstDHs3Bx
	tG388c5M3VekmCjsVTeGRffkD6pJVbcae2WIbT6JR/8gbO41LGSWYloNCCNTfMHARG4tAwEI=
X-Google-Smtp-Source: AGHT+IGcx0pGF7eli/nANUqU/IXnbiVeCtGpBZFEEMKHHxXD6rvkZG1Trzk76S2oImmPMArhnvO2AxU50Gn7F9Puzjw=
X-Received: by 2002:a81:f20e:0:b0:6ef:7d51:eba6 with SMTP id
 00721157ae682-6f6eb90d669mr181057947b3.28.1737693036556; Thu, 23 Jan 2025
 20:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122025519.361873-1-howardchu95@gmail.com> <Z5FC47bfDAPu75-e@google.com>
In-Reply-To: <Z5FC47bfDAPu75-e@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 23 Jan 2025 20:30:25 -0800
X-Gm-Features: AWEUYZmVBJAKMwhPsvIuxZw23nAcNMiu3c4JL7EXZoRLoOBN4UO0IkmwFWpYfDc
Message-ID: <CAH0uvog74tVNjKXZdu+pvg-7CnsuVugEb-XpF6Xcqzc9jzWSAw@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix runtime error of index out of bounds
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello again,

On Wed, Jan 22, 2025 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Jan 21, 2025 at 06:55:19PM -0800, Howard Chu wrote:
> > libtraceevent parses and returns an array of argument fields, sometimes
> > larger than RAW_SYSCALL_ARGS_NUM (6) because it includes "__syscall_nr"=
,
> > idx will traverse to index 6 (7th element) whereas sc->fmt->arg holds 6
> > elements max, creating an out-of-bounds access. This runtime error is
> > found by UBsan. The error message:
>
> I'm curious how I miss this.  Is this only for some specific syscalls or
> always happening?  Do you which commit introduced this?

Forgot to mention the commit: it is (5e58fcfaf4c6: 'perf trace: Allow
allocating sc->arg_fmt even without the syscall tracepoint') that
introduced the bug. However, I wasn't able to build the perf tool at
this commit because it dates back to 2017, so I couldn=E2=80=99t bisect and
test it.

As for the runtime error, it occurs with the first 6-argument syscall
that calls the syscall__alloc_arg_fmts() function and causes the
out-of-bounds access. That=E2=80=99s going to be the futex syscall. If I sk=
ip
the futex syscall, mmap is next.

static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)

** the 'nr_args' passed in can be 7

{
        int idx;

        if (nr_args =3D=3D RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_a=
rgs !=3D 0)
                nr_args =3D sc->fmt->nr_args;

        sc->arg_fmt =3D calloc(nr_args, sizeof(*sc->arg_fmt));

        ** arg_fmt has 7 elements

        if (sc->arg_fmt =3D=3D NULL)
                return -1;

        for (idx =3D 0; idx < nr_args; ++idx) {

                ** idx can be 6 (7th element), legal access for sc->arg_fmt
                ** but not for sc->fmt->arg, length of 6

                if (sc->fmt)
                        sc->arg_fmt[idx] =3D sc->fmt->arg[idx];
        }

        sc->nr_args =3D nr_args;
        return 0;
}

Thanks,
Howard


On Wed, Jan 22, 2025 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Jan 21, 2025 at 06:55:19PM -0800, Howard Chu wrote:
> > libtraceevent parses and returns an array of argument fields, sometimes
> > larger than RAW_SYSCALL_ARGS_NUM (6) because it includes "__syscall_nr"=
,
> > idx will traverse to index 6 (7th element) whereas sc->fmt->arg holds 6
> > elements max, creating an out-of-bounds access. This runtime error is
> > found by UBsan. The error message:
>
> I'm curious how I miss this.  Is this only for some specific syscalls or
> always happening?  Do you which commit introduced this?
>
> Thanks,
> Namhyung
>
> >
> > perf $ sudo UBSAN_OPTIONS=3Dprint_stacktrace=3D1 ./perf trace -a --max-=
events=3D1
> > builtin-trace.c:1966:35: runtime error: index 6 out of bounds for type =
'syscall_arg_fmt [6]'
> >     #0 0x5c04956be5fe in syscall__alloc_arg_fmts /home/howard/hw/linux-=
perf/tools/perf/builtin-trace.c:1966
> >     #1 0x5c04956c0510 in trace__read_syscall_info /home/howard/hw/linux=
-perf/tools/perf/builtin-trace.c:2110
> >     #2 0x5c04956c372b in trace__syscall_info /home/howard/hw/linux-perf=
/tools/perf/builtin-trace.c:2436
> >     #3 0x5c04956d2f39 in trace__init_syscalls_bpf_prog_array_maps /home=
/howard/hw/linux-perf/tools/perf/builtin-trace.c:3897
> >     #4 0x5c04956d6d25 in trace__run /home/howard/hw/linux-perf/tools/pe=
rf/builtin-trace.c:4335
> >     #5 0x5c04956e112e in cmd_trace /home/howard/hw/linux-perf/tools/per=
f/builtin-trace.c:5502
> >     #6 0x5c04956eda7d in run_builtin /home/howard/hw/linux-perf/tools/p=
erf/perf.c:351
> >     #7 0x5c04956ee0a8 in handle_internal_command /home/howard/hw/linux-=
perf/tools/perf/perf.c:404
> >     #8 0x5c04956ee37f in run_argv /home/howard/hw/linux-perf/tools/perf=
/perf.c:448
> >     #9 0x5c04956ee8e9 in main /home/howard/hw/linux-perf/tools/perf/per=
f.c:556
> >     #10 0x79eb3622a3b7 in __libc_start_call_main ../sysdeps/nptl/libc_s=
tart_call_main.h:58
> >     #11 0x79eb3622a47a in __libc_start_main_impl ../csu/libc-start.c:36=
0
> >     #12 0x5c04955422d4 in _start (/home/howard/hw/linux-perf/tools/perf=
/perf+0x4e02d4) (BuildId: 5b6cab2d59e96a4341741765ad6914a4d784dbc6)
> >
> >      0.000 ( 0.014 ms): Chrome_ChildIO/117244 write(fd: 238, buf: !, co=
unt: 1)                                      =3D 1
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index d7c7d29291fb..8d3260bad10a 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2108,7 +2108,7 @@ static int trace__read_syscall_info(struct trace =
*trace, int id)
> >       }
> >
> >       if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> > -                                     RAW_SYSCALL_ARGS_NUM : sc->tp_for=
mat->format.nr_fields))
> > +                                     RAW_SYSCALL_ARGS_NUM : sc->tp_for=
mat->format.nr_fields - 1))
> >               return -ENOMEM;
> >
> >       sc->args =3D sc->tp_format->format.fields;
> > --
> > 2.45.2
> >
