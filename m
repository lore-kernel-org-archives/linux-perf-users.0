Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9711A3166;
	Tue, 22 Sep 2026 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039404; cv=none; b=De6aPTsRGTIcjBkqIx6MMr672WGNdk0r5MVScf3owd3HNlJmoZ0mJkVPqKf5ZQJ0ePCEwfXfCqbcg1DPZtoeU1cslEew1rJu8Hl3OlEnM76gjj3NTIqNh+mQc4ZguOukRn9FFiEjkLsabXt9GpjsImYBLziTnNtiNCe3jo1IDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039404; c=relaxed/simple;
	bh=+RO/v0vYUHtVRDDOmUrYP4fIH3drLdyrh0B7KIRGE08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2cOieCTvVJXyvhX9qXgpmLVCSx6DBOk8v3U7XPJIw0ZPzDc081lumcGADQh1qX+Eo83KPZrYGQVePRkD4hSDm34zbRodLql5S+/cqKij5eEYe4BTb4Lk0mpI1zzJVxx4J26EGloFFg1Wa74pdM0+Jc9Wtp9xq05iK5AjJTA3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl+WGi1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl+WGi1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133FF1F000FF;
	Tue, 22 Sep 2026 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790039402;
	bh=7taw5NMh1Go/co+50I7v9zZYBrGlxQkqGwSLaB4vg9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gl+WGi1WdOxHEnsrPQ6k++7rVbLBYPqDHjjMKgLPoe+66LhgAO+MEO2SlcOMYFf/K
	 wEUqqbg+c6V/hUu892b4ujA2YB2pFaT3IasmWv65XcOYJvvCWmv3OWaiWLQeuvTtlu
	 Y1GV6TJHRqhnopUPS3XJs5VoAl7gqBTniOK1PMBaXlVYVQ7osX7UFRL8tx2W2lek9F
	 j6Y7pXt9MGx1185q0zff69qspva3GGFq69+AXb9biu2fNoIPWRtH770hXN53UvPf/x
	 JPGi2YqdO9Xu/f9pnwPYEWcx3H0bwSzssB4+UV3yeHIXNm+hO2/aNQw3ig9vC/mceg
	 GgX0OvxjJYiFQ==
Date: Tue, 22 Sep 2026 02:09:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com
Subject: Re: [RESEND PATCH v4 11/11] perf/cxl: Clear stale overflow status
 before using a counter
Message-ID: <20260922020957.66c4e9be@jic23-hlaptop>
In-Reply-To: <20260805155911.1304807-12-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
	<20260805155911.1304807-12-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 08:59:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pmu_event_stop() leaves the counter's bit set in the overflow status
> register and only cxl_pmu_irq() ever clears it, so a counter handed from
> one event to the next starts with the previous owner's overflow pending.
> The perf core stops and starts back to back with interrupts off, so an
> interrupt latched over the handover lands on the new event. prev_count is 0
> by then, so the read path adds a full period: 2^counter_width phantom
> counts.
> 
> Clear the bit in cxl_pmu_event_start(), before the config write arms
> Interrupt on Overflow. Clear the whole register at probe too, for counters
> no event ever owns - the driver never touched it, so firmware or a previous
> kernel can leave a bit set there.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: Richard Cheng <icheng@nvidia.com>
> Closes: https://lore.kernel.org/linux-cxl/anAVpO--i5heVfz9@MWDK4CY14F/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good to me as does the whole series. Thanks for hard work cleaning
up my mess!  Now there is actual hardware out there, I'm kind of expecting
a lot of extensions to the features of this driver as we deliberately
kept it minimal until more was known about what people were actually
building.  I wonder if the limited support did guide folk away from the
sillier things the spec allowed.  Will be fun to see.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
