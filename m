Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791527;
	b=vad1/ADao2xMc1YbesJslZtCd4bbqtJWAYmRi0CRtcjZ9n1EQgafwfYktpJqGiuG2hMW
	 KSKBwHUB+panFy9zISO338mIa/pN0/xJ4d2zR2a81ZEcnYguUq/8Wa0eET3Q9VAAt6D2p
	 i59CM9j4bTp7sVUnGeGGfF7opVbzFzo/KaEad8fia/O/B8lUcnQKirkqztNLC+RAxj7cY
	 /XnJkpmOFFfv8SBPmA8zynD7G9UDdQBNx1F6FaK5HpE4wxNTg1+MIfiTLHfVRXlC4f0a0
	 nd2ilxASkSPOQJSF9L8/mM7I5e+fC4ONi0aAqs4rnF51PhrixALt6sCenPL/LoPGOwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791527;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=akrbTj34kp1qQLuIM9IA5lVStfc+bc9pL2azqD7+FzE=;
	b=WSTOPec6pG6pwcAvvw8x4/tZu5nN5j/AWn/bPyM/0Fc1Ark2yVxk1F98KGhkGWleh7Zw
	 +ireyBfZGjP5+oZwc+XyXN+5JBlInOcrb777LAdYyfTONMhjdsicUynOVbhS28QFw91/6
	 B8BirtEiNSyV2SbiWWbWEHNuMILQqNGsGlNRYtLaLHr9sZHk6lhL1iPnJ06XC1JasoFcv
	 qO/fAmRtuEuDLO7zxnJIdpxKlq84mZ2bMqqmS52FnseXqyLc4xzfXXdZJHIz2cTsI5Kn4
	 drua5AcZANTaYd8nuHyfXETQBJ1n5ciePcdiAUyPmBs3HEUPAfbUqh3RaNqpBeATdAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ILZyt2V5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE2606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 14:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ACE2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ILZyt2V5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5442A169E;
	Fri, 27 Nov 2026 06:58:37 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75843F86C;
	Fri, 27 Nov 2026 06:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795791520; bh=EOBJ+NhqSTFq21LooJrnzAHFZphR7yuwbCN7US4Z3+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILZyt2V5OyFl3FnKePvEwIfPJqp6jkDEZ2PJJo6mFNyRLjpf0+dFs9/yqKWcuREQA
	 qIQaeNVj1ppgqiofUCrDFF6H+P6WbX9UKG/TgvZOJPHMrjVtsy9C2r/NQFHrWoZmOt
	 rUTb+sIykZsVkKg/p+agGCAC82jCnIsXzbxYs0+4=
Date: Fri, 27 Nov 2026 14:58:33 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: maz@kernel.org, oupton@kernel.org, fuad.tabba@linux.dev,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, will@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com,
	james.clark@linaro.org
Subject: Re: [RFC PATCH v7 06/28] KVM: arm64: Add KVM_CAP_ARM_SPE capability
Message-ID: <awmamXEZHdLyWNNS@raptor>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-7-alexandru.elisei@arm.com>
 <atDtheEuNRs7v3Gx@gremlin>
 <avXcdwY89YPFGIlk@raptor>
 <avtHrG0NFuUPqIot@gremlin>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avtHrG0NFuUPqIot@gremlin>

Hi Lorenzo,

On Mon, Nov 16, 2026 at 06:29:51PM +0000, Lorenzo Stoakes (ARM) wrote:
[..]
> On Thu, Nov 12, 2026 at 03:34:15PM +0000, Alexandru Elisei wrote:
[..]
> > On Thu, Oct 15, 2026 at 05:51:03PM +0100, Lorenzo Stoakes (ARM) wrote:
[..]
> > > On Thu, Sep 03, 2026 at 05:06:01PM +0100, Alexandru Elisei wrote:
[..]
> > > > +
> > > > +static LIST_HEAD(spe_pmus);
> > > > +static DEFINE_MUTEX(spe_pmus_lock);
> > > > +
> > > > +struct spe_pmu_entry {
> > > > +	struct list_head link;
> > > > +	struct arm_spe_pmu *spe_pmu;
> > > > +};
> > >
> > > This seems like an odd way of making this into a list, can't you just embed
> > > list_head in arm_spe_pmu?
> > >
> > > Then adding becomes:
> > >
> > > list_add_tail(&spe_pmu->link, &spu_pmus);
> > >
> > > And removing:
> > >
> > > list_del(&spe_pmu->link);
> > >
> > > And you can avoid the alloc below too.
> >
> > This is the same pattern used for the PMU. Seems like a small thing, so I
> > think consistency is better? I don't expect more than three SPE instances
> > in a system (little + medium + big), so the extra 3 * 8 bytes should not be
> > an issue?
> >
> > On the other hand, it is indeed more common to embed list_head in struct
> > arm_spe_pmu. Up to you what you prefer.
> 
> I'd prefer the embedded, and I think we shouldn't be too intent on following
> PMU's patterns _entirely_, especially in a case like this which really
> significantly simplifies everything.

Ok.

Thanks,
Alex
