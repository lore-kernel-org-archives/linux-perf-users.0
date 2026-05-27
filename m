Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4919A288;
	Wed, 27 May 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899425; cv=none; b=s/S9NtkgxecGtUBofvYryC1QRxNB9USAGEz7C6mdWkQkXPcSBGgthUgfTmV4J4yKAl+SgyI8RjmenW+EpbUQuXR0IM76IAExnmgb3ST8/v45S2TibqgWJSRiKcifRJ1OJr61cYHKuZlar3yUd7fR0GbqYm5u7o6QI6zjNZJzFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899425; c=relaxed/simple;
	bh=iSdz8ADlh7SmbRG7RwaWkpOoauiAdWfqFXI8F6QWd14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9rQQ38qmR/BB3lS0B2x7d80CcRVuxwP/AAqF83FEYeW5leoLMZIiVkZ+UFLX8ltiFpHXFkATjmwfzImsUNVGkNHSEc7ntSt9KQxwijLJp8GsFZ5KFAyNw/CVzbB4z1JnKo6VprQC6OL+qyGbJxQvHQ/bYQelH87CYMDAEDglt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TydIpMij; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TydIpMij"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hjubwyUGpvii4yHrQN7iWzf9058y+MhOuurWOoQQtoU=; b=TydIpMijDe4+FJpLkzynelnYRK
	VNJ9izAdgq8fYnktpyOTgB5E00ytSNQsFYRHl6ioo0y7Qq5hm6Bn5Hg+efQ1/kFjAbo0ZWgjaX84M
	rBbH7+2d61R/Y29S52qfADU1wPPtB49DsId57QDyAlYpWMFbnGD4eMKm5smUIKk8MtQuNLdA49L3D
	zqE3Iv60SGRCONJE31I1YpvUzgUZnJAHcDaUhrFmwwtvPsawIbBhbTrN4V5PCkPMATC9KK6vkIVTZ
	jpW06LeZImeIzGbDYH/hUJts4UPFAHj3qbFO8pqQJWz31/B9ktN7JQS8n5Ly0QMnTZFCH9sap5K8v
	odAAJHFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSH94-0000000EUWv-2M56;
	Wed, 27 May 2026 16:30:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6249E300673; Wed, 27 May 2026 18:30:14 +0200 (CEST)
Date: Wed, 27 May 2026 18:30:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] complete perf_allow_* trio and use in drm/xe
Message-ID: <20260527163014.GI3102624@noisy.programming.kicks-ass.net>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
 <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
 <8871a158-7a68-4247-a09f-bb3d970d6dc2@nvidia.com>
 <87ecixv82m.wl-ashutosh.dixit@intel.com>
 <ahcQ9Ns5mjsnrbEa@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahcQ9Ns5mjsnrbEa@intel.com>

On Wed, May 27, 2026 at 11:42:44AM -0400, Rodrigo Vivi wrote:
> On Tue, May 26, 2026 at 08:34:57PM -0700, Dixit, Ashutosh wrote:
> > On Sat, 23 May 2026 10:52:16 -0700, John Hubbard wrote:
> > >
> > > On 5/23/26 1:40 AM, Peter Zijlstra wrote:
> > > > On Fri, May 22, 2026 at 06:33:24PM -0700, John Hubbard wrote:
> > > ...
> > > >>    perf/core: out-of-line and export perf_allow_cpu/tracepoint()
> > > >>    drm/xe: gate observation streams with perf_allow_cpu()
> > > >>
> > > >>   drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
> > > >>   drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
> > > >>   drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
> > > >>   drivers/gpu/drm/xe/xe_observation.h |  3 +--
> > > >>   include/linux/perf_event.h          | 31 ++++++++++++++--------------
> > > >>   kernel/events/core.c                | 18 ++++++++++++++++
> > > >>   6 files changed, 79 insertions(+), 35 deletions(-)
> > > >
> > > > Sure, works for me. How do you want to route these things, Xe tree or
> > > > -tip?
> > >
> > > Hi Peter,
> > >
> > > Maybe -tip, but really, either way is perfectly OK with me.
> > 
> > I've R-b'd both the patches. If you want to merge via Xe tree, let me know
> > and we can get them merged.
> 
> To get them through drm-xe trees we need ack from performance events subsystem
> maintainers.
> 
> Peter, Ilgo, anyone, ack here?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
