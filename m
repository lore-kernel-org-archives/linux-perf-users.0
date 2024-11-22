Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4A16DC28;
	Fri, 22 Nov 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273749; cv=none; b=Wia+dxZ8GvgSKN9vq1BDPhcaHfpZNHpkAVOzhueqPJDhyfTSvgNcIPcZuHnoFT6CwA+noxm1KX5IFXicPjdXU7vNhW3js3lEue7cyu2tCwPL0ICaHIlH/n1NHUJOW+xhR2tNlDrIW8lFuo3MqXdxjbZpofQVQVh27CvyhEafPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273749; c=relaxed/simple;
	bh=ffs1nLKkGP3VEAuJlQD8RaPtk6KzOTqz/mLYiNoJA18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqk1Jt8LuaHr5lKqi7QopObS9k+JZmKJTOAvLKW/6Oq2BeK95wfoR1kBQoQJ1j1BwBuFmziH/gDVOJmG1n3sIBNY425vkKc8o7YdY+9rAzmnLO9hKY8SlnHb80vu6oseTpiOXB7T1MNQnKYqaT3Ztsw0ice4eDhAuBbiLUskvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J7fTQZ7o; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J7fTQZ7o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6cKBqccYYhy1XWbHT7WP8yFOQmmUZIX7hawSrfJ8Jag=; b=J7fTQZ7obtWwHEo4xLVe/EYmJb
	vz56rgz8iKklAMVoPhhtFpMpiOUy36XX1tvJckleBpSrsW8Y1+F/21AdPFNL46BwscZ8MfsOQi8J5
	qAwt5a7WHpHZgntk4JS6l+hTF3p+DBQBwdGjhSPMu4zLsC1h1AgzJNZFn1mLXGoqnxYZKevT3JgOB
	+WtjyJ9Nu0163PxSGuZuLIyjSQHp3Ct9xba4YYPiQIvYZtECNxnPhGvRsvoSFgah1L8Htg+7e8X4e
	mu1ynF3zSuvyJm/V/32NJYxloqvK0T5B97EFw5hDOB8Nd6USkLCPNpcy3m2GmfwKNLIThfWwTQa0/
	6JpCSqJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERWv-00000000hIE-48XB;
	Fri, 22 Nov 2024 11:08:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9EED330066A; Fri, 22 Nov 2024 12:08:53 +0100 (CET)
Date: Fri, 22 Nov 2024 12:08:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, vineethr@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [sos-linux-ext-patches] [PATCH v2 1/6] sched/stats: Print domain
 name in /proc/schedstat
Message-ID: <20241122110853.GQ24774@noisy.programming.kicks-ass.net>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
 <20241122084452.1064968-2-swapnil.sapkal@amd.com>
 <12995871-3186-4265-b1f5-520252b9757f@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12995871-3186-4265-b1f5-520252b9757f@amd.com>

On Fri, Nov 22, 2024 at 02:25:22PM +0530, Sapkal, Swapnil wrote:
> On 11/22/2024 2:14 PM, Swapnil Sapkal wrote:
> > From: K Prateek Nayak <kprateek.nayak@amd.com>
> > 
> > Currently, there does not exist a straightforward way to extract the
> > names of the sched domains and match them to the per-cpu domain entry in
> > /proc/schedstat other than looking at the debugfs files which are only
> > visible after enabling "verbose" debug after commit 34320745dfc9
> > ("sched/debug: Put sched/domains files under the verbose flag")
> > 
> > Since tools like `perf sched schedstat` require displaying per-domain
> > information in user friendly manner, display the names of sched domain,
> > alongside their level in /proc/schedstat if CONFIG_SCHED_DEBUG is enabled.
> > 
> > Domain names also makes the /proc/schedstat data unambiguous when some
> > of the cpus are offline. For example, on a 128 cpus AMD Zen3 machine
> > where CPU0 and CPU64 are SMT siblings and CPU64 is offline:
> > 
> > Before:
> >      cpu0 ...
> >      domain0 ...
> >      domain1 ...
> >      cpu1 ...
> >      domain0 ...
> >      domain1 ...
> >      domain2 ...
> > 
> > After:
> >      cpu0 ...
> >      domain0:MC ...
> >      domain1:PKG ...
> >      cpu1 ...
> >      domain0:SMT ...
> >      domain1:MC ...
> >      domain2:PKG ...
> > 
> > schedstat version has not been updated since this change merely adds
> > additional information to the domain name field and does not add a new
> > field altogether.
> > 
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Tested-by: James Clark <james.clark@linaro.org>
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

Surely you mean either acked-by or reviewed-by ? Otherwise I suggest you
re-read the documentation on tags.
