Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519193;
	b=iXSelO82uW3axh8IjwkCZkSRe+qktfxn88FfxSe8ef+uLk9Wf/lUXe1KYLld76TDmpPE
	 zcUXJehu5cWg+UCHln1VzLOxFgAQ11VM9sVGkwpUqujPICxNsgeD3xASDE2wXEW3+IpKb
	 57Qq3WQB49RHiXpv75Q2qEPkRV9WyjjPZuM0bYnpMlPfuF04wm0CUQ8yHMmTgKoJ5kDFd
	 WOjYTfh8fKwm8aknmhmeAEdfcKXAfZIaNBo/ui5pWscXvIuh+bcR21ClN0oZ31pn39iWU
	 ybKgL93XDlIyFcsGx+plp007KGt+Ej8azhGFhJ+AepoVPPrS1GLh29MGaysQ8l78tgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=prF5tjXqgroH+cDLlU5bcd95xTZWZ1bQNjqAX/0GDh8=;
	b=3lgVS07ezk+bb6xRQLAmvKexFwFp2WqELlIHrbTBeIsc8uhuEhOwNhNQMqLmQLz37+Xf
	 ZT1OjvByXvVreZbWGTaPT6ZuoiEKF4eUJdcQTMtK3Zn4hKyquBG81JOdxMXuvATMbGgqy
	 +9CWwzjSUL1FBKB/PDFilx9eYMbomoXHMe08arANs/VVpqbnf9AQuBXxIuofX9tRTuTuu
	 h6F0q8yvCDwdfsRSAaYLiUhFlkE86o8Ja6+H9+16roDFRL/uv08rgYEWRa1C7ggVaNM7J
	 AHjb0dXvnCy77mdxaifv7+K1vwL//V31xSoquEa9wQAcU63caxlBQ4G1hrmUfmyEaFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c+r70Miw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BA606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 21:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 853BA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c+r70Miw
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so39741cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 13:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794519191; cv=none;
        d=google.com; s=arc-20260327;
        b=Gp11xnC0KcPjYqMrcf54C5a6QPJ1Sf9O76iNmyWoQRl5qIcDOjywShn0cDXweGN7/C
         1jrOsyfRokw5RlNl9E8xCYAW/8jzmMWM9rSYPhkmEiXJ/gKR9IClsRO4DRDsjFD/9zhx
         kZS7aTDUQkdmV1D8FdAbtw6Fwu7UstrwUrPBc3fYtcKNcaFG9A4Zmw1bcTyugG47O6Kr
         aNrYSaHcAsZOOB0RFdKz4QPvvO9Rap3vhzTACLiDK+U1XeydwHngTtxfhhx7cDy7dd3O
         MXxL5kN+D2w0Yoe4IinYkdmZ3H2VlRRWg7FtUTy2zlrFFFKChcm9VhG/oJ38C8+7H3jR
         aMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prF5tjXqgroH+cDLlU5bcd95xTZWZ1bQNjqAX/0GDh8=;
        fh=5/bm4Ey0v8wK9YpFeR7aqF+S+zX44BOXlTXn8RLGveo=;
        b=gZNXA2+K9VOE1/IOfBUTYd/t+sNcyA+visbn/MWTSdlb7hLckE9xGsP1cGTB/2rgxt
         k2521yh/MZCR5c5Inaac2cfgPxOJA//QIw3spRnOHklvhjZdGZ2Y62NS6OlEupoctThL
         44CSa6ivDC3jkU/MNgWrIuJcCuTcUUMaMt1XB3DiAebpiniZy1aCEPET4foeqyzBpNmg
         mcx8T2g5gI5TyuWL0ygHXO9Bb9ntA4+RmyuSyMeqWhyXoyGqgx0OGsDN4+cAXYfnK5GW
         IDWaGlsFiFWr71tX1fxBUrxIZkk4x0/1Vn880cbFN7+/oPCqoUhlA1JGEiWiSzmyR0/I
         Wv9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794519191; x=1795123991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prF5tjXqgroH+cDLlU5bcd95xTZWZ1bQNjqAX/0GDh8=;
        b=c+r70MiwL5ihIwSFWBN7qSBDWPpBrkCxc6G8ewKG5Ylo0ToK6UNLaaaYAAA46JNOan
         4z7xWO4AMdQ8dbi4747cL9NCLq+mfA2JZiVgB73FJlId3AOE4H9GAbbd877tRR5ikVGA
         ysi5pkoASc08N7066rqoHHNWRREgldfIpcMm45xeZ+lfxiRAPyhmSFxt6QuV2Ue0t3Gq
         r2N9D02E35cMcEW1drj8gI27mUhM2EjbEA+U7VjAM7GodRJgyDzse1hZAWv3i6kGysRv
         tHRs9FYf+1SSvNQpUaHqCA8ogUc0hmy7NFcrf8o0GNjhsIqC2gAQxXKMEELoQ+LJhVMS
         Js+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794519191; x=1795123991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prF5tjXqgroH+cDLlU5bcd95xTZWZ1bQNjqAX/0GDh8=;
        b=EANhdm5ZI8WK7uTpCq6bVAB6UmM3D5hllK3eAT0BwzhGzLqGY7gIQvTSEz8OKNTIHb
         pqJ2v6Q0oxK441SYBZtdMXO2h440QWNkyHF5eleICuIpIq27U45j6XyVIuTAWy+AIDip
         /Zaoa2swieGm1uRljjFjRKaGH1xthb1MRA31hokmVjOxLKXTvhOitrqPQEhmiP0dbJp8
         qaKIkQ7iTHGthnWI4qR+F5HOpB9v9A5LDAR3b+d+6GIX+4Hp9DtK40yA0yjACjvi/69j
         Sa5yB4vhDzzlp7TU0OK+pfkL7kT84SWYzBxBzj9gRyltVAyYRuuxn83q0EWdaE7aBx2m
         /G7A==
