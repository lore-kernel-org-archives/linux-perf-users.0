Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794515156;
	b=QzRFSfWa4Bg95RGAwHAYIXuJJiWfquklrs05pN7qeCSdUQEM6gl69Q9Pq9NAp26k4sj9
	 DkerB0wY+NGc1jaGPPSgbQH5x2VoCt5TLA9pPs990gyPyMin4i7q+hzY9ascVu+Qzz8tq
	 LsZnrfSDuRRl0f2LdUK1FIkIqBHeatjk4DQbVNVkUADQjuDfNp+ri6B6c+oTNeYssw+zr
	 foE+DcIXrEpWtu5Gvejhts+t/tvaoUhMuRr9VCstz0JakGilo6omWAXDJNrjsiFqCiMTo
	 PVXviAiUOH4+Czm8YWFHFIgI/bfFyYr8jN5oq7apGkT7K7Q+iZI4J1QzqTpdi72RYLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gxPsaAvTclPv8Bzbeb+6GCZ9smfJzSH01Ggd1jA3xgY=;
	b=OjHyfTaJliVISCJxbKhzIUnol8/gG56U4LcBE9dTv9Mn8F7YEqnEf5NK3c69tulS2FvW
	 a99n+AZ6kc1f8x+hQkUyZHkQ0SeoGSvejZ9qh9+aCnMFcMFw0kP9iHM8BVKbKAxnk9bZq
	 Z07pZ3hg3Hyoi0rDwkrpZNl4KdKN3sNXgkeqQoBWMzt1K0d9uwUVSrh3LiEqycJ99oqw2
	 7/9LGifeSq0RdI+HxbGnpx+vnJy/MzuMaWxjciGO7uEAllDC/oSCyP9y1mposLFkTGCoC
	 fk8ltWcjZD/a8ykp1HLKFkvzb3JKqSYru30U6lUj63Ok8qIjeZU8KERb0jPLxYyOkOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuwKRyjN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C9606A891
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF8C9606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuwKRyjN
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd69954c755so231856a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 12:25:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794515155; cv=none;
        d=google.com; s=arc-20260327;
        b=BE+DOYNdEQAgWW5i2tMIeHDvUJPSVO64xCmnsuHCI+m4IcaoT6wMdkyaoWheUt9+us
         NH+3rbN0T/2sgkyXt4M4KPiHfPpEJw5WCBVSer9rn9xZJ6W+MHA/zNX2ehI1piIgWnYj
         8/PfuR0peoxN4r+NtS7wdGMrs/Gj887b8PBHjp8og5YhXfVfmNKFSfyU+qICI7jSPruZ
         Sbmyma1A3StfkaQyOHielIoXCeoa0XehQGMrS89qRtUv+E32LN+7E0c+yyJ6BZL89oiL
         KCUD/GUgaBYygdfy3Y7bPgiRdyHpMe23DrHs50J36b7x33HpI5yooEa99HX5Jf3kx8lD
         dFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gxPsaAvTclPv8Bzbeb+6GCZ9smfJzSH01Ggd1jA3xgY=;
        fh=xSwk0r3NBUipPY+/KgQpO6jFTorvFEnU9JDpl6SiH4g=;
        b=kLO3WgNzzHsIeDNBPKZ3oePAg1qvB+YzHjnCzxZkNPQwrTp+s7jedkJGGrr+xl9s/w
         I0GhXByiVckxaANryocUGhb6Xnvj4f7stTO+4k1YBi0yYHHgLonuiB52EI5Dn8nfTpuW
         Kx/Du+jAH9b0zpJuu8OTbkq2mEODVI3ka4d4qFNj04HXyIInI/ahXPf7OQXhgfq2VBul
         cvVHaz/iXnLyZ3uUzhJMew9cn0OiFhNo/p/W1Abqwd+VC/hhyx7btxHsB2Yh37w0RSve
         OSsZJqP63PH8phvWIkoQQZ4AzwX0ySE5q2rk4N5GwnoXHEbOZ9u38mff9QMqk9mlhJlI
         h0Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515155; x=1795119955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gxPsaAvTclPv8Bzbeb+6GCZ9smfJzSH01Ggd1jA3xgY=;
        b=cuwKRyjNEJPZuRxAUbH1GwuBLTQVJXtToKvJyi65LM6LXQQb5JS+TTPuGeR/SVDiCl
         dEQWa1G03Dgb3TecRWdmLlqHNYh83VMaydRsFrD/TOi9P/NcMHWAFbEcZDiFLzAuMval
         JrOxwCwccytHEFtnqCg+A3wP9fIwL5dDd5dLZO5CFq3Kmga5kCN8BsGwMlzDRzrxcfbQ
         V8vAMnmKEGw9Kj6k5i5NogYHnj+OWfB9bfgjISTP7cbmOFOxh/7sQOj93rFTbYX5Q0K3
         eUQzMaIdvrFdatjohAwfiSjRb3EUUqKfcJW62/S2mIw7SzP4betbqJuFKIv3R+L8dmd2
         kCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515155; x=1795119955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxPsaAvTclPv8Bzbeb+6GCZ9smfJzSH01Ggd1jA3xgY=;
        b=LibEjqIvNe1e9aPirK0SYnLkvSmoXASx/ntv5oR72x9h0QU16LViMs0Acvfk8QotZD
         pYJe6v62OpmPdWyEsx2G8wNQG4BZ8UIcPM73VthAKwS+/ZY3RaafVtLi5reV5AGm2kvJ
         hKG2Qus+6aoDJDjGvQleyHyGH0rvlHi94N5aFxQ0b4tNug38ADFeEGiI9ImPT9CuVCpV
         8LOm/3MZhjB+djxZY4evv/hDVtCQCLYP/114ydaogOh+FKvljoPeTcSFfl1Pu2Uh+GkK
         GbfryW9ElOEZ+TJvk+hLZuTrQQ0QQA5tUews86o8b6QkKcDZZTDJmFUqWktft4ko/Tf9
         mLog==
