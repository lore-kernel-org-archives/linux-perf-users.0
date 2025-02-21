Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB91E3DCF;
	Fri, 21 Feb 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119467; cv=none; b=eokYNAyHqoV+v4sSZqQtwjrIR9BYRt2nWYLyFBHXBds2KXI7+/YCDvOSkfLd91IaRV/8OkujoVl9KjBqaYYhZJUXmXcXrxcx7Jc2nacch0r6sNajA+B2xUKHSMA2n1MlihGGFhCRyyKsAduTEOarjTgFNzKg5e7KrzMEWkPgDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119467; c=relaxed/simple;
	bh=P7Lf8hYvd8ISwW/UTT8lmB7v+1omLRT5e7HGLeY1S/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwK2VlGS8iO67bDHXGle4VyhiEn0LKIZrGOIvCphoBcnollmcZ2ZD43+VwoWvFD3FBsKSDGljdtNU1bWGw9wesC5pl6/copQT6J/2FDm+EBzfu5ekl3qmSHNbIqB6uZ6xYsEB/2fcawTauH4oL0GQww56f1qsdKnZ/qwyf70Azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU0MJqMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU0MJqMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87CEC4CED6;
	Fri, 21 Feb 2025 06:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740119466;
	bh=P7Lf8hYvd8ISwW/UTT8lmB7v+1omLRT5e7HGLeY1S/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hU0MJqMWaVz6gBch0iHIwUGe/a0X9UfRIPOjL8Yg6d7pLzifVwla3d8nNu31KxHl2
	 h7R8fmT9HgcY2zZL4T8G31jaHyNRjWss5oOa2iwfaVTAlObHmxioYdML/VFZ9tgRrP
	 hBSSYxM+qniXprserA0IuUzYya9f7pjG1NakBYt1b6MSopOtY5tj2IeDrU2Wnd681q
	 Xtxjh2xTnYgGyzdujYSOmSo0msohXYREXIq5KizedRrD3TXkZw8eBhVt6lqplkAvMh
	 MMdqqNuYW6AHljLynoQGVCnoehVFd9EJywccRzjz467FiZ4HcTUS5jeqVaz3LbzNeo
	 X6o+3+QvlRdwQ==
Date: Thu, 20 Feb 2025 22:31:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>,
	Jesper Juhl <jesperjuhl76@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Subject: Re: [PATCH v2 1/7] tools lib api: Add io_dir an allocation free
 readdir alternative
Message-ID: <Z7gdqIQA6lrwivXt@google.com>
References: <20250207232452.994822-1-irogers@google.com>
 <20250207232452.994822-2-irogers@google.com>
 <Z7ZSVvmvYXD7Clnb@google.com>
 <CAP-5=fWukOvV4EKbn1n=rhBO1LBf9m040=WXEweeFXAr3GCiQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWukOvV4EKbn1n=rhBO1LBf9m040=WXEweeFXAr3GCiQA@mail.gmail.com>