X-Forwarded-Encrypted: i=1; AL+hErHVVcI6sbT9Mn8bSAt7II0a4Dq7SUksTZRyH6d+t9C53ZVMPLOLwZJtCb0UVh4oGqAmzVhzdQ6CjtdFYujX+JLJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+wtLV8AWPASE5WF3lI1Ar7aYscRCZ/84kTrESKif1pX3wwVl8N
	3NUc4vCTrKF75YWuS2TOz1l5fkQt0SKpqUiMeUnwbiUjdlsqTB4Z3UCIrTwN8t9ukXnQE3QBGD8
	jBrJfxZH5NKMnDR29BKEgQY+MsyahDrAOqqSvULtrepekrvx29ob/RCae3Ps=
X-Gm-Gg: AYBFou3cLwFlxP+vTgrF3xOr9VNrgJbKhYGvUB+fVFbySFBWu34IUSf+4bkMis+r2WN
	ywTQhRzvIwiXI90edYvrn+ZA8lZcvqX+TuSXVclP6hKSQh714N9+rptrmYoclimeOynDgFXicS9
	DlGp8T6XZ8YAWxLrWXoLNo/s9RTnxAYdpqIPhK23xS8ELop6xcXqFglIsRcfsfEKIXLGiVY4HXT
	PxAc83tmiCFunm2AiQZ52jT8UZi2MymZcOBQxdfCu52wwxhKu1Inyfm08KSwNtLew3tOwgbfRT5
	skD4ttEmxeZsLTxYTtOe8fIVkMtdD6UKR2YjhC8Br0qhWrBQmRCyOg/rboqN2a4h3UySypmbZ9F
	4zLq/ZiV/Pqf+AHcOkUq+vRLrjbOeQCjaWAxmUbQN4F/SoD0dwQaVjzlLkxLgQkYl94Y=
X-Received: by 2002:a05:622a:1e12:b0:536:6ae9:f55f with SMTP id
 d75a77b69052e-55afcae990emr1186911cf.7.1794519190580; Thu, 12 Nov 2026
 13:33:10 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAcuPuJUt=Qf6uuTVv63jiY_iCjsvjso1T=WYSFQB=i6Wzb2Vw@mail.gmail.com>
 <CAP-5=fWYxRTZmFQZZECLapQCUug-bs3cwTmwYA5SxBy0=0bKdQ@mail.gmail.com> <CAAcuPuLkaC_=c4NPxNmO3HK8dw8j=cH6M+nyfzYERMfZOKh8tA@mail.gmail.com>
