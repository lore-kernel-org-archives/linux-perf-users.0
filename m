Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4232470E
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701692; cv=none; b=m0iw6JWkcLM7IgiGEnXy2uEPT8D2kldcNY1H6a8Zq7VizljKHcsh/3QOQSEIGrSBoFQ33rlinICH4dzwq2VlcA+GI1nWJbb6boxzwA6vEPfoHnpCGPusgwJ2xTl0/RUSznLSbJxS3uDaxMvucM+gH2WY8h7zdvS5QnS2etoGZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701692; c=relaxed/simple;
	bh=7r7OtEQcxwrbh/VS8rTlzEINqoI1FnQy6dcVniAzdbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UnxigpQFTAT9rWpLogVTENtvY//UBKL+VBQ6wkZZRiv02uhCU5Ckjbtad1x3bw95YA8sNychROpuxsXJv5jkuJShzxDGSXwHy1tFxZWq5E6APZuBtt+nEumfMYPL4N/Cm3k7Gp5/NQdPX8fyQrtIUmpYXbvKwDOcVV04ryUTPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3cBWM+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3cBWM+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA5A1F00893;
	Fri,  5 Jun 2026 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701690;
	bh=iDzLeAhsy3LSdflvMmKNUQ0UBZCkNvnoNLlrxgN7Poc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3cBWM+gno9hOHHbYAUU+9H+0H07B3yatIZLdfEPWqaSu32jl7Ne/HMAghUsd3Wlj
	 DdYbv88TghdqRl2Z376IH+VHqb/iVAM7h63BvpyJLkcj/MMVcuu+cBTdgFtfjGueE/
	 asWUOOG04oThUOxFfF6a6K0DJLcH3LVmPuHYH2o3ELacnLOPM0lzJGpYEceMT6H2VW
	 6Yz+hSwm9JQ8ilt+bTWqWd8tEzdvyorYHfU+KvWIyi5dUwdGFfs507noh19ScLUY0m
	 D69tubYdABUyGirbVl/aDphj5zsEwTHaQYYqGc+CMQEj1ON45YDEX36AojcUctk8/B
	 HJl1DUVNExalw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf timechart: Fix memory leaks during record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605231155.2415760-3-namhyung@kernel.org>
References: <20260605231155.2415760-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:21:30 +0000
Message-Id: <20260605232130.BEA5A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The dynamically allocated `backtrace` string is assigned to multip=
le `cpu_sample` structs in `sched_switch()`, leading to a double-free durin=
g cleanup in `timechart__release()`.

Pre-existing issues:
- [High] The string dynamically allocated by `cat_backtrace()` is leaked fo=
r all events whose handlers do not explicitly take ownership of the pointer.
--

commit 3fc0db6fae9ace5123335636ffe90eb603c38998
Author: Namhyung Kim <namhyung@kernel.org>

perf timechart: Fix memory leaks during record

The command line options can be passed without copy as their lifetime is
limited within the same function.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 73a08236ac299..fded4be93de0d 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -1543,6 +1543,8 @@ static void timechart__release(struct timechart *tc=
hart)
>  			free(c);
>  			c =3D next_comm;
>  		}
> +
> +		free(p);
>  		p =3D next_pid;
>  	}

[Severity: High]
Does this code trigger a double-free on the shared backtrace pointers?

In sched_switch(), if both prev_p and p tasks have been previously
observed, the exact same backtrace pointer is passed to pid_put_sample()
twice:

pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
               prev_p->current->state_since, timestamp, backtrace);
/* ... */
pid_put_sample(tchart, next_pid, p->current->state, cpu,
               p->current->state_since, timestamp, backtrace);

pid_put_sample() stores this pointer in two newly allocated cpu_sample
structs without duplicating it.

Later, when timechart__release() traverses all cpu_sample structs it calls
free((char *)cs->backtrace). Since two samples point to the exact same
memory address, wouldn't this result in a double-free?

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under
review, but does process_sample_event() leak memory when calling event
handlers?

process_sample_event() unconditionally calls cat_backtrace(), which
dynamically allocates memory using open_memstream():

FILE *f =3D open_memstream(&p, &p_len);

This pointer is passed directly to the event's tracepoint_handler callback:

return f(tchart, evsel, sample, cat_backtrace(event, sample, machine));

However, numerous event handlers (e.g., process_sample_cpu_idle,
process_enter_read, process_exit_write) either ignore the backtrace
parameter or omit it entirely.

Since neither the caller nor these handlers free the memory, is it leaked
for every such sample?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605231155.2415=
760-1-namhyung@kernel.org?part=3D2
