Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7E344D9D;
	Mon, 13 Jul 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965654; cv=none; b=iV9Si4P0otg+f/GL1e9jghcm+Eh+z6pUCWYjMZlgf+PNzubFPcrpp086VBQpa8L9kW4jnmW/yOwkPlCxzeELr2ZYjwNYKquxdNNF7phN86sjTWq4oodEdkA9/hcYIceuhBlGpRqhFDOo5uXNmwoA27NCthZiF1cLoFBT5qb39Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965654; c=relaxed/simple;
	bh=Brk9LcOqSbf6D+xNLC4c1iqlWjEQgXfgC3tFzHrIq1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pepdeLyELcnCvnYTi8jucY0k9Yb1/HwO7mM86+Lhg4yDZB2El+/rfKETHV4LfM+NZZjjkoq8wnzyT16isZ1JTCn9VkH2ypwELhTW47XMiTl2gxElS25ayue+7/wCMkj4v/1JjHPhlA0p42xWiJWmFqXlHvGzCrVnAnP8BMqkRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh8dI4Zn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh8dI4Zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA5F1F000E9;
	Mon, 13 Jul 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965653;
	bh=0x+sBk0Vpxyvyry1ulK72Eg3AJJ717yIOOdbPcdnDQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qh8dI4ZnF2MKt39SoGIYZSeaCHAcr+AQKlSnAoIuXrQf/aW/8hPBTfAWnMtq05eRB
	 hxdjJm16DNK9IKTJNouxrspPxm1L+hneThmk2mluXxZyTiaeNf+lJjWfWUm9a96fFt
	 cZ5ec9DmLpemwMVT2TEqCiwihEDoVKIIosL/J47dzhrqB5Q00E/tvvbQ3dSOahE+3F
	 Nr0tpEThHCGXFjNJID6mPitoFZs7c36TcegeE4oHy1eXgg7jUxiresuqDAThJ3dh1f
	 Dz8RGgi7DYF0sWuGJMjMF46h0A3PLuTiIGeMv73/g74SJNAXi+JtJQytx4ZPYfXV7J
	 MEhtgLw/+SJ2w==
Date: Mon, 13 Jul 2026 11:00:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Viktor Malik <vmalik@redhat.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v4 0/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
Message-ID: <alUn0-W-2mIDs9GE@google.com>
References: <cover.1783406979.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1783406979.git.vmalik@redhat.com>

Hello,

On Tue, Jul 07, 2026 at 08:52:45AM +0200, Viktor Malik wrote:
> The loop for processing syscall args in augment_raw_syscalls has a
> history of breaking with Clang updates. In the past, we've seen it break
> (i.e. stop passing the BPF verifier) between Clang 15 and 16 and now a
> similar thing happened between Clang 21 and 22. While the issue is
> mitigated on the main line by a recent verifier update, it remains
> broken on the 6.12 and 6.18 stable branches, effectively breaking
> `perf trace`.
> 
> The reason is that the loop is quite complex and the BPF verifier often
> struggles to prove that it terminates.
> 
> This series fixes the issue by replacing the standard for loop by the
> bpf_for macro, which uses numeric BPF iterator. This should prevent
> future breakages of this kind since the verifier has much easier job
> proving that the loop terminates. Small adjustments were necessary for
> the loop to make it work, see the second commit message for details.
> 
> To keep perf compatible with older kernels, the first commit factors out
> the loop body into a function, which is then called either from bpf_for
> or from a standard for loop, depending on whether BPF numeric iterators
> are available.
> 
> Changes from v3:
> - v3: https://lore.kernel.org/bpf/cover.1783339165.git.vmalik@redhat.com/
> - Do not remove any hacks from the BPF program to keep it backwards
>   compatible with older kernels and Clang versions (Sashiko).
> 
> Changes from v2:
> - v2: https://lore.kernel.org/bpf/cover.1783070132.git.vmalik@redhat.com/T/
> - Small refactoring suggested by Namhhyung
> - Make `size` in augment_arg() an int (found by Sashiko)
> - Keep the original way of clamping aug_size to TRACE_AUG_MAX_BUF (found
>   by Sashiko)
> 
> Changes from v1:
> - v1: https://lore.kernel.org/bpf/akWqIfWPMCdaGgGg@google.com/T/
> - Use bpf_for instead of bpf_loop (suggested by Alexei and Andrii)
> - Keep the change backwards compatible with older kernels (required by
>   Namhyung)

Andrii, are you ok with this?

Thanks,
Namhyung

> 
> Viktor Malik (2):
>   perf trace: Factor out BPF loop body
>   perf trace: Refactor augmented_raw_syscalls using bpf_for
> 
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 155 +++++++++++-------
>  1 file changed, 98 insertions(+), 57 deletions(-)
> 
> -- 
> 2.54.0
> 