X-Forwarded-Encrypted: i=1; AL+hErGZh54tMeVJfdHr7BaLvBBnzspIoBYXkxDabuAxDV4DWQ+ku+CJ60WZLS/Goe5L+M5Jymh+/xU8beAGdIFyTwbw@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ibf6DZKJ2/5GRWHuuI6lCEQJcda0Q7QPvwuaQnigbMuQYbdZa
	+o/Hn1keA1Ty8pR+8XjASA7DhWSY6JD9Dc/g6ywmm1XEbUGetHS4STHE3hGFjbdszB1Bl70Qqhv
	RI/FT3KyEDfrnanQL9f3h7KBvMrVOvUY=
X-Gm-Gg: AYBFou1bX7SAGNSooKT24us2UsuImLCR1ITsuDQMq/B3fKEul1zfbZKOaUMCbTXM5Sz
	EjXyQKhBX5f/sUpXBju2NrpQ/eJ8n/XkR5S9zbxwklKUNvLL+lN7sgIdNm8jjI2MSyfQ3mHQ/14
	gDbtO865MRafF8UorjX1M6FLBdfkKkmh7PeYFJO4z6XEdQJba4LLOxyI+aOsQeSuZXwCuthM6rU
	cEyqlxkBujwGMD3PI65GyGU5/lIua4GCD+IeyJ29M99iS4Gk/xh7WfcY7SHuTraxdUgGtiHNvOz
	APQg+LI63+9NtvnnBngIIfDcA3lgKxQBAWkE7WJpXcojjaFXFYPdrHT/4+r+r/B3Fx0QZeiHhAU
	AXOIo+8ktoSwo9hXQKHRwLgnzTNi+Y/CiIUWGVP3f6t6Tea3olsDA5mE2IwGuj+75QCLcKd3Ho+
	V+BF23T/DgNRA7VXEknA==
X-Received: by 2002:a05:6a20:7490:b0:3dd:85a9:55a4 with SMTP id
 adf61e73a8af0-3f7a72caa82mr291436637.29.1794515154647; Thu, 12 Nov 2026
 12:25:54 -0800 (PST)
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
In-Reply-To: <CAP-5=fWYxRTZmFQZZECLapQCUug-bs3cwTmwYA5SxBy0=0bKdQ@mail.gmail.com>
From: szpuszi <szpuszi@gmail.com>
Date: Thu, 12 Nov 2026 21:25:42 +0100
X-Gm-Features: AclHuK9RaTEfuL1gyCuuJHx3CDkOCgXc4BWu8UGRwo2z1iefsrjrDcHQZcC1XcQ
Message-ID: <CAAcuPuLkaC_=c4NPxNmO3HK8dw8j=cH6M+nyfzYERMfZOKh8tA@mail.gmail.com>
Subject: Re: [PATCH] tools api io: Return high-bit bytes as unsigned characters
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

`tools/lib/api/Makefile` does not set -funsigned-char, so building
libapi standalone (`make -C tools/lib/api` on x86_64, where char is
signed by default) hits this directly: `filename__read_str()` calls
`io__getdelim()` -> `io__get_char()` and silently stops on bytes in
0x80-0xff.

Even if perf's -funsigned-char is also passed down to the libapi build,
`io__get_char()` is a `static inline` in a public header
(tools/lib/api/io.h) with fgetc()-style negative error/EOF returns.
Casting to `(unsigned char)` fixes the underlying bug in the header
itself rather than relying on every caller of <api/io.h> compiling
with -funsigned-char. The `-fsigned-char` flag on `api-io.o` is just so
the regression test keeps exercising this path under perf's default
-funsigned-char build.

If you'd also like me to check whether perf passes -funsigned-char
through to the libapi build and send a separate patch for that, let me
know.

Thanks,
Wojciech

