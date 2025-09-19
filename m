Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CD1917ED;
	Fri, 19 Sep 2025 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319114; cv=none; b=h7aJp5nPKvZqP2PQGGCeD0UolB3nffE86fyBFns/NSRzMBNSG8LDpCc6zUbgk9C9cL/NFlLFru2ODEzs68tYZAhUVnTDLHvbk1te/8IL0W1SZzt3Kdfq8YCUBUcz7bGIb7PmN8aRxfuGAL4UK/tkvNcs12xHFs6kciPKO4yrpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319114; c=relaxed/simple;
	bh=kMHMsiMXLMMWxx/BEuQU92+HF+K01AYCrNy5hdotJkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvoSe9lsFdKHxpNBBxjY1OVTimWxCIJ9GGoxnDYv92/D4JwgMRYc4ZPEwFm9sg6ueOBvKQNrXQlOhDjef1AIpD11VHuIhbpO6+UJxC4UXE4DgXr5uBi0t5YBWdUbLogLpLKw/NPUECMER7wrMCK7kIAAm6aBfDgTFOajzDVBQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhMDJZVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhMDJZVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1610C4CEF0;
	Fri, 19 Sep 2025 21:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758319114;
	bh=kMHMsiMXLMMWxx/BEuQU92+HF+K01AYCrNy5hdotJkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhMDJZVBK+YCaygv51ajgYrv9eYv62ZJqLLtrT17MYZUh3z5pMS+AOmRf4h2hM0V0
	 q0PNCo07bNU5lZ0MbX5Gi8Azzk5J4g6FmvMqDSuZN+2jioZ/5AzJQQUCUzKx5EfhKf
	 fyPwBiou3E0oaJYuMQThoA12oEViQftM5O853dmU5xtVjUgog9yC/t0ZudECW4C0A3
	 WAXsmRXBHwoWDOLp/SpoqYo8RyTlhHnVNvsOYCjy30lDTuVNOg2FoxbSAJh4Y4MWom
	 AkU4ZwFskLLNghr4Q+WxH6ZtrtNfPQ63ZljhrjFKnM4Kcd5iU2HRFEQmdnlCRfj2Gy
	 tHaCZ/weqAauA==
Date: Fri, 19 Sep 2025 14:58:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
Message-ID: <aM3SCGOXZsP3GZal@google.com>
References: <20250919210654.317656-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919210654.317656-1-acme@kernel.org>

On Fri, Sep 19, 2025 at 06:06:52PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please take a look, noticed after processing a patch from Ian
> for another such issue, on a hurry now, haven't checked when that
> emit_string was introduced.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (2):
>   perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
>   perf bpf: Check libbpf version to use
>     btf_dump_type_data_opts.emit_strings

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/util/bpf-event.c  | 2 ++
>  tools/perf/util/bpf-filter.c | 5 +----
>  tools/perf/util/bpf-utils.h  | 5 +++++
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 2.51.0
> 
