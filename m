Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C27396B67;
	Tue, 24 Feb 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935658; cv=none; b=Q/rfMesYhEpX1H6gS8ZdL3XjYFG+MLHYRZ+h4goQsonxa+UT2vRDqCOvN5BgCxv5S1098zqbk8FMGtUzuC/c6HNiWIVbU6LS1ih83jzFsb2U++5JMjCeexpN6SZzdS/GjLYz1PW76Kh4o1Ljx1dMED3KJVimAaP5dSqFRKOUrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935658; c=relaxed/simple;
	bh=ot+FuHpdmh1NN3k/S4wA7J5IdzxsnYaw9Pq1QpzUnLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaDsSKBHr3YQIgtIaXLGLg4+Sp7PWqZg64e9pPHd1NUk9q19lySUeWm5LurE7STOIuAriq6LH4FBt4p32g8cFfrawUodO8xGAHgreaOvkebSOmBt+dJxxjP1jEFTpxlDiB/7AbXO5goYmRfs4+11Ffgv3cygaQ1fGJknGSOuojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F3D9339;
	Tue, 24 Feb 2026 04:20:50 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27EA33F62B;
	Tue, 24 Feb 2026 04:20:56 -0800 (PST)
Date: Tue, 24 Feb 2026 12:20:54 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf bench: Fix initialization of union
Message-ID: <20260224122054.GB4184494@e132581.arm.com>
References: <20260219004417.188434-1-namhyung@kernel.org>
 <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
 <ea82e2ab-ddb5-419b-aa70-49b28f18383a@linaro.org>
 <20260219150256.GC136967@e132581.arm.com>
 <aZdd2clm2RQGLnT4@google.com>
 <aZymm3rGRtztu29p@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZymm3rGRtztu29p@google.com>

On Mon, Feb 23, 2026 at 11:12:27AM -0800, Namhyung Kim wrote:

[...]

> > > Thanks for bringing up this, James.  The latest patch would be:
> > > 
> > > https://lore.kernel.org/lkml/20250402173056.829400-1-leo.yan@arm.com/
> > > 
> > > This patch intends to apply the option across tools, but no response
> > > from the maintainers.  Seems to me, it may be good enought to apply the
> > > option to perf first.
> > 
> > Thanks for the reminder, yeah it looks better.
> 
> Leo, can you please resend that patch to linux-kbuild list and CC the
> maintainers?  It seems you did it to Clang folks only..

Sure, I have resent one on linux-kbuild:
https://lore.kernel.org/linux-kbuild/20260224-tools_build_fix_zero_init-v2-1-b1acc817a01e@arm.com/T/#u

It is a bit weird that get_maintainer.pl never finds linux-kbuild for
the patch, seems it can be improved in MAINTAINERS.

Thanks,
Leo
