Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE3398F85;
	Wed,  3 Dec 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784719; cv=none; b=NpEck9NHHFdkus45qzR2eSoeHySn3kmNyoqYetYKZKKC9+/mIYSLqJxI0pyrqFajXwOT1OAVJBlmiWHmHVeOVpcxH97mbkBTcvUlFKHqVjlu9H5iWyYFHfprGWYaZLqvZlu98tbMAT+QuU8TAg/2SE+dEwfr9A5B9grfIQ2XSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784719; c=relaxed/simple;
	bh=zA2GXWvmY79ocXBnoT1WjO7lgxmW1ZROvqwWDvTDndU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EIZONTrDENxSYII0IM+vHekjJPa/D4CqvxTFhD9ooCyieIMPktuSmSm3OyuVBZB3vkSNWpPsyJTGwZtABexSsIyAk8RRJXiy+CxDL1yFbQ0MKzPXO6a2F93Tr1HGF1RoZhAkGcurfTs9Jdcs/3jbvrY4wRsUj2N3nLSyO+1WCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sejnd+09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sejnd+09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BE1C4CEF5;
	Wed,  3 Dec 2025 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784718;
	bh=zA2GXWvmY79ocXBnoT1WjO7lgxmW1ZROvqwWDvTDndU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sejnd+09NLKbrUJ0za3FGFJyTbWrfz6wmk7XlS93yk2u0E7x+MfGgZApWsAMBu6cO
	 Sehmdj9prgL43dizohoIrFnenNm/PPEO1gMRrfBFYlOdMC2dtMiBXKelICplAWBkXd
	 iCh3IBYW527NXVC/Aqa5lcr4QlETm0V7FlMZnlToBXhcnWHMVnlLdjrqMWX4N0b1dM
	 ivb/ogLIFA5U2d/pUE2fO5tUN9woxy4UtA//7fxRgmU6OJT0rGwcCszrsT18rA4e1w
	 KleHDnvp0hKUZC7D1YRk9bZkXq5I0bLscqhcsu5+FvIkA9aRclObjMUqgm4NJYMSPY
	 ThLU07ZhegwfQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20251202235718.1018752-1-namhyung@kernel.org>
References: <20251202235718.1018752-1-namhyung@kernel.org>
Subject: Re: [PATCHSET v2 0/5] perf tools: Fix /proc/kallsyms map split
Message-Id: <176478471750.3636162.7547159580045819462.b4-ty@kernel.org>
Date: Wed, 03 Dec 2025 09:58:37 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 02 Dec 2025 15:57:13 -0800, Namhyung Kim wrote:
> I found a weird bug in symbol handling for kallsyms.  My system has a
> live patch which is a module and it has some symbols that conflict
> with the main kernel map.
> 
> * v2 changes)
>  - use map__kmaps()  (Ian)
>  - use temporary root directory  (Ian)
>  - Add Ian's Reviewed-by
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


