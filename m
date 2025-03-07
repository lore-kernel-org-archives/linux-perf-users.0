Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F53FF1;
	Fri,  7 Mar 2025 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308029; cv=none; b=olBXbZhlB9NkLPx4E6NL4Knr6Cjtui3eTE94K54J5DrUByo9w4ClBwCfhO76KvjieLXgh3Y5tDvPjRJu3KjsqElDA5uKJyRTdPgFNViolR9u5QFhTOCpuypWXwk/yDGi8qY9W+ypA1GHK0dQgUBlzYL/ez9cKy6HxkiTXIWqvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308029; c=relaxed/simple;
	bh=IZganfmTRVMXt6EEXPVKrpk3xnwBL7hHFlCNXq/YLrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1asYPvBx5Y9xKRlB9/vsb1MOM70jlOfKdGnnaDOfSNfxFH7rR6fmnDKXspPwC9Ru0SIPx655/GgVBU++d4FN7L3Moryhw/jcaX+t72u3uiQbEm0/1oxv4VZfOU+hH+YCeQVp22uy6JN8gBKvkm+RL5j+lc//T+8iYENqEDqsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSL53wta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSL53wta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8609C4CEE0;
	Fri,  7 Mar 2025 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308028;
	bh=IZganfmTRVMXt6EEXPVKrpk3xnwBL7hHFlCNXq/YLrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSL53wtaUNnzPbWmULzgpAyojYCLykCC1Eg7r1AInX2hFthJGHXzp8isoUe9qZSRQ
	 iD1KIGsa6Dlrk0xQfkRb0FkwBGDgoj7TKCMzte+0bzllzZ6ObaoIj2Au2G4lsCC7It
	 M7q60K/rAPJCyfB9lgrVy7PWGWUdilEAVpoiY/rGKnu9cCdoHhrFUbJbUrZlSl0cKL
	 DUery0nkfwCHX/QSlizBvpiVUuZ+fuCn51H2OH9f03nXOylLfolcLuN5lPH76Ev744
	 1ahdInhyqqHW2opZJS0rnq2xEt2QfA4CSHsbqNl/LpSNWSYw6Sno1BGffBFObwfSVz
	 0Om/z4vaFqOhw==
Date: Thu, 6 Mar 2025 16:40:26 -0800
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
Subject: Re: [PATCH] perf tests probe_vfs_getname: Skip if no suitable line
 detected
Message-ID: <Z8pAep0GJsMFTyEi@google.com>
References: <20250304163015.969720-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304163015.969720-1-jbrnak@redhat.com>

Cc-ing Masami,

On Tue, Mar 04, 2025 at 05:30:15PM +0100, Jakub Brnak wrote:
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
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh           | 8 +++++++-
>  tools/perf/tests/shell/probe_vfs_getname.sh               | 8 +++++++-
>  tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 8 +++++++-
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 8 +++++++-
>  4 files changed, 28 insertions(+), 4 deletions(-)
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
> index 0c5aacc446b3..9e99647fc61a 100755
> --- a/tools/perf/tests/shell/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/probe_vfs_getname.sh
> @@ -12,7 +12,13 @@ skip_if_no_perf_probe || exit 2
>  # shellcheck source=lib/probe_vfs_getname.sh
>  . "$(dirname $0)"/lib/probe_vfs_getname.sh
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [[ $err -ne 0 && $err -ne 2 ]]; then

Shouldn't it be equal to 1?

  if [ $err -eq 1 ];then

> +    skip_if_no_debuginfo
> +    err=$?
> +fi

Hmm.. probably better to call skip_if_no_debuginfo first so that it can
skip to call cleanup_probe_vfs_getname.

Thanks,
Namhyung

> +
>  cleanup_probe_vfs_getname
>  exit $err
> diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> index 5940fdc1df37..2724adc23e8f 100755
> --- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> @@ -34,8 +34,14 @@ perf_script_filenames() {
>  	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
>  }
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [[ $err -ne 0 && $err -ne 2 ]]; then
> +    skip_if_no_debuginfo
> +    err=$?
> +fi
> +
>  if [ $err -ne 0 ] ; then
>  	exit $err
>  fi
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 708a13f00635..f5cc59225cf1 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -25,8 +25,14 @@ trace_open_vfs_getname() {
>  }
>  
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [[ $err -ne 0 && $err -ne 2 ]]; then
> +    skip_if_no_debuginfo
> +    err=$?
> +fi
> +
>  if [ $err -ne 0 ] ; then
>  	exit $err
>  fi
> -- 
> 2.48.1
> 
