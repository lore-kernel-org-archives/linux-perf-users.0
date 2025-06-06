Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047661DFCE;
	Fri,  6 Jun 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749178582; cv=none; b=B6+Ts5wpmkQ+aYNNJn0PZ7mufqAy6/GB/ikDJKbgYKC/Gh/EL8ews2rofC4lpNeaBpxi6KoY35ZyrcjztAfp57/PYxEdlKgNMguD/EgYGmZhwB9QmpZJP3jzIzgPZzgYacJzkbZvwfB7yvMSD1+580Arfg14sg0MmXaHR92PskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749178582; c=relaxed/simple;
	bh=WtZ68Z97JDmdQHhcYaUt/bFAHNzQAr0y4QDKDf5SJao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCTcK5DMv3hkaKB+W6nSRafKVkp9wpdCAdikikhGAIdLwoO4zHilXDT9nfbUfPYAfeZB7iX9j+DtDZNZ+BafS6/kotCMJAt/N/sRBMvoQQ887SdKFqpYgUSKWB91egNpc0h0H01Ceh/sqASIJAMTgANlC5CQjw3NJzbeMnUGry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3/AgHMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3/AgHMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1C7C4CEEE;
	Fri,  6 Jun 2025 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749178581;
	bh=WtZ68Z97JDmdQHhcYaUt/bFAHNzQAr0y4QDKDf5SJao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3/AgHMRZj88+xNKxbzaPsB5GOS4QZcys0JC04jHGnGFhEvn5W1aK32DITAt3tbmY
	 t/I5D3F58cV3h2I5ijJxpbZM96BPXD5OZ0sw9Lp+P/UHk8kcZy5lvUu/QwzE2E+Uff
	 lwWa29fmNqovkbfKzI/v3jx60SGbKfr1aKG/YIrSB4/4fI7njTyXbon2VOyhJZp2KH
	 rQ7S4wtDO2zZ8szkEfzchLLVM25p9V+e2JvgiTQnLAwblLiovRCBMNeiOGeLwg0qb8
	 MJo7gq96ARlip5c8/Yl6qlFfI0Wgx49xqPtadL7S6NKbukxXnRqGEQBA59SL4877DO
	 BAvs4cCKNIxRw==
Date: Thu, 5 Jun 2025 19:56:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf test trace: Reduce test failures and make
 error messages verbose
Message-ID: <aEJY0xQTm1Q2cz1C@google.com>
References: <20250528191148.89118-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528191148.89118-1-howardchu95@gmail.com>

On Wed, May 28, 2025 at 12:11:42PM -0700, Howard Chu wrote:
> Currently, BTF tests fail constantly, this series fixes two major reasons
> why they fail, and makes the error messages acquired when using '-vv'
> more verbose, so when they fail, one can easily diagnose the problem.
> 
> Before:
>     $ sudo /tmp/perf test enum -vv
>     107: perf trace enum augmentation tests:
>     107: perf trace enum augmentation tests                              : Running
>     --- start ---
>     test child forked, pid 783533
>     Checking if vmlinux exists
>     Tracing syscall landlock_add_rule
>     Tracing non-syscall tracepoint syscall
>     ---- end(-1) ----
>     107: perf trace enum augmentation tests                              : FAILED!
> 
> After:
>     $ sudo /tmp/perf test enum -vv
>     107: perf trace enum augmentation tests:
>     107: perf trace enum augmentation tests                              : Running
>     --- start ---
>     test child forked, pid 851658
>     Checking if vmlinux exists
>     Tracing syscall landlock_add_rule
>     Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_start
>     [tracepoint failure] Failed to trace tracepoint timer:hrtimer_setup,timer:hrtimer_start, output:
>     event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
> 			 \___ unknown tracepoint
> 
>     Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not found.
>     Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.
> 
>     Run 'perf list' for a list of valid events
> 
>      Usage: perf trace [<options>] [<command>]
> 	or: perf trace [<options>] -- <command> [<options>]
> 	or: perf trace record [<options>] [<command>]
> 	or: perf trace record [<options>] -- <command> [<options>]
> 
> 	-e, --event <event>   event/syscall selector. use 'perf list' to list available events---- end(-1) ----
>     107: perf trace enum augmentation tests                              : FAILED!
> 
> Changes in v3:
> - Change the regex pattern in struct augmentation (Ian)
> 
> Changes in v2:
> - Add an extra newline after error messages
> - Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
> - Take the debug diff for explanation out of patch 5 to make it apply
>   normally
> - Add base-commit in this cover letter
> 
> Howard Chu (6):
>   perf test trace: Use shell's -f flag to check if vmlinux exists
>   perf test trace: Remove set -e and print trace test's error messages
>   perf test trace: Stop tracing hrtimer_setup event in trace enum test
>   perf test trace: Remove set -e for BTF general tests
>   perf test trace BTF: Use --sort-events in BTF general tests
>   perf test trace BTF: Change the regex pattern in the struct test

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/tests/shell/trace_btf_enum.sh    | 17 +++++++++--------
>  tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 628e124404b3db5e10e17228e680a2999018ab33
> -- 
> 2.45.2
> 
