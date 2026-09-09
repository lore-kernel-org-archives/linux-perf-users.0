Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5083F211A;
	Wed,  9 Sep 2026 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991607; cv=none; b=Kduwy1AVMjorLgn7lOAy3PwW8b/gtbcUL+8WgAMCiml42Eq9zBoL+YIbRgQ/ONOIkN70iBMwR/vsr7jzIbWDz2HBTSzBZXVXLPqZMu5kQBA1slmovmTDwnLo2tIsZysSA7UuKXf5GC6LxesCH1XsKtlwR8u4++erEcQ4LdvvexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991607; c=relaxed/simple;
	bh=DAZCZP+jNl1UHutqsO//KygP/NvM8hqekLdm0s6WQ08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT5jnCmfl9gol6M4GLdiYDcAsBAKm8ZbV90QSKuUtQne5PeadqPqx27izFUhHXyJfkpC70cWSKaNL994MYeyHROWtIjZ7bp0VQMbUqMqKpG6AdF6S4OQm9mZqCaIjt2BL7zezT4Quj8jNDCqeOeuUcrKS3vdbMR67bngCVynO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hjup01vs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjup01vs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jI1LmTAJIYoxCaZRZFRM28i1gGnOU+BKR9FTzNMJEvw=; b=hjup01vs5n5n8y4+e+dBJLJrX/
	WpdYg8Yvxw3v3Et+Jxt2HQKHSm28mt5Y6ubI6gYH4lcI22PrwwsGpJRrEMpwJnrIESImGvrsppNeQ
	SXscE457NtbFmZ+nll4VQR8IQ6KNIVXa0NPpggfSmJfo4jVK7a+X656ljmwTN+qaUSX+MsCTsA/oq
	TotR2F6fjteAG29PRmpz1X/no13GeSZp1ULxFJhOnvW6lt0Z9KjdgxIE7uGqKbRR1K6bAEbNh6CuN
	ZmsJhEkLdl/BZr+iB7V2ecFGhnpQ2xme7/I6iE6Pfva0TEo7tYKebH7KJxhB2y+BJCO1ZZFTnG/XE
	+/FO4KPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4QR3-00000001jrB-3Q59;
	Wed, 09 Sep 2026 22:06:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 92BF2300A9A; Thu, 10 Sep 2026 00:06:28 +0200 (CEST)
Date: Thu, 10 Sep 2026 00:06:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 4/4] objtool: Add explicitly sequenced -lzstd to
 libopcodes fallback
Message-ID: <20260909220628.GQ776954@noisy.programming.kicks-ass.net>
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909204122.1993010-5-irogers@google.com>

On Wed, Sep 09, 2026 at 01:41:22PM -0700, Ian Rogers wrote:
> Distributions like Fedora currently ship a statically compiled binutils
> libbfd (an intrinsic dependency of libopcodes) that internally utilizes
> zstd to decompress sections.
> 
> Because objtool resolves host dependencies sequentially via a manual HOSTCC
> shell loop, build failures will occur (e.g. undefined reference to
> 'ZSTD_decompress') unless the loop probes for it.
> 
> Add the '-lopcodes -lbfd -liberty -lz -lzstd' combination to the fallback
> chain, assuring successful compilation on hosts packaging static binutils.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.1-pro

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index a4484fd22a96..141b957c566b 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -88,7 +88,8 @@ LIBOPCODES_LIBS := $(shell \
>  	for libs in "-lopcodes" \
>  		    "-lopcodes -lbfd" \
>  		    "-lopcodes -lbfd -liberty" \
> -		    "-lopcodes -lbfd -liberty -lz"; do \
> +		    "-lopcodes -lbfd -liberty -lz" \
> +		    "-lopcodes -lbfd -liberty -lz -lzstd"; do \
>  		echo 'extern void disassemble_init_for_target(void *);' \
>  		     'int main(void) { disassemble_init_for_target(0); return 0; }' | \
>  			$(HOSTCC) -xc - -o /dev/null $$libs 2>/dev/null && \
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
