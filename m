Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF84D599;
	Wed, 23 Oct 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723726; cv=none; b=XAECT7ZhfNskJC0oGu6rNa9G7dhdcQitzp+1WJh79D3OHWjtCrd9dIiHJAL2dsEpGRfP/7TjocuEy61NvoKxTaNK3appH9+hxYMu/XnQCIYx4Z3qH/WnnCPTniaQfQO1tl8K7/XwmeUdSCSTYb0qI+1GymlUbhVyEfb/Or+uStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723726; c=relaxed/simple;
	bh=tQI6xcoW5Wj1FOWko5zJvCpwUmlsidOvfFIzSJxDFMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8D37LKKvJlvT1qrCVKwlgRw7LRuXZ7yBJq0WJxKDvCTkR4VQNwKkWegfBfJkLbeuyGxE9btw9JIKcCiicMzh13S1N+C0piSc9Kb4cS6kQW5vGsosqBztJzLCk0jAM3PxZgr+NmCtlWA1j5/sbI/9fLxiusdAMFUAwiUprcVMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2MxIgOq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2MxIgOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA9AC4CECD;
	Wed, 23 Oct 2024 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729723726;
	bh=tQI6xcoW5Wj1FOWko5zJvCpwUmlsidOvfFIzSJxDFMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2MxIgOqB8YXLhK/4j84W8rZc1bOCoeKveRTbjBHgHlcbNw9VjD4exFHXDU0mVDV8
	 PhkhzYEXBHQRhCPvKcM1MgedD6xjQqoorZsf9PQgTmqT53WH39gyqTwKwmz/SH5gte
	 lphEmYnVdhlJZO2amcLtAgsu+KqHHvn8KnDRoJKLEG6DJr5Yt9Lmsw2PRUqau+S8Y+
	 MCtK8auIMTPT3W9cJK5ruBpJHxZs3/0MUu7CPx7tnFu4CVybSlrHReOzE+Y0/LIo9E
	 mmLoNOdW+gf+ze1ppoUpoPkbyip9BooGhdrzOpadq5+IHkht5aQHEyDnuVk2TTBYKm
	 4pjuiq3yhldQA==
Date: Wed, 23 Oct 2024 15:48:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/9] tools subcmd: Add non-waitpid
 check_if_command_finished()
Message-ID: <Zxl9TNHCm6Ymdw9a@google.com>
References: <20241018054719.1004128-1-irogers@google.com>
 <20241018054719.1004128-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018054719.1004128-2-irogers@google.com>

On Thu, Oct 17, 2024 at 10:47:11PM -0700, Ian Rogers wrote:
> Using waitpid can cause stdout/stderr of the child process to be
> lost. Use Linux's /prod/<pid>/status file to determine if the process
> has reached the zombie state. Use the 'status' file rather than 'stat'
> to avoid issues around skipping the process name.
> 
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
> index 4e3a557a2f37..0a764c25c384 100644
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

Well.. I still don't like this part.  But I can live with that as I want
the improvements in the test much more. :)

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
> +		return *p == 'Z' ? 1 : 0;
> +	}
> +	/* Read failed assume finish_command was called. */
> +	fclose(status_file);
> +	return 1;
> +#else
>  	wait_or_whine(cmd, /*block=*/false);
>  	return cmd->finished;
> +#endif
>  }
>  
>  int finish_command(struct child_process *cmd)
> -- 
> 2.47.0.105.g07ac214952-goog
> 
