Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F01991DB;
	Tue, 30 Jul 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342333; cv=none; b=qjn0I7JacWyES9RwnGkTyCwDLHTSogTXL4qkrIGpWH3RFOliN7E5yumd0v3obq+//PwxeHmWockZsY9DLLnF0pBMdNMAOIWejMPyYxvynsF0Td5wxioakKSIcrkgQXDv8jVqd7mcWhmdcetnhaVCcqmPRkdkZKtvNwPMkzT5tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342333; c=relaxed/simple;
	bh=O+APogg31XJYXa+qA1ns4FuwpSfqqdQwvu/KFCgxW4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd3v0wP0cjtllcc9pYD32AQFAsJBY5yNeyr5yluekyAOlHyys7cvJUK4ICvACZftP0gTn1mwJ7qnSYFai5ozf2PgpHjrky9TTeWRaPhctiV13CJsVqpnQturWX946Nx0BcQcrXYuL2wrFI/AoTMjpGtoKJidfpMz7DBhtHnVwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g3yG5xOn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g3yG5xOn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jYz1vfAKG9FMPtlvfw35hYBFHC1NPgZLi13Kc5L4l4g=; b=g3yG5xOnz2KiC1O64/hVFAQ+JB
	g+IC2s4WpGdq1+l4HX70egoXG43jfcZ3IW2d3EpPHyy8hB7M6Vg0gFW9HBMZZ264qzSTMDlmbiUoF
	lltVGoxdTFJGydxvsIQObQvhlSZhxjlmytC1n2EvM5XHoSm9HLbtRb8bqlWoC9KbyHcPBvvnOi7AY
	DjmYVMVXL5Qi9jIPAQX3OJEGYssI3o3McYv5ym23Qw9GUlydkWUmV018mln91rzzfPEDwFqYN2cdo
	00y6Ap4JjNYSBofzn8I4Dd2kedg8Ur388vKZxwOgkWRH/VcFYggLmw8CkVVYDhb/SvuU7eikpGPku
	wB3d5Mrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYlut-0000000EfLh-3N0s;
	Tue, 30 Jul 2024 12:25:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 702753003EA; Tue, 30 Jul 2024 14:25:23 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:25:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ben Gainey <ben.gainey@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] perf: Support PERF_SAMPLE_READ with inherit
Message-ID: <20240730122523.GM33588@noisy.programming.kicks-ass.net>
References: <20240730084417.7693-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730084417.7693-1-ben.gainey@arm.com>

On Tue, Jul 30, 2024 at 09:44:13AM +0100, Ben Gainey wrote:
> This change allows events to use PERF_SAMPLE READ with inherit so long
> as PERF_SAMPLE_TID is also set.
> 
> Currently it is not possible to use PERF_SAMPLE_READ with inherit. This
> restriction assumes the user is interested in collecting aggregate
> statistics as per `perf stat`. It prevents a user from collecting
> per-thread samples using counter groups from a multi-threaded or
> multi-process application, as with `perf record -e '{....}:S'`. Instead
> users must use system-wide mode, or forgo the ability to sample counter
> groups, or profile a single thread. System-wide mode is often
> problematic as it requires specific permissions (no CAP_PERFMON / root
> access), or may lead to capture of significant amounts of extra data
> from other processes running on the system.
> 
> This patch changes `perf_event_alloc` relaxing the restriction against
> combining `inherit` with `PERF_SAMPLE_READ` so that the combination
> will be allowed so long as `PERF_SAMPLE_TID` is enabled. It modifies
> sampling so that only the count associated with the active thread is
> recorded into the buffer. It modifies the context switch handling so
> that perf contexts are always switched out if they have this kind of
> event so that the correct per-thread state is maintained. Finally, the
> tools are updated to allow perf record to specify this combination and
> to correctly decode the sample data.
> 
> In this configuration sample values, as may appear in the read_format
> field of a PERF_RECORD_SAMPLE, are no longer global counters. Instead
> the value reports the per-thread value for the active thread.
> Tools that expect the global total, for example when calculate a delta
> between samples, would need updating to take this into account when
> opting into this new behaviour. Previously valid event configurations
> (system-wide, no-inherit and so on) are unaffected.
> 

Thanks, I've picked up the kernel patches, and provided the robot
doesn't hate on them, they will appear in tip/perf/core soonish.
