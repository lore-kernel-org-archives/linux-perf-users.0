Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FB29B78F;
	Tue, 22 Sep 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039123; cv=none; b=jOzpHKzMI0ariYDrtLk0EcDIwcV9hEPjgZE8lWMhnuwpUb8lsQ+G15DkvgNm0We6PFauOtwuedtsCTkKBjnKYbEdhnSNfced+XX9DQQ595j5OC4K4jsNO5Cba19WjyHQfDryxZkfDif2VqLwBca1Cy+ZRAC+XViLomJFai6OGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039123; c=relaxed/simple;
	bh=W3+N2mC1ymm2sEXv9luGDZqAFCumjrkbXi1JyxM6Nog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldInor/V0lT9b7PB1hlSb0zy1UxVALW+ApMx2nk7tZ2bJpTTSTUMKVf+YXkAZOgp1R6zYEAMKYaqcS5JjxrgIftmVjOZWZqrdGuvXLlxOHXGxGizGKjlNSB/kjLVLA/xTZEJNH5TFD9OhZUFkPjn6r22JnYVtmuKF2kXQIxcjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/88jI4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/88jI4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE591F000FF;
	Tue, 22 Sep 2026 01:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790039121;
	bh=I+5Hh6p9Vqcz2obNB4QEqft81kjIcc5QgdXVfi0Vnn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m/88jI4OxogZK2Sw1ADp3pCe1asEikuGW3v+xF9la/xqSHe2NdjE2u7+hfK4xwlh8
	 Kory1lKg+Jlz3WMM4h2tRQd0fqDqboHEXRnmkFJYGwNMEDyJutT5zTdei++4Vat7JB
	 BRUM9JqtLwkEprTl0lJER6/TCtvys5C/IMQ0JJrnR83m3quoXw0NUwYRih07wO0Hd1
	 Z87KkAcwl7CkERGAQP/cB8LiWSyZPiTzx5MKBiFL/K4PzlWWZJS0dnJrVcoAPR8Bqy
	 ORH9JXpJz7l7ugrIDsMrfLCQ+sLQ1XCuVUCudBTMVyYd4HTfPBkoFCdZcc9aQMPwvr
	 qZhNxWCOLB3lQ==
Date: Tue, 22 Sep 2026 02:05:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com
Subject: Re: [RESEND PATCH v4 06/11] cxl/pci: Add the PMUs after configuring
 events
Message-ID: <20260922020517.46227d0a@jic23-hlaptop>
In-Reply-To: <20260805155911.1304807-7-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
	<20260805155911.1304807-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 08:59:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pci_probe() adds the CPMU instances before configuring the event
> interrupts. Both take an MSI/MSI-X vector the device names in its own
> capability registers, and the spec lets a device point several capabilities
> at one message number, so the two can collide.
> 
> They do not fail the same way. A failed devm_cxl_pmu_add() only breaks out
> of the loop, while a failed cxl_event_config() aborts probe and the memory
> device never appears. Going PMUs-first therefore lets a peripheral facility
> take the vector and deny it to one that matters.
> 
> Configure events first, so a collision costs the PMU rather than the
> memdev. Return 0 explicitly afterwards, since rc still holds any PMU error
> that cxl_event_config() used to overwrite on the way past.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - New patch, ahead of the PMU dropping IRQF_SHARED. Without this that
>   change can turn a shared vector into a probe failure for the whole
>   memdev rather than a missing PMU (sashiko-bot).
Make sense. Anyone crazy enough to share this interrupt gets to keep
the pieces.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
