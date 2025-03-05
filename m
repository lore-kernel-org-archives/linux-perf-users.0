Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E38250BFB;
	Wed,  5 Mar 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197126; cv=none; b=VL+rnsAX540Zzp7+yYCufBpDa/K3j49gnkZqnMCf/8V5SRByqtoVHLIM7Nq6QMtyeCXMCDVtGNNoXbHTR9ZttlA6BPlvh0Wa1RnM4VmQnfhUj5dpI17aXKRr5t491gx3vwg9DYSLwKFUYoqPASWcEzXoZgECPkU2OYSGxV9P73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197126; c=relaxed/simple;
	bh=m+51MfRoAL5YdS0vGlWIL8DUV0nJk+PB4wItTsuzwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+OacX93kv26kByeq0vgRCdkTqhnTv/47qLqB8eEJhZ3//MIYGjQryacMzqfKgJU9MdAmLM3DG3T512YMrxaYI1TBq6N57MveLIp1ngmfRLHh1QbTAM6C/e1+m5X6nRTO4O7t1STnQSAugibZFhSk6rs6h6kLtve06pPPJS2eXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STRmevfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STRmevfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EABC4CEE0;
	Wed,  5 Mar 2025 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197126;
	bh=m+51MfRoAL5YdS0vGlWIL8DUV0nJk+PB4wItTsuzwCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STRmevfNga2G8P5ufkAmYwxxw+WpeSEZPY3kLeBZkCLjtMeQutO0/nT8+33BI9w3j
	 ukqGlkV+9iE/bD7u1+fnFWRgDWnYzhRX4+MZxCS5m5vlRVlUN7YysjduUqvZ8DwwvW
	 cC5yn7nJdMS8ZwGXLeXTOb8bRyQ4lhBZG62DRYlWVD47fMSvl82kx5szV2pl+a0JEh
	 tvad8OpUoJIfpl8kG4gE08meNH99RqZWSCWy2oKMtuOBfkywazqd7A35gLEcEDtTao
	 A2qgYkB8H3q/7HYIt16fVMYnuz6OKEFDwbR5Yr0GbtEuGxk9NMwtjJAfmt1awbmUEs
	 c6XVY+dVQ1Hxw==
Date: Wed, 5 Mar 2025 09:52:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf test: Skip perf probe tests when running as
 non-root
Message-ID: <Z8iPQ-IVxIcAZIUU@google.com>
References: <20250301040252.1586750-1-namhyung@kernel.org>
 <20250301040252.1586750-3-namhyung@kernel.org>
 <Z8iNr0Lh61o_GZgg@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8iNr0Lh61o_GZgg@x1>

Hi Arnaldo,

On Wed, Mar 05, 2025 at 02:45:19PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 28, 2025 at 08:02:50PM -0800, Namhyung Kim wrote:
> > perf trace requires root because it needs to use [ku]probes.
> > Skip those test when it's not run as root.
> > 
> > Before:
> >   $ perf test probe
> >    47: Probe SDT events                                                : Ok
> >   104: test perf probe of function from different CU                   : FAILED!
> >   115: perftool-testsuite_probe                                        : FAILED!
> >   117: Add vfs_getname probe to get syscall args filenames             : FAILED!
> >   118: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> >   119: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 
> Do you have ShellCheck installed?
> 
>   TEST    /tmp/build/perf-tools-next/tests/shell/probe_vfs_getname.sh.shellcheck_log
>   TEST    /tmp/build/perf-tools-next/tests/shell/record+probe_libc_inet_pton.sh.shellcheck_log
>   TEST    /tmp/build/perf-tools-next/tests/shell/record+script_probe_vfs_getname.sh.shellcheck_log
> 
> In tests/shell/probe_vfs_getname.sh line 11:
> [ "$(id -u)" == 0 ] || exit 2
>              ^-- SC3014 (warning): In POSIX sh, == in place of = is undefined.
> 
> For more information:
>   https://www.shellcheck.net/wiki/SC3014 -- In POSIX sh, == in place of = is ...

Sorry for the noise, it's fixed in v2.

Thanks,
Namhyung
