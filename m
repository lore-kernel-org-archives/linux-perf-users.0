Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D528B517;
	Tue, 22 Sep 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038797; cv=none; b=Zhr172CA7UNyq0cma5YUTnNGaT0i6dLBzuXoYOin42SoiA/Ec7YPbjd2eWcmRthRR+L6SWFUsNoe1wjQjtd2YWtNPGLcjb99KxHGjzTUoCQm1rrVg8xpRsu/TdfeJH7lYA5QjYow5zG1ksInZ6u6qs/aJnRKBg1apVBKdO/yFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038797; c=relaxed/simple;
	bh=/J1TFSTFSItxV7mQtyKP6yCcvdXD9AwrVfy0z0mXJOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4bCV7Nv6opwUlnzXsCFI+YrSn2HtGDilH5LWs/3qwGdIB3K6rEWyYMEeUO9spyiWmOQsEccw8imG1B8WqFta1L3YKw5ADYG/y5aauvwgw/+jqKLv2zocE44mVx4/j0MsWzwkuG/l08yYVNu+wtIXM95cyJkTdBHusBGtBkwr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx7wkwON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx7wkwON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780F41F000FF;
	Tue, 22 Sep 2026 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038795;
	bh=AoEpRi5Jcji4x7YMi0Z1Xh5S9Jfi8DN1A1c0ItfjaiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bx7wkwONBIYXHTHlf6hzneNaPHHqg2gToiqrAtN/+5VPVY0D0ySA9M83ATXUnA53r
	 7VeGKVy8/LclFm7OQ/8+QgOjdRiNeqUo95vNeOYuZlu9QJYphjeYBkmVKLmQF1DuiH
	 wtNcz4fUpQuCo0c4Nh6Y+tN9DaC63E/kaeAKZ5e4lBk8iVxtzgqVx4Wifqqt4Gn73J
	 VUIaQZOUZbPxPXfV2zHu3d/Xvv0DPzYopVNS0W5imXyyypAoS9ahpz+fNc1+gVLTZv
	 aUvqwIzrpLIjtGGqUZL5uCZeR1wq9cXKRUylsA2dypa6XW4sVNXuoK3rYrdLd8rBgj
	 wHrCgmtPuTd5A==
Date: Tue, 22 Sep 2026 01:59:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com, sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 03/11] perf/cxl: Fix the counter overflow
 delta fixup
Message-ID: <20260922015953.24b0268c@jic23-hlaptop>
In-Reply-To: <20260805155911.1304807-4-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
	<20260805155911.1304807-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 08:59:03 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The counter is masked to counter_width, so the subtraction in
> __cxl_pmu_read() throws away the bit that records the wrap. A delta of one
> whole period reads back as 0, the same as no events at all, and only the
> overflow status tells the two apart - which is why __cxl_pmu_read() takes
> an overflow argument.
> 
> The fixup keys off the delta rather than the operands:
> 
> 	delta = (new_cnt - prev_cnt) & GENMASK_ULL(counter_width - 1, 0);
> 	if (overflow && delta < GENMASK_ULL(counter_width - 1, 0))
> 		delta += (1UL << counter_width);
> 
> so it cannot tell which of these it is looking at:
> 
>   event_start         polled read          wrap
>   ctr = 0 ..........  ctr = P/2 .........  mask -> 0 (+r)
>   prev = 0            prev = P/2                 IRQ reads new = r
> 
>   prev = 0    (no read yet):  new >= prev, fell short -> add period
>   prev = P/2  (polled):       new <  prev, spans wrap -> add nothing
> 
> Both rows are the same interrupt and the old guard adds a period in both,
> so a mid-period read makes the event over-count. 'perf stat -I' hits that.
> 
> Condition the fixup on new_cnt >= prev_cnt, the one case the subtraction
> cannot express. Dropping it outright would break the first row. It stays
> exact whatever the residual r is, which matters because some events
> increment by more than 1 per cycle (CXL r4.0 8.2.7.2.1, Threshold) and can
> step past 0 as they wrap.
> 
> Use mask + 1 for the period rather than a shift. It is 0 for a 64-bit
> counter, and avoids the old 1UL << counter_width - undefined for width 64,
> and for >= 32 on 32-bit kernels.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
