Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01561FC8;
	Thu, 10 Apr 2025 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264939; cv=none; b=dy3oF9JqN/+uLZwgMFOAHYthHzE9CQVHRlMxRgKpnqEPv97KKKYpK0iE7xqihrkpMtORvkLYDJCW4Z3Hsd6g8nCrUJNcoNjjZ7wGEdbmE+CKa3+fxml+ytVFlZHqye87jMfUHBeNRnmQ58oVoeDCLQ1ijj4CN22PHEXeedKiTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264939; c=relaxed/simple;
	bh=t9di0V6D2S+IdfEuP8c/3t/6z4st0pG17VyaUmdh8Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLEsQ9yflRUgEh1fS50j05raf9j2bCEuTsqF8jOJ9jtB5CsgW2gwboRQxhH+NG/J5LioM9WSFyyGHHqxgzkSv9O8ZzsZy1V46EbM0HtV0Peo8tJGAs3Wb8zB9h+Q2SfoI351Hfom+I2eYS+sZJqn5jBQSDc/JYhl+HHvryP/UHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urCxpGWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urCxpGWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D6AC4CEDD;
	Thu, 10 Apr 2025 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744264938;
	bh=t9di0V6D2S+IdfEuP8c/3t/6z4st0pG17VyaUmdh8Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urCxpGWjpCxeqmYDCEWtpMmC2K6N9POYKxeg2sI3xhCAa0XOzUtAQDDPFE0RHXFn6
	 zbS15v4F1STd5xuz6bnWxHmOmyoprTHSUoD3glFN6sYZi7QgbG0L9V/+GVt8p9TJ4Q
	 9lYXA7zfIRqCqCeHoOYB1nemMNAtcI6lJKNq0I+BGQxhIF6C8d+exhuutPMfk/XOHe
	 LIuFv+7CHguz4+6idz5/w1ZXdHhgLy6DYHDy7pxidsTn/5oXmV0Y+nKIQeA6qZd9bW
	 E4EzoOIXpytQMFq619L7ZLbcZt1b1eZPyb79LLlw85ZFG4SWWJBGeiPgFbUpk9fkru
	 XxifF8wZNsPwA==
Date: Thu, 10 Apr 2025 08:02:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 00/10] tools headers: Sync header files with the kernel
Message-ID: <Z_de5SDhwfP_uqjS@gmail.com>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>


* Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
> 
> FYI I'm carrying these changes in the perf tools tree so make perf trace
> beautifiers get the recent changes in syscall, ioctl, and so on.  For the
> background, please see tools/include/uapi/README.
> 
> Still there are some remaining items but it requires a bit more changes.
> So I'd like to leave them for the next cycle.
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>     diff -u tools/include/linux/bits.h include/linux/bits.h
>     diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (10):
>   tools headers: Update the KVM headers with the kernel sources
>   tools headers: Update the socket headers with the kernel sources
>   tools headers: Update the uapi/linux/perf_event.h copy with the kernel sources
>   tools headers: Update the VFS headers with the kernel sources
>   tools headers: Update the syscall table with the kernel sources
>   tools headers: Update the uapi/linux/prctl.h copy with the kernel sources
>   tools headers: Update the uapi/asm-generic/mman-common.h copy with the kernel sources
>   tools headers: Update the linux/unaligned.h copy with the kernel sources
>   tools headers: Update the x86 headers with the kernel sources
>   tools headers: Update the arch/x86/lib/memset_64.S copy with the kernel sources

>  32 files changed, 318 insertions(+), 109 deletions(-)

LGTM, I was eying those warnings too, glad you did this. :-)

Acked-by: Ingo Molnar <mingo@kernel.org>

	Ingo
