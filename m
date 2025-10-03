Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B279EA;
	Fri,  3 Oct 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516199; cv=none; b=I2c518lsjRYiP4gboXyFuch6ibAJ2TW1RCYuIPFqftPrWWJaLfiIU3w3MxGnJFY44vQKNGuj0JgrSLRoGJHCoTCTlzreD6PYR871QDI/X/UoSE3SCbyKvp4MuMl0sQ9G231zvlvbjwIoiJn+7Z689hLc+OlaPH94GslqT4IslaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516199; c=relaxed/simple;
	bh=onOJ5ys1KMYAk9JvWnFYI0TO51mifrfPMJRG3aNQEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMbuaK/e+sda8Kt4LQ2WFlC8SbZ0I3fVnSdbS6y0NYv+9VzVIDMyuXOM29Ipz5RKv9bXGYzFsoJp9uiiEPjB00vOFHhSB+merHDXQf4hK/ph+mHX5f2T657WxtHImy8RTwcgTtlqYK3oOGRgSAzubo7IqQAtIK1ybp3ezJQBnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/PEpngk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/PEpngk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D02C4CEF5;
	Fri,  3 Oct 2025 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516198;
	bh=onOJ5ys1KMYAk9JvWnFYI0TO51mifrfPMJRG3aNQEKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/PEpngkRBBl01CGcdTVJ43gL4uDAYrZ3Wc2tC6JufHV64OL32g/eF1W+phKhQUFU
	 LjWLU9/rRg3nMMrL66gIHvtcX2sxW0SeFv5bOB2AR5NQuUvgIfqvf6IH4WTfkZGrUY
	 H/96kbmv3zNIFI2Ny7f2ah291O81WRsTo5zpHvXi0uFEbLN3F1vE8CGydkXcCbH38O
	 +Khs9gqZM+zIc6VyWaSw2KpcEt7S4C5SA6CETzVjFskEEVYd1/n9jVx/0oaaf1nwN2
	 WQkjb1oyXZmhY62uvd24R1cSW7Q9CDF79qCNereth7zY8weKvkT9SpUH5p8hAJnFgj
	 1/CoLAltkgfkg==
Date: Fri, 3 Oct 2025 15:29:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf namespaces: Avoid get_current_dir_name
 dependency
Message-ID: <aOAWI85KsassikIS@x1>
References: <20251003175613.2512296-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003175613.2512296-1-irogers@google.com>

On Fri, Oct 03, 2025 at 10:56:12AM -0700, Ian Rogers wrote:
> get_current_dir_name is a GNU extension not supported on, for example,
> Android. There is only one use of it so let's just switch to getcwd to
> avoid build and other complexity.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Fix free of oldcwd on errout.

Simple enough, applied both patches to perf-tools-next.

I'll now have to try and pick as few patches as possible so as to have
what is in perf-tools-next sit over the weekend on linux-next to then
send a pull req for 6.18.

- Arnaldo
> ---
>  tools/perf/Makefile.config             |  4 ----
>  tools/perf/util/Build                  |  1 -
>  tools/perf/util/get_current_dir_name.c | 18 ------------------
>  tools/perf/util/get_current_dir_name.h |  8 --------
>  tools/perf/util/namespaces.c           |  7 +++----
>  5 files changed, 3 insertions(+), 35 deletions(-)
>  delete mode 100644 tools/perf/util/get_current_dir_name.c
>  delete mode 100644 tools/perf/util/get_current_dir_name.h
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0f4b297fbacc..6cdb96576cb8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -417,10 +417,6 @@ ifeq ($(feature-eventfd), 1)
>    CFLAGS += -DHAVE_EVENTFD_SUPPORT
>  endif
>  
> -ifeq ($(feature-get_current_dir_name), 1)
> -  CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
> -endif
> -
>  ifeq ($(feature-gettid), 1)
>    CFLAGS += -DHAVE_GETTID
>  endif
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 5ead46dc98e7..9464eceb764b 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -23,7 +23,6 @@ perf-util-y += evsel_fprintf.o
>  perf-util-y += perf_event_attr_fprintf.o
>  perf-util-y += evswitch.o
>  perf-util-y += find_bit.o
> -perf-util-y += get_current_dir_name.o
>  perf-util-y += levenshtein.o
>  perf-util-y += mmap.o
>  perf-util-y += memswap.o
> diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
> deleted file mode 100644
> index e68935e9ac8c..000000000000
> --- a/tools/perf/util/get_current_dir_name.c
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> -//
> -#ifndef HAVE_GET_CURRENT_DIR_NAME
> -#include "get_current_dir_name.h"
> -#include <limits.h>
> -#include <string.h>
> -#include <unistd.h>
> -
> -/* Android's 'bionic' library, for one, doesn't have this */
> -
> -char *get_current_dir_name(void)
> -{
> -	char pwd[PATH_MAX];
> -
> -	return getcwd(pwd, sizeof(pwd)) == NULL ? NULL : strdup(pwd);
> -}
> -#endif // HAVE_GET_CURRENT_DIR_NAME
> diff --git a/tools/perf/util/get_current_dir_name.h b/tools/perf/util/get_current_dir_name.h
> deleted file mode 100644
> index 69f7d5537d32..000000000000
> --- a/tools/perf/util/get_current_dir_name.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> -//
> -#ifndef __PERF_GET_CURRENT_DIR_NAME_H
> -#ifndef HAVE_GET_CURRENT_DIR_NAME
> -char *get_current_dir_name(void);
> -#endif // HAVE_GET_CURRENT_DIR_NAME
> -#endif // __PERF_GET_CURRENT_DIR_NAME_H
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index 68f5de2d79c7..01502570b32d 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
> @@ -6,7 +6,6 @@
>  
>  #include "namespaces.h"
>  #include "event.h"
> -#include "get_current_dir_name.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> @@ -293,14 +292,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
>  	if (!nsi || !nsinfo__need_setns(nsi))
>  		return;
>  
> -	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
> +	if (!getcwd(curpath, sizeof(curpath)))
>  		return;
>  
> -	oldcwd = get_current_dir_name();
> +	oldcwd = strdup(curpath);
>  	if (!oldcwd)
>  		return;
>  
> -	oldns = open(curpath, O_RDONLY);
> +	oldns = open("/proc/self/ns/mnt", O_RDONLY);
>  	if (oldns < 0)
>  		goto errout;
>  
> -- 
> 2.51.0.618.g983fd99d29-goog
