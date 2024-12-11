Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2F1D63F9;
	Wed, 11 Dec 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944536; cv=none; b=SKS93nfr8LyoL3p/fnVYB9HwNt7FIrvKJgYPQZ9iluZrZFYT/QE8dNbsJLUNbASaQ2XoeOuw8F9he9CLZDq18LdJGJjqg2AWoXzMNI+04E8ZDSbQ9DE6CyJVl1RTWuQNOtmq4G4kAb4rVdFKW2OuLVvtGAyBuAVINc43lokvysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944536; c=relaxed/simple;
	bh=QKMUe0IVB3GFMAU3+QDC3w0vBJ/jEc6BgiyRMSB0qfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjeohbXwf9fiutYzbseGcwYd0M0iq7lpOZlsmvnI6D5m0NYCU5RQJoIAUgBh8V95Jl7vhgEyKSwwLSjYEQfW2xHARdC6sBowYYHdJd8KS3M+uJLittPHSH8qGG9Skm+m9Trl2LvNolmMAmb0QqhelFKzXlki99LsKaVUpUYfIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQTMVI2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQTMVI2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A127C4CED2;
	Wed, 11 Dec 2024 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944535;
	bh=QKMUe0IVB3GFMAU3+QDC3w0vBJ/jEc6BgiyRMSB0qfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQTMVI2rRwoIO6NH1H10upzpK9DNOY2fT/CMvqf/e1gbjdh6sAodYj8SVe89W4W96
	 v6+bFsFsqjQxjeFZZpBROMafItlwPcnHm1NXWJcTnVosdFMjKv8S9csN9ohUZpZuKw
	 VfWENj6QpCtDbf7IyQKafm9k5AhYDqWzLY1RBJEZMdjoLF6ybace1JXFMeHBqZXFPG
	 BetgmiGHq4KNEkH9umSYSat3dEVp3dl+lGri2a3KkwVF1obMxSwBSTvwjB0nN8zKrn
	 JK49TQrInBE1R2fyc3xxgAMROgZojX040+FffswaBxBX6J1y854IZ9xGGO+vcZqSA0
	 IEwD+Iv0B9P+g==
Date: Wed, 11 Dec 2024 11:15:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf lock: Add percpu-rwsem for type filter
Message-ID: <Z1nk1gxH9siszkwG@google.com>
References: <20241210200847.1023139-1-ctshao@google.com>
 <20241210200847.1023139-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210200847.1023139-2-ctshao@google.com>

On Tue, Dec 10, 2024 at 12:08:21PM -0800, Chun-Tse Shao wrote:
> percpu-rwsem was missing in man page. And for backward compatibility,
> replace `pcpu-sem` with `percpu-rwsem` before parsing lock name.
> Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
> percpu-rwsem`
> 
> Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Documentation/perf-lock.txt | 4 ++--
>  tools/perf/builtin-lock.c              | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 57a940399de0..d3793054f7d3 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -187,8 +187,8 @@ CONTENTION OPTIONS
>  	Show lock contention only for given lock types (comma separated list).
>  	Available values are:
>  	  semaphore, spinlock, rwlock, rwlock:R, rwlock:W, rwsem, rwsem:R, rwsem:W,
> -	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, pcpu-sem, pcpu-sem:R, pcpu-sem:W,
> -	  mutex
> +	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, percpu-rwmem, pcpu-sem,
> +	  pcpu-sem:R, pcpu-sem:W, mutex
>  
>  	Note that RW-variant of locks have :R and :W suffix.  Names without the
>  	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 7e36bbe3cb80..50630551adad 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2365,7 +2365,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
>  		/*
>  		 * Otherwise `tok` is `name` in `lock_type_table`.
>  		 * Single lock name could contain multiple flags.
> +		 * Replace alias `pcpu-sem` with actual name `percpu-rwsem.
>  		 */
> +		if (!strcmp(tok, "pcpu-sem"))
> +			tok = (char *)"percpu-rwsem";
>  		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  			if (!strcmp(lock_type_table[i].name, tok)) {
>  				if (add_lock_type(lock_type_table[i].flags)) {
> -- 
> 2.47.1.545.g3c1d2e2a6a-goog
> 
