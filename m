Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68E2741B3;
	Thu,  2 Oct 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428132; cv=none; b=DXVVmYv6fxyevvTM44quRCLqDBva24sGHHHlHVAZdEml5rNxAiQ5tzlJvk5UeeVMsFaNiQjZhUHuI6gWXyqlGBParNn3AfHd7bS2/C3xdmYAg+uKuD0N8yWpouYUfO1LCUxeW39xFtc2fyxMJyPbVBOK/v9dTSJkGHEHpXMWonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428132; c=relaxed/simple;
	bh=CbY2NvA+Ap2HRr7OZFA29vi4VW/oJ93cwWfxn1XfYus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J59bLep/yOwlzUV17opmSbBdJZY3X75ylK4YEgtzod6fZxznDSh6bJPQhK6R7QYu7D7eY6OiK5qm9yn37yeQSoRWCDKLQ3NMRzArM/nqdIV16SJ5TP+6nYlKGJENHq08XlKE3n0Rl15N/Mi6OlPdJA7eNkZvcX4ay0OxdUgmPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6eKFwVq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6eKFwVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A71C4CEF4;
	Thu,  2 Oct 2025 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759428130;
	bh=CbY2NvA+Ap2HRr7OZFA29vi4VW/oJ93cwWfxn1XfYus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6eKFwVqrvVsGVhlwURDp5ZWiLODlKhamzFwLf9WK+4+lP+UKxQVnog+UbHyYx66p
	 q+3O0dvfjfTE9ra95S2A/9ze9xRqYWBajc856Mde8G1IOGGSlaIFAwMpGr5epcUkaM
	 2ZT4oLuxqx2GZpRcqYAJ9auDy49TQAMiO54egmoz8GMBgbhjUdRD3HVPKBYRhz42TD
	 lOpS/H9rUs3f7SS9YGlFotgydG/wUrm15SbKufIkPgw0jLfO5gaM0dHPedX6+qHlSE
	 odA+ZiP6dJ8XRJ1cUbo29slKDMHFNn6PFapjaEWAzmgSjEI2EN071gLa1qy4kRdHSd
	 q51PFoXDReneQ==
Date: Thu, 2 Oct 2025 15:02:05 -0300
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
Subject: Re: [PATCH v1] perf symbol-minimal: Be more defensive when reading
 build IDs
Message-ID: <aN6-HeKLpsBuseXS@x1>
References: <20250914183131.1962210-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914183131.1962210-1-irogers@google.com>

On Sun, Sep 14, 2025 at 11:31:31AM -0700, Ian Rogers wrote:
> The note_data at ptr is read as a nhdr but this may yield
> out-of-bounds reads if there isn't nhdrs worth of data. Be more
> defensive before doing the reads. This is motivated by address
> sanitizer capturing out of bounds reads running "perf top".

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/symbol-minimal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index 41e4ebe5eac5..aeb253248895 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -42,7 +42,7 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
>  	void *ptr;
>  
>  	ptr = note_data;
> -	while (ptr < (note_data + note_len)) {
> +	while ((ptr + sizeof(*nhdr)) < (note_data + note_len)) {
>  		const char *name;
>  		size_t namesz, descsz;
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
