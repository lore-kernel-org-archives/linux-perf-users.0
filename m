Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBF1C5D6A;
	Thu, 18 Dec 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056814; cv=none; b=GGhbozWCr3ay3O1LXIqII6r6C0MkrDCDBpGh1E5qwy0Rmjw47+oRAum2Uxxk1oN6cy8q8HSudaXp0bkXAceVzwUw93uL1da8xJicToCjW5YhvFcJwjpXpAkfcP8rDUoseuLpoBeBjRKu+NWLBmi4bbuRSOch5zYNNcOGm5gZ63M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056814; c=relaxed/simple;
	bh=f5dsD5o3ju0V5//YdrH5kREcuDjBDtgkJ69miIDuLMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCZPLogpLPXFzUt5vv30KdKkq++vlCEuqxtxKIyIx/tryZTvoNAVNAOncXe/AdXHuoFxJ/qh5F4MKgSBwdcZ9r3Q+JGn1huBscdDDRCLn6iR1rpGyvX45SvsBnlahIPJ5/jLZfrNt5PUEM+gIZvh5rXwcBh9Oi+3oq3mj1JwVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COhWPhj6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COhWPhj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EECC4CEFB;
	Thu, 18 Dec 2025 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766056813;
	bh=f5dsD5o3ju0V5//YdrH5kREcuDjBDtgkJ69miIDuLMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COhWPhj639J/O14f8HyeB0n+77kyG7CCpboF0SSP8vgemREBcHWzKgVIgnuME3v1a
	 vVTijeKSY7ptuoxxKoqA+huKYgj1ZSCi4Q2FCemcL3irwvMLUJ2EvOrJSuXkkWNBT1
	 epDM6HSF/t+B4YaUjMHOpDKzbSXsemqTmuls0QX0=
Date: Thu, 18 Dec 2025 12:20:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/uncore: clean up const mismatch
Message-ID: <2025121807-hacking-womanless-7b3a@gregkh>
References: <2025121741-headstand-stratus-f5eb@gregkh>
 <20251218085551.GK3707891@noisy.programming.kicks-ass.net>
 <2025121819-snowdrift-thievish-4108@gregkh>
 <20251218101113.GM3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218101113.GM3707891@noisy.programming.kicks-ass.net>

On Thu, Dec 18, 2025 at 11:11:13AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 18, 2025 at 10:59:25AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 18, 2025 at 09:55:51AM +0100, Peter Zijlstra wrote:
> > > On Wed, Dec 17, 2025 at 01:42:41PM +0100, Greg Kroah-Hartman wrote:
> > > > In some cmp functions, a const pointer is cast out to a non-const
> > > > pointer by using container_of() which is not correct.  Fix this up by
> > > > properly marking the pointers as const, which preserves the correct
> > > > type of the pointer passed into the functions.
> > > 
> > > How did you find this? My builds do not complain and all that.
> > 
> > I have a local change that turns container_of() into container_of_const():
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=container_of_const_mess&id=ea8cab3db2b5a56c5ef63d0e32accce58eb9bb2c
> > that I'm using to sweep the tree and fix up all of the places we have
> > gotten this wrong.  And wow, have we gotten it wrong in so many
> > places...
> > 
> > It's a slow grind, I'll get there eventually and then will merge a patch
> > that forces container_of() to catch this type of thing so it will not
> > come back in the future.  Maybe a year or so, no real rush :)
> 
> OK, meanwhile I'll see this patch is merged :-)

Thanks!