In-Reply-To: <CAAcuPuLkaC_=c4NPxNmO3HK8dw8j=cH6M+nyfzYERMfZOKh8tA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Nov 2026 13:32:58 -0800
X-Gm-Features: AclHuK-0mcpzVSbtDp10Qu2TQXFVJn9tlshi_Fs0QymOKakVYwrCs2-tCyKvVfA
Message-ID: <CAP-5=fVr+EHr_RpLiA45ZK8OkDNG8AdmgK+pz7kxd6G3zWXO1g@mail.gmail.com>
Subject: Re: [PATCH] tools api io: Return high-bit bytes as unsigned characters
To: szpuszi <szpuszi@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:25=E2=80=AFPM szpuszi <szpuszi@gmail.com> wrote:
>
> Hi Ian,
>
> `tools/lib/api/Makefile` does not set -funsigned-char, so building
> libapi standalone (`make -C tools/lib/api` on x86_64, where char is
> signed by default) hits this directly: `filename__read_str()` calls
> `io__getdelim()` -> `io__get_char()` and silently stops on bytes in
> 0x80-0xff.
>
> Even if perf's -funsigned-char is also passed down to the libapi build,
> `io__get_char()` is a `static inline` in a public header
> (tools/lib/api/io.h) with fgetc()-style negative error/EOF returns.
> Casting to `(unsigned char)` fixes the underlying bug in the header
> itself rather than relying on every caller of <api/io.h> compiling
> with -funsigned-char. The `-fsigned-char` flag on `api-io.o` is just so
> the regression test keeps exercising this path under perf's default
> -funsigned-char build.

It is only a bug if chars are signed. I thought by default it was
unspecified whether they were signed or not, hence char having 3 types
- signed, unsigned and unspecified. At least in the Chris Mason review
prompts we're pretty explicit that chars are unsigned:
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/build.=
md
```
Unsigned char (-funsigned-char): Top-level Makefile enforces unsigned
char on all architectures. Checking char < 0 is dead code or incorrect
logic.
```

> If you'd also like me to check whether perf passes -funsigned-char
> through to the libapi build and send a separate patch for that, let me
> know.

So I ran a check and I don't see `-funsigned-char` being passed into
libapi in the cc command line. So maybe there's a bug. I see
Makefile.perf exporting CFLAGS.

Thanks,
Ian

