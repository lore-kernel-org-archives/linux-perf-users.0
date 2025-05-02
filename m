Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD930245000;
	Fri,  2 May 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187464; cv=none; b=KsQu8yIIiY9QC2UNSafwMOfrGbDDvHRLJRtdt8T0HGQeAyBk6jJe24Z8T0j2dSdW6LwDp576rhss8OyE61FvKO+hTuEdyGUwy1MX+OsGwfthwcMYik3CheegnmdwPvr2aSDF27MEUJLT4ebLsjjkbyJPc2yz42b20hlG3SA+BEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187464; c=relaxed/simple;
	bh=m7SHXIJlHN3BFPabIlQ6y1QGcxPbcE0eg/81bW8PVRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M76QsbjkG/QMOcm3fRqhTtk+WgVhRc2fea8tBTbDpSqvLhllXyddLwVqixHn4gUOfEjGjKZwxBwoLhuGYC4CbWY2LWiLoZfkSSb1CFKt7c2LqUPVAeXzwjYi7WRmZlp11+sq+Wz28wJbd1Uvq7Y+4TbgZrV88sRa0wZMm7JtGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH7yrfze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH7yrfze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEC6C4CEE4;
	Fri,  2 May 2025 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746187464;
	bh=m7SHXIJlHN3BFPabIlQ6y1QGcxPbcE0eg/81bW8PVRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AH7yrfzeIz0E1XtU/6YSvpOZykzoZTml4IoQyLF1cvRfnxwGCZVE0qNQ+y4gQAHz1
	 Nd6Q9V0V3w3ksB4GPdop22vc/V7MY4suW7khS3flSnpHWVf4heHnoxwRg+Yvl3xm3n
	 liTPtpCvCnATWIrZMZPnERRaF0UEcqg+pA3Iri3pFvX9e8e0yqFnkSJ0v2JQfwMDUG
	 YSilDIRTllul47VPMS1ljNpm7LHSFDbIJacOFZKWkoY6IjY23Q7pGdsq/b4CbOX7C+
	 XaJMPMpK5ojvW0zvKEM+9efgSOrG1A2Oa55R5TA04MtTifzddnqi4bhCD8Byn6m4G/
	 62eShyzrEFUjw==
Date: Fri, 2 May 2025 14:04:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aBS0xd6KqoWRpj7u@pavilion.home>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-3-frederic@kernel.org>
 <20250424163024.GC18306@noisy.programming.kicks-ass.net>
 <aA9ic6m6WAcmVBAw@pavilion.home>
 <20250502102918.GW4198@noisy.programming.kicks-ass.net>
 <20250502113002.GF4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502113002.GF4356@noisy.programming.kicks-ass.net>

Le Fri, May 02, 2025 at 01:30:02PM +0200, Peter Zijlstra a écrit :
> On Fri, May 02, 2025 at 12:29:18PM +0200, Peter Zijlstra wrote:
> 
> > > @@ -13951,18 +13943,25 @@ perf_event_exit_event(struct perf_event *event,
> > >  	/*
> > >  	 * Child events can be freed.
> > >  	 */
> > > -	if (is_child) {
> > > -		if (parent_event) {
> > > -			mutex_unlock(&parent_event->child_mutex);
> > > -			/*
> > > -			 * Kick perf_poll() for is_event_hup();
> > > -			 */
> > > -			perf_event_wakeup(parent_event);
> > > +	if (parent_event) {
> > > +		mutex_unlock(&parent_event->child_mutex);
> > > +		/*
> > > +		 * Kick perf_poll() for is_event_hup();
> > > +		 */
> > > +		perf_event_wakeup(parent_event);
> > 
> > Should not this perf_event_wakeup() be inside the next if() as well?
> > doing anything on parent_event when !ATTACH_CHILD seems dodgy.
> 
> I made this change, and munged the original changelog on top and stuffed
> the patches into queue/perf/core.

Looks good, but it looks like you trimmed the changelog with the
race windows part. Though I must confess, who wants to read that anyway? ;-)

-- 
Frederic Weisbecker
SUSE Labs
