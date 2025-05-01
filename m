Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C46FB9;
	Thu,  1 May 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131130; cv=none; b=TEOMWqpsjrMeZiowg5e2Y0ilbTX2cD7iSpiacRbaoLEwNrfiBu2R0Ng3OtgTaY9pTmXpkFXZuo5kO0HGQxMJsUA5oD/WOXHCWTWg3z4xD2YNf93Ygj2nSiwqEhALZcCIDauVHzDh1wOAltWOEJMoVavwaJUdUyi3qi8tXdRuGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131130; c=relaxed/simple;
	bh=zTV8Qd3ZZkNI2Id5bjuty6/SAjsFzxHH0uQilyi7Hjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG2plbjmMucHiGMrxYDSZpXWsSdCpQh6Q+c/YFhO9yj0Pot5NPgqY6UnQFfSPHFJY2EWTawCqPf21BjFk1TAQ2jfWdVxUICAH1v20TFgceYoDsSgGGbOgGaZb81O7fu8K1FYyZKJ/BnBORBd+v4U1j20xOheuEvW1v5MyFlTPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+JSyxNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+JSyxNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094B7C4CEE3;
	Thu,  1 May 2025 20:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746131129;
	bh=zTV8Qd3ZZkNI2Id5bjuty6/SAjsFzxHH0uQilyi7Hjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+JSyxNCDKDUrtg4O5ORnZVVqR8Y5xoLaZ0RZnk9C4RZrxxAbnQ1rQ5fHAPlzWKUs
	 +EuCT2nELk7u0IIDOLAgMnLaYtDiw42Cqp+1GYVvEvS0d/aOg+m9CTp0OI8nP9t+bv
	 0QVnGmLY56np8Hpz2HAYQDJGH7e21zZK3C+pIYT0EOq+G+mM0igUCHjesZ54p1+6mc
	 CHKVwlsdlo8FyjOO/QW3MfvYybX+tJW0DOodAhQBhfvYfNZUdQqeljf9tdGBeF5Mbi
	 ItDANSRjlMiRPsKHe/s3jnRE3d0YvPfzftDzQXVXfCRybR+6oKUhcWQBII+OHf9LTk
	 IBgbDtc9MZbfw==
Date: Thu, 1 May 2025 13:25:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol-minimal: Fix double free in
 filename__read_build_id
Message-ID: <aBPYt1G3VpLI5qBa@google.com>
References: <20250501070003.22251-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501070003.22251-1-irogers@google.com>

Hi Ian,

On Thu, May 01, 2025 at 12:00:03AM -0700, Ian Rogers wrote:
> Running the "perf script task-analyzer tests" with address sanitizer
> showed a double free:
> ```
> FAIL: "test_csv_extended_times" Error message: "Failed to find required string:'Out-Out;'."
> =================================================================
> ==19190==ERROR: AddressSanitizer: attempting double-free on 0x50b000017b10 in thread T0:
>     #0 0x55da9601c78a in free (perf+0x26078a) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
>     #1 0x55da96640c63 in filename__read_build_id tools/perf/util/symbol-minimal.c:221:2
> 
> 0x50b000017b10 is located 0 bytes inside of 112-byte region [0x50b000017b10,0x50b000017b80)
> freed by thread T0 here:
>     #0 0x55da9601ce40 in realloc (perf+0x260e40) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
>     #1 0x55da96640ad6 in filename__read_build_id tools/perf/util/symbol-minimal.c:204:10
> 
> previously allocated by thread T0 here:
>     #0 0x55da9601ca23 in malloc (perf+0x260a23) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
>     #1 0x55da966407e7 in filename__read_build_id tools/perf/util/symbol-minimal.c:181:9
> 
> SUMMARY: AddressSanitizer: double-free (perf+0x26078a) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a) in free
> ==19190==ABORTING
> FAIL: "invocation of perf script report task-analyzer --csv-summary csvsummary --summary-extended command failed" Error message: ""
> FAIL: "test_csvsummary_extended" Error message: "Failed to find required string:'Out-Out;'."
> ---- end(-1) ----
> 132: perf script task-analyzer tests                                 : FAILED!
> ```
> 
> The buf_size if always set to phdr->p_filesz, but that may be 0
> causing a free and realloc to return NULL. This is treated in
> filename__read_build_id like a failure and the buffer is freed again.
> 
> To avoid this problem only grow buf, meaning the buf_size will never
> be 0. This also reduces the number of memory (re)allocations.

Thanks for fixing this!

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Fixes: b691f64360ec ("perf symbols: Implement poor man's ELF parser")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/symbol-minimal.c | 34 +++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index c6f369b5d893..d8da3da01fe6 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -147,18 +147,19 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  			if (phdr->p_type != PT_NOTE)
>  				continue;
>  
> -			buf_size = phdr->p_filesz;
>  			offset = phdr->p_offset;
> -			tmp = realloc(buf, buf_size);
> -			if (tmp == NULL)
> -				goto out_free;
> -
> -			buf = tmp;
> +			if (phdr->p_filesz > buf_size) {
> +				buf_size = phdr->p_filesz;
> +				tmp = realloc(buf, buf_size);
> +				if (tmp == NULL)
> +					goto out_free;
> +				buf = tmp;
> +			}
>  			fseek(fp, offset, SEEK_SET);
> -			if (fread(buf, buf_size, 1, fp) != 1)
> +			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
>  				goto out_free;
>  
> -			ret = read_build_id(buf, buf_size, bid, need_swap);
> +			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
>  			if (ret == 0) {
>  				ret = bid->size;
>  				break;
> @@ -199,18 +200,19 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  			if (phdr->p_type != PT_NOTE)
>  				continue;
>  
> -			buf_size = phdr->p_filesz;
>  			offset = phdr->p_offset;
> -			tmp = realloc(buf, buf_size);
> -			if (tmp == NULL)
> -				goto out_free;
> -
> -			buf = tmp;
> +			if (phdr->p_filesz > buf_size) {
> +				buf_size = phdr->p_filesz;
> +				tmp = realloc(buf, buf_size);
> +				if (tmp == NULL)
> +					goto out_free;
> +				buf = tmp;
> +			}
>  			fseek(fp, offset, SEEK_SET);
> -			if (fread(buf, buf_size, 1, fp) != 1)
> +			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
>  				goto out_free;
>  
> -			ret = read_build_id(buf, buf_size, bid, need_swap);
> +			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
>  			if (ret == 0) {
>  				ret = bid->size;
>  				break;
> -- 
> 2.49.0.967.g6a0df3ecc3-goog
> 
