Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1616E898;
	Fri, 10 May 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351342; cv=none; b=dOo2xdoE5/INSWiyTDqQ6c7o3OUZBy9UVVpc5i5Hi6qnEoxvhvgLeOXbJeUloKmdfjwKSge+tjApYomg3iVNIVFFGWi0n3QFEzMZgkwvfnKpwSRbv4eRymfKIHtTW5wYxuXoGgb86Nt+ff17vdDZ06jU8TTgTrAPii32Y4hvB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351342; c=relaxed/simple;
	bh=bkyDcW4SzquH0cCfq7aZdUGB8FDuymzITPFrA/FnaYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+i0VRJ4tyoXnziZ/va+Lx6+oAmP1rDS/lG3UFPV9qkxZrCI3E9XtifKL0SMTb6SkbwqY86b4+womLKx9TxGjAZEx37OueID2kC2eYTrzLijl76gKjLoklGdOZGk+0Ts35J8XBCEddcbF8+B/tM2Ka+3bDC0F5oiYUOkQMvjIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFsB9Tf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFsB9Tf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6DAC113CC;
	Fri, 10 May 2024 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715351341;
	bh=bkyDcW4SzquH0cCfq7aZdUGB8FDuymzITPFrA/FnaYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFsB9Tf9/uP6IFQZ2dJapq18nQUgwgPKUNV1ASDadJQTo/IymTBjSckwJusU92T3m
	 nYm23NT9VA9nOwADhFrc6u6gWHfdpvU/RWfEB9AVCXbsMnCs3iodzVs0XnwY7BEROg
	 ylGMqGg3ClHRvD1u3Ts+zee9kY83KZ4OvKwNSVR6v3/5xes+a631N5wpPmR8jyvAvn
	 +SgZuegx7KDsnNk1WJzkZdeonf90Ev6+Y/usDmf7xm7+QZDu9Ge1BqH0nyuo+YuGpe
	 vqgJfk+w1Ih8ZGxBaDroiyUtHpUpEE44e6v5sdqgp/lJ2r2qZIbZjnEDovjzvtaWHj
	 +7t7aEQV6GQCQ==
Date: Fri, 10 May 2024 11:28:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] perf daemon: Fix file leak in
 daemon_session__control
Message-ID: <Zj4vKps94GwVBwQ5@x1>
References: <20240510003424.2016914-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510003424.2016914-1-samasth.norway.ananda@oracle.com>

On Thu, May 09, 2024 at 05:34:24PM -0700, Samasth Norway Ananda wrote:
> The open() function returns -1 on error.
> 'control' and 'ack' both initialized with open() and further
> validated with 'if' statement. 'if (!control)' would evaluate
> to 'true' if returned value on error were '0' but it is actually '-1'.
> 
> Fixes: edcaa47958c7 ("perf daemon: Add 'ping' command")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Thanks, applied to perf-tools-next,

- Arnaldo

> ---
> Found this error through static analysis. This has only been compile
> tested.
> ---
>  tools/perf/builtin-daemon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 83954af36753..de76bbc50bfb 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -523,7 +523,7 @@ static int daemon_session__control(struct daemon_session *session,
>  		  session->base, SESSION_CONTROL);
>  
>  	control = open(control_path, O_WRONLY|O_NONBLOCK);
> -	if (!control)
> +	if (control < 0)
>  		return -1;
>  
>  	if (do_ack) {
> @@ -532,7 +532,7 @@ static int daemon_session__control(struct daemon_session *session,
>  			  session->base, SESSION_ACK);
>  
>  		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
> -		if (!ack) {
> +		if (ack < 0) {
>  			close(control);
>  			return -1;
>  		}
> -- 
> 2.42.0
