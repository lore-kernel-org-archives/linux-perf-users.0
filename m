Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08619DF95;
	Tue, 29 Oct 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221434; cv=none; b=SWqkew0J3J9bULgs3GmqDePdoBCRld+mlAC7pdHucaH8ODgke2nfO8t/04nhi8ocsuoXIU9RSVMfHExK//lQR6GCSiNXU4gCvOz0b/Rt/0ZUcwSLUWiVYuLBORAxqwU5PCjXe1JTcL/TgRoI+PjA/O3MD/xqyMZGBKODifaSnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221434; c=relaxed/simple;
	bh=YB9M7c3sxATgvrPkSYJC4f8JaUFO7qVF/Td0FejSKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEMfJC4P0IdU8fYF+4gWs1qkRsIOD67jXgXf3emG7h7kB4lNX2pUvviZ19x2FYRlhDV51JtBhNpJF1a1LaBxnkz8L9i7DPRMwSWgAaC5+1nv4CY8B95p7H1H3nrnda9529QTrcZcc/QN2cCD89feVN6LswSSHPBwSAmWkfIS3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CA4E113E;
	Tue, 29 Oct 2024 10:04:20 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 766D33F528;
	Tue, 29 Oct 2024 10:03:50 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:03:46 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Graham Woodward <graham.woodward@arm.com>, acme@kernel.org,
	mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
	james.clark@linaro.org, mike.leach@linaro.org, leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Message-ID: <20241029170346.GB24446@e132581.arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
 <Zx--dTqaZPjeWA2I@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx--dTqaZPjeWA2I@google.com>

Hi Namhyung,

On Mon, Oct 28, 2024 at 09:40:21AM -0700, Namhyung Kim wrote:
> 
> Hello,
> 
> On Fri, Oct 25, 2024 at 03:30:05PM +0100, Graham Woodward wrote:
> > Currently the --itrace=b will only show branch-misses but this change
> > allows perf to synthesize branches as well.
> >
> > The change also incorporates the ability to display the target
> > addresses when specifying the addr field if the instruction is a branch.
> >
> > Graham Woodward (4):
> >   perf arm-spe: Set sample.addr to target address for instruction sample
> >   perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
> >   perf arm-spe: Correctly set sample flags
> >   perf arm-spe: Update --itrace help text
> 
> It doesn't apply to perf-tools-next cleanly.  Can you please rebase?

I confirmed this series can apply cleanly on the branch [1] with the
latest commit 150dab31d560 ("perf disasm: Fix not cleaning up
disasm_line in symbol__disassemble_raw()"):

  [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
      branch: perf-tools-next

If you are suggesting for the branch:

  [2] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
      branch: perf-tools

You can see it misses some Arm SPE patches which have been picked up
in the repo [1].

Please kindly suggest what is right thing to do.

Thanks,
Leo
