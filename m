Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68223CFF6F
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846702; cv=pass; b=YrVnK7O0mnXt0WZMpc8pCmSr/b3dWDvNRkHz28CQmyhbiJrAM7+GSitvrvWImaBDQ/Shgc9DxtfS9KZekJDnXvKn2Sj58P/ZVJCHp663vblOmVpuAwcon+7VCGqwlLuQzx7NQ0BwoPcai/34iMOD15UCzHvuJP9apSwxlYdVLtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846702; c=relaxed/simple;
	bh=0I5bVHaxUWjp+7O8jDMkRiFwwFDI/695iS1DgzBz72s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWioOil/o2StWtKBKlMh0heSMykjX37VxzrDzCiCfwOtmPA44LGw1RHADQlDVyO7KDHfcf0kLvtaOmDHC4MTjxTKFljLuoDFPP06FPLerDOmuSf1E26jPwULKSEJ3Bjb2Qt/JhdFfke9+a9uQOF7nEnIzAqWppg4FC7nkIlkc20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsqmLjDL; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsqmLjDL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533202fe429so560391cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 16:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791846700; cv=none;
        d=google.com; s=arc-20260327;
        b=W/0k0VshJSfHYK6ivimATiK6+J2rOtxGY+jtaD+yXp8aX5+dnrogHSdOq8os5SyWyx
         3rxvPqDZ3YcSj12m5p3K5hJdk89/o5zeAzPuYp+01z6cmwDg2VykmwwjpooJzD1Q4WRa
         aJ91QTPk61oN2Y8eNBq559OUAEpzeiyepclmD+FveA8KulFj2G11r2CxAjr8eFNrNe75
         Md0ulfeJ28g7jx+6k5nHVu0YZ0fBNNeVmHxHU8eTIqRL/UIMXv0zt+MiyEPNNU0XZXw9
         CXLJsctQFjxWxIh/ly0TBiT6RhNyknB5jKxAAUMCa0u16RWTGEvMeqGR6ZfKpndkvgq4
         vz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u+bMsRouJZQukERfob8EiKwLyBg/G62Htpbl7G33MJs=;
        fh=ZB5lyUx5NzMjkbiVUc5J4GItPiu+SdlKBmFM3/uMTKc=;
        b=I70ECRbQoBZhBleYY8qUXXYGemR0g2AM8XcUdgiofEglPPJPmbiKdV5HInXmR9Evan
         gkpQ+sqHF50VXRAMNpbs7DPZLNc8kuZAQHtKp9N8Zbahl8+NaDljXxJHUKtruml/EbN9
         EIaT3S5DU8OACSdAUkqzgRTdiHFn8LZ/gymzQsQuIa8ezhFUCHF52/XUHoyJHMdWfnQc
         gJyrhn6wrhki1muH/RvI+s4KyUHV5kzwQBfpIRP3Oe5syxJyIxn4ZKryGKJnpHft5Y7b
         uLaxrj1bX/QKIswYP3H5hV9J1p+z5GATTmmhb1TcgMs2VfaVjgTY0fwQT2Bs+bMnd1lx
         8eeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791846700; x=1792451500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u+bMsRouJZQukERfob8EiKwLyBg/G62Htpbl7G33MJs=;
        b=MsqmLjDLFTE4bVh7B6k1QICflUvkyvJptJn8q9t1XdhuCe0s+EMspq7LzH7yA6rADh
         cDlX4iaG8/yLIRFpPbbkff2yfCv+MWpmXdcZi3gWFkSU+9nTPWYSGskkIt60LIh9blQb
         EId9I2Xzo4yJm61yJJwmik2P2bXIGcBtHBhlzGp7uGcrYPMiLdpzG0HGlNvlh5f2tSWx
         jAlIYOpZhQ9UKm7YIltKsPK+0nv+oUOFd65bwt7XYD/rXvsvWofrpSX5uOd8BVfk52yr
         yyRGvq6ER3vnYMEpn0XWFRn2ggAUy9zYVljG23ptfXVvtj1kZ0k2lvUTRu0nFXwAqka1
         zhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791846700; x=1792451500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+bMsRouJZQukERfob8EiKwLyBg/G62Htpbl7G33MJs=;
        b=tmzkBCgOsUBYwY1ahD5EVTLilT2bs6DzGLYrO+d2Uph4x18KQbG3xn4aZuXgQuzuh6
         ZUDgbnl+fjuVBY/nfV7HCyDXlyBdkhh+ii/E9r5lQtUNGqIigP0U0yTHb3AyYmHTAJ03
         sTXHyhzbAkx7yavSzshXfO0uTJGpgp9YJtzlqkHitGzY35DX+bdMLrl5+7BpgGsSJaeI
         62+zkPSqdm37bJLtZlX0Xva+IbQeogDddqqfvVSsKyrZ04S8G2GKupq+CzsWNBwio4iV
         Ef03cfTJ2wFuS6A2bKfKNa3HkH9GQYEn+aU46iZZ9qBkzWx8knUkqyYpfWdH3APoMS2D
         SKHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAxnkhq/5uVwJnRwfOsIItTx1EnqPsCBeoz2QxsTj0fjFu6EfiTV18q8rrWAayFER15+HjAQth6iDeTlrC6cIl@vger.kernel.org
