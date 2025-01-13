Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85F17557;
	Mon, 13 Jan 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783412; cv=none; b=fF/c/W3UOzrU8yThwwpzPx6mAR6I6rE0LuVj0X64mdv16EGo6F8C9Sw6eBdkpvR1OwpUgbjbf2S3gZeNn646iMtYteJoNIQ0xxyVj1KPUmGx4uhv0QlBrqv0ed59LprDpWy/Uf6Hy5ol3aQW57tb6D0dZQc5GSio1yse9rpXZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783412; c=relaxed/simple;
	bh=uIL+VKS9npGYXpMJEVjq4P46puMwkIl0vzoE9q+XkOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpIFv+e8NhVGwqX/Y/lL7y2vuvsViZ4b+mi0q1Widhst7Ll1lHCcVAMbSa+/xyNIO//d6Zfb6k4pCK/0ODUjvJErp5/HpbbzWxMY2pa5oHR6aYJGqxhKf3B5tATrx8gHVKF8q/zyrxxNksl7TSozPQcfnKvy9AOVWUIX7WUaHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkyK9qhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkyK9qhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A78C4CED6;
	Mon, 13 Jan 2025 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783412;
	bh=uIL+VKS9npGYXpMJEVjq4P46puMwkIl0vzoE9q+XkOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkyK9qhfed6ZTO8UHBVDTtRqM+u0NGdb0jyOi2JQDYVagdGp0ds7IFIhGjPYCGu01
	 un09FHFQWW2KnmXjVyIIZo0UtVAV0AnGGqFFMoI5VhavUo3UZDekdcs50zc4jl3/9j
	 0ZYmcnB44SD29qYoCqNEeBW8yzLLIOs9/JYtwZX6p/82yVzTiw/RQJ26rXfmh1nMWa
	 tkSlBjUvTM2p4eCt7gq3HDD1in4ifZi1bjU0gwhxALBEpiGYlnhv6h0jIiAf1vwy29
	 H5Ak5s5zF/3sDFQbtQdHnmN5fHRtDG0XwTBbIhxZgjTRa1FDEvx4YcRdsqMbKTXjVG
	 k3Emxg7NeUi7w==
Date: Mon, 13 Jan 2025 12:50:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test record+probe_libc_inet_pton: Make test
 resilient
Message-ID: <Z4U2MarOp0DLo31_@x1>
References: <20241202111958.553403-1-leo.yan@arm.com>
 <d0ab6e2e-cd57-4477-8171-77b4c2d364f7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ab6e2e-cd57-4477-8171-77b4c2d364f7@linaro.org>

On Tue, Jan 07, 2025 at 04:51:31PM +0000, James Clark wrote:
> 
> 
> On 02/12/2024 11:19 am, Leo Yan wrote:
> > The test failed back and forth due to the call chain being heavily
> > impacted by the libc, which varies across different architectures and
> > distros.
> > 
> > The libc contains the symbols for "gaih_inet" and "getaddrinfo" in some
> > cases, but not always.  Moreover, these symbols can be either normal
> > symbols or dynamic symbols, making it difficult to decide the call chain
> > entries due to the symbols are inconsistent.
> > 
> > To fix the issue, this commit identifies three call chain entries are
> > always present.  These entries are matched by iterating through the
> > lines in the "perf script" result.  The recording attribute max-stack is
> > set to 4 for the possible maximum call chain depth.
> > 
> > After:
> > 
> >    # perf test -vF pton
> >    --- start ---
> >    Pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
> >      Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
> >    Pattern: .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib/aarch64-linux-gnu/libc-2.31.so|inlined\)$
> >      Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
> >      Matching: ffffa14b7cf0 __GI___inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
> >    Pattern: .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
> >      Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
> >      Matching: ffffa14b7cf0 __GI___inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
> >      Matching: ffffa1488040 getaddrinfo+0xe8 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
> >      Matching: aaaab8672da4 [unknown] (/usr/bin/ping)
> >    ---- end ----
> >     82: probe libc's inet_pton & backtrace it with ping                 : Ok
> > 
> > Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> > Closes: https://lore.kernel.org/linux-perf-users/1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com/
> > Reported-by: Guilherme Amadio <amadio@gentoo.org>
> > Closes: https://lore.kernel.org/linux-perf-users/Z0X3AYUWkAgfPpWj@x1/T/#m57327e135b156047e37d214a0d453af6ae1e02be
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> > Changes from v1: Fixed a typo s/Seatch/Search.
> > 
> >   .../shell/record+probe_libc_inet_pton.sh      | 34 ++++++++++---------
> >   1 file changed, 18 insertions(+), 16 deletions(-)
> > 
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
