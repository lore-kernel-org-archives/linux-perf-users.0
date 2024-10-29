Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342F205AB4;
	Tue, 29 Oct 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243389; cv=none; b=KPyp4KiMnJ8kAQ7VAq6mT29VKglaAg+GQXzSqnEzLgtH6BLHXOGODR2WHrrFRbdX8oIHicYlVpDb4cyoX+LgUGrSg7sYl21rR73GNqG1D4JHS4nqkZdB74UVV+llozMLP1KGJ6Bb4fV6OpGArIqGTtg4xDG1pDsbPSTzfa4CQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243389; c=relaxed/simple;
	bh=zye+wNRL8G23aZqii/unX0c97dPTkeNuEax9eXdHRRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3uDd+EpEzAfugq+rX8AMAZ+Mv8LbuQNODxrcybzqRYb7E0fkleRaZReXECluL7NeONcVTKwNqXJJ8g6szphi3n47IF8LrJK24inVNjYH2XG5xasuY/BvALOH0jzGf0NgqwL2OUjQ/8ByqWJECqWAeDKA+A5S9GqTyreXfd/K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0udmcPM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0udmcPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CEEC4CEE3;
	Tue, 29 Oct 2024 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243388;
	bh=zye+wNRL8G23aZqii/unX0c97dPTkeNuEax9eXdHRRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0udmcPM0lt/uRUN2hO5OXCF8Jqu411MxWWC3X7r1XUA6LfxlfzVFSzNvdZLV8N/1
	 wUhYdMJz9JIGQ1dqfBANpSp75LnewD2GmrWH4PKmj7d6HbP0G6dt9+s/z8viCGDTP+
	 6aYMleLjU51Oqx/rQRoaRpq8s77wCpxwOo38sPc1xQfvmCGbZV9R5Oc8EG8snOBJ2U
	 ZlTtbtUYql4DUl3XQq6SHH6MbBh0KSapV9uTSsR5e1JvW+1D5Pq2u3iFDuLGC4PBuv
	 HU1lSV0BEo5pDzA+sCV8w8HWTXZIg++UlbFhoz65QhRoSqy6DHRLDF8NRT2vFX8Ys0
	 qdMxwJ20oXUgg==
Date: Tue, 29 Oct 2024 16:09:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Graham Woodward <graham.woodward@arm.com>, acme@kernel.org,
	mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
	james.clark@linaro.org, mike.leach@linaro.org, leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Message-ID: <ZyFrOo7K1qmjtaV5@google.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
 <Zx--dTqaZPjeWA2I@google.com>
 <20241029170346.GB24446@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029170346.GB24446@e132581.arm.com>

Hi Leo,

On Tue, Oct 29, 2024 at 05:03:46PM +0000, Leo Yan wrote:
> Hi Namhyung,
> 
> On Mon, Oct 28, 2024 at 09:40:21AM -0700, Namhyung Kim wrote:
> > 
> > Hello,
> > 
> > On Fri, Oct 25, 2024 at 03:30:05PM +0100, Graham Woodward wrote:
> > > Currently the --itrace=b will only show branch-misses but this change
> > > allows perf to synthesize branches as well.
> > >
> > > The change also incorporates the ability to display the target
> > > addresses when specifying the addr field if the instruction is a branch.
> > >
> > > Graham Woodward (4):
> > >   perf arm-spe: Set sample.addr to target address for instruction sample
> > >   perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
> > >   perf arm-spe: Correctly set sample flags
> > >   perf arm-spe: Update --itrace help text
> > 
> > It doesn't apply to perf-tools-next cleanly.  Can you please rebase?
> 
> I confirmed this series can apply cleanly on the branch [1] with the
> latest commit 150dab31d560 ("perf disasm: Fix not cleaning up
> disasm_line in symbol__disassemble_raw()"):
> 
>   [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>       branch: perf-tools-next
> 
> If you are suggesting for the branch:
> 
>   [2] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
>       branch: perf-tools
> 
> You can see it misses some Arm SPE patches which have been picked up
> in the repo [1].
> 
> Please kindly suggest what is right thing to do.

Sorry, my bad.  It works ok.  I'll add it to tmp.perf-tools-next branch
and run some tests.

Thanks,
Namhyung

