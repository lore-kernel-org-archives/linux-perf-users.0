Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F255345EA7;
	Sat, 12 Sep 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244111; cv=none; b=AC6tDXIDSh/e4kIHTvvpAw+PVZkvTp5vcmfKHv+dpJFbYKJvEzdOw2Gk22bNyvRpvoVUzOeOPxIuzGHqymQqoXw09OdhoD1VLv4MrUVKKgXxMnUui5PsukDFVX4UxBpyjsQmZWfbXY25R4lOTetOA6We0W7b/McHbEG7mWKlxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244111; c=relaxed/simple;
	bh=XJmiCQsVdnNmISDg3lxYu29PWa7Ygrnba439C1aPA/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDL/N5vpkaKZAijmfNqpyZ+MLUh05XXE6d2/ZJwK7KiC8ruhAwDSATSVP07idKfyb1CtT2SRhFZkroAMrBbc4D5g5fMzhvRi8C/jbZBHWpmYt/i7XFkP2Qo/AOpdXSwTQDrm9BgPQnkm8/ey7UVjslBc9iCl8+uAoXYrgY1rwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeyIAvd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeyIAvd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FB51F000FF;
	Sat, 12 Sep 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244109;
	bh=iARXpJiva2weZPGXK48Cat7tifL8FGJrdQkrAN+DV1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BeyIAvd+8CaDUxvXLA8+PzsWhF0PZ4grovnXONlkyWZvDBq0o45EU6jnMMREv8i2w
	 5xYd7eIePlQqRA/FF5RFZ3uzuK76YTpvXg/atQPyFfqRJeGZNYZUPkFP3IOAO6uNws
	 uU+HKDP5HwMG8Xjy5ha9Il4im6m5RD6URFRglM2v5+Jy2MSSrCUkVoyrFLipgqyNXI
	 GA6FolaK3B5wtn70hKIYcraw/BBiZI8SovMQpts37RNvJmiyCnJCRz6YIs3r/+LDLj
	 TiRMOj1wOZqV5hqvkalfyB06qWl+ClSYr95SPgi850OV7NOXpSgH2oMTP327DI8D0y
	 lv69+TSYPbOEQ==
Date: Sat, 12 Sep 2026 17:15:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v1] tools build: Fix timerfd feature detection with clang
Message-ID: <aqWyyC4n0XvAFvux@x2>
References: <20260910213907.3206529-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910213907.3206529-1-irogers@google.com>

On Thu, Sep 10, 2026 at 02:39:07PM -0700, Ian Rogers wrote:
> Clang's uninitialized-const-pointer warning causes a feature test to
> fail when building perf with clang. This disables support for 'perf
> kvm stat live'. Add default initialization to new_value as a
> workaround.
> 
>   test-timerfd.c:15:30: error: variable 'new_value' is uninitialized when passed
> 			       as a const pointer argument here
> 			       [-Werror,-Wuninitialized-const-pointer]
>      15 |         if (timerfd_settime(fd, 0, &new_value, NULL) != 0)
>         |                                     ^~~~~~~~~
>   1 error generated.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
> ---
>  tools/build/feature/test-timerfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/feature/test-timerfd.c b/tools/build/feature/test-timerfd.c
> index 9c72c697a9df..f88e8cc63ef3 100644
> --- a/tools/build/feature/test-timerfd.c
> +++ b/tools/build/feature/test-timerfd.c
> @@ -6,7 +6,7 @@
>  
>  int main(void)
>  {
> -	struct itimerspec new_value;
> +	struct itimerspec new_value = {};
>  
>  	int fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
>  	if (fd < 0)
> -- 
> 2.55.0.1007.g17ff1f9808-goog
> 
