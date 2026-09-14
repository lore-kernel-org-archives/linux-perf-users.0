Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24838838B;
	Mon, 14 Sep 2026 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414116; cv=none; b=p52c6u2TahpX7abrsDoeeFqBxvEe4kUBwMtXn1LZEqEYYFJgCfgJm5fPZd4UV9+UDftIGsUxUvQryXVMxhTWYG+ET91f6l0LpPatT4AGMCz0TpP9xCY6btxf6/YjEnmtkqxtyJkZn3Akzh4JRdB5VMnHe8XXNl0rSDb8J8jqj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414116; c=relaxed/simple;
	bh=HRsWAOfE5wfBbrL7HjpB/f5PzdRMvLcsUR96pJH35Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+D8RE/5pCh3/eRERHMimxDd5YhvroIEtR3Uum5YStDMiIjXUx3UjOydWb/yMLz8vO/uJ54MahV7fPkrQwmNo/2wbWNOsIrGt9tKZ2hy3pRUkOYoK476JGQ4dHQrh+a5Y0J3It0ge4++hPmJPsv+Z1AEEEs6kQ2+FsGz+9Eb70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP/5/hpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP/5/hpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F21F000FF;
	Mon, 14 Sep 2026 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789414115;
	bh=HRsWAOfE5wfBbrL7HjpB/f5PzdRMvLcsUR96pJH35Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FP/5/hpxIwg0EEXYuu1ifxdNh3bdhWTaxidDXNdlMvkN0ltdbq/3NyAOT3DNTMWLQ
	 cykNxHlCAsZ5DF0O3u+zF1GjOB//c58jboPiujCBTTfn0bM7dOJ4tznxN3gLW+5Lmr
	 w6+pZ3IVPeRWrThyfYefqKrJ7JkEiTT+AREx1FAxLFWzGtl0wWzakG6c0edIWzdXkO
	 99leIDIQ67yEO6RebXOsOWNVquBFbXrOPIEGwfhn5lbrxof4jD6ZLuTnsi5HOKlZrU
	 HilL3aL1lxD04+SEQS3PCey1J0ULT0HNn/Pd7l9zPkh8c2WTLFQo7sCRnci2uPZblO
	 wwP/i226fmHOg==
Date: Mon, 14 Sep 2026 16:28:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
Message-ID: <aqhK3K_yfdtB51Ax@x2>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
 <20260914020418.97E881F000FF@smtp.kernel.org>
 <1870044f-ab4c-4906-8f8b-c3216fb28211@linux.intel.com>
 <aqg9DV05lxzLKu0t@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqg9DV05lxzLKu0t@x2>

On Mon, Sep 14, 2026 at 03:29:33PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 14, 2026 at 01:17:00PM +0800, Mi, Dapeng wrote:
> > On 9/14/2026 10:04 AM, sashiko-bot@kernel.org wrote:
> > > [Severity: Low]
> > > Does this file need an explicit inclusion of <stdio.h>?

> > > The perf tool can be compiled with musl libc, which enforces strict POSIX
> > > namespace separation and does not implicitly include headers. Relying on
> > > implicit header inclusion for printf() can cause build failures under musl.

> > Ok, this can be fixed in a separate patch later.

> Ok, merging it now, later you send fixes for these minor issues.

It is now in tmp.perf-tools-next, will do the usual set of containerized
build tests and push,

- Arnaldo

