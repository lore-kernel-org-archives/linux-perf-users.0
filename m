Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9A13213E;
	Thu, 24 Apr 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511392; cv=none; b=Yr5W4ao5CEWaf1ll/vIAHk1Og4VKk/3ICqybpH3XCbZNUDvkjqH8q61diM5Fubm1Q95BItdLxaEAHM7J3BENeQEWLtt/vXXkZyAv0pf8mQY8DjHmluC8oOzw3lY/1eYx1DJzvP9ZoQQOzRSVFMWW7/XcGiZdx7Lo7/1Pymg3UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511392; c=relaxed/simple;
	bh=ufPD5Qc37EQkwAX6bXVZ6anbgOdjefX2LxyQmQbslzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OADQ8Cyepo/ukx3p81QkoazaYsPbDYY02HB5B7TGOfS1/CFTmzAUuw3jG8VCMqtZF3tsRREhFNNBoNNbaHfgrjZAQwz2eKm02JZaUHUByQliYnyE+qt/z3GEyX3A6CTZ5hR5GatPJjBgNB85a+ZW9HVDT975WdvqEiLgAF8xan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EYIanhV0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EYIanhV0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PNY4afMuvAcfFQt5nQIxzLkrrR5jlxWzwnh2y2DRzY=; b=EYIanhV08SnaH/rHYdMDItwphV
	jd1ERqfdwFiEH3xw9gJPARmotnHiBbJhgmkb/CaAn4WhL5GjOxVjhsbvpWuevhvcTTlAwmskYrjsM
	GcJBKu/QPoH8oapRH9t06RZIupMDJvP+umFz9VaYXghwojqvrHaFmvgLUGzmUewT+gqv9N1wfSNGo
	pPG5w6WXLZlrD3zURiQ/RZJNUDrgt+ZmQ4tLE7gL2Dd/QbRGJslSAurUONZfTqaRI3DIFYSZBSHFV
	y5dC1M++AgDC5SG2YwFNnHH4L1bmWNfk2t3nAP/Sb5gdSei0hWE5u4ypUYiF8GjOdeSfTnY+rMYWK
	rtUkrYkA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zFO-0000000Cp9u-3Urm;
	Thu, 24 Apr 2025 16:16:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4AC7E300642; Thu, 24 Apr 2025 18:16:22 +0200 (CEST)
Date: Thu, 24 Apr 2025 18:16:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf: Fix failing inherit_event() doing extra
 refcount decrement on parent
Message-ID: <20250424161622.GB18306@noisy.programming.kicks-ass.net>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424161128.29176-2-frederic@kernel.org>

On Thu, Apr 24, 2025 at 06:11:25PM +0200, Frederic Weisbecker wrote:
> When inherit_event() fails after the child allocation but before the
> parent refcount has been incremented, calling put_event() wrongly
> decrements the reference to the parent, risking to free it too early.
> 
> Also pmu_get_event() can't be holding a reference to the child
> concurrently at this point since it is under pmus_srcu critical section.
> 
> Fix it with restoring the deleted free_event() function and call it on
> the failing child in order to free it directly under the verified
> assumption that its refcount is only 1. The refcount to the parent is
> then voluntarily omitted.
> 
> Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Bah, yes, another bad interaction between your fix and my patch :/
