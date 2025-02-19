Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2E1A841F;
	Wed, 19 Feb 2025 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001881; cv=none; b=kxHt75qmIZcT7u20lT3hxlrhKk5JZbomuapXmGv8fs5l2k51YtMyABG1Pp+bEjLZHGi0HWqHH32+xo+UhsFe4/rUMRQdW5rBjhOp96PIn5xr0TYtPdl/sM9QsT52P7l0wzJ6J81vK91jfX019onmL6dDfkrQsH0BtRgRV/jYeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001881; c=relaxed/simple;
	bh=H3b6RBRBHUE0izguuOJatBXxCTwXSbSbQM2q3tYgp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/49aJS7vtRVHMGAtNmNFqbpCfvL7RA7qtp8vIleSdAMVtfPZUB15ZaI+gDw3p5eFu6KX4275hGdWxm6C+oHd+UnY62ukuM/XI6woNnTmZCB62i3++slsc1BqJ4DNaeLPJOPGgOX3sG8t+uxQLOGcHcIWOfQo+CmgxdUpI8KoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV7UxlGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV7UxlGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC239C4CED1;
	Wed, 19 Feb 2025 21:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740001880;
	bh=H3b6RBRBHUE0izguuOJatBXxCTwXSbSbQM2q3tYgp34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV7UxlGVj0ncqLp/JM9yFF0uHiUZEUrNtTyVWGZlwPa5pZbrLs5NZmvmv+69qVOBH
	 Z0ai6brrQGeikxwsGJx02TscoGPySEGfrW/gnZFkYClVL1oLXW6+lfOJ/cA1koxNsA
	 Sn9nNjiKis6UV354PE6g29Ibl8c5jF4FZbBI+OYozNwUnG0HGCT+UAhZWcDyFKv4nY
	 S9xoxMdXg5P175kPji/2YI1catpKp32BvyeMGMC9faWXtjDGVLB1GMvQvTNQtUsW2K
	 YMVjytx5Mh5qGiCdigC8hk9a8R1Bzdcw7QOfGoE3FMYFx17gbCQb+8jqdCiy6ARauO
	 rBmNV/hB2kVbw==
Date: Wed, 19 Feb 2025 13:51:18 -0800
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
Message-ID: <Z7ZSVvmvYXD7Clnb@google.com>
References: <20250207232452.994822-1-irogers@google.com>
 <20250207232452.994822-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207232452.994822-2-irogers@google.com>

On Fri, Feb 07, 2025 at 03:24:42PM -0800, Ian Rogers wrote:
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb.
> 
> As getdents64 may be missing from libc, add support using syscall.
> Note, an earlier version of this patch had a feature test for
> getdents64 but there were problems on certains distros where
> getdents64 would be #define renamed to getdents breaking the code. The
> syscall use was made uncondtional to work around this. There is
> context in:
> https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/Makefile |  2 +-
>  tools/lib/api/io_dir.h | 93 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/api/io_dir.h
> 
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index 7f6396087b46..8665c799e0fa 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -95,7 +95,7 @@ install_lib: $(LIBFILE)
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
>  
> -HDRS := cpu.h debug.h io.h
> +HDRS := cpu.h debug.h io.h io_dir.h
>  FD_HDRS := fd/array.h
>  FS_HDRS := fs/fs.h fs/tracing_path.h
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
> diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> new file mode 100644
> index 000000000000..c84738923c96
> --- /dev/null
> +++ b/tools/lib/api/io_dir.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +/*
> + * Lightweight directory reading library.
> + */
> +#ifndef __API_IO_DIR__
> +#define __API_IO_DIR__
> +
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +
> +#if !defined(SYS_getdents64)
> +#if defined(__x86_64__)
> +#define SYS_getdents64 217
> +#elif defined(__aarch64__)
> +#define SYS_getdents64 61
> +#endif
> +#endif
> +
> +static inline ssize_t perf_getdents64(int fd, void *dirp, size_t count)
> +{
> +#ifdef MEMORY_SANITIZER
> +	memset(dirp, 0, count);
> +#endif
> +	return syscall(SYS_getdents64, fd, dirp, count);

Unfortunately this fails to build on my i386 vm (and probably other old
archs don't have SYS_getdents64 yet).

  In file included from util/pmus.c:6:
  /build/libapi/include/api/io_dir.h: In function 'perf_getdents64':
  /build/libapi/include/api/io_dir.h:28:24: error: 'SYS_getdents64' undeclared (first use in this function); did you mean 'perf_getdents64'?
     28 |         return syscall(SYS_getdents64, fd, dirp, count);
        |                        ^~~~~~~~~~~~~~
        |                        perf_getdents64

> +}
> +#endif

Maybe mismatched.

Thanks,
Namhyung

> +
> +struct io_dirent64 {
> +	ino64_t        d_ino;    /* 64-bit inode number */
> +	off64_t        d_off;    /* 64-bit offset to next structure */
> +	unsigned short d_reclen; /* Size of this dirent */
> +	unsigned char  d_type;   /* File type */
> +	char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
> +};
> +
> +struct io_dir {
> +	int dirfd;
> +	ssize_t available_bytes;
> +	struct io_dirent64 *next;
> +	struct io_dirent64 buff[4];
> +};
> +
> +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> +{
> +	iod->dirfd = dirfd;
> +	iod->available_bytes = 0;
> +}
> +
> +static inline void io_dir__rewinddir(struct io_dir *iod)
> +{
> +	lseek(iod->dirfd, 0, SEEK_SET);
> +	iod->available_bytes = 0;
> +}
> +
> +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> +{
> +	struct io_dirent64 *entry;
> +
> +	if (iod->available_bytes <= 0) {
> +		ssize_t rc = perf_getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
> +
> +		if (rc <= 0)
> +			return NULL;
> +		iod->available_bytes = rc;
> +		iod->next = iod->buff;
> +	}
> +	entry = iod->next;
> +	iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
> +	iod->available_bytes -= entry->d_reclen;
> +	return entry;
> +}
> +
> +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
> +{
> +	if (dent->d_type == DT_UNKNOWN) {
> +		struct stat st;
> +
> +		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
> +			return false;
> +
> +		if (S_ISDIR(st.st_mode)) {
> +			dent->d_type = DT_DIR;
> +			return true;
> +		}
> +	}
> +	return dent->d_type == DT_DIR;
> +}
> +
> +#endif
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 
