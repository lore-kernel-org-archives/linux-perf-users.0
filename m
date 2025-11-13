Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C868313296
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066588; cv=none; b=sN6/JmdAb18ckfNY9BBy56iPmHrUYMyGwzRNpfYmEo0tL8XfsurHfCH0eEWXuCgRne1s6ZaAsoRi24mhLtKTXM/J5ZMVgzcsX+RzAU0ojukq2eU4xIBr+PIDGWtIUqWW/GEgLMaJqVx4nYCWS9dOkNzg3oyBv9N+4yrXt8CNr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066588; c=relaxed/simple;
	bh=DdBCjOxZp44RxGg1kTv+u/bNPKQ61xvO9+ai2DAE9Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=do6fHV0tQx6iX5b88rnjonayV/DJ3I6MRq66BAXpWLIJlK1i5XR1LN2fGF49FCs6gkUzCVM4EZJhLJwWS3A1QGtAuOMUYtVCIDlXTIg/tU9ubRzMCG5QiLcjLUXyfQ1q17nzDICXf/qRZ4gwJrbIkrb2pxulUjcLdu957C4QfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KC2N/dMd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KC2N/dMd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295c64cb951so49755ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763066586; x=1763671386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4ZRWYfrOgK7GB6iGAUuyC7jCNSfweOp4fkutoHLsWM=;
        b=KC2N/dMd8UNSumKzcUN8L+apb5H3jZCOvqJydDiQpvNQIfZrO5NIr3JU/btJoRd78u
         oiBljQqsGQyppm3Zve4cY5LQQLtgK9W7+nK5pQWG42nuN4U1cxaud921UTf1xT+xodde
         621GQKr4KXeb+yIZzjyF1ffGlMRC2J4vgC70h84YJEnCOPSWSq1xqrv5oGRIa4/c8PCE
         q2M1oRU9OK/v5bJzR4XYIns/Y82o0z2abjlQU/HfdidM0xzmUaQgKh81rpSlHfzDIzN9
         Q7/fRqJL5OqI0cd1oNgJfHjtxV/vhQ+dcVatUD/07FWOMbimyjURSWKxG9USRoUi9HVG
         HBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066586; x=1763671386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4ZRWYfrOgK7GB6iGAUuyC7jCNSfweOp4fkutoHLsWM=;
        b=Law0G6n6DEUNvVa5Z0td3T13z9dBug5imY5w0ASBQrn368zMMcQbXYjLBMwIZxlhaz
         U1xf4M7zZpGAaebeTG0G+Vo/Sn+FZTs9QrYngnNZXUaXwvRA3HX6pp+YHoVYrmjEPuXY
         uJRmHPn6Iw4Y6EpNXg1/b8xler3xmIxldAjIu/whY+7ps/9D4g2XcOsaSaqK6fojT5Wp
         eZm0hwq5Q8yxYPouM4x6b+QewpgbSFnBDoa/xXh8R4yvCC7jiePi3fP2STkU0lqjbGoY
         S+zFgfHerAicSuuIESSOmir84unaFEe9ORYxTyubYmDXqKJdd9t4Igzrz2D1dywZ+mmR
         s6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCE8xgQLSxyXp+eYhk3VWXvktXpPS7E8L4Z9rtyC/JxhzZBIMLHR1yL1PUdzicvcZAL8qE4k7V5BjrPsnM5PYG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb55j1SEmS/TFbqxyCbvarzrfNHmUsr0GyWluPZl+fSxCoYVxW
	hzFg0ZyAAq9IGf9jU3TfzpeTtfn4a/AtDh2sKjRrVmEQcC7LhiTq7SZm2pGUKRIiIjDhgaGMr7+
	ft0bzSehEELQj0+rYkWUkXY2SavAmFBFpF0hkbz5z
X-Gm-Gg: ASbGncuAy9/uSad77QphAg19Xb9I0NJPCCNJY2iUst8l7hlsuPKlzm0zUGLElTwvDFG
	jBYeJFyVX3HIqe1KYhV05PnlsizDd+z1K+emLKv8OL86gF5XbbRk9MDsGlpU1JdXViw+QkvvYrK
	qzIKfaV+X3f54xv7OkEkYoT0pXLtZrs/GF8IFZGFEOG6CwhG33j/A2gBSc/G+8mQy84m0ytRO3b
	A4Lggc90MBq89+bgNdAx1Vk9C81rm4icBZbLRELFQix+mN5KKfSnXHmxXahEtir3eu2OvdER//j
	l4/JSr13v+A5OaLVGbzqTKSAcYkRRA==
