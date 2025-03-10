Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95ED1DE4F3
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642225; cv=none; b=shNq0sZ94wox7pwta3ad1rTlrFX9HJG5ou9TXpBHKDJWgQVtVG/cBRHCQHZ6lkR/xCmVRnIfNYL+2dA80um8yk7xQAV6EF8DdwZ8qT23jBS5WXW3uCCjPO4v+wf9/rXdnPV0cyIxxHk1eBiKKB6P1HKeQbhREvDIfXCYF6Ms0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642225; c=relaxed/simple;
	bh=eFdk14ZuG94bKCtjEYT3td+T4jBH6NjfqZinG5/Wbco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnO35s9QFUv3FsUo3wyZLqJm1g5ZNUNBD6AthYF6JSCOVmPjsE8oeEBBVkzF7Ma6ZV2Igu0UPYXe7l6smoMNdIznM9mxAQI7S3UYc5+966whP02U15IgdabL8IBJG3UWm4g6cWCjvjFs4jQ+lRKDlAAQBmcyHZUKutJz5Iwsrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faTUunvb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faTUunvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CDBC4CEE5;
	Mon, 10 Mar 2025 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741642225;
	bh=eFdk14ZuG94bKCtjEYT3td+T4jBH6NjfqZinG5/Wbco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faTUunvbmNiuTSBIuoDRtBgxbxPZf08rKloUc4GerBrOBFoT/+necSwuD5lopBEmF
	 rf4r6CPSeQvlIYrZUbLG4IW9187+YdoDFgB9CT2mJQ4Fi2sWWpZEDmjgv96oVfYzKQ
	 HVZkaIgy2vZfBGS1q0gR2Dy/esZn5XcE/ZIv73VhPr0hzGzNQ8zuJilLrcUnfREuNR
	 3F3YjE1L8tuPWd0erkt7kFtlntHr43XLbxLEg694MOGjm4+h8y/9LtlxMOXHkkjDcq
	 6HaoI83pYEdZKWGMWaNhDiCOidaOgdOrxihFQnv4sbgz4OhGi2cBEnTtBDJpOYolJi
	 ny7dOjw5GASxg==
Date: Mon, 10 Mar 2025 14:30:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: David <davidzgumberg@gmail.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf: Live mode flamegraph recording results in segmentation
 fault
Message-ID: <Z89Z7zvqbKmc82gA@google.com>
References: <f3d4363e-1de6-4817-b45e-fb2a05f02723@gmail.com>
 <516dd4bb-c317-42ce-b539-92c6c1eabcbe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <516dd4bb-c317-42ce-b539-92c6c1eabcbe@linaro.org>

On Mon, Mar 10, 2025 at 11:53:06AM +0000, James Clark wrote:
> 
> 
> On 07/03/2025 4:25 pm, David wrote:
> > I've reproduced this on recent versions of Debian, Ubuntu, CentOS, and
> > Fedora,
> > and I used to be able to downgrade perf and it would work, but an early
> > enough
> > version of perf is no longer available from most package repositories.
> > 
> > Steps I have taken to reproduce:
> > 
> > 1. Install perf from a distro package manager. ( `sudo dnf install perf`)
> > 
> > ```
> >   $ perf --version
> > 
> > perf version 6.13.5-200.fc41.x86_64)
> > ```
> > 
> > 2. Attempt a live flamegraph report:
> > 
> > ```
> > 
> > $ perf script flamegraph ls
> > /usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3:
> > 1644 Segmentation fault      (core dumped) perf script -s
> > "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> > ```
> > 
> > 
> 
> Hi David,
> 
> Are you able to bisect this to find the breaking commit?
> 
> Is this the full output you get? I'm not able to reproduce your exact issue.
> I do see a bug with the template download prompt but it produces more output
> than you have:
> 
>  $ perf script flamegraph ls
> 
>   Warning: Flame Graph template '/usr/share/d3-flame-graph/d3-
>   flamegraph-base.html' does not exist.
>   [...]
>   s = input("Do you wish to download a template from cdn.jsdelivr.net?
>   (this warning can be suppressed with --allow-download) [yn] ").lower()
>   OSError: [Errno 9] Bad file descriptor
>   Fatal Python error: handler_call_die: problem in Python trace event
>   handler
>   Python runtime state: initialized
> 
>   Current thread 0x00007d1916afd400 (most recent call first):
>   <no Python frame>
> 
>   Extension modules: apt_pkg (total: 1)
>   Aborted (core dumped)
> 
> But if I avoid the record/report wrapper and go straight to the script it
> works:
> 
>   $ perf record -g ls
>   $ perf script flamegraph.py
> 
>   [...]
>   Do you wish to download a template from cdn.jsdelivr.net? (this
>   warning can be suppressed with --allow-download) [yn] y
> 
>   dumping data to flamegraph.html
> 
> I'm wondering if the template prompt ever worked in conjunction with the
> wrappers? Maybe they were only tested with the template already installed,
> or the script was always used directly when the need for a template was
> added.

I don't know but it didn't work well for me too.  Maybe it should have
default 'y' for live mode.

Thanks,
Namhyung