On Thu, Nov 12, 2026 at 6:27=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Nov 12, 2026 at 9:06=E2=80=AFAM Wojciech Szpucha <szpuszi@gmail.c=
om> wrote:
> >
> > From: Wojciech Szpucha <szpuszi@gmail.com>
> >
> > On signed-char builds, io__get_char() returns negative values for bytes
> > 0x80-0xff. This makes filename__read_str() silently truncate non-ASCII
> > input in standalone libapi builds.
> >
> > Cast the byte to unsigned char before returning it as int. Add regressi=
on
> > tests compiled with -fsigned-char, since perf defaults to -funsigned-ch=
ar
> > and already avoids the issue.
> >
> > Fixes: e95770af4c4a ("tools api: Add a lightweight buffered reading api=
")
> > Signed-off-by: Wojciech Szpucha <szpuszi@gmail.com>
>
> Can you provide more context of where this is a problem? The code
> builds with -funsigned-char :
> https://lore.kernel.org/linux-perf-users/20260306191908.2065682-1-irogers=
@google.com/
> and so we may be failing to pass CFLAGS through properly for the libapi b=
uild.
>
> Thanks,
> Ian
>
> > ---
> > Tested on Ubuntu 24.04 x86_64, GCC 13.3.0: standalone libapi reads 0/4
> > bytes before the fix and 4/4 afterwards. The API IO regression fails
> > before and passes after. libapi and perf build successfully; checkpatch
> > passes. Full perf suite and kernel builds were not run.
> >
> > https://github.com/szpuszi/linux-perf-io-test/actions/runs/43257707229
> >
> >  tools/lib/api/io.h        |  2 +-
> >  tools/perf/tests/Build    |  1 +
> >  tools/perf/tests/api-io.c | 33 ++++++++++++++++++++++++++++++++-
> >  3 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > index 1731996b..25e2008d 100644
> > --- a/tools/lib/api/io.h
> > +++ b/tools/lib/api/io.h
> > @@ -91,7 +91,7 @@ static inline int io__get_char(struct io *io)
> >                 if (ret)
> >                         return ret;
> >         }
> > -       return *io->data++;
> > +       return (unsigned char)*io->data++;
> >  }
> >
> >  /* Read a hexadecimal value with no 0x prefix into the out argument he=
x. If the
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 58858f3d..c3ba1fca 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -79,6 +79,7 @@ perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> >  endif
> >
> >  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> > +CFLAGS_api-io.o +=3D -fsigned-char
> >
> >  perf-test-y +=3D workloads/
> >
> > diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
> > index 0ba3d5cc..f283712e 100644
> > --- a/tools/perf/tests/api-io.c
> > +++ b/tools/perf/tests/api-io.c
> > @@ -98,7 +98,7 @@ static int do_test_get_char(const char *test_string,
> > size_t buf_size)
> >         for (i =3D 0; i < strlen(test_string); i++) {
> >                 ch =3D io__get_char(&io);
> >
> > -               EXPECT_EQUAL(ch, test_string[i]);
> > +               EXPECT_EQUAL(ch, (unsigned char)test_string[i]);
> >                 EXPECT_EQUAL(io.eof, false);
> >         }
> >         ch =3D io__get_char(&io);
> > @@ -118,6 +118,7 @@ static int test_get_char(void)
> >                 "12345678abcdef90",
> >                 "a\nb\nc\nd\n",
> >                 "\a\b\t\v\f\r",
> > +               "\x7f\x80\xfe\xff",
> >         };
> >         for (i =3D 0; i <=3D 10; i++) {
> >                 for (j =3D 0; j < ARRAY_SIZE(test_strings); j++) {
> > @@ -290,6 +291,34 @@ static int test_get_dec(void)
> >         return ret;
> >  }
> >
> > +static int test_get_line_non_ascii(void)
> > +{
> > +       static const char test_string[] =3D "a\xc3\xa9\xff\nnext\n";
> > +       char path[PATH_MAX];
> > +       struct io io;
> > +       char *line =3D NULL;
> > +       size_t line_len =3D 0;
> > +       int len, ret =3D 0;
> > +
> > +       if (setup_test(path, test_string, 2, &io))
> > +               return -1;
> > +
> > +       len =3D io__getline(&io, &line, &line_len);
> > +       EXPECT_EQUAL(len, 5);
> > +       EXPECT_EQUAL((int)line_len, 5);
> > +       EXPECT_EQUAL((int)strlen(line), 5);
> > +       if (line_len =3D=3D 5)
> > +               EXPECT_EQUAL(memcmp(line, test_string, 5), 0);
> > +       len =3D io__getline(&io, &line, &line_len);
> > +       EXPECT_EQUAL(len, 5);
> > +       EXPECT_EQUAL((int)line_len, 5);
> > +       EXPECT_EQUAL(strcmp(line, "next\n"), 0);
> > +
> > +       free(line);
> > +       cleanup_test(path, &io);
> > +       return ret;
> > +}
> > +
> >  static int test_get_line(void)
> >  {
> >         char path[PATH_MAX];
> > @@ -337,6 +366,8 @@ static int test__api_io(struct test_suite *test
> > __maybe_unused,
> >                 ret =3D TEST_FAIL;
> >         if (test_get_line())
> >                 ret =3D TEST_FAIL;
> > +       if (test_get_line_non_ascii())
> > +               ret =3D TEST_FAIL;
> >         return ret;
> >  }
> >
> >
> > base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
