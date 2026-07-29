Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1500468C06;
	Wed, 29 Jul 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353152; cv=none; b=l05psSxy3ItNTxvfvrHxe/Km7apUkFl27ZOsHRfk2wr3DmkAXA2VYcXU62H33GIW0BMAinkzUOcRhtV+yWH1TAT0PWkbuKx6uLL211ZYVBdAExybLCZwjEv7s8ynlQgRSwSpNyvT60ecnOJ00zWwmOQYMubNysILcsWH3HQreGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353152; c=relaxed/simple;
	bh=u2sU7+g2++/bp1aHNbYDMDe0dRren1MNlMLqkD+ot74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVe6MuQ9yNHtD3H7oLCILQXzOhYVDZso4Xj8QEFes5CKdG5y3hTVvkvn5IW/MimnJw/n+ob4f2ii7ae6BRB6SIG6XcWnK0Wf3mtnn4pe0VEQ26r6qFge64lM/FxSspeIWbvhjqWWkiG7jEMtP5jj87kOzdBUhMAOJiZ3dd4+gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqSOVLCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqSOVLCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B181F000E9;
	Wed, 29 Jul 2026 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353147;
	bh=FfP6XWvrCgro9QB2TBf6Ep4o2Rb3oAsMZ1Xxvy4f9RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VqSOVLCipMECvYXKqJGXZ2r/x0eBxtxQLwtpnlHSEAeeEDuxGLLKidDJVObfCito+
	 PUC+7EqnJ7tqPRheIjL7eGiE/vSvc/2zEwnzmqpq456j0/h5Pgol0ZkwWSKLmnUN1t
	 mjRW2DmxmFsiKaeoYzSoUJgM2GmyV9mX4OccdcYMeo7DfiGH0UI/UJLFoStbePAp4C
	 4JIgbRD2ZMfxU7rtqZt7ZZa3UhghoNLokEFr5amDY7G4ZdHmSQD3De0ITornUJqzGv
	 NXFazA/a632l+KH3Nl0z6pePI5VTslpFudpeDh61feRvH3iyXbeQXtBzPZnEHUy34G
	 qq0BIh4wEvW0Q==
Date: Wed, 29 Jul 2026 20:25:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
Message-ID: <20260729202543.697b52f3@jic23-huawei>
In-Reply-To: <20260729145555.3919550-6-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:51 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The PMU pins its overflow interrupt to info->on_cpu in the hotplug
> online/offline callbacks, but requests it with only IRQF_SHARED |
> IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
> smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
> then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
> hwc->prev_count and event->count concurrently with the managing CPU;
> local64_t is only atomic against same-CPU access, so counts get
> corrupted.
> 
> Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
> matching other uncore-style PMU drivers.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/perf/cxl_pmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index d1e810601e36..8b89db8f4d68 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (!irq_name)
>  		return -ENOMEM;
>  
> -	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
> +	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
> +			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,
>  			      irq_name, info);
>  	if (rc)
>  		return rc;

