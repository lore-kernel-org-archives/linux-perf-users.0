Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3E35CBDF;
	Thu, 13 Nov 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066550; cv=none; b=T3tyh6t02di2zxD56aBYDemo/TnXqLwQGsQ886f6dUUhYOVQTNRwSdGiaFQcTyppaEt14ykcoBwD4pznnJwjv2P2EU4r6lHcBDYXGJ09m5MsTmun7keyRK91KZ5t4re3tov2PyPBkS6kqXEe1lHMj9NcKAXgQFdjL9BGfrAyhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066550; c=relaxed/simple;
	bh=E6tb3rBJKXvvigE+N9ImHISEUjSlbUp6V7kM2T3iI+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpcUf+IDRUBkslHoubkb7nwliJUSj3vJuG/mFQBfie46LahOaWcVzFgqCcARamak8uZs1ZaNnD2oNdFkWbcvlBypvJ15f1cIgqghDo3RaIfywNjtkTCIMEVdZTvMLYIJbcSvCRz0/TbNJ9AR1uPcDTiU1bZFIlb3UsceO1/TNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Foj1K5vc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Foj1K5vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3E1C4CEF5;
	Thu, 13 Nov 2025 20:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763066550;
	bh=E6tb3rBJKXvvigE+N9ImHISEUjSlbUp6V7kM2T3iI+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Foj1K5vcVek8tOhBZgQzpn7hXSONG/V4XWbBT6HjNejFkTx2xRwWHBmUj0ratxdKd
	 kulO/5M0GrCgyoR3X/VXRkp0Y4aweO8fzKLMpmvQzHZuz+0wxWtDCcbUfe6nONkdLx
	 vt8tjqDK1/V/GeN8/NWLKzpwa46OII43couux3atzQYkIXb17mi3uk1UMdjVVd/76V
	 EYgaXeYhLEjsitv33EUc3cX+0CAZO/yqU79BlqLJkzHJeKAmPYGiHuRVi77EMZGJA8
	 5DsX1b39nJuKk8JBnfLzyKf+PT6EbPxL0eeGj6ept9tqVs2EHU/Uq740QtJuUUHdbz
	 q8AGTXQhLXMZw==
Date: Thu, 13 Nov 2025 17:42:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Guilherme Amadio <amadio@gentoo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf libbfd: Ensure libbfd is initialized prior to use
Message-ID: <aRZCsU8x0ebgxT6R@x1>
References: <20251112074311.1440101-1-irogers@google.com>
 <CAP-5=fU6xad0EGzQ=gJy6eUJtYrgV2FKSu=JcndeWVTKZE_RrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6xad0EGzQ=gJy6eUJtYrgV2FKSu=JcndeWVTKZE_RrA@mail.gmail.com>

On Thu, Nov 13, 2025 at 09:03:42AM -0800, Ian Rogers wrote:
> On Tue, Nov 11, 2025 at 11:43 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Multiple threads may be creating and destroying BFD objects in
> > situations like `perf top`. Without appropriate initialization crashes
> > may occur during libbfd's cache management. BFD's locks require
> > recursive mutexes, add support for these.
> >
> > Reported-by: Guilherme Amadio <amadio@gentoo.org>
> > Closes: https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/
> > Fixes: 95931d9a594d ("perf libbfd: Move libbfd functionality to its own file")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> I'm hoping adding the missing initialization is just obviously
> correct, Guilherme if you could provide a Tested-by it would be great.

I reproduced the problem by building with BUILD_NONDISTRO=1 + having
binutils-devel installed, 'perf top' segfaults straight away.

After applying this patch things gets back to normal.

