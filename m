Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCE1C3F27;
	Wed, 11 Dec 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942910; cv=none; b=AqYTOQHWHstkYfo2oCxNve05EcW0Sx2e738zWHR2nTvNWd31u/PUmpPWmpxOogb2jPpFVMSpUxIbFHCilu2V4lC/pQm4Z+ehU/J7xzNqIO/he/IXCuTb2XKFos/WLzd4hfxHZBhAmNK8o6BfLfn6H057yYZ3Iih1yHTySvJa/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942910; c=relaxed/simple;
	bh=AY7y1pz3aYKq5RkIzqUfYOmw2nUVDajhefeF/OTXuhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C28yxd4v3tw4ypMLh2ITP3Qt/E7Rj4Le7TgDqpIry+jFy2uq7oSsyz1NGX7NHopjnlgjlYp5Mx7ex++od/+wILoKWU6h/96vw/IhNvZTLK7qjna8b68kbvVp5BbXt9ilogLVmr/s/V1ldM/E+8d4tL8KJN6VLYAev2jzvibtAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P70w6UIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P70w6UIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B7C4CED2;
	Wed, 11 Dec 2024 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733942909;
	bh=AY7y1pz3aYKq5RkIzqUfYOmw2nUVDajhefeF/OTXuhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P70w6UIK+2bmfq2QZjCfL1+L0CCdMlwIlFBSNusSwvYRdMMV1Utve7UjkBpGg4bjn
	 RhklwVNGVbcy52FZAFXxH5CgEJLKSFZ5hUhqG/nDHoH/hoqbGzSLiAHffhgaDZGrno
	 ty6tnX4YzNoN7NRFvgvlP1/RdM+C7kOyu2meEZ3RJT8bBFh8wMlRMrhKZQ7OpmezAX
	 PqArN9B9ynwK8x5vWZXSQ1zCs9xjBqmmBVC9ccp2v/3HPS8/3PR5qNd3ABkZRUGABV
	 EP58+MgNsUokdNt4I4srqCoFJmYC+YW92OTZSVaqvX2cllZBWCRDuRwZSwYaZ737K1
	 ZBRWYjfSXkt9w==
Date: Wed, 11 Dec 2024 10:48:27 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Atish Patra <atishp@atishpatra.org>,
	Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [REGRESSION] 'perf mem record' on a Intel hybrid system broken
Message-ID: <Z1nee9PakNKG_mL3@google.com>
References: <Z1CVTJ5jzIyNiB1R@x1>
 <Z1CsX3n5U_q5ehRp@google.com>
 <63eac289-07cb-4c3b-b34d-ea5bd009441a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63eac289-07cb-4c3b-b34d-ea5bd009441a@linux.intel.com>

On Wed, Dec 11, 2024 at 12:55:03PM -0500, Liang, Kan wrote:
> On 2024-12-04 2:24 p.m., Namhyung Kim wrote:
> > I think I got a related report from the kernel test robot but it was a
> > Sapphire Rapids machine.  I don't have a Intel hybrid machine in hand.
> > I'll try to take a look at it on Sapphire Rapids.
> 
> The default precise_ip level for perf mem is always 3.
> 
> For the latest intel platforms, it implies PDist, which is only
> available on GP 0.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c#n4412
> 
> However, the mem-load PEBS event is available on all GP counters but GP
> 0. :(
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/ds.c#n1176
> 
> So the precise_ip-- is required.
> 
> The failure of scheduling returns -EINVAL.
> 
> But Namhyung's patch assumes that the kernel return -EOPNOTSUPP when PMU
> doesn't support the given precise level.
> (Sorry, I didn't notice the case early.)
> 
> Is it possible to reduce the precise_ip for the -EINVAL as well?

Sure, please see https://lore.kernel.org/r/Z1DV0lN8qHSysX7f@google.com

Thanks,
Namhyung

