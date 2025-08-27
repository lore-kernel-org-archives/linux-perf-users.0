Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D3343D62;
	Wed, 27 Aug 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291507; cv=none; b=ab1otppxeuqGIpI8XCovi0uo6W5cu8TpvDzSMfeNObVL2QHoSRBr2UFlwGhg8mYlVQy7XcGvd9Aw3ZJ2z9zuCTfZEzaf3FRmwXkXk9anENZ0vR5SiuqvAz25cDMGOkwRGX5gsy/es4TjuZbPMcQEUhsXOkXIzbLpm9VVNbGuKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291507; c=relaxed/simple;
	bh=mTHdHp88cfulmKlg6hi2N+BqqmTIwWb7wo7FeEhOdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G97fw2PDKwQ1HIUW/ddZdtSPbFG4TYn4xr0Vt/qozvq4xXkIUDkUiVOUAOxwCb8JKFavQDl0GqlwvGp3gDM4OgCgUSjvI/joJULJxvoVxeXmjWZZB+5iUXajcKrXzxQ5o58B9YCKzA58stPzLN8gHBkPXZ4hO9feIcmp6miM1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C571688;
	Wed, 27 Aug 2025 03:44:55 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7C5D3F738;
	Wed, 27 Aug 2025 03:44:59 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:44:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Chengdong =?utf-8?B?TGko5p2O5oiQ5qCLKQ==?= <chengdongli@optimatist.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Improve arguments checking of inherited
 per-task counters when sampling.
Message-ID: <aK7hpARhr5RxVveA@J2N7QTR9R3>
References: <20250814110625.84622-1-chengdongli@optimatist.com>
 <aKRRSsEJxb1LZDV1@J2N7QTR9R3>
 <D1D50EA0-EFC3-4FAB-A898-A61BD081B527@optimatist.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1D50EA0-EFC3-4FAB-A898-A61BD081B527@optimatist.com>

On Tue, Aug 19, 2025 at 09:31:46PM +0800, Chengdong Li(李成栋) wrote:
> Hi Mark,
> 
> On 2025/8/19, 18:26, "Mark Rutland" <mark.rutland@arm.com <mailto:mark.rutland@arm.com>> wrote:
> 
> 
> >On Thu, Aug 14, 2025 at 07:06:25PM +0800, Chengdong Li wrote:
> >> It's not allowed to mmap() of inherited per-task counters with CPU ==
> >> -1, this would create a performance issue. But it is not friendly to
> >> developers as current implementation postponed the arguments checking to
> >> perf_mmap(), developer can get an -EINVAL from mmap() but without
> >> any previous error returned from perf_event_open().
> >>
> >> This patch improves it by moving the arguments checking from perf_mmap()
> >> to perf_event_open().
> >
> >Why is that an improvement?
> >
> >IIUC before this patch, it would be possible to read() the event,
> >whereas now the event cannot be opened at all.
> 
> That's true, could you provide a use case that using sampling mode but without
> ring buffer? From my best knowledge, I think counting mode is more suitable
> for read() only.

I could be mistaken, but IIRC the RR folk were using sampling mode to
get notifications upon each sample/overflow, but they don't really care
about the sample itself. They might not care about inherited counters
for that workload, but I'm fairly sure that sampling without mmap is a
real (albeit unusual) use-case.

> >AFAICT this is removing functionality people could legitimately use, so
> >this doesn't seem like an improvement.
> 
> The problem is that using inherit per-task counter with sampling mode would lead
> developer hard to debug why mmap() returns -EINVAL. There is not error returned from
> perf_event_open(), everything done seems right but failed at mmap(), and there is
> no clue in man open_event_open() as well.

Ok, but presumably they do that mmap() shortly after doing the relavant
perf_event_open() calls?

When do people hit this in practice? Do they actually see this when
deploying a workload, or just when developing code that uses sampling?

Mark.
