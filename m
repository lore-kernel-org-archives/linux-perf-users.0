Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E23EC83E;
	Tue,  6 Oct 2026 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317240; cv=none; b=QBbbTZdxpDtsP/VfTyaZghyRUE8kdAG8wCvKZ8mjdDUvAmSeYGjcwUlKM+rOcVxlfzxRLF8IFUMgPwnaozSzpCR90glicQM5mnGHn9y9H6eDtm89Adi/TnHKnAMhbx/4oRs4ypw1V7iW9Vl6CyBG+BfVBQasFvk6lgOfCqTRC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317240; c=relaxed/simple;
	bh=k2fH18dzk0HQ+d3L4Bluh6+vHASAYpt70Yt0WBj7DuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtUQ6ETro5wyT32ni5BF2cMmFMVp5hu+la027zXZkL2TFIucwbib5sppjUWOWBd9slzjsNIzrEKi5o+F8qXXTB0YQULzJZBzPMPAbaqPdMQOIvtjcv5KYB0yVhH7c5XKwi7kXh77NblLQr347BNHmwJx6+WfrIpIzCUwz/ORWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5b1s1iz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5b1s1iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7951F0089B;
	Tue,  6 Oct 2026 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791317238;
	bh=7zoYG4QC6Zbhdm3n3G8wSp6IdB5d7B0X1RbtlEE4BbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A5b1s1izb0pvKzmqs3qFy4uZ2vsUMOcByefGxdGbHf+lhPQytXfxk8eAzIMmXyJFB
	 wYDrVFWPYuTUCTS7TL+SUNcWs4faQYC9cdnQ+iEzlTNSWvOKmMNizNY+b55pMzvXLe
	 FJzwIkm9Q575kegfdm347MwEcLE57UxcWCZfS2uOKwIKeDA8TR1lQENK01HKCaCb/u
	 6Ta2x4hzWPcd4T/dt3tetVxf9p93+i/JeVSjejYAQ3dxwRYDoqKsaZwYgPPe1PDX13
	 s805/3bqd5uoPIWmFN8JlaMltispKk7jabyyibdwVNOJbzLc5QCgy/QN6Ox5agnUd+
	 d9kXi+ic9jIfA==
Date: Tue, 6 Oct 2026 13:07:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf symbol: Shrink the demangled Rust buffer to fit
Message-ID: <asVU9e4eQ3OxJ2Qd@google.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-5-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928010227.1903673-5-michalpl2003@gmail.com>

On Mon, Sep 28, 2026 at 02:02:26AM +0100, Michal Pluta wrote:
> The buffer a demangled Rust name is returned in is sized to whatever
> attempt succeeded, which is usually larger than the string it holds.
> Shrink it to the string's exact length before returning it.

Oh, you already have the patch! :)

Thanks,
Namhyung

> 
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
> ---
>  tools/perf/util/symbol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 1a52bc2980a0..858a14a91f79 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2772,8 +2772,10 @@ char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
>  				break;
>  			demangled = tmp;
>  			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
> -							   /*alternate=*/true) == OverflowOk)
> -				return demangled;
> +							   /*alternate=*/true) == OverflowOk) {
> +				tmp = realloc(demangled, strlen(demangled) + 1);
> +				return tmp ?: demangled;
> +			}
>  		}
>  		/* Failure to grow output buffer or buffer exceeded sensible bounds. */
>  		free(demangled);
> -- 
> 2.43.0
> 
