Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF961953A1
	for <linux-perf-users@vger.kernel.org>; Sun, 18 May 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747591370; cv=none; b=fqorxEhydUhwepKWQfpDR61c9Cj5g3NR/aWNIsPzS3DH0L1KXoiJXKIJrQCpQ7pHbFZIq2CX285NThtSObitLm/iLEI0Hv1A5JtnlVw9LVJ+7ePbxpLqMioCGoJAqOKreXIiDGSiqa3DDZ6o7KBAn1vFBB+lapye+ZN2XjFIOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747591370; c=relaxed/simple;
	bh=DzL+TXBFb/L4JlINohZkeBFeqts884s0d2JZvneyMio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H31R5vNyih6ZEJO4uJtOkgbQkOjlN2wB7zQlQ63ucw5O46P5waTwvEh+DeMzvAK+4832wYBBnXkWPw1+JrmAgLMCRfx/MjnuUuXkcWssFwDD+zxdiGUKkcQmhI+i8O6jmRtkRg0Chj1F1y+F4Q1JKW8Rbv56YfLVVvtJcsoPctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6yRr6Cw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6yRr6Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B2C4CEE7;
	Sun, 18 May 2025 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747591369;
	bh=DzL+TXBFb/L4JlINohZkeBFeqts884s0d2JZvneyMio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6yRr6CwUBvfI0Ys53HEguqE4f1u76k0KX0Nsps2SDF9RYcR5A0EHhDPUyLNPTdaI
	 hruaQvNQZCPn4Plkk5a2RHC/txuY7Mzm2VAZBUhIg+djVkbTtMj46p0J+6HhBnDvjl
	 TZmf9XlGvVAfND7erxK5uO7eoDUDpkHsl7JOqihay1TzJMkC1NtYTueavkRvoD68JF
	 3dc/frcjP9y2YRrTwts0Pk1is13NPDMis09D+D399wXHWPY4ymtyJD/F3+Ub43e40c
	 auWCn/Qdys5fO1f7A0Se8YXAA/3p8BbZoLiJiiNnQnmUMQ7jryjdMuCWVKpete0Dnj
	 boNKZDyzKjptA==
Date: Sun, 18 May 2025 11:02:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf trace: always print return value for syscalls with
 set errpid
Message-ID: <aCogx3jPtKTQOPa0@google.com>
References: <20250403160411.159238-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403160411.159238-2-ashelat@redhat.com>

On Thu, Apr 03, 2025 at 12:04:12PM -0400, Anubhav Shelat wrote:
> Currently some syscalls that have errpid set to true do not print a
> return value in perf trace. The syscalls that were consistently
> observed were set_robust_list and rseq. This is because perf cannot find
> their child process. This change ensures that the return value is always
> printed.
> 
> Before:
>      0.256 ( 0.001 ms): set_robust_list(head: 0x7f09c77dba20, len: 24)                        =
>      0.259 ( 0.001 ms): rseq(rseq: 0x7f09c77dc0e0, rseq_len: 32, sig: 1392848979)             =
> After:
>      0.270 ( 0.002 ms): set_robust_list(head: 0x7f0bb14a6a20, len: 24)                        = 0
>      0.273 ( 0.002 ms): rseq(rseq: 0x7f0bb14a70e0, rseq_len: 32, sig: 1392848979)             = 0

I'm ok with the change but I'm not sure if they are right syscalls.  It
seems neither of syscalls return a thread id.

Thanks,
Namhyung

> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6ac51925ea42..c192f0219b2b 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3005,8 +3005,8 @@ errno_print: {
>  	else if (sc->fmt->errpid) {
>  		struct thread *child = machine__find_thread(trace->host, ret, ret);
>  
> +		fprintf(trace->output, "%ld", ret);
>  		if (child != NULL) {
> -			fprintf(trace->output, "%ld", ret);
>  			if (thread__comm_set(child))
>  				fprintf(trace->output, " (%s)", thread__comm_str(child));
>  			thread__put(child);
> -- 
> 2.48.1
> 
