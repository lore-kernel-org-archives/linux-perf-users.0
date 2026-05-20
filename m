Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351E30AABE;
	Wed, 20 May 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307101; cv=none; b=Hw2ngVlo/hsW3vcox3rTk+WFCOJSpUEOBjC/U3OwyWS0HkSIx5/37O9YiIOkqJDDKCa4WCiFZaGS9q8prRxPatFGACAxB+Teerlsiy+S09R39U0gpLbIvz/aVqfnGajnU16qpBt8vsxwSHKwCOzx1Qpjt42Sa3JOsEeB/ZwcP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307101; c=relaxed/simple;
	bh=z6YDFF/F/G9KRUXz6hjp/SsQ3nqabfGLtqJYh2V7fRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKAGR/ijpMHlEf0ZP8ZrLFBrJjKYeL+CXAbINw8ZjD8c4Qzc5CwXwZIMlkljxLArOorc2CKGYTggWkYJe/UG/cwclxN86wjO3he6WEtQd98L8YVMhFwLjPmlNVqMsbMmpsKt0n9350GP9Izol2C3XL5Gi0G7dZdZEOcgB0pIfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLB/HoQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLB/HoQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E97E1F00893;
	Wed, 20 May 2026 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307099;
	bh=uzxapyiocbfI1LGh1K06T5Oc18KznljB3gV4rIxT3Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dLB/HoQBogzhFCpRBQMcVo7n6otJ2D9ZuSOFScisIHQpeBmIv8NXIiQTCFTopFSlj
	 9jv+Fgr6pc12c1Qcv0WT08C7bPLGgLVe0wI0NxvUhj8xlMsvjxtzlIVlcEXgGfTZMo
	 x105TehnGMr/NMUZGfRLIA8G6QyVvxZyij93K7LeyfIu+MN0BDIK6kmULCqa9zFJlD
	 kJZuegbDhmZ0JQziqdZObTsoavXfwpEuvVPQNLHuUWyAyBh6uxC7HgkjghL0/iImOe
	 NuzUNw6uTn7SP1kgTuGem2A8ejHVHjEW/bSHylKfhokKN//jbJtp2mODid9lvp+ifh
	 YaM/bv9h2S0Ug==
Date: Wed, 20 May 2026 16:58:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, james.clark@linaro.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] perf: Fix SIGCHLD vs pause() race with
 short-lived workloads
Message-ID: <ag4SWXqjAWsjuCsE@x1>
References: <20260520102017.293419-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520102017.293419-1-swapnil.sapkal@amd.com>

On Wed, May 20, 2026 at 10:20:14AM +0000, Swapnil Sapkal wrote:
> Several perf subcommands (sched stats, lock contention) use the pattern
> of forking a workload child, calling evlist__start_workload() to uncork
> it, and then calling pause() to wait for a signal (typically SIGCHLD
> when the child exits, or SIGINT/SIGTERM from the user).
> 
> This pattern has a race condition: if the workload is very short-lived,
> the child can exit and deliver SIGCHLD in the window between
> evlist__start_workload() and pause(). Since pause() only returns when a
> signal is received *while the process is suspended*, and SIGCHLD has
> already been delivered and handled by the empty sighandler(), pause()
> blocks indefinitely.
> 
> The fix replaces pause() with a simpler approach:
> 
>  - The signal handler now sets a 'volatile sig_atomic_t done' flag
>    to record delivery.  The flag is reset before handler registration
>    so that a signal arriving during the setup phase is not discarded.
> 
>  - Replace pause() with a unified loop:
> 
>        while (!done) {
>            if (argc && waitpid(evlist->workload.pid, NULL, WNOHANG) > 0)
>                break;
>            sleep(1);
>        }
> 
>    This handles both workload mode (child exit detected via waitpid)
>    and system-wide mode (user sends SIGINT/SIGTERM setting done).
>    Using WNOHANG avoids the SA_RESTART problem where a blocking
>    waitpid() would auto-restart and ignore the done flag if the child
>    doesn't exit on signal.
> 
> Three call sites are affected across two files:
>   - perf_sched__schedstat_record() in builtin-sched.c
>   - perf_sched__schedstat_live()   in builtin-sched.c
>   - __cmd_contention()             in builtin-lock.c
> 
> The two pause() sites in builtin-kwork.c are NOT affected because they
> do not register SIGCHLD or fork workload children; they only wait for
> user-initiated SIGINT/SIGTERM.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