> Thanks,
> Wojciech
>
> On Thu, Nov 12, 2026 at 6:27=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Nov 12, 2026 at 9:06=E2=80=AFAM Wojciech Szpucha <szpuszi@gmail=
.com> wrote:
> > >
> > > From: Wojciech Szpucha <szpuszi@gmail.com>
> > >
> > > On signed-char builds, io__get_char() returns negative values for byt=
es
> > > 0x80-0xff. This makes filename__read_str() silently truncate non-ASCI=
I
> > > input in standalone libapi builds.
> > >
> > > Cast the byte to unsigned char before returning it as int. Add regres=
sion
> > > tests compiled with -fsigned-char, since perf defaults to -funsigned-=
char
> > > and already avoids the issue.
> > >
> > > Fixes: e95770af4c4a ("tools api: Add a lightweight buffered reading a=
pi")
> > > Signed-off-by: Wojciech Szpucha <szpuszi@gmail.com>
> >
> > Can you provide more context of where this is a problem? The code
> > builds with -funsigned-char :
> > https://lore.kernel.org/linux-perf-users/20260306191908.2065682-1-iroge=
rs@google.com/
> > and so we may be failing to pass CFLAGS through properly for the libapi=
 build.
> >
> > Thanks,
> > Ian
> >
> > > ---
> > > Tested on Ubuntu 24.04 x86_64, GCC 13.3.0: standalone libapi reads 0/=
4
> > > bytes before the fix and 4/4 afterwards. The API IO regression fails
> > > before and passes after. libapi and perf build successfully; checkpat=
ch
> > > passes. Full perf suite and kernel builds were not run.
> > >
> > > https://github.com/szpuszi/linux-perf-io-test/actions/runs/4325770722=
9
> > >
> > >  tools/lib/api/io.h        |  2 +-
> > >  tools/perf/tests/Build    |  1 +
> > >  tools/perf/tests/api-io.c | 33 ++++++++++++++++++++++++++++++++-
> > >  3 files changed, 34 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > > index 1731996b..25e2008d 100644
> > > --- a/tools/lib/api/io.h
> > > +++ b/tools/lib/api/io.h
> > > @@ -91,7 +91,7 @@ static inline int io__get_char(struct io *io)
> > >                 if (ret)
> > >                         return ret;
> > >         }
> > > -       return *io->data++;
> > > +       return (unsigned char)*io->data++;
> > >  }
> > >
> > >  /* Read a hexadecimal value with no 0x prefix into the out argument =
hex. If the
> > > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > > index 58858f3d..c3ba1fca 100644
> > > --- a/tools/perf/tests/Build
> > > +++ b/tools/perf/tests/Build
> > > @@ -79,6 +79,7 @@ perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.=
o
> > >  endif
> > >
> > >  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> > > +CFLAGS_api-io.o +=3D -fsigned-char
> > >
> > >  perf-test-y +=3D workloads/
> > >
> > > diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
> > > index 0ba3d5cc..f283712e 100644
> > > --- a/tools/perf/tests/api-io.c
> > > +++ b/tools/perf/tests/api-io.c
> > > @@ -98,7 +98,7 @@ static int do_test_get_char(const char *test_string=
,
> > > size_t buf_size)
> > >         for (i =3D 0; i < strlen(test_string); i++) {
> > >                 ch =3D io__get_char(&io);
> > >
> > > -               EXPECT_EQUAL(ch, test_string[i]);
> > > +               EXPECT_EQUAL(ch, (unsigned char)test_string[i]);
> > >                 EXPECT_EQUAL(io.eof, false);
> > >         }
> > >         ch =3D io__get_char(&io);
> > > @@ -118,6 +118,7 @@ static int test_get_char(void)
> > >                 "12345678abcdef90",
> > >                 "a\nb\nc\nd\n",
> > >                 "\a\b\t\v\f\r",
> > > +               "\x7f\x80\xfe\xff",
> > >         };
> > >         for (i =3D 0; i <=3D 10; i++) {
> > >                 for (j =3D 0; j < ARRAY_SIZE(test_strings); j++) {
> > > @@ -290,6 +291,34 @@ static int test_get_dec(void)
> > >         return ret;
> > >  }
> > >
> > > +static int test_get_line_non_ascii(void)
> > > +{
> > > +       static const char test_string[] =3D "a\xc3\xa9\xff\nnext\n";
> > > +       char path[PATH_MAX];
> > > +       struct io io;
> > > +       char *line =3D NULL;
> > > +       size_t line_len =3D 0;
> > > +       int len, ret =3D 0;
> > > +
> > > +       if (setup_test(path, test_string, 2, &io))
> > > +               return -1;
> > > +
> > > +       len =3D io__getline(&io, &line, &line_len);
> > > +       EXPECT_EQUAL(len, 5);
> > > +       EXPECT_EQUAL((int)line_len, 5);
> > > +       EXPECT_EQUAL((int)strlen(line), 5);
> > > +       if (line_len =3D=3D 5)
> > > +               EXPECT_EQUAL(memcmp(line, test_string, 5), 0);
> > > +       len =3D io__getline(&io, &line, &line_len);
> > > +       EXPECT_EQUAL(len, 5);
> > > +       EXPECT_EQUAL((int)line_len, 5);
> > > +       EXPECT_EQUAL(strcmp(line, "next\n"), 0);
> > > +
> > > +       free(line);
> > > +       cleanup_test(path, &io);
> > > +       return ret;
> > > +}
> > > +
> > >  static int test_get_line(void)
> > >  {
> > >         char path[PATH_MAX];
> > > @@ -337,6 +366,8 @@ static int test__api_io(struct test_suite *test
> > > __maybe_unused,
> > >                 ret =3D TEST_FAIL;
> > >         if (test_get_line())
> > >                 ret =3D TEST_FAIL;
> > > +       if (test_get_line_non_ascii())
> > > +               ret =3D TEST_FAIL;
> > >         return ret;
> > >  }
> > >
> > >
> > > base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