On Wed, Feb 19, 2025 at 02:21:45PM -0800, Ian Rogers wrote:
> On Wed, Feb 19, 2025 at 1:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Feb 07, 2025 at 03:24:42PM -0800, Ian Rogers wrote:
> > > glibc's opendir allocates a minimum of 32kb, when called recursively
> > > for a directory tree the memory consumption can add up - nearly 300kb
> > > during perf start-up when processing modules. Add a stack allocated
> > > variant of readdir sized a little more than 1kb.
> > >
> > > As getdents64 may be missing from libc, add support using syscall.
> > > Note, an earlier version of this patch had a feature test for
> > > getdents64 but there were problems on certains distros where
> > > getdents64 would be #define renamed to getdents breaking the code. The
> > > syscall use was made uncondtional to work around this. There is
> > > context in:
> > > https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/api/Makefile |  2 +-
> > >  tools/lib/api/io_dir.h | 93 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 94 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/lib/api/io_dir.h
> > >
> > > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > > index 7f6396087b46..8665c799e0fa 100644
> > > --- a/tools/lib/api/Makefile
> > > +++ b/tools/lib/api/Makefile
> > > @@ -95,7 +95,7 @@ install_lib: $(LIBFILE)
> > >               $(call do_install_mkdir,$(libdir_SQ)); \
> > >               cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> > >
> > > -HDRS := cpu.h debug.h io.h
> > > +HDRS := cpu.h debug.h io.h io_dir.h
> > >  FD_HDRS := fd/array.h
> > >  FS_HDRS := fs/fs.h fs/tracing_path.h
> > >  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
> > > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > > new file mode 100644
> > > index 000000000000..c84738923c96
> > > --- /dev/null
> > > +++ b/tools/lib/api/io_dir.h
> > > @@ -0,0 +1,93 @@
> > > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > > +/*
> > > + * Lightweight directory reading library.
> > > + */
> > > +#ifndef __API_IO_DIR__
> > > +#define __API_IO_DIR__
> > > +
> > > +#include <dirent.h>
> > > +#include <fcntl.h>
> > > +#include <stdlib.h>
> > > +#include <unistd.h>
> > > +#include <sys/stat.h>
> > > +#include <sys/syscall.h>
> > > +
> > > +#if !defined(SYS_getdents64)
> > > +#if defined(__x86_64__)
> > > +#define SYS_getdents64 217
> > > +#elif defined(__aarch64__)
> > > +#define SYS_getdents64 61
> > > +#endif
> > > +#endif
> > > +
> > > +static inline ssize_t perf_getdents64(int fd, void *dirp, size_t count)
> > > +{
> > > +#ifdef MEMORY_SANITIZER
> > > +     memset(dirp, 0, count);
> > > +#endif
> > > +     return syscall(SYS_getdents64, fd, dirp, count);
> >
> > Unfortunately this fails to build on my i386 vm (and probably other old
> > archs don't have SYS_getdents64 yet).
> >
> >   In file included from util/pmus.c:6:
> >   /build/libapi/include/api/io_dir.h: In function 'perf_getdents64':
> >   /build/libapi/include/api/io_dir.h:28:24: error: 'SYS_getdents64' undeclared (first use in this function); did you mean 'perf_getdents64'?
> >      28 |         return syscall(SYS_getdents64, fd, dirp, count);
> >         |                        ^~~~~~~~~~~~~~
> >         |                        perf_getdents64
> >
> > > +}
> > > +#endif
> >
> > Maybe mismatched.
> 
> So even on 32-bit systems we want getdents64 as getdents encodes the
> d_type at the end of dirent making it hard to index. On i386 we know
> the number of the syscall for perf trace:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl?h=perf-tools-next#n235
> So we can presumably change:
> ```
> #if !defined(SYS_getdents64)
> #if defined(__x86_64__)
> #define SYS_getdents64 217
> #elif defined(__aarch64__)
> #define SYS_getdents64 61
> #endif
> #endif
> ```
> to also have:
> ```
> #elif defined(__i386__)
> #define SYS_getdents64 220
> ```
> Could you test this so that I don't need to resend 7 patches for each
> architecture you test upon? The man page says <sys/syscall.h> and
> <unistd.h> should be sufficient for the code to work, so I think
> addressing this is adding workarounds for distros that aren't
> conformant - ie its the distro's fault the code fails to compile and
> not the tool's.

It fixes the issue on my machine but I'm afraid others will see the same
issue on other archs.  I think <sys/syscall.h> should provide the number
for the syscall but the problem is old distros which didn't ship recent
headers.  So it's a matter of how long the tool needs to support such an
old one. :(

Thanks,
Namhyung

> >
> > > +
> > > +struct io_dirent64 {
> > > +     ino64_t        d_ino;    /* 64-bit inode number */
> > > +     off64_t        d_off;    /* 64-bit offset to next structure */
> > > +     unsigned short d_reclen; /* Size of this dirent */
> > > +     unsigned char  d_type;   /* File type */
> > > +     char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
> > > +};
> > > +
> > > +struct io_dir {
> > > +     int dirfd;
> > > +     ssize_t available_bytes;
> > > +     struct io_dirent64 *next;
> > > +     struct io_dirent64 buff[4];
> > > +};
> > > +
> > > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > > +{
> > > +     iod->dirfd = dirfd;
> > > +     iod->available_bytes = 0;
> > > +}
> > > +
> > > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > > +{
> > > +     lseek(iod->dirfd, 0, SEEK_SET);
> > > +     iod->available_bytes = 0;
> > > +}
> > > +
> > > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> > > +{
> > > +     struct io_dirent64 *entry;
> > > +
> > > +     if (iod->available_bytes <= 0) {
> > > +             ssize_t rc = perf_getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
> > > +
> > > +             if (rc <= 0)
> > > +                     return NULL;
> > > +             iod->available_bytes = rc;
> > > +             iod->next = iod->buff;
> > > +     }
> > > +     entry = iod->next;
> > > +     iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
> > > +     iod->available_bytes -= entry->d_reclen;
> > > +     return entry;
> > > +}
> > > +
> > > +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
> > > +{
> > > +     if (dent->d_type == DT_UNKNOWN) {
> > > +             struct stat st;
> > > +
> > > +             if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
> > > +                     return false;
> > > +
> > > +             if (S_ISDIR(st.st_mode)) {
> > > +                     dent->d_type = DT_DIR;
> > > +                     return true;
> > > +             }
> > > +     }
> > > +     return dent->d_type == DT_DIR;
> > > +}
> > > +
> > > +#endif
> > > --
> > > 2.48.1.502.g6dc24dfdaf-goog
> > >
