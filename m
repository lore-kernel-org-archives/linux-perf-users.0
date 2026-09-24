Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9C33EB17;
	Thu, 24 Sep 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289051; cv=none; b=QNCZXWQsPS1MQX/gEyJRsmydjIpCX1eW8YYfBWZlEDqMmytTdZiOFSSA+xtnR14xkrTvNC8iEecb6ykpMBLqbtmNMPmHol84YkHJGep8Uh6Yo0jbrSZW7vO5ZdeS/8qqNeW6JV8/eU7JcuFWnChLxCLUTxS2SKB2uW4eQGtFBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289051; c=relaxed/simple;
	bh=cpPJRa1lXkq0wJljIvXhRZLEL9o4KXxDl6/ZTG63+UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuXgtYASc3IlBblzzTJXDLfcMl6HZS30vjGzKwl9JspB3g5z8d3PKcF7uHU+QooW+wTl4FJM9248JD5GhiHOTw3puD5kmx6ZS7tEgyHBiJ3dZJrQ29KBwxYifhMTkHgp6e7y6I1VVB0rS0AfjuxIXst4Kt53uyLbhNJo0UcC9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTcbJpTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTcbJpTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E611F000FF;
	Thu, 24 Sep 2026 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289050;
	bh=rW61pGXNeD2X1UJL+FWGfDEslXamE4AP8axw+i1v+Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTcbJpTm2Y0iEhEzbqrctw0zYtKjhAzc00Zlahjw/eLJ8rrJVKLC2EhjAyzBx2HVU
	 but05vlzRQ3S7gTrKXMxSH8Wp7ezdMmvW2rzgF/0FIEvrWxtOXFq39ZBwgnmv70WDO
	 +qszbai5jxFZ2rRhBiyZ2iYM1HwCMHBjcKnM2bAFV4Yq8pclZN+JOb3T26vxRwmTf3
	 OuF0Mv99VzdF3qY3EGXqi3S7L0GBlVR2hqePSg+OMwKCOKTS/0hXExJiMauz1zoYgK
	 K1unjfD343+h0srZJ7M7WPU/UorMwhH9F21ZFu7gdoGQeLacYHzwXHB+8jdqqe/Ghq
	 4ywRMid8SPWQg==
Date: Thu, 24 Sep 2026 15:30:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: irogers@google.com, acme@kernel.org, changbin.du@huawei.com,
	adrian.hunter@intel.com, jolsa@kernel.org, mingo@redhat.com,
	peterz@infradead.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH v3] perf symbols: Apply the symfs flat layout to the
 composed filename
Message-ID: <arWkmNKRbzF2FhoA@google.com>
References: <20260922131952.2922816-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922131952.2922816-1-zhanxusheng@xiaomi.com>

Hello,

