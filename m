Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791889;
	b=0P8StGULm6Odwbxl2Q4h7vRUBwLCquM7/fbtHFfmQZ9tX7zvIoExUbT19nxjBM9A5aXq
	 Oda3lPJ/beFVqA84wUDGbjRSYeE0mX7++y7HnEBRfg/fe8zM9uWndxhAh12l7lwF1GDRc
	 /a8wxBWGKS5JmWVmbQLQEGkq58LcJLwYxQMG5NBeHJ2ltibbTmGveaGEnI+k5Zhgr3G3F
	 kDOBTTyEtZmkv+lXpEzVVMELRwWNp2szT5U6KnxcwZ7fI+DyNSQM/hJ1ng/xJskeTaEa+
	 u4Cg5Vxlgoe4W0IY5enNSf8Uq4zYNIK9izSe4qtYTegG6N/d9SaaX6GLTuZVjO1eXXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791889;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zJMYmG+hFRAiAQXsXLcPjjAA+AdGp4gOt8/ZQXWz6Iw=;
	b=Oi+nD0fOJsfry76m58KJOFRcouaFicoaObZGCYIrQ43Bo86OGGKkqfCOBXM/vOim6bvv
	 b9rMi3Qe+eTY37nTZ2pWsuRI+Vi/9/Bl7uKu8DkNlfxL3tBmBtdtg8Bijj00xoZnrCSSW
	 qzlYJyaYts/ECJ0q6v+KCcxLm2sy96+bkCCp90r8MjIrPZ5Osd8Jxj6cxKF/FBgyXgNBQ
	 WsCDPbqGGBAhgfy5U2hVOD2IGLorDlHrY2NJRWFXXbQ9DlEoaTQq32usmMBoVS8Qnv2ip
	 NMWxCBdGifq97EGNQ7PB51ZY9lZmSP2YA0HhI9s80JrzREXe29eY/MzPt0ffOVvTEJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Q4hiAaGA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09311606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 15:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09311606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Q4hiAaGA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709E3169E;
	Fri, 27 Nov 2026 07:04:45 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 454E23F632;
	Fri, 27 Nov 2026 07:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795791888; bh=Kf2u3+pp6YKT0cNUHCqSJb7trEljWxemN2FamiU/bxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4hiAaGAw0EWPBEIOOeQkDgfHDkovS4x7Dg78UF0E/14h8/L2HyTx/tE5cNqhWF+W
	 GSweeM6g3cvkUwPn1fDT2yNteGV/MJvxBjVEGkIqM2wWwWH+RUM/tYSO9wSfdy35Cj
	 YYuc9m2+vc/SV0SLahDEc27J69+uBMD8Rfmbb5Mk=
Date: Fri, 27 Nov 2026 15:04:42 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: maz@kernel.org, oupton@kernel.org, fuad.tabba@linux.dev,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, will@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com,
	james.clark@linaro.org
Subject: Re: [RFC PATCH v7 08/28] HACK! KVM: arm64: Disable SPE
 virtualization if protected KVM is enabled
Message-ID: <awmcCq3p0gOX1n_5@raptor>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-9-alexandru.elisei@arm.com>
 <atIzmvlo78PDwAXI@gremlin>
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
In-Reply-To: <atIzmvlo78PDwAXI@gremlin>

Hi Lorenzo,

On Fri, Oct 16, 2026 at 03:30:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Sep 03, 2026 at 05:06:03PM +0100, Alexandru Elisei wrote:
> > For RFC only.
> >
> 
> I realise this isn't intended for the final series :) but be good to put
> something here briefly for reviewers to explain why this is here, e.g. pKVM
> needs special attention etc. Similar comment for 9, 10 if there's an RFC
> respin.
> 
> So for this and patches 9, 10 in general it seems you disable the feature
> for:
> 
> - pKVM (at global level)
> - non-VHE
> - nested virt
> 
> Are these temporary for proof-of-concept reasons or do you plan to make
> them permanent limitations for the initial implementation of SPE?

This was intended to be temporary ('For RFC only'), until we can get to a
consensus that using guest_memfd to keep memory mapped at stage 2 for SPE is
viable.

As per the ongoing conversation on the cover letter [0], it is possible
that these limitations (VHE-only, no pKVM, no NV) might end up as part of
the initial implementation.

[0] https://lore.kernel.org/kvmarm/auy-TwnMbIn-r2xl@gremlin/

> 
> If the former it'd be good to know what your plans are to provide support
> for these, if the latter it seems sensible to put these all in one patch
> that describes why you are limiting each.

The reason for each limitation:

- VHE-only: to save me the effort to implement the context switching code, which
  is a pain to get right. Arguably this is the easiest to implement out of the
  three though.

- no pKVM: last I checked, the __host__ SPE driver is broken under pKVM, didn't
  even bother figuring out if it can be made to work for a guest.

- no NV: too much complexity around reinjecting an SPE fault back into the L1
  hypervisor for an RFC. I'm also not sure if KVM can configure VNCR_EL1 to
  transform accesses to the profiling buffer system registers to memory accesses
  instead of traps, and how that interacts with the errata workarounds, and with
  dirty page logging.

Thanks,
Alex
