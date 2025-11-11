Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE928850D;
	Tue, 11 Nov 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900692; cv=none; b=MLb2WoPQ4Be3r3/gAGaeMOP8DMYu1hoU1J8xLQh6BowA03Tymcj3e1+yAzuAVNtQCOskBQSyEGgvhLnjNxvokHEYwIaWrD04/yxep1Z1rl8/0jdSvwA9hEMm1ozpYz4/8RjQpS8ykxkMoU99sXkFHw+drGUoPrvZ5mwMCblqDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900692; c=relaxed/simple;
	bh=LRVuRv9PQKkgI1+rlOG0vUkR9MJG4fNjqko8aLJaMbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/j90poL/Rz/NDa0kGO6gQdrtLdGbhYF2FomAv6lQxVknHzzvg1ucJmuZAftUfZ71Z/Ewpl+oyDcr66UA54zpWS+rUrwF8j9brkxQ7OR8JnZWrmE8nbnxKuxCQN8p8/R6/s0ZSAxRYygKiEdzEc6Q4Q4vNadv6a8vXADaUhdBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuhkkJHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuhkkJHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FCBC4CEF7;
	Tue, 11 Nov 2025 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762900692;
	bh=LRVuRv9PQKkgI1+rlOG0vUkR9MJG4fNjqko8aLJaMbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuhkkJHJ6hyNwezKyP0tcqEBjCWpbcxgnFFyXTl4SE+IOelOaUMNAMoPluIoIaWbm
	 v7RZVjhIE4fzP9WtkKetVnZziHt4NWGKlIcd8umsQu7lSPAJ0wrFuqOhXWEDpDYIkA
	 sJvqTgp/pzF+z0T6vmkpbXI08/RhYz55uT2Q1e8swKhpCuf5ER2E/z4mAlVjEe/6p1
	 bc0Q8epBCp5lQ7QgEEmF6jmvvwdDZeE+79WrLu8rFzTPG43hIp6yrpnGKpZyfY2EaB
	 MSJLGEyEB92CnOmIaBI6Kmp5CFsGXtrziuZzSsUJF7R8oheUlmvMSdBeUUaB6LKq4a
	 F1qeYu3WJz5qQ==
Date: Tue, 11 Nov 2025 14:38:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: write bpf_prog (infos|btfs)_cnt to data file
Message-ID: <aRO6z1Q76852Ig6n@google.com>
References: <20251107173150.135037-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107173150.135037-1-thomas.falcon@intel.com>

On Fri, Nov 07, 2025 at 11:31:50AM -0600, Thomas Falcon wrote:
> With commit f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF
> info"), the write_bpf_( prog_info() | btf() ) functions exit
> without writing anything if env->bpf_prog.(infos| btfs)_cnt is zero.
> 
> process_bpf_( prog_info() | btf() ), however, still expect a "count"
> value to exist in the data file. If btf information is empty, for
> example, process_bpf_btf will read garbage or some other data as the
> number of btf nodes in the data file. As a result, the data file will
> not be processed correctly.
> 
> Instead, write the count to the data file and exit if it is zero.

Oh, I'm afraid it'd create a compatibility problem.  But I think this is
a right behavior and it's should be fine if it goes to the stable soon.

Arnaldo, can you please take this into perf-tools tree for v6.18?

Thanks,
Namhyung

> 
> Fixes: f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF info")
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/util/header.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index db2ad19fa50d..54968881481c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1022,12 +1022,9 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>  
>  	down_read(&env->bpf_progs.lock);
>  
> -	if (env->bpf_progs.infos_cnt == 0)
> -		goto out;
> -
>  	ret = do_write(ff, &env->bpf_progs.infos_cnt,
>  		       sizeof(env->bpf_progs.infos_cnt));
> -	if (ret < 0)
> +	if (ret < 0 || env->bpf_progs.infos_cnt == 0)
>  		goto out;
>  
>  	root = &env->bpf_progs.infos;
> @@ -1067,13 +1064,10 @@ static int write_bpf_btf(struct feat_fd *ff,
>  
>  	down_read(&env->bpf_progs.lock);
>  
> -	if (env->bpf_progs.btfs_cnt == 0)
> -		goto out;
> -
>  	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
>  		       sizeof(env->bpf_progs.btfs_cnt));
>  
> -	if (ret < 0)
> +	if (ret < 0 || env->bpf_progs.btfs_cnt == 0)
>  		goto out;
>  
>  	root = &env->bpf_progs.btfs;
> -- 
> 2.47.3
> 
