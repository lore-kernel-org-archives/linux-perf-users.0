Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9931799F;
	Wed,  3 Jul 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977041; cv=none; b=JdgVFJzUoq+Z9MRHBMEj94NNDCkiMHwbevo0eL4XFaVcR1om2seaC0VbXRaBJCnFQ1uFH0USEYEHe0lc7RxZcb7YDAjlB2e68wFwWAoK1/eGOPVedk3k4ugEd1X+85oYQXRVz6U6RnBimhTqtNoUWKhEGkfnDR8dZJlaLVquxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977041; c=relaxed/simple;
	bh=qzEG3oESDXRJMNTCffvSAEMa/1sN/tHpyXP/Rj1Sn+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3flJQmVQZBUbKV8i12jvOe/r3XE30NOX6q2sY88ngpTpra+HKRe+Xx3bQ03mdYlplS0bRL1bSi6Z06ntwHK7SBpa3shEbtjpOylqKMsXx6X0QRpFbzjlMXY8n9hnnR/R/tUcyW7eicXHAL3/I2vouoHjkhjG3m4TFe7qBbmz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOr+k0fq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOr+k0fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB074C116B1;
	Wed,  3 Jul 2024 03:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719977041;
	bh=qzEG3oESDXRJMNTCffvSAEMa/1sN/tHpyXP/Rj1Sn+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOr+k0fqC1evUmg6/mUVKlLo6zR2tW4KkrPNeoLk/GSHeSOPVEoKjeG261K3q6jUY
	 4NsIADTauazrNwuRNeEIfuY3KATdXiC3/1rqDVyavOhfYLL2zlPV+AsV5QbypMbE9K
	 7NTq4pQdUlEAeogk+5qrjIYs0rqumcRMgNp9NpBHF9UwU4dc/4N4oenTQ/RRFjM4l9
	 /iaTJvhV2SDQMj2wh5yy5gDvqLmaXmkKSOf6kOtV2nZRFpZAAzAuYG67d57Bjn5xVf
	 Tyniog03qtH0xxdV9tC55hFAWHRvW8KRL3w4vWZB7ypYclN7+vZplGZcY7fyOu5FoB
	 FD/ZcLD8PvhpQ==
Date: Tue, 2 Jul 2024 20:23:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools subcmd: Add non-waitpid
 check_if_command_finished()
Message-ID: <ZoTETvgcPdl9EUJV@google.com>
References: <20240701044236.475098-1-irogers@google.com>
 <20240701044236.475098-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701044236.475098-2-irogers@google.com>

Hi Ian,

On Sun, Jun 30, 2024 at 09:42:35PM -0700, Ian Rogers wrote:
> Using waitpid can cause stdout/stderr of the child process to be
> lost. Use Linux's /prod/<pid>/status file to determine if the process
> has reached the zombie state. Use the 'status' file rather than 'stat'
> to avoid issues around skipping the process name.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
> index 4e3a557a2f37..ec06683e77a0 100644
> --- a/tools/lib/subcmd/run-command.c
> +++ b/tools/lib/subcmd/run-command.c
> @@ -2,6 +2,7 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <ctype.h>
>  #include <fcntl.h>
>  #include <string.h>
>  #include <linux/string.h>
> @@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd, bool block)
>  
>  int check_if_command_finished(struct child_process *cmd)
>  {
> +#ifdef __linux__

Is this really necessary?  I don't think we plan to support other OS..

Thanks,
Namhyung


> +	char filename[FILENAME_MAX + 12];
> +	char status_line[256];
> +	FILE *status_file;
> +
> +	/*
> +	 * Check by reading /proc/<pid>/status as calling waitpid causes
> +	 * stdout/stderr to be closed and data lost.
> +	 */
> +	sprintf(filename, "/proc/%d/status", cmd->pid);
> +	status_file = fopen(filename, "r");
> +	if (status_file == NULL) {
> +		/* Open failed assume finish_command was called. */
> +		return true;
> +	}
> +	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
> +		char *p;
> +
> +		if (strncmp(status_line, "State:", 6))
> +			continue;
> +
> +		fclose(status_file);
> +		p = status_line + 6;
> +		while (isspace(*p))
> +			p++;
> +		return *p == 'Z';
> +	}
> +	/* Read failed assume finish_command was called. */
> +	fclose(status_file);
> +	return true;
> +#else
>  	wait_or_whine(cmd, /*block=*/false);
>  	return cmd->finished;
> +#endif
>  }
>  
>  int finish_command(struct child_process *cmd)
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
