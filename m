Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAC313524;
	Thu, 13 Nov 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065526; cv=none; b=vFNcBQ5twYq2k0jLmAes+YAttbTlT0lFiVACiSzcgCdzVcY0fqbzOP2XklTiMnNIYqRvfmGPnQsl8ycG2hDvkJ6e/BvfTqAWfDP3PHj6misKNx9C/JbeRcb8HGNrs/wvsdnlyN4UefMVNQuZ3Y5s6zC9Kj4adW5ROsbS8lzEdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065526; c=relaxed/simple;
	bh=hMbap58dqPjNxTDTyluprXOh9BYFh3z+65TfKU1wV5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8U03XdPINiFu1QmSOBhgN8J2y7I1MBuvxg/M3ekfsGk27dkG3DHtcheSQ+WJ+P/zF66I1G56WCCGaGGsGKNSzt6HxZ5BcKpWj2X/20Yqpcb4Pq6g39sgXgIj3fCv8Ps0Z3LPOaJObuRreraXDYv58nzZoOPMJ64/1Om6o44Oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9AD7F340E2B;
	Thu, 13 Nov 2025 20:25:22 +0000 (UTC)
Date: Thu, 13 Nov 2025 21:25:18 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf libbfd: Ensure libbfd is initialized prior to use
Message-ID: <aRY-rtsJllzqwDYh@gentoo.org>
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

Dear Ian,

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

Apologies for the hiatus, just been quite busy at work, but following
the emails. Thank you very much for providing a fix, I tried to apply
it on perf-tools-next, and perf-tools, but got the build error below
(both before and after applying the patch):

gentoo linux $ git describe && make -B -C tools/perf -f Makefile.perf BUILD_BPF_SKEL=1 BUILD_NONDISTRO=1 WERROR=0 NO_SHELLCHECK=1 NO_CAPSTONE=1 DEBUG=1 2>&1 | tail -n 20
v6.18-rc4-182-gda32d155f4a8
  CC      util/perf_event_attr_fprintf.o
  CC      util/evswitch.o
  CC      util/find_bit.o
  CC      util/levenshtein.o
  CC      util/libbfd.o
In file included from /usr/include/bfd.h:10,
                 from /usr/include/dis-asm.h:36,
                 from /home/amadio/src/linux/tools/include/tools/dis-asm-compat.h:6,
                 from util/libbfd.c:14:
/usr/include/x86_64-pc-linux-gnu/bfd.h:35:2: error: #error config.h must be included before this header
   35 | #error config.h must be included before this header
      |  ^~~~~
make[3]: *** [/home/amadio/src/linux/tools/build/Makefile.build:86: util/libbfd.o] Error 1
make[3]: Leaving directory '/home/amadio/src/linux/tools/perf'
make[2]: *** [/home/amadio/src/linux/tools/build/Makefile.build:142: util] Error 2
make[2]: Leaving directory '/home/amadio/src/linux/tools/perf'
make[1]: *** [Makefile.perf:797: perf-util-in.o] Error 2
make[1]: Leaving directory '/home/amadio/src/linux/tools/perf'
make: *** [Makefile.perf:289: sub-make] Error 2
make: Leaving directory '/home/amadio/src/linux/tools/perf'

The header in /usr/include/x86_64-pc-linux-gnu/bfd.h:35 has this, right
after the include guards:

/* PR 14072: Ensure that config.h is included first.  */
#if !defined PACKAGE && !defined PACKAGE_VERSION
#error config.h must be included before this header
#endif

However, I did try a build with BUILD_NONDISTRO disabled and it works, so I'm
tempted to change things in Gentoo to have it always disabled or offer libbfd
support with a USE-flag but keep it off by default.

I bisected the build failure to the same commit you added in the Fixes tag:

 95931d9a594dd0b5f2191a6a6340549b8f3b031b is the first bad commit
 commit 95931d9a594dd0b5f2191a6a6340549b8f3b031b
 Author: Ian Rogers <irogers@google.com>
 Date:   Mon Sep 29 12:07:54 2025 -0700

     perf libbfd: Move libbfd functionality to its own file


This is the version of binutils-libs I have, in case it's useful:

gentoo linux $ qfile /usr/include/x86_64-pc-linux-gnu/bfd.h
sys-libs/binutils-libs: /usr/include/x86_64-pc-linux-gnu/bfd.h
gentoo linux $ equery l binutils-libs
 * Searching for binutils-libs ...
[IP-] [  ] sys-libs/binutils-libs-2.45.1:0/2.45.1
gentoo linux $ eselect binutils list
  [1] x86_64-pc-linux-gnu-2.44
  [2] x86_64-pc-linux-gnu-2.45.1 *

Since I couldn't build with the patch, I instead checked out the parent of the
commit above to check if "perf top" worked. However, it still crashed, so
I bisected the crash to this commit:

 53b00ff358dc75b12042b2b2aaf1d0e998fd0075 is the first bad commit
 commit 53b00ff358dc75b12042b2b2aaf1d0e998fd0075
 Author: Ian Rogers <irogers@google.com>
 Date:   Thu Jul 24 09:32:48 2025 -0700

     perf record: Make --buildid-mmap the default

(snip)

 Link: https://lore.kernel.org/r/20250724163302.596743-9-irogers@google.com

I hope this is useful in getting the issue better understood.

Best regards,
-Guilherme

> 
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
