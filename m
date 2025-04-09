Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD912566CB;
	Wed,  9 Apr 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198805; cv=none; b=Zsts/Ti2ZvMH/RkRviYn3hHBBUwQMRmeS6Ila+4dzb8swbxf1Mt3b/xWkhnhpPNRv2joytUmIILwMJiJQR2uQh3hfTbHpYRKHiI8SBZtjyzFxBZh/CnEtY2gbGAL9tLy11OGLL4crUoSN9E+fs+1QlzuVZ6OBeWc1u0O8QvER9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198805; c=relaxed/simple;
	bh=DLBwwNWnA+fgJ6dwEkWaa43c/CIIIb95epf0rVpyE1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsIshFPboshawOxpih09d2ZVedJRUF/1MRpGs/zsgPrQ9bNN4ECclcWspCYPZgNN8xMgaq4Ti/lhiU7vq6HFWmQBM/hK9JVCKGElTKoy1R06KTqp4/hM82UeJXHknXqJebVTyhMqjAuywTzX8obvKfI0xNe7itfKpV/Ge6MagG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7Pybuc9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Pybuc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0025C4CEE3;
	Wed,  9 Apr 2025 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744198804;
	bh=DLBwwNWnA+fgJ6dwEkWaa43c/CIIIb95epf0rVpyE1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7Pybuc9nNJOmvYGtlFb+aAVj+YgJCFhfVZHHSlqC998vKiRcZPKIb+HM0Rch09jw
	 +qVUrbTkCzmnpv1B71Ue1/uT4u/UcxlUWtnRINGSk8vf5fzpzWndfuHmeEuXsKITLZ
	 J8bXKGgJT8gO60BR+UizPc9GM/xRa99aBZX2VXl+Hpj89W+ChnZZkOif5s70tuU1o3
	 RybfJeijLs5vbrBeRk3do0aUDpSaaKYQQVRyw9Tsf16FSjRWmPFk7dRCVOiz1WXWhl
	 zG1l68R8IeLd8j5voAJmdysMwcZZEpGia7W9U+Rk8z92c9PO+8QI/q2OkwbJGenWDa
	 HM/uWIW85/8Ag==
Date: Wed, 9 Apr 2025 13:39:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: mark.barnett@arm.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/5] perf: Record sample last_period before updating
Message-ID: <Z_ZcjvdC0W3Kq2kq@gmail.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <20250408171530.140858-2-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171530.140858-2-mark.barnett@arm.com>


* mark.barnett@arm.com <mark.barnett@arm.com> wrote:

> From: Mark Barnett <mark.barnett@arm.com>
> 
> This change alters the PowerPC and x86 driver implementations to record
> the last sample period before the event is updated for the next period.
> 
> A common pattern in PMU driver implementations is to have a
> "*_event_set_period" function which takes care of updating the various
> period-related fields in a perf_event structure. In most cases, the
> drivers choose to call this function after initializing a sample data
> structure with perf_sample_data_init. The x86 and PowerPC drivers
> deviate from this, choosing to update the period before initializing the
> sample data. When using an event with an alternate sample period, this
> causes an incorrect period to be written to the sample data that gets
> reported to userspace.
> 
> Link: https://lore.kernel.org/r/20240515193610.2350456-4-yabinc@google.com
> Signed-off-by: Mark Barnett <mark.barnett@arm.com>
> ---
>  arch/powerpc/perf/core-book3s.c  | 3 ++-
>  arch/powerpc/perf/core-fsl-emb.c | 3 ++-
>  arch/x86/events/core.c           | 4 +++-
>  arch/x86/events/intel/core.c     | 5 ++++-
>  arch/x86/events/intel/knc.c      | 4 +++-
>  5 files changed, 14 insertions(+), 5 deletions(-)

I've picked up this patch into tip:perf/core, because I think it makes 
sense standalone as well.

Thanks,

	Ingo
