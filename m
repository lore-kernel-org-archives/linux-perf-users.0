Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBC1DDC2B;
	Fri,  6 Jun 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749178788; cv=none; b=ankXV7X6GnTtEVgWYSW6edaKlX9cXXCJ3a+KL2NEnmuvON62N7F/MdAi4z4fdVGtWo4xiQ/a9LTlAWTvpP5bYghXkef0szoh8eRPopHt9Rg57yF4XCJyddBoGyANtwZvYFKrO5hIUGtPRFvuRlrPuiF79MhWeAkAqT04lXdcHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749178788; c=relaxed/simple;
	bh=RmP9bQh9omwzPjxxRL2d93ANlNPA42S4hbcj7JF36L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsDPQeqnBN5rVAsYywDKteMJXmaCjiNfpwKj4HJsPF6gIvAq9LZ9WQcMXXxdc/OkIMbxVXd8y90nqbY2lFqyER6sDJFjBdaf0b1zO8GkZqtYRRaH0F8J7jochUTbim5RdTgC9MaSw23AUXlwtYJtqVHzdY+RAqEzGm2VRS+iDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPyh7li9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPyh7li9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3AEC4CEE7;
	Fri,  6 Jun 2025 02:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749178788;
	bh=RmP9bQh9omwzPjxxRL2d93ANlNPA42S4hbcj7JF36L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPyh7li9bkcxCFPmQ3AXxoSoQafQ0iS8yqfSH6nHJCZsnAvpat5TRrCPZ23FNTa5W
	 SSBST/nyTG/LkxuS8m4JSEj3/EDTzjYSTdq35z24NZ3Bqc3DM/N6lzF1ZsKVrPc/fe
	 JLr/RnoFBWdXEaaO1wWBGNp/tt/r7j8EwYZi7nMo4DuuS4XxxA+SWGHAXpbAklyk/A
	 jFCAW55CYh7VdvEPm0WA5NTlAgA4ZKA41+Bb+kWgMr1KGyxrnAvb7227Nfzjn1C+s3
	 3niyDdDFq9fMVJOHh4jmfcnjwdqU0yucDJg9B++pOT1+oiODK2plC2DS6pOLDmbbEs
	 Wv1ubceKJt57w==
Date: Thu, 5 Jun 2025 19:59:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] perf annotate: Remove __annotation_line__write()
Message-ID: <aEJZouXDjGkRDbc2@google.com>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-3-namhyung@kernel.org>
 <aEH2KoxicdjYUW1g@x1>
 <aEH3NwfDVq2LT0b6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEH3NwfDVq2LT0b6@x1>

Hi Arnaldo,

On Thu, Jun 05, 2025 at 04:59:51PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 05, 2025 at 04:55:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sat, May 31, 2025 at 11:52:58PM -0700, Namhyung Kim wrote:
> > > Get rid of the internal function and convert function arguments into
> > > local variables if they are used more then twice.
> > 
> > "more than once"? "twice or more"?
> 
> Well, its "more than twice", as you did:
> 
> -               if (change_color)
> +               if (wops->change_color)
>                         color = obj__set_color(obj, HE_COLORSET_ADDR);
>                 obj__printf(obj, bf);
> -               if (change_color)
> +               if (wops->change_color)
>                         obj__set_color(obj, color);
> 
> Ok, I wouldn't touch this, i.e. would leave all as local variables that
> way the patch would be smaller :-)

I see.

> 
> So its just 'then once' to 'than once' the fixup.

Oops, will fix in v2.

Thanks,
Namhyung
