Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369542741CF;
	Thu,  8 May 2025 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720333; cv=none; b=Nz7mD5+UHpoUaimzrnvjn+i/igWY8p3AL1jI+VWChilGS65Irif1tvnSKRZ+UNgBblsHXy08PM9KU2bs/Hg3SLIJvL6HAx6+T6z0ZFXUu96Bzsuj9+SqtC7dwl7x049OIwPhpB5QleCw2fpCvXbNlax9yPdLYHmf9L72pc8cgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720333; c=relaxed/simple;
	bh=7qKKMZlG0QuZoiFYx7gS6XYcKRcAoqo6IoP4i1tWvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV4KAVjWDcvRyXFd/aHv9jw0g65s7ghv/GF8S70hoV6JBk9IBV27oMd8D+Dfno2m7b0Z8E78ZViuGcKjtTriiyCHY6XQ3qVuTz3PEagBNgk0cwusUSWVpK68WSdkiP/RkXFsu9bWwMPqu0SI9bo+AhMAqtwCR3I2RkiAssC0a04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqeHmpOB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqeHmpOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B3EC4CEEE;
	Thu,  8 May 2025 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746720332;
	bh=7qKKMZlG0QuZoiFYx7gS6XYcKRcAoqo6IoP4i1tWvJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqeHmpOBQqETvRlV5GVxhUmf/qQBptjCQLA9hn/rjJ8WgEOhuyCBSPu8PidtNbaOA
	 7qpua65wZ9eHfBgm1JZO0XW/cTZ5PsU7l4i0VnqrODcSEGcuDy1lHaNvKzaVCQEWSG
	 fzXNRK/lqmOVle7lLymH+6enSvpZYz+650ilKNDNTVYu5LvkCQoFY9Adc8zPNgW5OW
	 DHrsi3psbMF+hbvEITF503hPk9whLjHTAdAiwAvE1DSrVv1+sstypkh14A6z2DkMYk
	 Yvr/CnDaP9xYEQnXE6U91mMZJbQuCgRK2Z3UC5+u+svvEN76p5r2UftObYM5EiVa4/
	 4VAypCjNmRP5A==
Date: Thu, 8 May 2025 13:05:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andi Kleen <ak@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] NMI warning and debug improvements
Message-ID: <aBzWSTzjSW97FlBN@x1>
References: <20250402201549.4090305-1-irogers@google.com>
 <18c2fb33-2b3a-4ebe-ab26-8cebe0b6b94c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c2fb33-2b3a-4ebe-ab26-8cebe0b6b94c@linux.intel.com>

On Wed, Apr 02, 2025 at 04:33:25PM -0400, Liang, Kan wrote:
> 
> 
> On 2025-04-02 4:15 p.m., Ian Rogers wrote:
> > The NMI warning wouldn't fire even if all the events were for one PMU
> > type. Remove a nearby, and no longer useful, mixed hardware event
> > group function. Improve the evlist to string function and dump it in
> > verbose mode after the reordered events warning.
> > 
> > As commonly happens legacy events like instructions will be uniquified
> > to hybrid events like cpu_core/instructions/, even though the
> > encodings differ. To make this correct either:
> > https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
> > or:
> > https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/
> > needs merging.
> > 
> > v3: Increase the verbose dump length from 1024 to 2048 as requested by
> >     Kan Liang.
> > 
> > v2: Rename evlist__has_hybrid to evlist__has_hybrid_pmus and add a
> >     max_length parameter to evlist__format_evsels as suggested by Kan
> >     Liang.
> > 
> > Ian Rogers (5):
> >   perf stat: Better hybrid support for the NMI watchdog warning
> >   perf stat: Remove print_mixed_hw_group_error
> >   perf evlist: Refactor evlist__scnprintf_evsels
> >   perf evlist: Add groups to evlist__format_evsels
> >   perf parse-events: Add debug dump of evlist if reordered
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo
