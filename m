Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15B79FD;
	Thu, 19 Dec 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734570502; cv=none; b=mEaNUZmHGrij9uq3iLfYwV7WbDrLVfH0Ji7LZVnPgXTXVgIRsXKuXb2TUlm4qjYZg8s1N1hkNNPybkrVZTsZzEWsm4byaNXgLTZMLfPJCmD8M8hdC1RVduJo8scIGahWJgyPrGM6NMMA4dilIgVG+nodaQI3SvFPJ6UQmI9ji/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734570502; c=relaxed/simple;
	bh=QZ4z8fjBWTcf3il0BH2jZzxoBzP4WVaws/GscSyURNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLxe98G0Kn9OibYR3thxzRBIsUjQeJOxyPK1wT/0h6Dp2Y8saQdOLxkPpbSTxw1lyMQEYcPeLuXyfS68A7KsnJ2bUqtHnyUpxjeW8ayIg3oVJeu1KKItMJYAw1mEwA0Xjn1z7Yz8PoSVvRnh6qFLoQaM+OJ3WX+ILVwrmsGABQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENhMPHg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENhMPHg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4319CC4CECD;
	Thu, 19 Dec 2024 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734570501;
	bh=QZ4z8fjBWTcf3il0BH2jZzxoBzP4WVaws/GscSyURNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENhMPHg1VrFPFSGz+vbM+Yh2LPcDCSGXGLo2vJ7olQhZxsVUBfCCcEBBVx4BdS9EI
	 1RWVEfDicylpJ/qx61nzEWglLLvZtKowJKVgGFDlsrMWjsAswRKD9ah2C7hBUQXGja
	 UK6v7YEPWNbrcoU0831kDW+FOqnM6j1ewhPk4VJjAPnX+jfwaueGedgo0D0DxoG8qm
	 /KXRE8sU+jmmd+rlXImGOh/voD6ZKhIL9jxt7x7AAIUepf2y+IMKzvuJ3/CZrK8GlO
	 tdAjgWXi0hKLeCVnqt5pVrdu+wJgfG2J4GSjxgowirDuCu0Olf5HndT28PPwt8Rslp
	 qXAIGE92iWIlw==
Date: Wed, 18 Dec 2024 17:08:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf synthetic-events: Ensure features are aligned
Message-ID: <Z2NyAxRzKaIw2qaB@google.com>
References: <20241216232459.427642-1-irogers@google.com>
 <20241216232459.427642-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216232459.427642-4-irogers@google.com>

On Mon, Dec 16, 2024 at 03:24:57PM -0800, Ian Rogers wrote:
> Features like hostname have arbitrary size and break the assumed
> 8-byte alignment of perf events. Pad all feature events until 8-byte
> alignment is restored.

But it seems write_hostname() and others use do_write_string() which
handles the padding already.

thanks,
Namhyung

> 
> Rather than invent a new mechanism, reuse write_padded but pass an
> empty buffer as what to write. As no alignment may be necessary,
> update write_padded to be tolerant of 0 as a count and count_aligned
> value.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c           | 7 ++++---
>  tools/perf/util/synthetic-events.c | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 03e43a9894d4..d10703090e83 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -168,11 +168,12 @@ int write_padded(struct feat_fd *ff, const void *bf,
>  		 size_t count, size_t count_aligned)
>  {
>  	static const char zero_buf[NAME_ALIGN];
> -	int err = do_write(ff, bf, count);
> +	int err = count > 0 ? do_write(ff, bf, count) : 0;
>  
> -	if (!err)
> +	if (!err && count_aligned > count) {
> +		assert(count_aligned - count < sizeof(zero_buf));
>  		err = do_write(ff, zero_buf, count_aligned - count);
> -
> +	}
>  	return err;
>  }
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index f8ac2ac2da45..ee6e9c2fb11b 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2401,6 +2401,8 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
>  			pr_debug("Error writing feature\n");
>  			continue;
>  		}
> +		write_padded(&ff, /*bf=*/NULL, /*count=*/0,
> +			     /*count_aligned=*/PERF_ALIGN(ff.offset, sizeof(u64)) - ff.offset);
>  		/* ff.buf may have changed due to realloc in do_write() */
>  		fe = ff.buf;
>  		memset(fe, 0, sizeof(*fe));
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
