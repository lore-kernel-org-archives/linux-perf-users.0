Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E9213E6D;
	Fri,  2 May 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185413; cv=none; b=YVIhvrt7kIhhiTOWuABFdV3rgoYxNKv5X41sWAOmoR67tGv2LpFxdIAxCZ9cbwLgk4nraZdjIxd1bLRyGw/IAcMv7UoPmf3QsswxWmB4YUhzrtgFbKkeYlMEB2pV51eWs/HTSmut3GMb2Tlg3B478leDsecNkvuv+cW5HutwylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185413; c=relaxed/simple;
	bh=2QKHX5I0hrfjKUeJW5kqDHcnDew73hGAW86pFp03DEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dhf1N4aApfMfvkjmus+YEyqM5gfaDebZ6qVTNpeCZegfJiEicfQlbTmIBDWqtfprpSugEkasVY5D/Zj3ZLTDhdwqp1CGIjaliZfevfOb5GPgOAJxQAjCqguS20U5qBfWQFaj87yJkz3ek7YALRfoXmxD7IMvqlzua5NwQSiAMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W9KPIPgQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W9KPIPgQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q9WiYxsL0hM2ucNez6Xdvadf+AnlurqcqXxqHVY4ku0=; b=W9KPIPgQbJzttJSnUnHXmYV0o4
	a8m3wtPol/rEWe3szznpiHry9s0IR3srTVQdvTD9PSNSVxfH0vKU3hrtI9VYkAyr4Ydq3hzTKC567
	xek4RHndpZu8vMLQnkmJ/WBtwfmIji9TqHyERU8dYsnNXexR0O0l6SiRN4B3NGnB0nYRnrSKb3bry
	JA9E7ebsXTr0p+H7AgwOSbNHZcpuCVod+F05fxs8B43n58lyeW3uiyW1IC5G82ShTuoWrOKYmBPMY
	BP/qVBV0J6oZVY4/NhLfFe89uCePs/uOEpL43us2A/Kqoq/EBjLVuYIALiieUOAjik6cSjE6vhNPT
	KKpTmwog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uAoag-0000000EpK0-3IGE;
	Fri, 02 May 2025 11:30:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 260F030057C; Fri,  2 May 2025 13:30:02 +0200 (CEST)
Date: Fri, 2 May 2025 13:30:02 +0200
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
Subject: Re: [PATCH 2/4] perf: Fix irq work dereferencing garbage
Message-ID: <20250502113002.GF4356@noisy.programming.kicks-ass.net>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-3-frederic@kernel.org>
 <20250424163024.GC18306@noisy.programming.kicks-ass.net>
 <aA9ic6m6WAcmVBAw@pavilion.home>
 <20250502102918.GW4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502102918.GW4198@noisy.programming.kicks-ass.net>

On Fri, May 02, 2025 at 12:29:18PM +0200, Peter Zijlstra wrote:

> > @@ -13951,18 +13943,25 @@ perf_event_exit_event(struct perf_event *event,
> >  	/*
> >  	 * Child events can be freed.
> >  	 */
> > -	if (is_child) {
> > -		if (parent_event) {
> > -			mutex_unlock(&parent_event->child_mutex);
> > -			/*
> > -			 * Kick perf_poll() for is_event_hup();
> > -			 */
> > -			perf_event_wakeup(parent_event);
> > +	if (parent_event) {
> > +		mutex_unlock(&parent_event->child_mutex);
> > +		/*
> > +		 * Kick perf_poll() for is_event_hup();
> > +		 */
> > +		perf_event_wakeup(parent_event);
> 
> Should not this perf_event_wakeup() be inside the next if() as well?
> doing anything on parent_event when !ATTACH_CHILD seems dodgy.

I made this change, and munged the original changelog on top and stuffed
the patches into queue/perf/core.


> > +
> > +		/*
> > +		 * Match the refcount initialization. Make sure it doesn't happen
> > +		 * twice if pmu_detach_event() calls it on an already exited task.
> > +		 */
> > +		if (attach_state & PERF_ATTACH_CHILD) {
> >  			/*
> >  			 * pmu_detach_event() will have an extra refcount.
> > +			 * perf_pending_task() might have one too.
> >  			 */
> >  			put_event(event);
> >  		}
> > +
> >  		return;
> >  	}
