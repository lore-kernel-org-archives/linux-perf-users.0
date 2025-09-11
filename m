Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A150220685;
	Thu, 11 Sep 2025 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625152; cv=none; b=nq/ygTjG3X1siWl18sBChCGQYTydPH5cF31rwZKz8iNXsAgXLxKGaix4SlB2InGFCJDUZCK2Em+xwIs9hABE4OPyGu0PiDbTUk2YX7k8wVWyMqqOq8H9DKO4J0H3n1YIYGadsO6uwkcnwGyj4Ho5hOk7Gop+/pNmy7vgZuivf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625152; c=relaxed/simple;
	bh=+Vvnf5OW+rlrUpmdHjX4Ph1IZZBMUh7UgFAb+ElL2ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njy1Wkw1IZ1V65qzRZt/PnKmfKxcxyFjzV+zW3K6G512wLC0fHlNWMsykeTnuYuM63/9Y1KPXTuAmfBnPASjzLXcenNzuKT7YJa5w+xtIfcydMY5BSVDfQd/Mc/kCG70WKBVUFDIpDw+FAzut6X/rrWvTfVDkhouiUzroWodpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq26FmxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq26FmxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8CEC4CEF0;
	Thu, 11 Sep 2025 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757625152;
	bh=+Vvnf5OW+rlrUpmdHjX4Ph1IZZBMUh7UgFAb+ElL2ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq26FmxMitRLKCy/IwiH2B3nDPAXwT/so2F5Ez0TzzBKj11Z9dAlD8RX9spG5F9yW
	 x77cke6FD4BZ0mi++QnZvGgvceRsT75sRktaZQ4xgh9nPj/sZIC4Rbijd9CabDXDCE
	 QzHXwyta9F4FWLA/wwthe3BqvEI37fxp4d1Q8bTuhG+MzQlhzpvuO05aHYh/hO3Bh6
	 UXY44+ra4iWRn4RYLuObEWFYhs3TqkBYcJNKwnoHlqfPaeE92ss94QrC9X9mMY/8Ki
	 J56ciQhs4GnsZTKzLrlySgIJUeZUDlBBWYrfBrR8qZIxZ4fPxdRPvIGZs+UB+0fgMm
	 arcMtdXb/E07A==
Date: Thu, 11 Sep 2025 14:12:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, Ian Rogers <irogers@google.com>,
	adrian.hunter@intel.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org
Subject: Re: perf --help triggers an assertion
Message-ID: <aMM7PtxJx83aUJ7z@google.com>
References: <20250701201027.1171561-3-namhyung@kernel.org>
 <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
 <aMF0iWh4yTK5KwcJ@gentoo.org>
 <aMMq7I5TBoL7SX6z@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMMq7I5TBoL7SX6z@x1>

On Thu, Sep 11, 2025 at 05:02:52PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 10, 2025 at 02:52:25PM +0200, Guilherme Amadio wrote:
> > On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> > > On Tue, Sep 9, 2025 at 2:49 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> > > > I was updating perf's package in Gentoo Linux and noticed some problems
> > > > which were not there before. I tested with the version below and the problem
> > > > still seems to be there. perf --help triggers an assertion (see below).
> > > > Looking in the list, it seems related to the patch below:
> 
> > > > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyung@kernel.org/
> 
> <SNIP>
> 
> > > I tried to reproduce the same version with various options: DEBUG=1
> > > -UNDEBUG in EXTRA_CFLAGS, -fsanitize=address. Being in various
> > > directories with "perf-" prefixed files. I'm afraid I wasn't able to
> > > reproduce. The assert is trying to avoid a memory leak, so
> > > non-critical, and I couldn't in a quick inspection eye-ball an issue.
> > > Without getting a reproduction I don't think I can make progress with
> > > the issue.
>  
> > I do not have any special setup on my machine (if you consider Gentoo
> > not special, of course). I just did a git bisect and arrived at commit
> > 9401d1771dad99bfc795dd2ae0c292343fd1f78d, which is the commit I linked
> > above. I used>
> 
> ⬢ [acme@toolbx perf-tools-next]$ git show 9401d1771dad99bfc795dd2ae0c292343fd1f78d
> fatal: bad object 9401d1771dad99bfc795dd2ae0c292343fd1f78d
> ⬢ [acme@toolbx perf-tools-next]$ 
> 
> Looking for the patch title I got to this one:
> 
> commit 1fdf938168c4d26fa279d4f204768690d1f9c4ae
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Tue Jul 1 13:10:27 2025 -0700
> 
>     perf tools: Fix use-after-free in help_unknown_cmd()

Sorry for the trouble.  The hupu's patch should fix the problem.

Thanks,
Namhyung

