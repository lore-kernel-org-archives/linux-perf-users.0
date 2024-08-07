Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC1155A59;
	Wed,  7 Aug 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072880; cv=none; b=XwgM12DVK2nt7xPX6TE/H/BOkwCW1VSzoHCd8TPyXXaSLuAUzThawdqVBReY9MYRPc8zlp9mbgnmsdgNPcLQWf7SxPGOpl2eAYstGw3h4ByzyQraoJ9xdZmQqLaswRR2wlFj1qTiIss4IGFhYunzU2hCAySbBRSQfZcBPOAIKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072880; c=relaxed/simple;
	bh=+vDjH0P71IA02qOSeYSwgyQaKNjAymPtQXbVQQoitt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMJRy/7Uj/fIk3rxG9CQcdReD9W4JAVXhf/2v1lSW0O3+9QkxIZPF3+VRAsHiblovaLPp2JyKoRAMrRa/7LejZny2xltM0FLCBMrogFhk6UqfQSaF2dQRUbLzRNSEtebsdflZvun4PVtBNjiKshkTL5ZT16iMbbFANtCnlIGLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwDbrVKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwDbrVKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA309C32781;
	Wed,  7 Aug 2024 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723072879;
	bh=+vDjH0P71IA02qOSeYSwgyQaKNjAymPtQXbVQQoitt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwDbrVKoy9u1C7ur2Xpk4gF4sv6NA3mb870kT2qrlG+RTysUO1H+5D5QLSPaHIjmW
	 bnvIufd/FD1r+NrFgaILCkzUVOXgXUtc9Z24fGoMg1HjfE/ZDK8jVNutsQRI6iHIgA
	 MOEvCdilz+dc4EFjHaedAxNgzXZ+Zy48RRuUj49C6dKppg4z39FzaKAl9cfrhPL+sI
	 T9uolSi5Ym9sn4g9Fsh8JYkdcEpx41KlpNJSvaGvkj6Gffp9C0KnlVhYn2N5DnO/aA
	 MPmBgQU/152rQVBc28Xce5P3bdYkjjIiurcDlCNEGjm4ouU6lDHjIjwyXYzyouL+5n
	 /Eltn7jgb/lpQ==
Date: Wed, 7 Aug 2024 16:21:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] perf evsel: Set BPF output to system-wide
Message-ID: <ZrQBbMiIt1NCvxbY@google.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807153843.3231451-2-howardchu95@gmail.com>

On Wed, Aug 07, 2024 at 11:38:35PM +0800, Howard Chu wrote:
> pid = -1 for bpf-output event.
> 
> This makes perf record -p <PID> --off-cpu work. Otherwise bpf-output
> cannot be collected.

I don't understand why it's necessary.  Why isn't it collected?
Is it the kernel to reject the BPF output event to open?

Thanks,
Namhyung

> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bc603193c477..b961467133cf 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2282,6 +2282,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			test_attr__ready();
>  
> +			/* BPF output event can only be system-wide */
> +			if (evsel__is_bpf_output(evsel))
> +				pid = -1;
> +
>  			/* Debug message used by test scripts */
>  			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
>  				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
> -- 
> 2.45.2
> 
