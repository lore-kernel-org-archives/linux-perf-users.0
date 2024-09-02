Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00E13B2A8;
	Mon,  2 Sep 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273538; cv=none; b=eTaHslgQgSEtLnZuqd1QpO4dpPvaLjoj1mBhveilprYWMeBxQOXushvkAl1/FOoR8wodwBZpKky9ttV5VmEMJqs6q5WNQebux0cCxa2NOGVkFOfe2MzqaGOwSJACosY4x6S0gN0EBSPMJPYEsJ0edybMRyVcNXbh8RUcsyZS2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273538; c=relaxed/simple;
	bh=ot8Fmu649Y0ccENnu1SrOH7aAeWJNW8i6O4K7NV1Rco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmvm/cIErHMPltIzQ/bpscGQAHPuy+JTa2pk+3Vjx8aXQETUZVu/aIwHQ0C+ROgOEGm3ss6MNeKzl+HqHVbUhMNFjs8NaJCxGPd/VkFW93tuzzieN9gQfb1ivqhp/ho4ilw9rjZFxU2Rf/IvX/eXjjwupBRV+qS1j+Ra29fDVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZ1O9oys; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZ1O9oys"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uf8MwF/4dGWtWA/eHqRkvB1VGv/hhnoNp3eqd6ZV74E=; b=dZ1O9oysTENaAGZnE844e9t26U
	5VdjqIA3ghjxfdWyPiH+5OWN7SbthqjSSbyskG0Xap8IRjOlryyt2eDKVWrdi333jamHysWTIaRJi
	9yFS9TUZM+vubF+WT6cfrHrEfoVduWuV9vzhQmsTbx+W90tjQKj1ELTDEo5d+o4lvNJJlq+2DjDb+
	g/91KAb4m3wr+35LonqyhoHIFKaOZzwWy/xdarNbQ6308wpycWT3AJwlm0RoPgg76Vs3TvNzeI9tE
	79MPYaYvQ88xhTj0wOATwuTygxdspcixPWv3kIXL0p7yLkO2MU6/Hyc4I9XlvVTn75FL2rAXnvkkc
	CF9yUBQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl4SG-0000000C8Rq-02kt;
	Mon, 02 Sep 2024 10:38:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D0508300642; Mon,  2 Sep 2024 12:38:38 +0200 (CEST)
Date: Mon, 2 Sep 2024 12:38:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: kan.liang@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	ravi.bangoria@amd.com, sandipan.das@amd.com,
	atrajeev@linux.vnet.ibm.com, luogengkun@huaweicloud.com,
	ak@linux.intel.com
Subject: Re: [RFC PATCH] perf: New start period for the freq mode
Message-ID: <20240902103838.GF4723@noisy.programming.kicks-ass.net>
References: <20240829152036.3923842-1-kan.liang@linux.intel.com>
 <ZtFjFpg0MCcLbgnq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtFjFpg0MCcLbgnq@google.com>

On Thu, Aug 29, 2024 at 11:13:42PM -0700, Namhyung Kim wrote:
> Hi Kan,
> 
> On Thu, Aug 29, 2024 at 08:20:36AM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The freq mode is the current default mode of Linux perf. 1 period is
> > used as a start period. The period is auto-adjusted in each tick or an
> > overflow to meet the frequency target.
> > 
> > The start period 1 is too low and may trigger some issues.
> > - Many HWs do not support period 1 well.
> >   https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/

So we already have x86_pmu::limit_period and pmu::check_period to deal
with this. Don't they already capture the 1 and increase it where
appropriate?

> > - For an event that occurs frequently, period 1 is too far away from the
> >   real period. Lots of the samples are generated at the beginning.
> >   The distribution of samples may not be even.

Which is why samples include a WEIGHT option IIRC.

> Sounds like a per-pmu callback is fine.  PMUs don't have the callback
> (including SW) can use 1 same as of now.

This, but also, be very careful to not over-estimate, because ramping up
is fast, but having to adjust down can take a while.


