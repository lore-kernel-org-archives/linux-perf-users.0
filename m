Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519709;
	b=ETMN9wGImB8YC2tNPk4ZqvT6/Sn8K/YIhcCVmeoYaqPr+gl/PTzNAtCx9KNu8YhvVgPZ
	 jfF2R6F+X7oFlF1eLzgtT830Da92ln+nG/RpHSa0AP+pCRzOLYHRFgXqfPtjvM1yO2eC7
	 7XmFAvE7usGjzSx4qzU6jmtP2gHb2o0nBRlD0J/mD9OqKWuevDhn/mD3i4jYt6CJDKfWz
	 M4Di8dXcSzZRquwGzpblAzLVop1+wnMpnDUx4zeWCGoq73qf9Bmi7yi/3Is8F9ONlBiwS
	 43XGtN+Jf2RaG3Wf26rbp2JI5h1Id8uK1f/MyxTtA+VvGzUKvFOtAnq8iTm2eQC68UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M3YLsKzG5cqeB2dDG96sb0hKNdycjo/1Ky/AnQJorPs=;
	b=De+fh7CoEjTfYFIrk9GBjAL3CmSQ6fWixh+aUcPhhlGTiOiukfnZNzP+3DR+TcmZf55s
	 Am59FdCphUp5KYV4HCVis1tKc+G2xhNoQV55YnXk4EvlFUYUY4xOtJ5VYd0jXXKJBYsMU
	 1DL9aXnjbDcogwmTsMu93Pk66N6eN5iVMyHGsgDiOyIHMKk0kLz/pHt0W/b41bwqHuUUX
	 1CguepJwyZD+xIonDD+lZjWmHygVdWDM88MB6vOxsr6H9jOSqC/EC5Y1yD3f7bMAvCqX3
	 eQ+UFzFnK+FrOntR7HCyaG9SL0BgXNX0u85byncz4ti7w3Daf6N302GFUz7ftBY5yFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l6AmSxx/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA305606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 21:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA305606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6AmSxx/
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so289869a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 13:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794519708; cv=none;
        d=google.com; s=arc-20260327;
        b=Ph3ZzPcaSKRiFDxhXGNzrZDSPpOSVtj3nCcGjgPH4Z5tnyQMnr3vW1UkxTZO0/5o9p
         BlOXnUw7B+OfUQRz23XFiTUQ2zIBgSsIXLJASqU0iHwAlpcRhmLNl1/WTOZDomj8JT3D
         2MmUXaxOx8n1Z7pO4JogKyl4AAHSnhktDncFv355dIsgOnf2oyflrbxzMM/Qd2/1Z1e5
         5Uo9geHOtKNIcdvOt//fA8gKdNjAPcfISwDEkF7G9DimDlg10YwsunJ9AbZ2D8O+fyfA
         OzWG1BpffpClu8lYirN3ZKoSOz4RWeGXm7eulJyXJrcnWxCbmMRl222A4WAFXzxN5HzS
         tuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3YLsKzG5cqeB2dDG96sb0hKNdycjo/1Ky/AnQJorPs=;
        fh=0ZxFyIrHd9vpYi7eWtB0qxJ4nbKdHe3lW4SX23xMWi0=;
        b=EYl0nHGnNdLZZ411Npgi9trfWB0J9DF1MiUTpEGeXUtzMeOogL34bubMDvo7UdHk+8
         DMreGCbTNK0E0p9MA5YysXnNRC/iulhvZCmtNq/IQNxRbkVr8ktyBa8FhThkUiF6r5ZH
         gPkNFeBXhOvbLuwEWQ1vnsSUzQ6CVdtN2ZNOaH59frl57AyzSRZiJd/KEsvzFNkC9vBw
         yb8X2iIm0+7jgSYKoRDsJPioefXHjrCHcLonzHbQoV9njcSX61xuC/atWny0Kkjstq5T
         gdWu8e9/eRAXaRLxOZFsLHim8wsEokSDay3ayNR8kjQcG786ARAdi+Z/nflevkDonWDw
         AqKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794519708; x=1795124508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3YLsKzG5cqeB2dDG96sb0hKNdycjo/1Ky/AnQJorPs=;
        b=l6AmSxx/K8y3qh9zmFpdgkWR3MpQOes+RmCoESNQYBUY/buW5zHFnipPlv4E09NdYg
         PyOciIhr4enYC9mGL9Cpgx9rMLKGs+zhsXbiFoK582CLKSH0xI0MZrcua22441AY3a8/
         S23fadoyQdd9kIS8VCaiwr3RpeNThieSwcEy3Mqrrp6KdRwR7OkczzONhmVeRqmmswlb
         u9AepUoIcXlhwSWnG24RlC0ibBEZgphgdMPdjz3nOWfCCF6kPMS66YX6UppFdcC0wlDE
         s1oJ/DHThjLdChZys3WQVY6exXGCzTl66BCjURltHp/AazTMZPBm08Ss3LKLQfz6Jt90
         VZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794519708; x=1795124508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3YLsKzG5cqeB2dDG96sb0hKNdycjo/1Ky/AnQJorPs=;
        b=zs/CbhCYA+w2KkAYEv14n+B8y/YyEE55W2FWoZDUTaNrpjKJAwqfDVGJoyj2d7yNBw
         54Q6jDB6atp+MC4fbWeVV2AZSOy6dD7Mb+y5N8NkUb6y+gjN7tdOMZr2LPppTH1X7DHS
         TLODFIuHlI8/FHv9FQpQRWO0p7qZLb8b0nHFaMuwFHiFacq1EWxRMzeBrudm520RDIt4
         aLe1ls7+lGvSl14bEfxrGj2RqHqSvjR/8Wsj3GDTMDbHHWVdyDrE/jZsuGLzrzEDdZFo
         bnPWIibC/ZPflnjhCdgIcWjgppoZPTYuA7llGBlcr32ZR/uI+tNWptT81jp1DSgdYoOC
         ORbg==
