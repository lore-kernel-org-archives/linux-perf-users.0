Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092445D900;
	Fri, 25 Sep 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338053; cv=none; b=IDLAfIhm66//fKU/H1Vi3JgyLBoV7FVDyE6SHbuw10HgE1rrugJ20mpphk0dziOP6JERKA3kQdDgtb4fErDutdX5jJ/Fk/uWy4OXRAWFWx9OX5kt4IuQpFT1Uf0vWaU11rbEaKprQjb6ZvwLDjBItex2EaFY5h1sebrSrQXUHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338053; c=relaxed/simple;
	bh=uHJCpTwRObwyx4hWMGHupU+ZKK5CvstozY5P7O4+Q7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3/rYFnIHLtBvi2BvGyaTbQvAB+W+8TPkiKkeJwQoCKEI9xrIWT2VEaKE1K3iLtZncVk1nHf5m6cltW+2+rzSygesE5F+Y7GuBO4ixdXjSj/NIg6+qj+7lYiQtyF4rXvnOuVuxGJiUAPrZpmUSOweGBKesA3MlOVtScIsGWTb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSWhED9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSWhED9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927601F00893;
	Fri, 25 Sep 2026 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338052;
	bh=BbeJuCO9IRIzIvTlLTnZgXrjVPhUF1FO+vCpZZwjEVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSWhED9YO4iRKLsQMTGIe+sqUNmn5KwwYdBvDM1IuNpraFKX7oJRZ9cJiRWUEI95x
	 4vv5woxG5axvADbPWgIZoqy1UjZ9pYLBoCISnyfZ5kABoO6dZacLfNZUFjJLVY40mj
	 YlVyGitv+evgN7wmgCzlOGjYPntzf4OFMpzdW+x0Zi3yKCQaR6mAwh6N4SZiPRbzsj
	 Stkt5Za8g8qSPv/x5ZSnGyzlVTGswu96i3G3+CLESD0G65/soPRQAxURJV/0Ug9q7/
	 RqpE6ZvV0vwHenKtBmSbIF4kyNu5kkdKlzy1wOta4G2AQ4iw3xjrxAp4vTgtXZgllS
	 qW2QfWT7FmYkw==
Date: Fri, 25 Sep 2026 14:07:28 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, irogers@google.com,
	changbin.du@huawei.com, adrian.hunter@intel.com, jolsa@kernel.org,
	mingo@redhat.com, peterz@infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v3] perf symbols: Apply the symfs flat layout to the
 composed filename
Message-ID: <arZkAFwiXTbkwSdT@x2>
References: <20260922131952.2922816-1-zhanxusheng@xiaomi.com>
 <arWkmNKRbzF2FhoA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arWkmNKRbzF2FhoA@google.com>

On Thu, Sep 24, 2026 at 03:30:48PM -0700, Namhyung Kim wrote:
> On Tue, Sep 22, 2026 at 09:19:52PM +0800, Zhan Xusheng wrote:
> > BUILDID_DEBUGINFO needs one more step: the build id cache splits the first
> > two characters of the build id off into a directory name, so the basename
> > of the hierarchy path is only part of the build id.  Name the flat file
> > after the whole build id.
> > 
> > dso__disassemble_filename() passes a path from perf's own build id cache
> > rather than one on the profiled system, and every entry there is named
> > "elf" or "debug".  Use path__join() so the layout does not apply.
> > 
> > With --symfs /s,flat the lookups are now /s/libc.so.6, /s/libc.so.6.debug,
> > /s/sleep and /s/<build id>.debug.  hierarchy is unchanged.
> > 
> > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
