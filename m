Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C43C2E7166
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648141; cv=none; b=d30OPoeEf9//F+CKVPTcXGDdOUCxW6pvpM2cXvb75jHdI1SuHA0NBnsfM2yUfnuV9YBz2+NCl4fOWU/70iuhECiPhoKHon67yDbPtJb9RszQJDdbqNQmrQ23RS2h5MCBNBCk/In5GTl5+pcahUFm/khsBXAghWqAvr1AFCfBqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648141; c=relaxed/simple;
	bh=PPM0NdmhavnZ5/16nWVThmZF6EjIOYJE3NbRDP/CX0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBuUdtOL26VHMV+SqBqOaV7D7XfPYnNUSeUcM7vd5Zva6hy59VPDM4CjSqE/FdIT9IKTy4UUH0KwIYw9ve5nz+Tx2dySTPDkgxSZYVhEvzwlgg8bo3Vb/jxds/9adAmnaogZmq70Dmr8P6j/ANGH0Vql3RkauW5YoP5t/c8F0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94C52339;
	Mon,  5 Jan 2026 13:22:09 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BDC3F694;
	Mon,  5 Jan 2026 13:22:15 -0800 (PST)
Date: Mon, 5 Jan 2026 21:22:13 +0000
From: Leo Yan <leo.yan@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <20260105212213.GA336318@e132581.arm.com>
References: <20260102214043.1410242-1-puranjay@kernel.org>
 <CANk7y0j7hAJ7OcH_HgN0cVGnUh=iBz=iuD9sYZmSy-koMjB_cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0j7hAJ7OcH_HgN0cVGnUh=iBz=iuD9sYZmSy-koMjB_cg@mail.gmail.com>

Hi,

On Fri, Jan 02, 2026 at 09:51:15PM +0000, Puranjay Mohan wrote:
> Hi Catalin, Will, Mark, and Rob.
> 
> I don't have access to BRBE enabled hardware and Qemu doesn't support
> this as well therefore I just sent the compile tested version.
> 
> Can you help me with testing this:
> 
> The relevant bpf self test is:
> 
> ./test_progs -t get_branch_snapshot
> #132     get_branch_snapshot:SKIP
> Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
> 
> skipped for my setup as it is not supported.

eBPF selftest build is quite heavy (many dependencies), finally I built
it cleanly.

I did a test on FVP RevC, the test hit NULL pointer deference and kernel
panic in armv8pmu_sched_task().  See https://termbin.com/peg4, the
backtrace should can give you hints for the issue.

Thanks,
Leo

P.s. some logs are duplicate, this might be caused by two cores both hit
the NULL pointer issue ?