X-Forwarded-Encrypted: i=1; AL+hErHSVFnlroYWM+vF871rs89aR3s/UrI4fZ+r2pTjBPRVJWNcAoehLVkKU2rnXpCu5itiwfVGANkoS4oGgMvPJXRb@vger.kernel.org
X-Gm-Message-State: APuU4Z+ER3c0QG2TbVNsOcOYwObftPnjw5XtSoYJq/PBlx9jy9jFY7St
	OksaHcjk91zN55BpxmaQ7OaWhvHdb2sNTICBApl3jgO5q14xS3pyBPDFPlBnI9EVWAbpVFLqaTh
	ex7Wyfdi5xTApMRwwRYzNyQxU1QsiYQ0=
X-Gm-Gg: AYBFou13ajTT4pwHJUzbAEDOS7LDRJlILYKP5Fahg+bB/zbj0/c9EsvYfF1eKvcEs86
	1WZ4xW5jY8z9wxYoD8Fq22BBLlJ3jRVQAAs7r0V+wgmYSn8my3yp8esjjZztLoUTjVpP2DtCjrn
	VOXP9Yn15vYZt9cDs2SWjQkmdWlzEGIizFpU9g1/ARY7yWi+AqRt/J+7oU15bnjlCJyBTEFZrDP
	xbtH8ZDBcshSPm7jF2Oj0Snj8AMBofQbQZOStkF/mK7DB4m+Xen+VPoyYN20g7dg0SWtR6RWJem
	bhgcmMLa8prywFf/Zn0GUBAsIX6hCck24RJbUvYpaAI06JvE+jUH9VadK7jrY4yP0XMMSYGCzx6
	XZHfm0Y0iD9eJwsDKbpPYMC0u2jryfflhYeSnU1ovN56Rp3jp9Y3rUYptWk0bG13Mw6W9M/sicK
	mDAuBS7y14ueJqnWoo3g==
X-Received: by 2002:a17:90b:2ccf:b0:3b0:aaa3:ce75 with SMTP id
 98e67ed59e1d1-3b1b081866emr318496a91.3.1794519707828; Thu, 12 Nov 2026
 13:41:47 -0800 (PST)
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
 <CAP-5=fWYxRTZmFQZZECLapQCUug-bs3cwTmwYA5SxBy0=0bKdQ@mail.gmail.com>
 <CAAcuPuLkaC_=c4NPxNmO3HK8dw8j=cH6M+nyfzYERMfZOKh8tA@mail.gmail.com> <CAP-5=fVr+EHr_RpLiA45ZK8OkDNG8AdmgK+pz7kxd6G3zWXO1g@mail.gmail.com>