On Tue, Sep 22, 2026 at 09:19:52PM +0800, Zhan Xusheng wrote:
> --symfs=<dir>,flat documents itself as matching only the base name, so a
> debuginfo lookup for /usr/lib/x86_64-linux-gnu/libc.so.6 should land on
> <dir>/libc.so.6.debug.  It lands on
> <dir>/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug instead, because the
> layout is applied to a fixed prefix and the file name arrives afterwards:
> 
> 	len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
> 	snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
> 
> perf_basename() only ever sees "/usr/lib/debug", so neither layout comes
> out of it.
> 
> Compose the path as it would appear on the profiled system and join it
> once, which puts the layout on the whole name.  That covers
> FEDORA_DEBUGINFO, UBUNTU_DEBUGINFO, MIXEDUP_UBUNTU_DEBUGINFO,
> OPENEMBEDDED_DEBUGINFO and BUILDID_DEBUGINFO, plus the same composition in
> build_id_cache__find_debug().
> 
> BUILDID_DEBUGINFO needs one more step: the build id cache splits the first
> two characters of the build id off into a directory name, so the basename
> of the hierarchy path is only part of the build id.  Name the flat file
> after the whole build id.
> 
> dso__disassemble_filename() passes a path from perf's own build id cache
> rather than one on the profiled system, and every entry there is named
> "elf" or "debug".  Use path__join() so the layout does not apply.
> 
> With --symfs /s,flat the lookups are now /s/libc.so.6, /s/libc.so.6.debug,
> /s/sleep and /s/<build id>.debug.  hierarchy is unchanged.
> 
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> v2->v3: different approach.  v1 and v2 took the four sites out of the
> layout; Namhyung asked for the layout to be made to work instead, so v3
> composes the filename first and joins once.
> 
> v2: https://lore.kernel.org/r/20260819094621.844115-1-zhanxusheng@xiaomi.com
> 
> Traced openat()/newfstatat() under --symfs /s,flat and /s,hierarchy with
> perf record -- sleep 0.3 before and after: flat goes from 21 paths to 15,
> hierarchy is identical at 21.
>  tools/perf/util/build-id.c | 12 +++++++----
>  tools/perf/util/disasm.c   |  8 ++++++-
>  tools/perf/util/dso.c      | 43 +++++++++++++++++++++++++-------------
>  3 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index eb95ab90f974..02233ef0eaff 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -586,9 +586,9 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
>  	const char *dirname = "/usr/lib/debug/.build-id/";
>  	char *realname = NULL;
>  	char dirbuf[PATH_MAX];
> +	char pathbuf[PATH_MAX];
>  	char *debugfile;
>  	struct nscookie nsc;
> -	size_t len = 0;
>  
>  	debugfile = calloc(1, PATH_MAX);
>  	if (!debugfile)
> @@ -599,9 +599,13 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
>  		dirname = dirbuf;
>  	}
>  
> -	len = __symbol__join_symfs(debugfile, PATH_MAX, dirname);
> -	snprintf(debugfile + len, PATH_MAX - len, "%.2s/%s.debug", sbuild_id,
> -		 sbuild_id + 2);
> +	/* See the build id note in dso__read_binary_type_filename(). */
> +	if (symbol_conf.symfs_layout_flat)
> +		scnprintf(pathbuf, PATH_MAX, "/%s.debug", sbuild_id);
> +	else
> +		scnprintf(pathbuf, PATH_MAX, "%s%.2s/%s.debug", dirname,
> +			  sbuild_id, sbuild_id + 2);
> +	__symbol__join_symfs(debugfile, PATH_MAX, pathbuf);
>  
>  	nsinfo__mountns_enter(nsi, &nsc);
>  	realname = realpath(debugfile, NULL);
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 6cfdbabbb8c7..1148dde6c975 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -31,6 +31,7 @@
>  #include "map.h"
>  #include "maps.h"
>  #include "namespaces.h"
> +#include "path.h"
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "thread.h"
> @@ -1173,7 +1174,12 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  
>  	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
>  	if (build_id_filename) {
> -		__symbol__join_symfs(filename, filename_size, build_id_filename);
> +		/*
> +		 * This is a path in perf's own build id cache, not a path on
> +		 * the profiled system, so the symfs layout does not apply.
> +		 */
> +		path__join(filename, filename_size, symbol_conf.symfs,
> +			   build_id_filename);
>  		free(build_id_filename);
>  	} else {
>  		if (dso__has_build_id(dso))
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 42bfe30a3b51..e52de7cc1bc6 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -115,6 +115,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  				   const char *root_dir, char *filename, size_t size)
>  {
>  	char build_id_hex[SBUILD_ID_SIZE];
> +	char relative[PATH_MAX];
>  	int ret = 0;
>  	size_t len;
>  
> @@ -167,13 +168,15 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  		break;
>  
>  	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
> -		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
> -		snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
> +		snprintf(relative, sizeof(relative), "/usr/lib/debug%s.debug",
> +			 dso__long_name(dso));
> +		__symbol__join_symfs(filename, size, relative);
>  		break;
>  
>  	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> -		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
> -		snprintf(filename + len, size - len, "%s", dso__long_name(dso));
> +		snprintf(relative, sizeof(relative), "/usr/lib/debug%s",
> +			 dso__long_name(dso));
> +		__symbol__join_symfs(filename, size, relative);
>  		break;
>  
>  	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
> @@ -187,8 +190,9 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  			ret = -1;
>  			break;
>  		}
> -		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
> -		snprintf(filename + len, size - len, "%s", dso__long_name(dso) + 4);
> +		snprintf(relative, sizeof(relative), "/usr/lib/debug%s",
> +			 dso__long_name(dso) + 4);
> +		__symbol__join_symfs(filename, size, relative);
>  		break;
>  
>  	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
> @@ -200,15 +204,15 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  		while (last_slash != dso__long_name(dso) && *last_slash != '/')
>  			last_slash--;
>  
> -		len = __symbol__join_symfs(filename, size, "");
>  		dir_size = last_slash - dso__long_name(dso) + 2;
> -		if (dir_size > (size - len)) {
> +		if (dir_size > sizeof(relative)) {
>  			ret = -1;
>  			break;
>  		}
> -		len += scnprintf(filename + len, dir_size, "%s",  dso__long_name(dso));
> -		len += scnprintf(filename + len , size - len, ".debug%s",
> -								last_slash);
> +		len = scnprintf(relative, dir_size, "%s", dso__long_name(dso));
> +		scnprintf(relative + len, sizeof(relative) - len, ".debug%s",
> +			  last_slash);
> +		__symbol__join_symfs(filename, size, relative);
>  		break;
>  	}
>  
> @@ -219,9 +223,20 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  		}
>  
>  		build_id__snprintf(dso__bid(dso), build_id_hex, sizeof(build_id_hex));
> -		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
> -		snprintf(filename + len, size - len, "%.2s/%s.debug",
> -			 build_id_hex, build_id_hex + 2);
> +		/*
> +		 * The build id cache layout splits the first two characters off
> +		 * into a directory name, so the basename of the hierarchy path
> +		 * is only part of the build id. Name the flat file after the
> +		 * whole build id instead.
> +		 */
> +		if (symbol_conf.symfs_layout_flat)
> +			snprintf(relative, sizeof(relative), "/%s.debug",
> +				 build_id_hex);
> +		else
> +			snprintf(relative, sizeof(relative),
> +				 "/usr/lib/debug/.build-id/%.2s/%s.debug",
> +				 build_id_hex, build_id_hex + 2);
> +		__symbol__join_symfs(filename, size, relative);
>  		break;
>  
>  	case DSO_BINARY_TYPE__VMLINUX:
> 
> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> -- 
> 2.43.0
> 
