Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30428E0F;
	Thu,  2 Oct 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428298; cv=none; b=hJdz3Xz67Cohz28Qjvor7ySc85dVp79f+tduhz2uQzAU0pbknSayst6urmVQUngSFWBj4FtB538RiO8m6IPvhvmBKd1xxksIRhWRsvdUZjhSNOnHTCi804S6NrbiyEzKra4sTwH+k9GM1SshsnzK1qWxGvyT8KGVz7SpXUrNFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428298; c=relaxed/simple;
	bh=+YpbQ5kLgsPWSLHiqjsCHFhCOGG5AXkBncjFEdSXwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpfkZBCyxpnjYtwRuTON0TjbVBIIjlbYP3xUsQDlkLYCjYJlcsc+h5aOYF+ghk7EBLaz+GBBFbYYPqAyoI9c7yKz0U/Q4OiHDIusyoftoEarx8XbQbSJkQSEnjhLCBKPBPDGFIUdHVZwSLP08acF385W46XPiCOL1j3XbETfhd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYBIu/8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYBIu/8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC6BC4CEF4;
	Thu,  2 Oct 2025 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759428298;
	bh=+YpbQ5kLgsPWSLHiqjsCHFhCOGG5AXkBncjFEdSXwvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYBIu/8BFfzEH+5VckSaOBDuhrC80cklLYfS7/fVNVzRou2sTvc/s2ZetL83eVESC
	 Jg+nfhmQF3oCGur84Ap0dmRnnxGxTx0yFYNTFqqc3mTUvHS/ZWb2UNxDH+gI1160tE
	 cmg48mGK29FjiHfwucLMAhjI8k6CsZkIx1PsaujldzOTV7qrKM3R7oewGJSkaLvgPu
	 WDv7MuRCzZPZykYVx/wpIK+TS/fZAlg8vj66FZGm7JA5Y0xDexjkFLMviJ4e7HMbWP
	 xnox5vlKOR8heTVCzUD1kJgSPqt2pxULym55O1iu+5vcRupMH5mh064qDm7JimLltO
	 IhmdZUZboHVFw==
Date: Thu, 2 Oct 2025 15:04:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] libperf mmap: In user mmap rdpmc avoid undefined
 behavior
Message-ID: <aN6-xfp4pcnxbnaq@x1>
References: <20250914182437.1959331-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182437.1959331-1-irogers@google.com>

On Sun, Sep 14, 2025 at 11:24:37AM -0700, Ian Rogers wrote:
> A shift left of a signed 64-bit s64 may overflow and result in
> undefined behavior caught by ubsan. Switch to a u64 instead.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index c1a51d925e0e..ec124eb0ec0a 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -508,7 +508,7 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
>  		idx = READ_ONCE(pc->index);
>  		cnt = READ_ONCE(pc->offset);
>  		if (pc->cap_user_rdpmc && idx) {
> -			s64 evcnt = read_perf_counter(idx - 1);
> +			u64 evcnt = read_perf_counter(idx - 1);
>  			u16 width = READ_ONCE(pc->pmc_width);
>  
>  			evcnt <<= 64 - width;
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
