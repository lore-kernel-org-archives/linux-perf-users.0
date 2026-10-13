Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC9549373;
	Tue, 13 Oct 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925338; cv=none; b=mZbq1UeBHEFEktk3yBIsCKGHav4RH8+fKvn0LWy97/1sU813Y8J2vGfiOuURLMv/AEJ/j5ndZfqITbYv1X0DJ2HpH+TKRprvXMOCrVtYh+uoM+5arIOJFo6bnvAZvSasJqGSKIpefn/ISYzaUdnANIcClBTxE0xOqSlaUCW819M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925338; c=relaxed/simple;
	bh=UJHR76vl+MEUjiZ//7x/PXjvjCbdvLEy4hJOsBGNIIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AazHTahTvuTEWOiEVNNnNz9UE47xPMYJmID9dHjxr760Li8sxo2AiLKXJIuyZLqEloMn5i5N6YQcMzuk06HXJaJoB1GFJNceiYlTzyGfv6xhA+hmy373SDIuQfKtwFAgjJJTg315sLf/zJ4YuEub2/SYD7ExGDB6WCk5cvyVDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvW0QaRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvW0QaRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3431F000FF;
	Tue, 13 Oct 2026 21:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925337;
	bh=4R7RHEcGGuyj5QBCKA+FhYuw4CzT0viDaHNbHQ0NMQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OvW0QaRw9OjkDu1ZoiVUnF3yq2owNaS1USUeSE8QF2XjI22jcMkOviIskB14gTtAz
	 GGqKzofLTmgWKAlurgZ41W/bQ2UrV3nstZqbCKFPS3Hkb8OOBUgfJNOIyQOzZsTkN0
	 /lQXbGvCtIMYWPEih/ja35XIcczQ+B9wjJXCP6Vc6b/z5kFAGqOdBZP69Umwvj1Jx3
	 pMnEwYlLgtAVuHvl+tvYEUSp2EdOnJqZv5wNxoBdWlkFD0jnekUNPWIwXkHjVY7BBm
	 eG4u2z0THoicPERHN20etM/2RtqrkxZq+o5Oc5qe2fm0KXgNUhShL0ffTD+gkarCJp
	 eJY5fGdXKG3hQ==
Date: Tue, 13 Oct 2026 14:02:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/4] perf symbol: Fix symbol loading from libbfd
Message-ID: <as6cV-cm6dgTtzet@google.com>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <as557LTNwiigXk0O@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as557LTNwiigXk0O@x2>

On Tue, Oct 13, 2026 at 03:35:24PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 12, 2026 at 04:59:34PM -0700, Namhyung Kim wrote:
> > The dso__load() should return a positive number (number of symbols
> > loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> > only returns 0 and it's hard to check if it actually loaded symbols or
> > not.  Let's return the value of dso__has_symbol() and check it in
> > dso__load() so that it can return 1 for success.
> > 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> > Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks, applied to perf-tools-next, for v7.4.

Thanks Arnaldo!

As you may know, this is from my other series on cleaning up symtab and
binary types.  I'd like to land it as well so that I can continue
working on the related issues.  There are some Sashiko feedback left,
but I think they are either pre-existing bugs or known issues.

Thanks,
Namhyung

