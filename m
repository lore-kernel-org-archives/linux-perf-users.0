Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86201E0DF5;
	Wed, 19 Mar 2025 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424685; cv=none; b=Y5Gj8ues/ODio76H3nPbFph6hm+tPCb+I3y1CpnctwcJ8UVgfQCVUw76QtnXSezBfXtZ01LtQpuXp17PkAF4Vkz359GAYSQfcQfwqbp+TnIElcOqxZNUwpUkIT+GMTIbQL1LH1lknaUg/HX7xCpCDipv/MWbwl5rIchLgIUYFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424685; c=relaxed/simple;
	bh=xV1h3Lo3+NyG6OtmsVjOMt1f5+YDo2UjANOSl80KhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvbQohGp8EQ+vgcMNaY9P+mwIRXohAX3HnqHaeDMic2NEi/y56UdMgxIjBj8iPll5zaroyZsaw1sMqu6VftLT14tZ8zp0JSPnW93S/Xr8NajhJ8BgEJr9mSncitSOOGjlQP9PQLStmBLoCvu46oFZNLX0Nl1RsMMDXhnu3KP7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDR8pB3e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDR8pB3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA64FC4CEE4;
	Wed, 19 Mar 2025 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742424684;
	bh=xV1h3Lo3+NyG6OtmsVjOMt1f5+YDo2UjANOSl80KhlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDR8pB3e3nddnlu4eZg+rnvZYgCiBSfcx0jhjQ/gyO663UgFPTEAW3EbzKonMgfMv
	 qFMENSlVGNohwkVOKNDFskQv1F4nrW2fBVwL6gpnjscZPE+hMGKtKULvPb2Yzwxu6a
	 EsJqryJa28wf9GFT88/o+aCdFKwtA6y8mNx8x4Cpnf8dg8OE8G6eV+IZtXGhl06/9L
	 niuBF4oWK6uzPXgjQj/0VdOoVdgJGwAK7Xd3QuZVXrYvOm4GJHzdSVhwMTKf5sTNWc
	 Mm+yWO+dlsyEWEUXllRy9wgzGRZAZ+dixfc5v1bmdfC3wdtRqLFSywJYuhnB36B/mW
	 p++UzTCa0ACWQ==
Date: Wed, 19 Mar 2025 15:51:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	mpetlan@redhat.com, tglozar@redhat.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2] perf test probe_vfs_getname: Skip if no suitable line
 detected
Message-ID: <Z9tKat6vvC1XUj0U@google.com>
References: <20250313165824.7711-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313165824.7711-1-jbrnak@redhat.com>

Hello,

On Thu, Mar 13, 2025 at 05:58:24PM +0100, Jakub Brnak wrote:
> In some cases when calling function add_probe_vfs_getname, line number
> can't be detected by perf probe -L getname_flags:
> 
>   78         atomic_set(&result->refcnt, 1);
> 
> 	     // one of the following lines should have line number
> 	     // but sometimes it does not because of optimization
> 	     result->uptr = filename;
>              result->aname = NULL;
> 
>   81         audit_getname(result);
> 
> To prevent false failures, skip the affected tests
> if no suitable line numbers can be detected.
> 
> 
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
> v2:
> - check if return from add_vfs_getname equals to 1 since
> it is only option in case of fail
> 
> v1: https://lore.kernel.org/linux-perf-users/Z8pAep0GJsMFTyEi@google.com/T/#t
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh          | 8 +++++++-
>  tools/perf/tests/shell/probe_vfs_getname.sh              | 8 +++++++-
>  .../perf/tests/shell/record+script_probe_vfs_getname.sh  | 8 +++++++-
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh        | 9 +++++++--
>  4 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 5c33ec7a5a63..89f72a4c818c 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -19,8 +19,14 @@ add_probe_vfs_getname() {
>  			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
>  			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
>  		fi
> +
> +		if [ -z "$line" ] ; then
> +			echo "Could not find probeable line"
> +			return 2
> +		fi
> +
>  		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> -		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
> +		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
>  	fi
>  }
>  
> diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
> index c51a32931af6..b210576f1971 100755
> --- a/tools/perf/tests/shell/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/probe_vfs_getname.sh
> @@ -13,7 +13,13 @@ skip_if_no_perf_probe || exit 2
>  # shellcheck source=lib/probe_vfs_getname.sh
>  . "$(dirname $0)"/lib/probe_vfs_getname.sh
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [[ $err -eq 1 ]] ; then

I got this error from shellcheck.

  In tests/shell/probe_vfs_getname.sh line 19:
  if [[ $err -eq 1 ]] ; then
     ^--------------^ SC3010 (warning): In POSIX sh, [[ ]] is undefined.
  
  For more information:
    https://www.shellcheck.net/wiki/SC3010 -- In POSIX sh, [[ ]] is undefined.

Thanks,
Namhyung


> +	skip_if_no_debuginfo
> +	err=$?
> +fi
> +
>  cleanup_probe_vfs_getname
>  exit $err
> diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> index fd5b10d46915..a26248d52628 100755
> --- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> @@ -35,8 +35,14 @@ perf_script_filenames() {
>  	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
>  }
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [[ $err -eq 1 ]] ; then
> +        skip_if_no_debuginfo
> +        err=$?
> +fi
> +
>  if [ $err -ne 0 ] ; then
>  	exit $err
>  fi
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 60fccb62c540..4956cd9be41f 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -25,9 +25,14 @@ trace_open_vfs_getname() {
>  	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
>  
> -
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [[ $err -eq 1 ]] ; then
> +        skip_if_no_debuginfo
> +        err=$?
> +fi
> +
>  if [ $err -ne 0 ] ; then
>  	exit $err
>  fi
> -- 
> 2.48.1
> 
