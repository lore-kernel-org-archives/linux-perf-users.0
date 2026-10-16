Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C24447A0B5;
	Fri, 16 Oct 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145145; cv=none; b=QZIpGRck18rQ1EpokHQIySi079KMQBnBFDVK/nzmLJczzKxnfiNYZ8Kz3rJUEJGxuSppKEgc1Z4ctvOBNpVa/LMZDQCSQGNTR84gv/qmA1zgKi/OUt74KOzeNLGpSiMncjdy6eaAyl0u6/tl19LKiB9Clq2Re/mh/P0rbDOXBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145145; c=relaxed/simple;
	bh=Lr4z80TttA9CAj46C7TTaxQIkqHJjPbuCEYVhj/R2RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeyM1TtjqwqXIVeX/199wlPa826BqW+T2jeBsQfMEGGscfjgOPyjf/j+fhzwwLdDjy8Uv7TjSpYjB6/Z+m/12ZuPFOMp62AbvebHuGbuQNpB2m3Iub5uB1c1XbvSbkRNaM0xQTAOiZkKQcBsAS0mXpETZI1z91wGYhY87vjRh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lIBC6cNj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lIBC6cNj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A56614BF;
	Fri, 16 Oct 2026 03:05:39 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E7D3F871;
	Fri, 16 Oct 2026 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792145142; bh=Lr4z80TttA9CAj46C7TTaxQIkqHJjPbuCEYVhj/R2RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIBC6cNjFrf2xJ3onlfJxxXZJso7mCRvMSP5GGPQHeVUbtaYLIBKPoOsOZ8fQMWCt
	 WPNzABduNKk3UA8BO3A7cMpnYyKSwCRjqtydQrHkcSWAKt6kvQiz5SW0mVLA19OFfw
	 YoJHrsnBJWxKR2yAZQrq5H9sOkVv7nE904yPJ4ls=
Date: Fri, 16 Oct 2026 11:05:38 +0100
From: Leo Yan <leo.yan@arm.com>
To: Johnny Fan <johnny.fan@cixtech.com>
Cc: Marc Zyngier <maz@kernel.org>, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	james.clark@linaro.org, jeremy.linton@arm.com,
	cix-kernel-upstream@cixtech.com, bob.zhang@cixtech.com,
	jie.fu@cixtech.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
Message-ID: <20261016100538.GE26205@e132581.arm.com>
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org>
 <20261015141926.GC26205@e132581.arm.com>
 <atGY5+kzQggCZboX@JohnnyFan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atGY5+kzQggCZboX@JohnnyFan>

On Fri, Oct 16, 2026 at 11:24:23AM +0800, Johnny Fan wrote:
> On Thu, Oct 15, 2026 at 03:19:26PM +0100, Leo Yan wrote:
> > The SPE driver probes its capabilities on one CPU selected by
> > smp_call_function_any(), then performs local setup on every CPU in
> > supported_cpus. It therefore relies on that mask being accurate;
> > including a CPU without SPE could lead to accesses to unimplemented
> > SPE system registers.
> 
> Right. On ACPI the driver gets no affinity information for this
> device, so supported_cpus falls back to cpu_possible_mask. That only
> works today because registration is limited to homogeneous systems.
> The PMSVer trimming in this patch works around the heterogeneous case;
> with the mask taken from the MADT walk, both go away.

SPE driver supports heterogeneous systems. If firmware creates proper
devices based on CPU topology, the driver can probe multiple instances.

So "registration is limited to homogeneous systems" is not quite right.

Thanks,
Leo
