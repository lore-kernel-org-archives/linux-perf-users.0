Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454E4D2EFB;
	Fri, 25 Sep 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352677; cv=none; b=O6z4n57qQzEFLccYtqGKtoWpejDd28VdStEbQWbir1IbpP7ou0XxupwtJKnCP6jqC/fB4UzOvnBQr2J7MN3aypq8McupmP1Y9Uijm6lAmuifv5tgnjeYoiOx/wD3ueyjW29zVY91SKPx/gGevtuUrEkuOsS7dU1WLOguyqLd6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352677; c=relaxed/simple;
	bh=tNZiINhAgoWBddneOe0lxhDTMu/CtC8NhXjgbDcZdMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4ce3Rtg4uIzp3wwqlk1oS0Eaptj9zKTCf88M2Q2RyykGyJEk5rEtMG2Iw/LgmN1g0zCOU8VXcvbRHSzNlkQ/JmHcDJNuSqvtmmKbSvRLcdeeHlcaoLm6c/Ke6GGYMGbcbA4o+UHOsIEbu09KAq2FXXwnRpFTk4AnwASWyTzwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1TeRTQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1TeRTQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B5C1F000FF;
	Fri, 25 Sep 2026 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352673;
	bh=+jiq9FfOTSApRJUAH06bTA+5s0SgNSc+chX4QLxSW6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q1TeRTQah78L0XfQfws7DjkA21t3a2cfIi6l+oYcF+OmrMVSex5aplGXP8cYwgfr1
	 fzDYEUJi68dC65BjeWLP5s+XCof7kniZK+o3wzcfX5GNR5xz82/G0Pne4sa5M2WoRe
	 Jm9mmkx/uv2hDqlgkW8UOyhx88gndfIr91Lp/PFlaqd8KsEtr8jeZe/kTA/5+Ur634
	 sV1LSxMDh5eCo/WbhBR8OnCaRbv+FHgFSS8ps/UY/atWF7YhuzPM1xbF4ItCzDd425
	 nEfqK7J+VfWqs/BZhUQlEC/t9TLbSNkYFzDR5tCJqgFNqWeplJlm9h5P9arZ+EULwj
	 UzhDeq7NBLdGA==
Date: Fri, 25 Sep 2026 18:11:11 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/6] perf annotate-data: Bound the member nesting
 recursion
Message-ID: <aradH0z2mqcNxyFK@x2>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-5-acme@kernel.org>
 <araVqTiVF9DpkSmh@z2>
 <araWryMoGYJ99LC1@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <araWryMoGYJ99LC1@x2>

On Fri, Sep 25, 2026 at 05:43:43PM +0200, Arnaldo Carvalho de Melo wrote:
> On Fri, Sep 25, 2026 at 08:39:21AM -0700, Namhyung Kim wrote:
> > On Fri, Sep 25, 2026 at 05:06:55PM +0200, Arnaldo Carvalho de Melo wrote:
> > > +++ b/tools/perf/util/annotate-data.h
> > > @@ -61,6 +61,9 @@ struct annotated_member {
> > >  	int size;
> > >  	bool is_union;
> > >  	bool is_flex_array;
> > > +	unsigned int depth;
> > > +	/* Children not expanded because the nesting limit was reached */
> > > +	bool truncated;

> > Nit: it'd be better to switch the order of the last two fields to reduce
> > the padding.
 
> I should have used pahole... 8-)

MAX_MEMBER_DEPTH is 32, so we can make it an u8, did it:

⬢ [acme@toolbx perf-tools-next]$ pahole -C annotated_member ~/bin/perf
struct annotated_member {
	struct list_head           node;                 /*     0    16 */
	struct list_head           children;             /*    16    16 */
	char *                     type_name;            /*    32     8 */
	char *                     var_name;             /*    40     8 */
	int                        offset;               /*    48     4 */
	int                        size;                 /*    52     4 */
	_Bool                      is_union;             /*    56     1 */
	_Bool                      is_flex_array;        /*    57     1 */
	_Bool                      truncated;            /*    58     1 */
	u8                         depth;                /*    59     1 */

	/* size: 64, cachelines: 1, members: 10 */
	/* padding: 4 */
};

⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
