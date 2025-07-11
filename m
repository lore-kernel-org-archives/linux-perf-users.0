Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAA1F3D54
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264142; cv=none; b=bA+9bWfWy4hl7HPPoGkfUwGG2N8NBUJbIy/PSw2RrDBUrXFuOBQbreoPEeU5zwPxJj7vL+lKr/7Af09cAoIZRKglKdI5CdUMzrJVLeHpwGOzCj9KWbieVIPMYWJqTpvlDUgItz7jtPZtEk8fWKa6pzb+tGCZDXdOmZMhpZvYs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264142; c=relaxed/simple;
	bh=cJs55+gzHQVnZDWZCXtwlNp0mV/3JIrwGHgnX0UNWr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LapVhiOhCrxEQiHoBa+7QWp0FtPu0ClURcdpHmaptpU9bCveAxgpP0Ljo8oSZSmfis4e5hoDzclMUEs9t1aYTb5o4AFfaE8ArIkmSnB4i1vzIePbWOSfKXZOjM81DSThZolwBtri4Fk1/2QE2jLFXhbbux0wATGnkjXHmR8zelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z697tI7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z697tI7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C5C4CEED;
	Fri, 11 Jul 2025 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752264142;
	bh=cJs55+gzHQVnZDWZCXtwlNp0mV/3JIrwGHgnX0UNWr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z697tI7akWgtWFCItWsjRU9bb9vwg2YJVyoxQsWb1YxTFw64ymY6orC5HwSIwSkG3
	 YETtzQ/a7mJ3fGu708O2mE3ubCgEbqPiMg7chYBg4tQ42IR8HlEYojWKjvr7HkZLVI
	 ITw4z/QoP9Nw3C3dMD7Hln5ifUfyRw3ARhkFZH57HeyJ4sPwmve9cvNQFkHVu6ORID
	 j2uWkDyVCH2FZQA5EzUN/kfkFnHaexkNNJ3Q6eZvyYz77Uz4nK5c46EzkPjgXkdG+O
	 IbGfumOWejhvGDlKnmC3+N3zpaFW3ptL/zrYQFOnj0g0JDGyzawzKnz1KpTU8+bJNn
	 NIibMSFkFkqjQ==
Date: Fri, 11 Jul 2025 13:02:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf sched timehist: decode process names of processes
 in zombie state
Message-ID: <aHFtzFZEvCp0B6V2@google.com>
References: <20250709143119.91147-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709143119.91147-2-ashelat@redhat.com>

Hello,

On Wed, Jul 09, 2025 at 10:31:20AM -0400, Anubhav Shelat wrote:
> Previously when running perf trace timehist --state, when recording
> processes in the zombie state the process name would not be decoded
> properly and appears with just the PID:
> 
> 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
> 1140057.412222 [0012]  :1248612[1248612]                   0.000      0.000      0.332      Z
> 1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
> 1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
> 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S
> 
> Now some extra processing has been added to decode the process name:
> 
> 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
> 1140057.412222 [0012]  sleep[1248612]                      0.000      0.000      0.332      Z
> 1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
> 1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
> 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S

Thanks for the fix.  A nitpick below.

> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/builtin-sched.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 26ece6e9bfd1..e1a931341bc8 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2023,11 +2023,15 @@ static int comm_width = 30;
>  static char *timehist_get_commstr(struct thread *thread)
>  {
>  	static char str[32];
> -	const char *comm = thread__comm_str(thread);
> +	char *comm = (char *) thread__comm_str(thread);
> +	char *empty = (char *) "";
>  	pid_t tid = thread__tid(thread);
>  	pid_t pid = thread__pid(thread);
>  	int n;
>  
> +	if (*comm == ':')
> +		comm = empty;
> +
>  	if (pid == 0)
>  		n = scnprintf(str, sizeof(str), "%s", comm);
>  
> @@ -2147,6 +2151,8 @@ static void timehist_print_sample(struct perf_sched *sched,
>  	struct thread_runtime *tr = thread__priv(thread);
>  	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
>  	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
> +	const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
> +	char *comm_str = timehist_get_commstr(thread);
>  	u32 max_cpus = sched->max_cpu.cpu + 1;
>  	char tstr[64];
>  	char nstr[30];
> @@ -2173,8 +2179,15 @@ static void timehist_print_sample(struct perf_sched *sched,
>  		}
>  		printf(" ");
>  	}
> -
> -	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
> +	
> +	/* if a process is in zombie state commstr will start with a '[' and 
> +	 * we need to do extra processing to decode the process name */
> +	if (*comm_str == '[') {
> +		printf(" %s", evsel__strval(evsel, sample, "prev_comm"));
> +		printf("%-*s ", comm_width - (int) strlen(prev_comm), comm_str);
> +	}
> +	else
> +		printf(" %-*s ", comm_width, comm_str);

What about just updating thread comm if it's missing?

	if (!thread__comm_set(thread)) {
		const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
		thread__set_comm(thread, prev_comm, sample->time);
	}
	
	printf(" %-%s ", comm_width, timehist_get_commstr(thread));

Thanks,
Namhyung

>  
>  	if (sched->show_prio)
>  		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
> -- 
> 2.50.0
> 