In-Reply-To: <CAP-5=fVr+EHr_RpLiA45ZK8OkDNG8AdmgK+pz7kxd6G3zWXO1g@mail.gmail.com>
From: szpuszi <szpuszi@gmail.com>
Date: Thu, 12 Nov 2026 22:41:35 +0100
X-Gm-Features: AclHuK-yNJRex-RsbKwKnBvYiP2bsWKAs9gCK8UsPybUgdCdSZcHWabaSgM1qwk
Message-ID: <CAAcuPuKGrssxsfCEoVHzWstrC5syZ13iV-aZ6QQm0bV2kgEzpg@mail.gmail.com>
Subject: Re: [PATCH] tools api io: Return high-bit bytes as unsigned characters
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

I checked the Makefiles. Makefile.perf exports CFLAGS, but the libapi
sub-make receives them through the environment. tools/lib/api/Makefile
then replaces them with:

  CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)

A Makefile assignment overrides an environment variable, so this
explains why the exported -funsigned-char is lost.


Thanks,
Wojciech

On Thu, Nov 12, 2026 at 10:33=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 12:25=E2=80=AFPM szpuszi <szpuszi@gmail.com> wrot=
e:
> >
> > Hi Ian,
> >
> > `tools/lib/api/Makefile` does not set -funsigned-char, so building
> > libapi standalone (`make -C tools/lib/api` on x86_64, where char is
> > signed by default) hits this directly: `filename__read_str()` calls
> > `io__getdelim()` -> `io__get_char()` and silently stops on bytes in
> > 0x80-0xff.
> >
> > Even if perf's -funsigned-char is also passed down to the libapi build,
> > `io__get_char()` is a `static inline` in a public header
> > (tools/lib/api/io.h) with fgetc()-style negative error/EOF returns.
> > Casting to `(unsigned char)` fixes the underlying bug in the header
> > itself rather than relying on every caller of <api/io.h> compiling
> > with -funsigned-char. The `-fsigned-char` flag on `api-io.o` is just so
> > the regression test keeps exercising this path under perf's default
> > -funsigned-char build.
>
> It is only a bug if chars are signed. I thought by default it was
> unspecified whether they were signed or not, hence char having 3 types
> - signed, unsigned and unspecified. At least in the Chris Mason review
> prompts we're pretty explicit that chars are unsigned:
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/buil=
d.md
> ```
> Unsigned char (-funsigned-char): Top-level Makefile enforces unsigned
> char on all architectures. Checking char < 0 is dead code or incorrect
> logic.
> ```
>
> > If you'd also like me to check whether perf passes -funsigned-char
> > through to the libapi build and send a separate patch for that, let me
> > know.
>
> So I ran a check and I don't see `-funsigned-char` being passed into
> libapi in the cc command line. So maybe there's a bug. I see
> Makefile.perf exporting CFLAGS.
>
> Thanks,
> Ian
>
> > Thanks,
> > Wojciech
> >
> > On Thu, Nov 12, 2026 at 6:27=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, Nov 12, 2026 at 9:06=E2=80=AFAM Wojciech Szpucha <szpuszi@gma=
il.com> wrote:
> > > >
> > > > From: Wojciech Szpucha <szpuszi@gmail.com>
> > > >
> > > > On signed-char builds, io__get_char() returns negative values for b=
ytes
> > > > 0x80-0xff. This makes filename__read_str() silently truncate non-AS=
CII
> > > > input in standalone libapi builds.
> > > >
> > > > Cast the byte to unsigned char before returning it as int. Add regr=
ession
> > > > tests compiled with -fsigned-char, since perf defaults to -funsigne=
d-char
> > > > and already avoids the issue.
> > > >
> > > > Fixes: e95770af4c4a ("tools api: Add a lightweight buffered reading=
 api")
> > > > Signed-off-by: Wojciech Szpucha <szpuszi@gmail.com>
> > >
> > > Can you provide more context of where this is a problem? The code
> > > builds with -funsigned-char :
> > > https://lore.kernel.org/linux-perf-users/20260306191908.2065682-1-iro=
gers@google.com/
> > > and so we may be failing to pass CFLAGS through properly for the liba=
pi build.
> > >
> > > Thanks,
> > > Ian
> > >
> > > > ---
> > > > Tested on Ubuntu 24.04 x86_64, GCC 13.3.0: standalone libapi reads =
0/4
> > > > bytes before the fix and 4/4 afterwards. The API IO regression fail=
s
> > > > before and passes after. libapi and perf build successfully; checkp=
atch
> > > > passes. Full perf suite and kernel builds were not run.
> > > >
> > > > https://github.com/szpuszi/linux-perf-io-test/actions/runs/43257707=
229
> > > >
> > > >  tools/lib/api/io.h        |  2 +-
> > > >  tools/perf/tests/Build    |  1 +
> > > >  tools/perf/tests/api-io.c | 33 ++++++++++++++++++++++++++++++++-
> > > >  3 files changed, 34 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > > > index 1731996b..25e2008d 100644
> > > > --- a/tools/lib/api/io.h
> > > > +++ b/tools/lib/api/io.h
> > > > @@ -91,7 +91,7 @@ static inline int io__get_char(struct io *io)
> > > >                 if (ret)
> > > >                         return ret;
> > > >         }
> > > > -       return *io->data++;
> > > > +       return (unsigned char)*io->data++;
> > > >  }
> > > >
> > > >  /* Read a hexadecimal value with no 0x prefix into the out argumen=
t hex. If the
> > > > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > > > index 58858f3d..c3ba1fca 100644
> > > > --- a/tools/perf/tests/Build
> > > > +++ b/tools/perf/tests/Build
> > > > @@ -79,6 +79,7 @@ perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwin=
d.o
> > > >  endif
> > > >
> > > >  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> > > > +CFLAGS_api-io.o +=3D -fsigned-char
> > > >
> > > >  perf-test-y +=3D workloads/
> > > >
> > > > diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
> > > > index 0ba3d5cc..f283712e 100644
> > > > --- a/tools/perf/tests/api-io.c
> > > > +++ b/tools/perf/tests/api-io.c
> > > > @@ -98,7 +98,7 @@ static int do_test_get_char(const char *test_stri=
ng,
> > > > size_t buf_size)
> > > >         for (i =3D 0; i < strlen(test_string); i++) {
> > > >                 ch =3D io__get_char(&io);
> > > >
> > > > -               EXPECT_EQUAL(ch, test_string[i]);
> > > > +               EXPECT_EQUAL(ch, (unsigned char)test_string[i]);
> > > >                 EXPECT_EQUAL(io.eof, false);
> > > >         }
> > > >         ch =3D io__get_char(&io);
> > > > @@ -118,6 +118,7 @@ static int test_get_char(void)
> > > >                 "12345678abcdef90",
> > > >                 "a\nb\nc\nd\n",
> > > >                 "\a\b\t\v\f\r",
> > > > +               "\x7f\x80\xfe\xff",
> > > >         };
> > > >         for (i =3D 0; i <=3D 10; i++) {
> > > >                 for (j =3D 0; j < ARRAY_SIZE(test_strings); j++) {
> > > > @@ -290,6 +291,34 @@ static int test_get_dec(void)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int test_get_line_non_ascii(void)
> > > > +{
> > > > +       static const char test_string[] =3D "a\xc3\xa9\xff\nnext\n"=
;
> > > > +       char path[PATH_MAX];
> > > > +       struct io io;
> > > > +       char *line =3D NULL;
> > > > +       size_t line_len =3D 0;
> > > > +       int len, ret =3D 0;
> > > > +
> > > > +       if (setup_test(path, test_string, 2, &io))
> > > > +               return -1;
> > > > +
> > > > +       len =3D io__getline(&io, &line, &line_len);
> > > > +       EXPECT_EQUAL(len, 5);
> > > > +       EXPECT_EQUAL((int)line_len, 5);
> > > > +       EXPECT_EQUAL((int)strlen(line), 5);
> > > > +       if (line_len =3D=3D 5)
> > > > +               EXPECT_EQUAL(memcmp(line, test_string, 5), 0);
> > > > +       len =3D io__getline(&io, &line, &line_len);
> > > > +       EXPECT_EQUAL(len, 5);
> > > > +       EXPECT_EQUAL((int)line_len, 5);
> > > > +       EXPECT_EQUAL(strcmp(line, "next\n"), 0);
> > > > +
> > > > +       free(line);
> > > > +       cleanup_test(path, &io);
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  static int test_get_line(void)
> > > >  {
> > > >         char path[PATH_MAX];
> > > > @@ -337,6 +366,8 @@ static int test__api_io(struct test_suite *test
> > > > __maybe_unused,
> > > >                 ret =3D TEST_FAIL;
> > > >         if (test_get_line())
> > > >                 ret =3D TEST_FAIL;
> > > > +       if (test_get_line_non_ascii())
> > > > +               ret =3D TEST_FAIL;
> > > >         return ret;
> > > >  }
> > > >
> > > >
> > > > base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
