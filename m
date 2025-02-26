Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74026A1A1;
	Wed, 26 Feb 2025 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607590; cv=none; b=Drs1ebXYPFeFhZd2041faMpv03bkcbaNVTg3hci8cAbpMtkzPr3ij8T7TVGcsOdazXKuAXB75bKtic6hGP/7BLozGgtU6KmnGWml5/y3pja9W+KEnwF5Owmb7YAsGapmKq8SbkvuP5rnAsfrq7X7I1IXYU1TpJKUxRjuTHZDVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607590; c=relaxed/simple;
	bh=woly9IepJ5w3hJtMtxDYgZ3OaHe4J2biEM9myQkczNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyqD1Hu3RuZv4Al1pNqLyptBYa2VeSR+fwDhphtT2TEA45JvpTRaXBmy4i5gilQp9i+SDq4QaUdZ9IgboVhqQn89jtW3CXQBXFCFydqKJm1Wa80jI0+tdaepEbmmMzkqna8C4liuWfhxPP1xxGUdzZsfK/sv+wERex3S2jDM8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb7uc1xz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb7uc1xz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882FC4CED6;
	Wed, 26 Feb 2025 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607590;
	bh=woly9IepJ5w3hJtMtxDYgZ3OaHe4J2biEM9myQkczNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pb7uc1xzS+gPQktzxx92L4tV1m4nMnwqQP7R6xYi/9Y1zxooh1fF3kdTaJmhT8Ojy
	 g9put0DNRS/WnLhHEgUOxAfYgvxFhH5IF22W6tXEoaVtXNMzk+F7hyCqnDTIxtN1/N
	 +WOqjCi+3mAcMRiieIGmsPuKS3ZwgUeltXeq4OHaCs0RspyZU/F8eBP+Ukvvf92MYd
	 3L8PpQNzytXHTTplHPUaG/XGhOVnKDb4TH7DqJQ/ig57ONvry2XDWhkNYFWANt0CfL
	 lsEKZPs2IYhSfUuc++HTudaMhlXJn8aOSqKyw0Mmeja1m24VBAz7HkJr5TPPzX7f8z
	 yxbtbgSi7ItLw==
Date: Wed, 26 Feb 2025 14:06:28 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support .gnu_debugdata for symbols in perf
Message-ID: <Z7-QZKNT4Cc8lspM@google.com>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>

On Thu, Feb 20, 2025 at 10:55:08AM -0800, Stephen Brennan wrote:
> Hello all,
> 
> This series adds the ability to read symbols from the ".gnu_debugdata" section,
> an LZMA-compressed embedded ELF file which is supposed to contain additional ELF
> symbols. This is something that Fedora implemented (as "MiniDebuginfo" [1]).
> There are more details in v1. I've tested it with binaries that have
> .gnu_debugdata, and I've also ensured that the build & runtime work when LZMA is
> disabled.
> 
> [1]: https://fedoraproject.org/wiki/Features/MiniDebugInfo
> 
> Changes since v1:
> * Reuses the existing LZMA decompression helpers, rather than implementing a
>   new LZMA decompression loop. This does involve creating a temporary file, but
>   I think that actually makes things cleaner, since now the symsrc has a file
>   descriptor to close, rather than adding a new pointer that needs freeing.
> * I did also remove the pr_debug() for the case where there is no
>   ".gnu_debugdata" section. That's not really an error worth logging, that's
>   just normal operation.
> * I added a pr_debug() for the case where we successfully load .gnu_debugdata
>   so that it's easier to determine whether it gets used in tests.

Thanks, it'd be nice if anyone with a Fedora box could test this.

Thanks,
Namhyung

> 
> v1: https://lore.kernel.org/linux-perf-users/20250213190542.3249050-1-stephen.s.brennan@oracle.com/
> 
> Stephen Brennan (3):
>   tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
>   tools: perf: add LZMA decompression from FILE
>   tools: perf: support .gnu_debugdata for symbols
> 
>  tools/perf/util/compress.h   |  20 +++++++
>  tools/perf/util/dso.c        |   2 +
>  tools/perf/util/dso.h        |   1 +
>  tools/perf/util/lzma.c       |  29 ++++++----
>  tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++-
>  tools/perf/util/symbol.c     |   2 +
>  6 files changed, 147 insertions(+), 13 deletions(-)
> 
> -- 
> 2.43.5
> 
