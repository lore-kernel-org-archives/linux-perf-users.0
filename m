Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFE21CC71;
	Mon, 19 May 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698119; cv=none; b=puEHEE0LT8B78AHAcBf03+YYjDq6avze4gINuoGi8cikhs7AC6LAcNtL9YiH1SGqGcIUg/gatN9JX9iV2sbAqBx2KjO2fIlsbPvBHtBfwiBP3afncxuyvAA5sKxhpf9ROkAZV6mYd3jz1ZPBHwvMtS8oAHYjKEbAW/Fo9x03kLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698119; c=relaxed/simple;
	bh=V/li6Uijn/aiVmnRkCCoIqlA4NSJk5tcQV616cmmHeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh0m4FraxHt0Q1k5viZrPdY+dPjjds2oY7FVySXuEj1zZ1Ybywtoab6jjhJUGx+MnaePDajQnuOVIG0/VOsSSs953BZevbuNyYubksKRx4U/Av8PFLKkbhuIVtBayKLAgh/y+7Ip+qXXWrnfF7AIOwz4Gzg7Lo+svsukmJelZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAJTpX1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAJTpX1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA3CC4CEE4;
	Mon, 19 May 2025 23:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747698119;
	bh=V/li6Uijn/aiVmnRkCCoIqlA4NSJk5tcQV616cmmHeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAJTpX1wKEsvpw/8Ls8l/aYArDPxuMjvN5ihILqM1lE54TGhZ3PA89Y1QxJjsrFOW
	 2TXgh3R982NpEQ4Psphi3F2kgW4z/7flj2cLcb2AbjFVTQk65en65v0SMuFh6Xv235
	 reSS59VjwCvs4PgLm/3CRixTBFPPy4kZMcqGyWZRw/dxTxNL9D16WuaZ1Ec8/4JiGd
	 CGiHKYiT3GIi4oA2SjRr0DjgOpehYQeckq+dRImmNDlaw6xj9498w8LgmsN8AD6uO7
	 Ne1TWhs0BW/Vq5Cgx2l0JLQ+C0JmDriQe/h/Q8vnrkZm4Z4VGSIJXPNbfL/aASEePd
	 RQ5oLH7rd+mdw==
Date: Mon, 19 May 2025 16:41:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
Message-ID: <aCvBxEkb_1hgCA-V@google.com>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>

Hi Arnaldo,

On Mon, May 19, 2025 at 06:41:19PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Just FYI,
> 
> 	Updating some kernel headers with the kernel sources.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (7):
>   tools include UAPI: Sync linux/vhost.h with the kernel sources
>   tools arch x86: Sync the msr-index.h copy with the kernel sources
>   tools headers x86 cpufeatures: Sync with the kernel sources to pick
>     ZEN6 and Indirect Target Selection (ITS) bits
>   tools headers: Sync the linux/unaligned.h copy with the kernel sources
>   tools headers: Synchronize uapi/linux/bits.h with the kernel sources
>   tools headers compiler: Pick the const_true() define from the kernel
>     sources
>   tools headers: Synchronize linux/bits.h with the kernel sources

Thanks for doing this!  Do you want to add it to v6.15?  I feel like
it's slightly late for this cycle, but I can try if you want.

Thanks,
Namhyung

> 
>  tools/arch/x86/include/asm/cpufeatures.h      |  5 ++++-
>  tools/arch/x86/include/asm/msr-index.h        |  8 +++++++
>  tools/include/linux/bits.h                    |  5 ++---
>  tools/include/linux/compiler.h                | 22 +++++++++++++++++++
>  tools/include/uapi/linux/bits.h               |  8 ++-----
>  tools/include/vdso/unaligned.h                | 12 +++++-----
>  .../trace/beauty/include/uapi/linux/vhost.h   |  4 ++--
>  7 files changed, 46 insertions(+), 18 deletions(-)
> 
> -- 
> 2.49.0
> 
