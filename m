Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9711A3178;
	Mon, 26 Jan 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460713; cv=none; b=TGd/bLOvt3bekc8GqRF+bQ83U3WCB5l440Wu0tuuCalo9W0hvDilnlJO9as9ExDbpubzIYsMblTS9u3mkivM2BclztYLhyJ6o8u+8gVb+Rn2I5Fn+lbiTOunmHoWzBJVc2J/WN17sX3QwDSud7tXj7Z+DOZEr6RVt4t7UFXeuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460713; c=relaxed/simple;
	bh=SnYC2f71WWl1IKrC2Lf9SJ9abCCcOr3XyyHtI57n3N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSh1SNxpk382GQQzVXsYpEnyZq1ovep7v+/k5K82W7NpxV0uxya9iMgbOA3ktKua8FLAPKp3p4Q3YSd4idzeiAtOaMfeTAK1qzeopqd1nB1W2Ko7hILsDIrBFvBkv9oVkhPrZyGxoCvU67RPdQfrogMBh+/01uk3NwdhIbT3zgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMWrsm/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMWrsm/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364DEC116C6;
	Mon, 26 Jan 2026 20:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460712;
	bh=SnYC2f71WWl1IKrC2Lf9SJ9abCCcOr3XyyHtI57n3N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMWrsm/uPO/GZCkGEEVOXIjFPNLSFrHAvmhplkr61JEcJUKVajYa0nacX24WhqxvO
	 ScjUoVFZqdV7kMiGNi90sHZ13ZUl8BvdLPBdRy7TuQ14022UUkRE9euNmfyZQl5ETC
	 ZJc+c12DiOex0DQABRj6OxpTULutiAtsFaYOwT5CceLEDg/jffnUtkLCTCKEtBXDT7
	 c3xlX6LjTachdLOVN/Dxhcibd1yXh5h3Jz7NkrqcEnxH+8556hRv7XWBcrk38HEGHJ
	 UIsJfxBbFExThk6I3928HoiF0ZPdy1sQe+AaudJ/1CfaZRM59XBew0FT+imLwP48LH
	 yryX85dm8AVNw==
Date: Mon, 26 Jan 2026 17:51:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Guo Ren <guoren@kernel.org>,
	Tianyou Li <tianyou.li@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Sergei Trofimovich <slyich@gmail.com>,
	Shimin Guo <shimin.guo@skydio.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org
Subject: Re: [PATCH v1 0/4] perf e_flags support for CSKY
Message-ID: <aXfT5XlRkURVMwDB@x1>
References: <20260123222209.1181249-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123222209.1181249-1-irogers@google.com>

On Fri, Jan 23, 2026 at 02:22:05PM -0800, Ian Rogers wrote:
> The ELF machine type for CSKY is insufficent to describe the perf
> registers, the e_flags from the ELF header is also required. Expand
> the thread__e_machine and associated APIs to optionally fill in an
> e_flags output field. For uses in `perf trace` the e_flags doesn't
> matter and the e_flags needn't be computed. For `perf annotate` the
> e_flags are computed and passed around, however, this is optimized so
> the e_flags are only read for EM_CSKY. Call chain unwinding needs to
> know about perf registers during recording and in the unwinding logic,
> this is similarly wired up with the e_flags.
> 
> Ian Rogers (4):
>   perf dso: Factor out e_machine reading for use in thread
>   perf thread: Add optional e_flags output argument to thread__e_machine
>   perf perf_regs: Accurately compute register names for CSKY
>   perf unwind-libdw: Wire up e_flags for CSKY

Thanks, applied to perf-tools-next,

- Arnaldo
