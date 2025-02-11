Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B06261564;
	Tue, 11 Feb 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295976; cv=none; b=NIvhy7CylFaDHwp1KoqZfy+W0npHe+ZJRry990KHTLLUGPbyiQyIewRX3IOGdJQT5Sj9AE963sA5Zk2f84Ud0s9zQ3tbb8UMVzyWdejFCNV05hVYXsJrMhXlI1UsSutPkVey61VavOcz+JNTnSHMIs+IHXSFc3oLn6MdLzQp0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295976; c=relaxed/simple;
	bh=4bWCQgq6wE2a3T0Qy5XzYaE2anG4zZm9WC4XUKvmajU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg2/Ozq9KqqiyXzydICaJEyu/I6/5UYnLp0GX5lVQEO+OT/mdkUhy85PzQY7SDg5Zx4EEGZeK0GQ40ahVK+QZF8pZ19xIZyBKK6F21TP7pI5J7CmtnFLGaYELJzWNwqPnObdVMZWeGz9bC555w3WNhjLQFNUbCuD4SGUYBoSWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcrCSPml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcrCSPml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A42C4CEDD;
	Tue, 11 Feb 2025 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739295974;
	bh=4bWCQgq6wE2a3T0Qy5XzYaE2anG4zZm9WC4XUKvmajU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcrCSPmlaB/tYdBAf+u3i+Q22uPyV5tZ3MrFzjw4HdRxRADGAUIM8IcFdQxl3KlP5
	 2v9uqMCLN3NtFrg+dFYz6tqB2r8MiyoETdn1Ibc+0mnCWUc3lAW2iDV0nZiRlLeGo9
	 lZelCnXID3Z3YTYM5xGdpcZZT5aWLKkqfCbVNt+Hn1bu1t/miAoixrmL6aCJqdriBJ
	 HoGFlWPR4ZiaBD1knaHIiv6KEWlIL9Ah0Tx5RGT8gvtNIbSdJdW+K0BYZp4Q5O379y
	 g+CNBASjEwDJgUeVtLZKMZI87FVsRMFCI6zS4CeFQBCZ5+OBDjjSwKtD+JrpbLtN42
	 qjJB2lSvxnP/w==
Date: Tue, 11 Feb 2025 09:46:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tavian Barnes <tavianator@tavianator.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andi Kleen <ak@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH v1] perf sample: Make user_regs and intr_regs optional
Message-ID: <Z6uM48_IJa-AEzEI@google.com>
References: <20250113194345.1537821-1-irogers@google.com>
 <CAP-5=fVoQRhd-8jyXfjc2dCuwt7_o1sU208aADT1FriwCNa9qw@mail.gmail.com>
 <Z6q7EZxAvskBE4H3@google.com>
 <CAP-5=fUTBJ_15f1WFuHjZzbWDwsAo3d90WX_hobfVWPjSOe3Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUTBJ_15f1WFuHjZzbWDwsAo3d90WX_hobfVWPjSOe3Vw@mail.gmail.com>

On Mon, Feb 10, 2025 at 08:43:40PM -0800, Ian Rogers wrote:
> On Mon, Feb 10, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 10:15:22AM -0800, Ian Rogers wrote:
> > > On Mon, Jan 13, 2025 at 11:43 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > The struct dump_regs contains 512 bytes of cache_regs, meaning the two
> > > > values in perf_sample contribute 1088 bytes of its total 1384 bytes
> > > > size. Initializing this much memory has a cost reported by Tavian
> > > > Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> > > > script --itrace=i0`:
> > > > https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com/
> > > >
> > > > Adrian Hunter <adrian.hunter@intel.com> replied that the zero
> > > > initialization was necessary and couldn't simply be removed.
> > > >
> > > > This patch aims to strike a middle ground of still zeroing the
> > > > perf_sample, but removing 79% of its size by make user_regs and
> > > > intr_regs optional pointers to zalloc-ed memory. To support the
> > > > allocation accessors are created for user_regs and intr_regs. To
> > > > support correct cleanup perf_sample__init and perf_sample__exit
> > > > functions are created and added throughout the code base.
> > >
> > > Ping. Given the memory savings and performance wins it would be nice
> > > to see this land. Andi Kleen commented on doing a reimplementation,
> > > which is fine but out-of-scope of what I'm doing here.
> >
> > Yeah, I like the core of the change.  Andi's concern is that it touches
> > too many places.  It'd be nice if we can do that without allocating
> > memory for regs and eliminating the perf_sample__{init,exit}.  But I'm
> > not if it's possible.
> 
> Moving from no allocations to 2 possible allocations means there has
> to be corresponding frees. Putting the frees into an __exit function
> is the norm for this kind of cleanup. I don't see how you can move to
> the approach presented without adding the frees and not introduce a
> memory leak. I don't see what's actionable for me to do here.

Right, I'm inclined to merge this patch.  But I need to think a bit more
about the Andi's approach before that.

Thanks,
Namhyung