X-Gm-Message-State: AFq9FYLIoybAS/VKXdzDDL8298XPitXN6W16Y0InUL/NSOxIBsYmxyKE
	JnxDbQeA4kUKV2pQP2Q9urnB7M/5JfQYpddajRAf5hc9NKKNNkLHCQ5XrCoU+RVbeLi2NoDrhFW
	xNReSJ3rjVQEKrcdXPZE6yYlxhb1m9ZsyjGJWTWek
X-Gm-Gg: AYBFou0enzywlWscJvi2nRLJD7XMpSujVv0X4zM2dnOEmhYzv+qmNa+oYI7J1JW8Tjs
	kVMvU371FMIILjRTWsJ8kYY6K59FOE1XQ8bbx1S0/XzMKvOmTEtYzDdJy+t/ww3QoF7G1YOe/zE
	7MnySiSpj81ItAyLGIfhJh0sQ6zchLnwZWViBec0gK/OAR+1g73zKNUtiGrQcj9zbOvycos7m/J
	46p3gmoEK1srV4lZFpXzzt5LXg9X2JuKpF3nwTI8x3yfKKcsX2k3ytq8jjlcXBxfoNpQQx3fbKP
	S4Aj3+JZhPZfEj20REWAikTAbHNPfn/zpLwCjaHF+oyA3BkP/LbPmVF3J5vOU1J+Dfa/ouLsdmx
	TxtmiJ/w6jw==
X-Received: by 2002:a05:622a:1f0c:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-535b4eca219mr39913141cf.8.1791846698966; Mon, 12 Oct 2026
 16:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012053013.14378-1-namhyung@kernel.org> <20261012053013.14378-4-namhyung@kernel.org>
 <CAP-5=fW1SSoyGKjaujZewF=b3rJ-0vp4kJ-friWNzOQWk+ki5A@mail.gmail.com> <as1n8CgDZxYlQkSK@google.com>
In-Reply-To: <as1n8CgDZxYlQkSK@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 16:11:27 -0700
X-Gm-Features: AclHuK-HHukluNicUj8GP7CFFxMUgqf9ZaEpkGApcagQdUXfvb0VwJu2TGe3iKw
Message-ID: <CAP-5=fXeufoS36+660zMnWksONa8UzbUo_MXyVzDtSDXVnWbfw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf test: Update PE file test for other locations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Oct 12, 2026 at 02:51:52PM -0700, Ian Rogers wrote:
> > On Sun, Oct 11, 2026 at 10:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > The test__pe_file_parsing() expects the test is in the tools/perf
> > > directory, but it could be root or a separate build directory.  Let's
> > > update the logic to try other paths like in the shell_tests__dir_fd()=
.
> > >
> > > Also add some debug messages to inform users why it's skipped.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/tests/pe-file-parsing.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe=
-file-parsing.c
> > > index 3979f38bf127c218..78dae7e43603b9f8 100644
> > > --- a/tools/perf/tests/pe-file-parsing.c
> > > +++ b/tools/perf/tests/pe-file-parsing.c
> > > @@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suit=
e *test __maybe_unused,
> > >  {
> > >         struct stat st;
> > >         char path_dir[PATH_MAX];
> > > +       static const char * const tests_dirs[] =3D {
> > > +               "./tools/perf/tests",
> > > +               "./tests",
> > > +               "./source/tests"
> >
> > I'm not sure where "source/tests" comes from?
>
> AFAIK it's set when you pass O=3D$(DIR) option when you build perf and it
> points the source tree.

Ah, Andi's change:
https://lore.kernel.org/r/20240807231823.898979-1-ak@linux.intel.com

> > nit: could we add the exec_path case to the list?
>
> It's checked right after. :)

Right, I think you can avoid the duplicated logic by having tests_dir
also have path_dir as the last entry. It'd mean always doing the
snprintf but performance doesn't matter much in a test.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Thanks,
> > Ian
> >
> > > +       };
> > >
> > >         /* First try development tree tests. */
> > > -       if (!lstat("./tests", &st))
> > > -               return run_dir("./tests");
> > > +       for (size_t i =3D 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> > > +               if (!lstat(tests_dirs[i], &st))
> > > +                       return run_dir(tests_dirs[i]);
> > > +       }
> > >
> > >         /* Then installed path. */
> > >         snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path()=
);
> > > @@ -85,6 +92,7 @@ static int test__pe_file_parsing(struct test_suite =
*test __maybe_unused,
> > >         if (!lstat(path_dir, &st))
> > >                 return run_dir(path_dir);
> > >
> > > +       pr_debug("cannot find the tests directory\n");
> > >         return TEST_SKIP;
> > >  }
> > >
> > > @@ -93,6 +101,7 @@ static int test__pe_file_parsing(struct test_suite=
 *test __maybe_unused,
> > >  static int test__pe_file_parsing(struct test_suite *test __maybe_unu=
sed,
> > >                           int subtest __maybe_unused)
> > >  {
> > > +       pr_debug("libbfd is not available\n");
> > >         return TEST_SKIP;
> > >  }
> > >
> > > --
> > > 2.55.0
> > >
