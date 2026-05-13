Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDA38F63D
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715797; cv=none; b=SXwPsainEW72X7pEIZiU0QWumUURi4wnIhm6j9CNG2qG64BCyeXc4otjIHzxB5Dx32f3JwYCTJy6wdc0fmNojI1MivBgz28zCEPAKU7W7QfNxh7fnNJKrUaYF4CspgSBYmtAweXn0m5qB5+F9i9cgHAwzKBu+Fabgl5Qq0maih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715797; c=relaxed/simple;
	bh=O+zqSZTTBJEm7z7D3dMxFERLiQ8aH+Hmhjk1eoRAi4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8/qC27arjn0Ogs2JJvql/F+BMOCDhH0QGtXmXWcFHaWJfhFiB/Yb356Cj/L3z+GF2SrmZzIJLgzK3yotN0d03LUIhpM+TBBrhDPZ90Z1AjX/pIXuqKrD8oNvTCFWCLZjleVb4+KOHeB/VPPYvRIsP+DpLb1tbokl2BNzkWunKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVpOGbH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVpOGbH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E81C19425;
	Wed, 13 May 2026 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715796;
	bh=O+zqSZTTBJEm7z7D3dMxFERLiQ8aH+Hmhjk1eoRAi4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jVpOGbH4TPztUhNS7wz7nqexRaTxike5RPD13a1IRACUUOI267D2EMaOEIkSPvgl5
	 SUVdfHnFJWs+NG2zBPYOIziVtJVfgvGPXs48TlkpnaJGZhNj+OHF+KyL+L023o0Th8
	 jiKC5lsl2kHy+DBKaGRz09/SNXXM1HBfEmlwtPA8o2Jfp3447Nq+r1jO/TtlFhqHNV
	 dpJC/uGjDrkZbJJQqdjVmTwjK5VJ0mbmPfGMtQAPwTp9nxNgo0q6y2XNopD+EwSgWI
	 lfANwEySv2uhvVw+4zSr7BnKaS05JNObgVWp/IZnQnLNMYZvIc6aKR1tKcVelVILtV
	 ZeLn7gvd48W8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/28] perf timechart: Bounds check cpu_id and fix
 topology_map allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-27-acme@kernel.org>
References: <20260510033424.255812-27-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:43:16 +0000
Message-Id: <20260513234316.B2E81C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional ownership claim of backtrace strings in `process_sam=
ple_sched_switch` and `process_sample_sched_wakeup` causes memory leaks.
- [High] ABI mismatch in syscall tracepoint handlers causes Control-Flow In=
tegrity (CFI) crashes.
--

commit 310a44af966c165c046286e82f4de1ad3863786f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf timechart: Bounds check cpu_id and fix topology_map allocation

This commit introduces bounds checking for cpu_id in timechart tracepoint
handlers to prevent out-of-bounds array accesses on corrupted perf.data
files. It also changes the backtrace parameter in handlers to a double
pointer to fix ownership transfer and avoid memory leaks.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 40297f2dcd035..bccc48cfb99a1 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c

[ ... ]

> @@ -569,7 +570,7 @@ static const char *cat_backtrace(union perf_event *ev=
ent,
>  typedef int (*tracepoint_handler)(struct timechart *tchart,
>  				  struct evsel *evsel,
>  				  struct perf_sample *sample,
> -				  const char *backtrace);
> +				  const char **backtrace);

This isn't a bug introduced by this patch, but changing this typedef
signature highlights an existing ABI mismatch.

Many syscall handlers registered in the power_tracepoints array (such as
process_enter_read and process_exit_read) are defined to take only 3
arguments.

When process_sample_event() casts these functions to tracepoint_handler
and calls them with 4 arguments, could this trigger Control-Flow Integrity
(CFI) traps on modern builds due to the strict type violation on the
indirect function call?

[ ... ]

> @@ -628,13 +660,20 @@ static int
>  process_sample_sched_wakeup(struct timechart *tchart,
>  			    struct evsel *evsel,
>  			    struct perf_sample *sample,
> -			    const char *backtrace)
> +			    const char **backtrace)
>  {
>  	u8 flags  =3D evsel__intval(evsel, sample, "common_flags");
>  	int waker =3D evsel__intval(evsel, sample, "common_pid");
>  	int wakee =3D evsel__intval(evsel, sample, "pid");
> =20
> -	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, ba=
cktrace);
> +	/* sample->cpu used as index into topology_map[] during SVG generation =
*/
> +	if (sample->cpu >=3D tchart->numcpus) {
> +		tchart->nr_invalid_cpu++;
> +		return 0;
> +	}
> +
> +	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, *b=
acktrace);
> +	*backtrace =3D NULL;
>  	return 0;
>  }

Does unconditionally clearing the backtrace pointer here cause memory leaks
if the underlying functions do not actually consume the string?

If sched_wakeup() returns early on allocation failure without saving the
string, the backtrace is not stored. Because *backtrace is set to NULL
in this wrapper, the caller's free() becomes a no-op, and the unconsumed
backtrace string would be leaked.

> @@ -642,27 +681,41 @@ static int
>  process_sample_sched_switch(struct timechart *tchart,
>  			    struct evsel *evsel,
>  			    struct perf_sample *sample,
> -			    const char *backtrace)
> +			    const char **backtrace)
>  {
>  	int prev_pid   =3D evsel__intval(evsel, sample, "prev_pid");
>  	int next_pid   =3D evsel__intval(evsel, sample, "next_pid");
>  	u64 prev_state =3D evsel__intval(evsel, sample, "prev_state");
> =20
> +	/* sample->cpu used as index into topology_map[] during SVG generation =
*/
> +	if (sample->cpu >=3D tchart->numcpus) {
> +		tchart->nr_invalid_cpu++;
> +		return 0;
> +	}
> +
>  	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
> -		     prev_state, backtrace);
> +		     prev_state, *backtrace);
> +	*backtrace =3D NULL;
>  	return 0;
>  }

Similar to the issue above, does this cause a leak if sched_switch() ignores
the backtrace?

If sched_switch() ignores the backtrace because
prev_p->current->state =3D=3D TYPE_NONE, the string isn't consumed but the
pointer is still cleared here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D26
