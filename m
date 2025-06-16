Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C423A6;
	Mon, 16 Jun 2025 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036462; cv=none; b=Z8lEa+qtiRYraqCLPJz09C+hNKcibmhQzxDp5834NL5R6y7OK73RWaurOMuEbnsRowtsFRD1AmGvbWKCIPfae52yPdcl/NwK218eWrz+vGm48ORMusL9jnREY3//f4WU/ZzsckAIDS1n8zb7qorg10WHfWrHyCa7Obu8PCefms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036462; c=relaxed/simple;
	bh=2YOXpK9r3MRdHxDzSCw+wT4X4yV9DABmQZEI0E8zKhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPYgHSA58qD/G95lqkN++QI4zbsv26zpCKSVYnjl7C5cWvG+UrQhgk6RMIuHW4U53h3qgODw+o8QLNQUHieEapgP7XXqbpfe0z4ugeBcA0QLWIHC+RPqcr3G5JVpOIkhZRckMOoHD6WI4OQQqy+7X9SESHwx6kqZL1Sf4jP/e5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2iRL6lH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2iRL6lH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86882C4CEE3;
	Mon, 16 Jun 2025 01:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750036461;
	bh=2YOXpK9r3MRdHxDzSCw+wT4X4yV9DABmQZEI0E8zKhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2iRL6lHQaqY3EAJsgKX3qqwQSFy585QszQyzUqw6Knarzpnz8JTV9ETVI71KcpE6
	 AZRN31+6g+Bj8jIL+Tl7lV/rl4qbZXZUS2vgvF2/qcAessBd6So/ytETdBbS1SiODW
	 oeyFUUXySnfY5uYCT3NyROVI1WUrBTzfwGHvh642x5bGcH/LX4a8TPrxaKESlLmKLY
	 STqpRuzV7Ha2e1zj4xTJnV47M4e3WPi2SQ5/AXyz5njseZnT5SH6rO4c6BM3SgxdS3
	 X0qQAKn4WOG/rgVVvBg3PiKivrLgfmwcQ4GGMYEc6am+ueqWeHbPmCGZDOxRncjkeC
	 6JxoSa3Jt5xYQ==
Date: Sun, 15 Jun 2025 18:13:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: Re: [PATCH v2 1/4] perf build: enable -fno-strict-aliasing
Message-ID: <20250616011353.GA58711@sol>
References: <20250614044133.660848-1-ebiggers@kernel.org>
 <20250614044133.660848-2-ebiggers@kernel.org>
 <CAP-5=fXLCAN_8PpPRYcLpLXG0oPDqGMzn8VwuxPdg63+zFNTUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXLCAN_8PpPRYcLpLXG0oPDqGMzn8VwuxPdg63+zFNTUQ@mail.gmail.com>

On Sun, Jun 15, 2025 at 04:40:45PM -0700, Ian Rogers wrote:
> On Fri, Jun 13, 2025 at 9:43 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > perf pulls in code from kernel headers that assumes it is being built
> > with -fno-strict-aliasing, namely put_unaligned_*() from
> > <linux/unaligned.h> which write the data using packed structs that lack
> > the may_alias attribute.  Enable -fno-strict-aliasing to prevent
> > miscompilations in sha1.c which would otherwise occur due to this issue.
> 
> Wow, good catch! I wonder if -fsanitize=type could be used to capture
> when perf's code is broken like this? Perhaps we should just remove
> linux/unaligned.h in tools because of this, the alternative of using
> memcpy doesn't look particularly burdensome. Given the memcpys are of
> a known/fixed size I'd expect the compiler to be able to optimize
> things just as well. Perhaps we should rewrite unaligned.h in tools
> but perhaps the kernel too. Something like:
> 
> #define __get_unaligned_t(type, ptr) ({
>                  \
>         const struct { type x; } __packed * __get_pptr =
> (typeof(__get_pptr))(ptr);     \
>         __get_pptr->x;
>                  \
> })
> 
> becomes:
> 
> #define __get_unaligned_t(type, ptr) ({
>                  \
>         type __get_val; memcpy(&__get_val, ptr, sizeof(__get_val));     \
>         __get_val;
>              \
> })

As far as I know, the packed struct method of doing unaligned memory accesses is
obsolete these days, and memcpy() generates the desired code on all supported
architectures and compilers.

- Eric