Thanks, applied.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> > v2: Remove unneeded unistd.h include.
> > ---
> >  tools/perf/util/libbfd.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/mutex.c  | 14 ++++++++++----
> >  tools/perf/util/mutex.h  |  2 ++
> >  3 files changed, 50 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > index 01147fbf73b3..6434c2dccd4a 100644
> > --- a/tools/perf/util/libbfd.c
> > +++ b/tools/perf/util/libbfd.c
> > @@ -38,6 +38,39 @@ struct a2l_data {
> >         asymbol **syms;
> >  };
> >
> > +static bool perf_bfd_lock(void *bfd_mutex)
> > +{
> > +       mutex_lock(bfd_mutex);
> > +       return true;
> > +}
> > +
> > +static bool perf_bfd_unlock(void *bfd_mutex)
> > +{
> > +       mutex_unlock(bfd_mutex);
> > +       return true;
> > +}
> > +
> > +static void perf_bfd_init(void)
> > +{
> > +       static struct mutex bfd_mutex;
> > +
> > +       mutex_init_recursive(&bfd_mutex);
> > +
> > +       if (bfd_init() != BFD_INIT_MAGIC) {
> > +               pr_err("Error initializing libbfd\n");
> > +               return;
> > +       }
> > +       if (!bfd_thread_init(perf_bfd_lock, perf_bfd_unlock, &bfd_mutex))
> > +               pr_err("Error initializing libbfd threading\n");
> > +}
> > +
> > +static void ensure_bfd_init(void)
> > +{
> > +       static pthread_once_t bfd_init_once = PTHREAD_ONCE_INIT;
> > +
> > +       pthread_once(&bfd_init_once, perf_bfd_init);
> > +}
> > +
> >  static int bfd_error(const char *string)
> >  {
> >         const char *errmsg;
> > @@ -132,6 +165,7 @@ static struct a2l_data *addr2line_init(const char *path)
> >         bfd *abfd;
> >         struct a2l_data *a2l = NULL;
> >
> > +       ensure_bfd_init();
> >         abfd = bfd_openr(path, NULL);
> >         if (abfd == NULL)
> >                 return NULL;
> > @@ -288,6 +322,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
> >         bfd *abfd;
> >         u64 start, len;
> >
> > +       ensure_bfd_init();
> >         abfd = bfd_openr(debugfile, NULL);
> >         if (!abfd)
> >                 return -1;
> > @@ -393,6 +428,7 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block
> >         if (fd < 0)
> >                 return -1;
> >
> > +       ensure_bfd_init();
> >         abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
> >         if (!abfd)
> >                 return -1;
> > @@ -421,6 +457,7 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
> >         asection *section;
> >         bfd *abfd;
> >
> > +       ensure_bfd_init();
> >         abfd = bfd_openr(filename, NULL);
> >         if (!abfd)
> >                 return -1;
> > @@ -480,6 +517,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
> >         memset(tpath, 0, sizeof(tpath));
> >         perf_exe(tpath, sizeof(tpath));
> >
> > +       ensure_bfd_init();
> >         bfdf = bfd_openr(tpath, NULL);
> >         if (bfdf == NULL)
> >                 abort();
> > diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> > index bca7f0717f35..7aa1f3f55a7d 100644
> > --- a/tools/perf/util/mutex.c
> > +++ b/tools/perf/util/mutex.c
> > @@ -17,7 +17,7 @@ static void check_err(const char *fn, int err)
> >
> >  #define CHECK_ERR(err) check_err(__func__, err)
> >
> > -static void __mutex_init(struct mutex *mtx, bool pshared)
> > +static void __mutex_init(struct mutex *mtx, bool pshared, bool recursive)
> >  {
> >         pthread_mutexattr_t attr;
> >
> > @@ -27,21 +27,27 @@ static void __mutex_init(struct mutex *mtx, bool pshared)
> >         /* In normal builds enable error checking, such as recursive usage. */
> >         CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
> >  #endif
> > +       if (recursive)
> > +               CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE));
> >         if (pshared)
> >                 CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
> > -
> >         CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
> >         CHECK_ERR(pthread_mutexattr_destroy(&attr));
> >  }
> >
> >  void mutex_init(struct mutex *mtx)
> >  {
> > -       __mutex_init(mtx, /*pshared=*/false);
> > +       __mutex_init(mtx, /*pshared=*/false, /*recursive=*/false);
> >  }
> >
> >  void mutex_init_pshared(struct mutex *mtx)
> >  {
> > -       __mutex_init(mtx, /*pshared=*/true);
> > +       __mutex_init(mtx, /*pshared=*/true, /*recursive=*/false);
> > +}
> > +
> > +void mutex_init_recursive(struct mutex *mtx)
> > +{
> > +       __mutex_init(mtx, /*pshared=*/false, /*recursive=*/true);
> >  }
> >
> >  void mutex_destroy(struct mutex *mtx)
> > diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> > index 38458f00846f..70232d8d094f 100644
> > --- a/tools/perf/util/mutex.h
> > +++ b/tools/perf/util/mutex.h
> > @@ -104,6 +104,8 @@ void mutex_init(struct mutex *mtx);
> >   * process-private attribute.
> >   */
> >  void mutex_init_pshared(struct mutex *mtx);
> > +/* Initializes a mutex that may be recursively held on the same thread. */
> > +void mutex_init_recursive(struct mutex *mtx);
> >  void mutex_destroy(struct mutex *mtx);
> >
> >  void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >
