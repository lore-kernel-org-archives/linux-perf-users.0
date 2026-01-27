Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE326A1B9;
	Tue, 27 Jan 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486956; cv=none; b=jVwtPfv1OfvNIpfWjCi7JIAGefQrVEXn/GRD7w1dkWVQWVPLrrb7Ki12aA4b1SPOxauqs29Hc8Ub7T7vKh/4n99UODkz9vjRWS0uDzr0C5POVSARXJVCWaKE8YkgG7j0LmRy8rvgyaxd0GIfHTcrzvAeV7xL9bQ/oiQkmGJGHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486956; c=relaxed/simple;
	bh=Ht9p1cSrU6hif6zNbuXM46ucmsMsv6CJ7srWlYHdlYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYCSmAF0Mo2TKSIsaXXXR600ZOH2jaIACIz7/ZYj1w0qnbSVEQ/y7yQ7Y4BGXOqTOfg4NPJDB/bML243VyhcNATrRmXaTjYNLqTL4yArG07jzXovFsttEQOs87EXijeq9U/vS+YpWgVy/q6ompspqbaMf7afC+wXQnLv50OvCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GumtWNqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GumtWNqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B32C116C6;
	Tue, 27 Jan 2026 04:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769486956;
	bh=Ht9p1cSrU6hif6zNbuXM46ucmsMsv6CJ7srWlYHdlYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GumtWNqejX8n8D7DEYqAdjjW8oWYAzPna+hYoZJ22H7t8NxV4DNdbKY17IVug1s63
	 k8Wgs0Zerz0m9PmucY8nN5lzPoB6oEIR9MGMw4lW+ykuaGwn5WMGtND9VL1CCNar/O
	 BxxliIl2ER3mksTntJeL/khrVxbeMlhR26abvDQKSH94H2m7hddZMxDua5vwYO3yu8
	 LyxnhQn5HHUB+xrhkIrkYQaQRWda1hmK+0UkozJJ3nFWW0lzbByS9NYsW6kvRGRc8D
	 qM5vC8tKsjo7Zd2tUsvfbZ3XWbz4fmKCaM84r2xZgRxEjCSyJfc1hRDH7kGaqEdeJd
	 yz2PAfXSycgsQ==
Date: Tue, 27 Jan 2026 01:09:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>, Andi Kleen <ak@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf more ELF machine usage
Message-ID: <aXg6aEpEl9F44vRS@x1>
References: <20260126220550.2573257-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126220550.2573257-1-irogers@google.com>

On Mon, Jan 26, 2026 at 02:05:47PM -0800, Ian Rogers wrote:
> Switch 3 more cases where the perf_env arch was being used to
> determine the architecture type and switch to using the ELF
> machine. This includes the addition of minimal instruction parsing in
> perf script for architectures other than x86, or x86 when
> cross-platform.
> 
> v2: Resolve conflicts with:
>     https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20260124001611.1332019-1-irogers@google.com/
> 
> Ian Rogers (3):
>   perf script: Fix script_fetch_insn for more than just x86
>   perf callchain: Switch callchain_param_setup from an arch to an
>     e_machine
>   perf thread-stack: Switch thread_stack__init to use e_machine

Thanks, applied to perf-tools-next,

- Arnaldo
