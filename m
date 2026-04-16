Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712B1DE894;
	Thu, 16 Apr 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353311; cv=none; b=cw+vo/wsEeevUQ9mGaq6doByCh4U5PJJziW+FYIxl706Dn01ZWzvsFngzXaQhlvc36V22W7rjKmgndo9fm2eLI833fGfRXK1s0yOorIcdb1C65uKgPHSeit4E8FCVu2k1HxdN/SmICf3ZDRH3OBz4RpyXzZGGcBstzkwiY34r08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353311; c=relaxed/simple;
	bh=Ta3qXQHIkOjPZ6LA1f4jw6wh5lc5MQY9rn0SjJ30FVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGt0zxX8R3MnRCZbQZ5ZY5SnUpZ7jL0DQoD3R69CKdiUz5IfZI6dKcxhfWfhd+/VS5zGZkm85GlIrL9gR0kUA3z7PfQA4spPynfyOR2oDvPuVrrTk45KlwbY1jH6eMQklnjO2r2/rY4M9qzY5VMYrNlF0yRZMQSEp3oJ/aZwuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guRZ2MlC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guRZ2MlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAB4C2BCAF;
	Thu, 16 Apr 2026 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353311;
	bh=Ta3qXQHIkOjPZ6LA1f4jw6wh5lc5MQY9rn0SjJ30FVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guRZ2MlClzchpr7U+8NGIGGzXY+28tV/9dLfBwkw7pj4iiA0afqo1EkISigxOIGcH
	 XD5PFX/cvfRnLUFJs9RojK7LNvIuH2W9JQXjcYlaKLTsqRZyV9mpEkPoyQBRiHFF15
	 vEsGnyApWuJNjeaKDbMHKVCRbrAKrfYyLp6G071y1iLC5S5OrGW81ZMjJ/rENO8eTS
	 2LpOakTGEA4k7eMgr/2EoGoaqTiqqSh1I5fN7kbYLrclj50o0e78XJkHei6fgJI9j/
	 L/EyId9/JQo0rZ/ZWeT8iJMnkhVcld4Md3XfKds8la/I6hTMQEJbKMsdIBDweZUuBJ
	 LjvWut4Tfw9Tw==
Date: Thu, 16 Apr 2026 12:28:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCHES 0/5 v2] More perf.data header validation
Message-ID: <aeEAG2F3ERbSv94-@x1>
References: <20260416001424.362797-1-acme@kernel.org>
 <2231f14c-0467-41d7-8774-5f720edc0e18@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2231f14c-0467-41d7-8774-5f720edc0e18@linaro.org>

On Thu, Apr 16, 2026 at 02:17:37PM +0100, James Clark wrote:
> On 16/04/2026 01:14, Arnaldo Carvalho de Melo wrote:
> > Hi,
> > 
> > 	This is picking up from what was reported in the previous
> > series, pre-existing lack of perf.data file validation, processing files
> > and buffers in header.c in a similar fashion.
> > 
> > 	There is more to process in the trace data, but that is a
> > different can of worms that needs to be dealt with in a similar,
> > upcoming patch series,
> > 
> > 	This is probably 7.2 material, but if feeling this can still
> > sneak into 7.1, feel free to do it :-)
> > 
> > 	Now lets see what Sashiko discovers while I still don't have it
> > running locally right after Claude, before submitting it publicly, which
> > will soon happen :-)
> > 
> > - Arnaldo
> > 
> > v2: Addressed sashiko comments, adding a patch to the series.
> > 
> > Arnaldo Carvalho de Melo (5):
> >    perf header: Add section bounds checking to the fd read path
> >    perf header: Validate string length before allocating in do_read_string()
> >    perf header: Sanity check HEADER_EVENT_DESC
> >    perf header: Validate bitmap size before allocating in do_read_bitmap()
> >    perf header: Fix 32-bit incompatibility in bitmap serialization
> > 
> >   tools/perf/util/header.c | 57 +++++++++++++++++++++++++++++++++-------
> >   1 file changed, 48 insertions(+), 9 deletions(-)
> > 
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks! I'm replying with a few new fixes and will tentatively keep your
Reviewed-by, please check when it get to the mailing list.

I also made sure it ran checkpatch and fixed the two minor issues it
noticed: order of tags and replacing a Link: after a Reported-by with a
Closes:, also reduced the length of a subject line.

- Arnaldo
