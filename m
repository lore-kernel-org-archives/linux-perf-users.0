Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A0D332621
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775893328; cv=none; b=Xm5yXAVbtH3FMvDUuCLt09tE/CC9sjZwV+FIIiYYRhg6mF5Ys3vB0QHW1fLqFU9B6W2AJwnsSZ+0wLs1mZu1MjjwsNJg743LJfeSwiQc2Nkz1Da+Sulg8hWfHDu2xjLXsrun1BsNXEVq9IvkV/7HV1JS75cxYUi/SaRBENEtGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775893328; c=relaxed/simple;
	bh=oZbLzGA9V/2InviTruxDPWbCtVfPLcbvlQsm9QTQSP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvXdRBLZ2mpv3ezMUKnJ6drNB40MsE/g8jLbnZFuqR5vbb9BiY2DeHBLd2MJ8rgIaFMTKJt5HClSRP8k5dfIajYEP9orsnPyGImaqWtpHVHhEs0XoZTfdAJ0dFvflA3k/rO3UMULGIkFCDjcGLQx7vPIlj6lDT3OxkV9fE7Pfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmsaho7r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmsaho7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7CDC4CEF7;
	Sat, 11 Apr 2026 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775893328;
	bh=oZbLzGA9V/2InviTruxDPWbCtVfPLcbvlQsm9QTQSP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rmsaho7rcoYr/H9SNGEeiyVmrD3lmSpQuPk8CMIr13z58ZihfCuQw5pI1wq/eXZ90
	 8DT8VcDLEaEBhXXMjZXws7WYSscAKaDosVKPdSqbZsHhc2gCu0njp6VL48xikBsMua
	 CfBK9pViEdYxnVwA3711xx5SqwQJ/JyJAJSs/fjLwvb9mEdUZoXkXP5RWagHKqWFv3
	 nWPMN/XyxZgFV5l0DBKvKjGSB23T5+0BruWxVYkJ9qSOPQquAgL47pkocRoyYPwLM0
	 uxmu0KL7Y+DCTjm9dWbpwZ6LVEEc10R7inUi7PcVFkuoDypcLY3Q59jLrlw8EAs607
	 7jqO4QsYWtWag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 25/29] perf sched: Bounds check CPU in sched switch
 events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-26-irogers@google.com>
References: <20260411065718.372240-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:42:07 +0000
Message-Id: <20260411074208.0A7CDC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Missing CPU bounds check in the 'timehist' subcommand's sched swit=
ch and wakeup event handlers leads to out-of-bounds memory accesses.
- [Medium] Returning -1 on an out-of-bounds CPU aborts the entire trace pro=
cessing session without an explicit error message.
--

commit 468b69261d074326f363527184e94c05b18bc45c
Author: Ian Rogers <irogers@google.com>

perf sched: Bounds check CPU in sched switch events

This commit adds a bounds check on the CPU value extracted from perf samples
in the sched switch event handler. It prevents out-of-bounds array accesses
by checking if the CPU exceeds MAX_CPUS.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 45439e2af8ffa..6d0655d56e269 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct=
 perf_tool *tool,
>  	u32 prev_pid =3D perf_sample__intval(sample, "prev_pid"),
>  	    next_pid =3D perf_sample__intval(sample, "next_pid");
> =20
> +	if (this_cpu < 0 || this_cpu >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bound sample CPU %d\n", this_cpu);
> +		return -1;

Returning -1 here aborts the entire trace processing session. Because the
out-of-bounds condition is only logged via pr_debug(), normal users will
not see any explanation for the failure, and the command will simply exit
with a generic error message.

Could we either gracefully skip the unsupported sample by returning 0
(similar to the established pattern in replay_switch_event()), or use
pr_err() to explicitly inform the user why the session is being aborted?

Additionally, do the timehist subcommand event handlers also need CPU
bounds checks?

Looking at timehist_sched_switch_event() and timehist_sched_wakeup_event(),
they pass the unvalidated sample->cpu (a u32) to get_idle_thread(int cpu).
If the trace contains a corrupted value like 0xFFFFFFFF, it is cast to -1.

Since cpu is a signed int, the reallocation check bypasses reallocation if
idle_threads is already initialized (because -1 >=3D idle_max_cpu is false).
The code then attempts to read/write idle_threads[-1].

Can this result in a negative out-of-bounds memory access that crashes the
tool or causes memory corruption?

> +	}
> +
>  	if (sched->curr_pid[this_cpu] !=3D (u32)-1) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D25