X-Google-Smtp-Source: AGHT+IEg1DvAH94a3iClW54LUV3iqQMotFqBt4osj+21JbDLtcfZqI059bfvx2acfI32Lqq1024uNUWjb6goqoT/rXU=
X-Received: by 2002:a17:902:f54b:b0:297:f0aa:d466 with SMTP id
 d9443c01a7336-29869e22c5emr800315ad.8.1763066586092; Thu, 13 Nov 2025
 12:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112074311.1440101-1-irogers@google.com> <CAP-5=fU6xad0EGzQ=gJy6eUJtYrgV2FKSu=JcndeWVTKZE_RrA@mail.gmail.com>
 <aRY-rtsJllzqwDYh@gentoo.org>
In-Reply-To: <aRY-rtsJllzqwDYh@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Nov 2025 12:42:54 -0800
X-Gm-Features: AWmQ_bm58PVJNlrsWXUrjhztWq6nZ0kLAKetgdvIni3tpDpqdRk9BivA1raEDxE
Message-ID: <CAP-5=fUnJqLT2gkRWLnoiUCEQ5GyMj7TCfrvcjusdtoV_Lhwug@mail.gmail.com>
Subject: Re: [PATCH v2] perf libbfd: Ensure libbfd is initialized prior to use
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:25=E2=80=AFPM Guilherme Amadio <amadio@gentoo.or=
g> wrote:
>
> Dear Ian,
>
> On Thu, Nov 13, 2025 at 09:03:42AM -0800, Ian Rogers wrote:
> > On Tue, Nov 11, 2025 at 11:43=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Multiple threads may be creating and destroying BFD objects in
> > > situations like `perf top`. Without appropriate initialization crashe=
s
> > > may occur during libbfd's cache management. BFD's locks require
> > > recursive mutexes, add support for these.
> > >
> > > Reported-by: Guilherme Amadio <amadio@gentoo.org>
> > > Closes: https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/
> > > Fixes: 95931d9a594d ("perf libbfd: Move libbfd functionality to its o=
wn file")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > I'm hoping adding the missing initialization is just obviously
> > correct, Guilherme if you could provide a Tested-by it would be great.
>
> Apologies for the hiatus, just been quite busy at work, but following
> the emails. Thank you very much for providing a fix, I tried to apply
> it on perf-tools-next, and perf-tools, but got the build error below
> (both before and after applying the patch):
>
> gentoo linux $ git describe && make -B -C tools/perf -f Makefile.perf BUI=
LD_BPF_SKEL=3D1 BUILD_NONDISTRO=3D1 WERROR=3D0 NO_SHELLCHECK=3D1 NO_CAPSTON=
E=3D1 DEBUG=3D1 2>&1 | tail -n 20
> v6.18-rc4-182-gda32d155f4a8
>   CC      util/perf_event_attr_fprintf.o
>   CC      util/evswitch.o
>   CC      util/find_bit.o
>   CC      util/levenshtein.o
>   CC      util/libbfd.o
> In file included from /usr/include/bfd.h:10,
>                  from /usr/include/dis-asm.h:36,
>                  from /home/amadio/src/linux/tools/include/tools/dis-asm-=
compat.h:6,
>                  from util/libbfd.c:14:
> /usr/include/x86_64-pc-linux-gnu/bfd.h:35:2: error: #error config.h must =
be included before this header
>    35 | #error config.h must be included before this header
>       |  ^~~~~
> make[3]: *** [/home/amadio/src/linux/tools/build/Makefile.build:86: util/=
libbfd.o] Error 1
> make[3]: Leaving directory '/home/amadio/src/linux/tools/perf'
> make[2]: *** [/home/amadio/src/linux/tools/build/Makefile.build:142: util=
] Error 2
> make[2]: Leaving directory '/home/amadio/src/linux/tools/perf'
> make[1]: *** [Makefile.perf:797: perf-util-in.o] Error 2
> make[1]: Leaving directory '/home/amadio/src/linux/tools/perf'
> make: *** [Makefile.perf:289: sub-make] Error 2
> make: Leaving directory '/home/amadio/src/linux/tools/perf'
>
> The header in /usr/include/x86_64-pc-linux-gnu/bfd.h:35 has this, right
> after the include guards:
>
> /* PR 14072: Ensure that config.h is included first.  */
> #if !defined PACKAGE && !defined PACKAGE_VERSION
> #error config.h must be included before this header
> #endif
>
> However, I did try a build with BUILD_NONDISTRO disabled and it works, so=
 I'm
> tempted to change things in Gentoo to have it always disabled or offer li=
bbfd
> support with a USE-flag but keep it off by default.
>
> I bisected the build failure to the same commit you added in the Fixes ta=
g:
>
>  95931d9a594dd0b5f2191a6a6340549b8f3b031b is the first bad commit
>  commit 95931d9a594dd0b5f2191a6a6340549b8f3b031b
>  Author: Ian Rogers <irogers@google.com>
>  Date:   Mon Sep 29 12:07:54 2025 -0700
>
>      perf libbfd: Move libbfd functionality to its own file
>
>
> This is the version of binutils-libs I have, in case it's useful:
>
> gentoo linux $ qfile /usr/include/x86_64-pc-linux-gnu/bfd.h
> sys-libs/binutils-libs: /usr/include/x86_64-pc-linux-gnu/bfd.h
> gentoo linux $ equery l binutils-libs
>  * Searching for binutils-libs ...
> [IP-] [  ] sys-libs/binutils-libs-2.45.1:0/2.45.1
> gentoo linux $ eselect binutils list
>   [1] x86_64-pc-linux-gnu-2.44
>   [2] x86_64-pc-linux-gnu-2.45.1 *
>
> Since I couldn't build with the patch, I instead checked out the parent o=
f the
> commit above to check if "perf top" worked. However, it still crashed, so
> I bisected the crash to this commit:
>
>  53b00ff358dc75b12042b2b2aaf1d0e998fd0075 is the first bad commit
>  commit 53b00ff358dc75b12042b2b2aaf1d0e998fd0075
>  Author: Ian Rogers <irogers@google.com>
>  Date:   Thu Jul 24 09:32:48 2025 -0700
>
>      perf record: Make --buildid-mmap the default
>
> (snip)
>
>  Link: https://lore.kernel.org/r/20250724163302.596743-9-irogers@google.c=
om
>
> I hope this is useful in getting the issue better understood.

Thanks Guilherme,

so I kind of figured this patch would be the problem. The issue is
that we're using build-IDs by default now, we use the libbfd code to
read build IDs, libbfd maintains a cache, because of a lack of proper
initialization/locking by perf the cache crashes. The crashes would
have been possible previously, say if you did a perf annotate and that
loaded lots of things using libbfd, however, those things don't happen
on threads, etc. we're just in a much more easy to crash situation
that build IDs are the default.

I couldn't repeat the config.h build failure. This looks like an issue
in the actual bfd.h and not the perf code. I checked the git logs but
didn't see anything that looked blame-able.

Thanks,
Ian

> Best regards,
> -Guilherme
>
> >
> > Thanks,
> > Ian
> >
> > > ---
> > > v2: Remove unneeded unistd.h include.
> > > ---
> > >  tools/perf/util/libbfd.c | 38 ++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/mutex.c  | 14 ++++++++++----
> > >  tools/perf/util/mutex.h  |  2 ++
> > >  3 files changed, 50 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > > index 01147fbf73b3..6434c2dccd4a 100644
> > > --- a/tools/perf/util/libbfd.c
> > > +++ b/tools/perf/util/libbfd.c
> > > @@ -38,6 +38,39 @@ struct a2l_data {
> > >         asymbol **syms;
> > >  };
> > >
> > > +static bool perf_bfd_lock(void *bfd_mutex)
> > > +{
> > > +       mutex_lock(bfd_mutex);
> > > +       return true;
> > > +}
> > > +
> > > +static bool perf_bfd_unlock(void *bfd_mutex)
> > > +{
> > > +       mutex_unlock(bfd_mutex);
> > > +       return true;
> > > +}
> > > +
> > > +static void perf_bfd_init(void)
> > > +{
> > > +       static struct mutex bfd_mutex;
> > > +
> > > +       mutex_init_recursive(&bfd_mutex);
> > > +
> > > +       if (bfd_init() !=3D BFD_INIT_MAGIC) {
> > > +               pr_err("Error initializing libbfd\n");
> > > +               return;
> > > +       }
> > > +       if (!bfd_thread_init(perf_bfd_lock, perf_bfd_unlock, &bfd_mut=
ex))
> > > +               pr_err("Error initializing libbfd threading\n");
> > > +}
> > > +
> > > +static void ensure_bfd_init(void)
> > > +{
> > > +       static pthread_once_t bfd_init_once =3D PTHREAD_ONCE_INIT;
> > > +
> > > +       pthread_once(&bfd_init_once, perf_bfd_init);
> > > +}
> > > +
> > >  static int bfd_error(const char *string)
> > >  {
> > >         const char *errmsg;
> > > @@ -132,6 +165,7 @@ static struct a2l_data *addr2line_init(const char=
 *path)
> > >         bfd *abfd;
> > >         struct a2l_data *a2l =3D NULL;
> > >
> > > +       ensure_bfd_init();
> > >         abfd =3D bfd_openr(path, NULL);
> > >         if (abfd =3D=3D NULL)
> > >                 return NULL;
> > > @@ -288,6 +322,7 @@ int dso__load_bfd_symbols(struct dso *dso, const =
char *debugfile)
> > >         bfd *abfd;
> > >         u64 start, len;
> > >
> > > +       ensure_bfd_init();
> > >         abfd =3D bfd_openr(debugfile, NULL);
> > >         if (!abfd)
> > >                 return -1;
> > > @@ -393,6 +428,7 @@ int libbfd__read_build_id(const char *filename, s=
truct build_id *bid, bool block
> > >         if (fd < 0)
> > >                 return -1;
> > >
> > > +       ensure_bfd_init();
> > >         abfd =3D bfd_fdopenr(filename, /*target=3D*/NULL, fd);
> > >         if (!abfd)
> > >                 return -1;
> > > @@ -421,6 +457,7 @@ int libbfd_filename__read_debuglink(const char *f=
ilename, char *debuglink,
> > >         asection *section;
> > >         bfd *abfd;
> > >
> > > +       ensure_bfd_init();
> > >         abfd =3D bfd_openr(filename, NULL);
> > >         if (!abfd)
> > >                 return -1;
> > > @@ -480,6 +517,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol =
*sym __maybe_unused,
> > >         memset(tpath, 0, sizeof(tpath));
> > >         perf_exe(tpath, sizeof(tpath));
> > >
> > > +       ensure_bfd_init();
> > >         bfdf =3D bfd_openr(tpath, NULL);
> > >         if (bfdf =3D=3D NULL)
> > >                 abort();
> > > diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> > > index bca7f0717f35..7aa1f3f55a7d 100644
> > > --- a/tools/perf/util/mutex.c
> > > +++ b/tools/perf/util/mutex.c
> > > @@ -17,7 +17,7 @@ static void check_err(const char *fn, int err)
> > >
> > >  #define CHECK_ERR(err) check_err(__func__, err)
> > >
> > > -static void __mutex_init(struct mutex *mtx, bool pshared)
> > > +static void __mutex_init(struct mutex *mtx, bool pshared, bool recur=
sive)
> > >  {
> > >         pthread_mutexattr_t attr;
> > >
> > > @@ -27,21 +27,27 @@ static void __mutex_init(struct mutex *mtx, bool =
pshared)
> > >         /* In normal builds enable error checking, such as recursive =
usage. */
> > >         CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRO=
RCHECK));
> > >  #endif
> > > +       if (recursive)
> > > +               CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MU=
TEX_RECURSIVE));
> > >         if (pshared)
> > >                 CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD=
_PROCESS_SHARED));
> > > -
> > >         CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
> > >         CHECK_ERR(pthread_mutexattr_destroy(&attr));
> > >  }
> > >
> > >  void mutex_init(struct mutex *mtx)
> > >  {
> > > -       __mutex_init(mtx, /*pshared=3D*/false);
> > > +       __mutex_init(mtx, /*pshared=3D*/false, /*recursive=3D*/false)=
;
> > >  }
> > >
> > >  void mutex_init_pshared(struct mutex *mtx)
> > >  {
> > > -       __mutex_init(mtx, /*pshared=3D*/true);
> > > +       __mutex_init(mtx, /*pshared=3D*/true, /*recursive=3D*/false);
> > > +}
> > > +
> > > +void mutex_init_recursive(struct mutex *mtx)
> > > +{
> > > +       __mutex_init(mtx, /*pshared=3D*/false, /*recursive=3D*/true);
> > >  }
> > >
> > >  void mutex_destroy(struct mutex *mtx)
> > > diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> > > index 38458f00846f..70232d8d094f 100644
> > > --- a/tools/perf/util/mutex.h
> > > +++ b/tools/perf/util/mutex.h
> > > @@ -104,6 +104,8 @@ void mutex_init(struct mutex *mtx);
> > >   * process-private attribute.
> > >   */
> > >  void mutex_init_pshared(struct mutex *mtx);
> > > +/* Initializes a mutex that may be recursively held on the same thre=
ad. */
> > > +void mutex_init_recursive(struct mutex *mtx);
> > >  void mutex_destroy(struct mutex *mtx);
> > >
> > >  void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
> > > --
> > > 2.51.2.1041.gc1ab5b90ca-goog
> > >
