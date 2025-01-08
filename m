Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BE19ABB6;
	Wed,  8 Jan 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366156; cv=none; b=FxV9NIQPl86VcYgcSzMuSdk1TVlN5rBqLBLQnGwrhgJ4S8RjhtOhF/RJNX5XOqrrm4Efk/H5tDCl18jbA6WwIV/chHQ+EhZ0HJ2kbvbHdpp4KiLIJA5wZgsBYJWChIkyPF0PZ/B9Wd0Zok/RvS5/KHqdrjEoG4wDLbyievP298A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366156; c=relaxed/simple;
	bh=d+BjqX6a64TsT7Fi6gIQ6p4XPXOWjDadBxtZpjjVovA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnO7aMaRO1CEyqMsxkJDAUukSPal3coGSU0vDRWw9VzSDt3ccQ1X7C5UeHtEJ4Dt9rytxRn6jXLrvBbRVa971oFoOV01X4KqsSmeRofswnXybH1huKfzqVhB3NGafBw822y4fpLnpxdZcu/rEmQOQt/rs4NmmjWrw9Nx86bbBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH+Lj21X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH+Lj21X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9E3C4CED3;
	Wed,  8 Jan 2025 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736366156;
	bh=d+BjqX6a64TsT7Fi6gIQ6p4XPXOWjDadBxtZpjjVovA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OH+Lj21XHbgPnC5NYzAOBn+0XFmBdOYGW+2uq7Q05QfZsIGko1fVrqdXRXROpO+eW
	 IBIPB60MrsrRF9UN+stOzAQwvS0WXGcN1gOhl0Y0j/LpOwaas02s0NPB4LrsbCwii6
	 ty4yaa7SAg/PvDevQ30LStkmfSZYhbkQyFBHOY3dlmokGXyIh5B73LwbVBVnslFQZz
	 8NZkKDibtwZ9zzkrVTY6OQUsngSI3BbbLiLZntA5Kq+ffvBZEzhv75Nh32KGi+EohB
	 ZX69upswPUNBiHZsw6WIIFMQSbWIPB+AvgNzUUC6rJqDvm7mKv4w0pmyH6mkPV21QG
	 HWT3KPgejjQHg==
Date: Wed, 8 Jan 2025 16:55:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf: Fix display of kernel symbols
Message-ID: <Z37YSfVMabaJ3A8z@x1>
References: <2ea4501209d5363bac71a6757fe91c0747558a42.1736329923.git.christophe.leroy@csgroup.eu>
 <Z36Ra23US_zC3n2v@x1>
 <590b2f02-f7f0-48b2-b45e-8a31bbadef2a@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <590b2f02-f7f0-48b2-b45e-8a31bbadef2a@csgroup.eu>

On Wed, Jan 08, 2025 at 06:06:03PM +0100, Christophe Leroy wrote:
> 
> 
> Le 08/01/2025 à 15:53, Arnaldo Carvalho de Melo a écrit :
> > On Wed, Jan 08, 2025 at 10:54:20AM +0100, Christophe Leroy wrote:
> > > Since commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily
> > > sorted array for addresses"), perf doesn't display anymore kernel
> > > symbols on powerpc, allthough it still detects them as kernel addresses.
> > > 
> > > 	# Overhead  Command     Shared Object  Symbol
> > > 	# ........  ..........  ............. ......................................
> > > 	#
> > > 	    80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
> > > 	     3.91%  Coeur main  gau            [.] engine_loop.constprop.0.isra.0
> > > 	     1.72%  Coeur main  [unknown]      [k] 0xc005f11c
> > > 	     1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
> > > 	     0.44%  Coeur main  libc.so.6      [.] epoll_wait
> > > 	     0.38%  Coeur main  [unknown]      [k] 0xc0011718
> > > 	     0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
> > > 
> > > This is because function maps__find_next_entry() now returns current
> > > entry instead of next entry, leading to kernel map end address
> > > getting mis-configured with its own start address instead of the
> > > start address of the following map.
> > > 
> > > Fix it by really taking the next entry, also make sure that entry
> > > follows current one by making sure entries are sorted.
> > > 
> > > Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > > v2: Make sure the entries are sorted, if not sort them.
> > 
> > Since you have changed what I reviewed I'll have to re-review :-) Will
> > try to do it after some calls.
> 
> Ah yes sorry, should have removed your Reviewed-by.
> 
> Based on Ian's feedback "Using the next entry in this way won't work if the
> entries aren't sorted", I added the following block in front of the initial
> change:
> 
> +	while (!maps__maps_by_address_sorted(maps)) {
> +		up_read(maps__lock(maps));
> +		maps__sort_by_address(maps);
> +		down_read(maps__lock(maps));
> +	}

Its ok, I'll keep it now that I looked at it.

Thanks!

- Arnaldo
