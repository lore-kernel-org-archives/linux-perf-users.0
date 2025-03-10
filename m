Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53D28EA;
	Mon, 10 Mar 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604158; cv=none; b=cAQsWT1b1NFDDL7AP/eyOUCxiuXQO/dceptDlDV3zAvCWOhKZBknHdc9kVtekokGco1hBNDqjNGLRMsljHHRwK61s7gwBC09O0ZygULK1g6f5AxzOwNoRCtxXOxLdRdIE7FaDyv1nYzisWfS+gckCukEqAWfbkomMpSiEY0z1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604158; c=relaxed/simple;
	bh=U6QojVvDNCz2sg10+fQRWNK7SCsQmMVV3uzE13H8jHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRHZ8Fcdp5MQ5M9PtJ4d9ItF6wJ7zbbK97oZDQ85YK1iVHsLlUZHN3d3FlqoLhnwEziTBNs+0xITQ9oz+nhK69Wsl+9RXt6qdK8XX2s/6eRsUG5noAzxiLyq/HzXbqFVk7F65Nj0j+WwCx8tKUZB1j9J/myotB/0cskFEW72Gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3D9152B;
	Mon, 10 Mar 2025 03:56:08 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E653F5A1;
	Mon, 10 Mar 2025 03:55:56 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:55:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: Mark Barnett <mark.barnett@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] perf: Allow periodic events to alternate between
 two sample periods
Message-ID: <20250310105551.GB9682@e132581.arm.com>
References: <20250106120156.227273-1-mark.barnett@arm.com>
 <20250106120156.227273-2-mark.barnett@arm.com>
 <20250121130154.GA416913@e132581.arm.com>
 <c62a9f8a-312d-4f9e-9022-265e53564101@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62a9f8a-312d-4f9e-9022-265e53564101@arm.com>

On Fri, Mar 07, 2025 at 08:28:13PM +0000, Mark Barnett wrote:
> On 1/21/25 13:01, Leo Yan wrote:
> > >   	local64_set(&hwc->period_left, hwc->sample_period);
> > > +	if (attr->alt_sample_period) {
> > > +		hwc->sample_period = attr->alt_sample_period;
> > > +		hwc->using_alt_sample_period = true;
> > > +	}
> > 
> > My understanding it sets a short sample window for the first period.
> > Would it initialize the `hwc->period_left` with the updated sample
> > period?
> > 
> 
> It sets the long period first: hwc->period_left is used to program the PMU
> when setting up the event, and hwc->sample_period is queued up as the next
> period to switch to.

Makes sense to me.  Thanks for explanation.

Leo
