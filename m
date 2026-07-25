Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9830BF70
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964091; cv=none; b=Ej/qEDokSpBjJQIZ6s4CwMa2q96/HNWGBsaYCGDPTxdQckNEyDzPSIrdNeIuS9Mn5Y0m0p5BMqyPi4vGnsZOhN1IbYurJsqCuBB5CzPpH2clutkirUiFmmoxG1GOFLkRq/m/RP5EU1WCU4yOFgF0ueJBMWuK+oWWwzlpOyCD59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964091; c=relaxed/simple;
	bh=4+efOJ1kHSA5ZT9UKG3RzZvJ1GYRm5arFk0ShHyN2ZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmWyeokFWeBXAadLG1tGro8HAcjH/9d7rwIz59NtEqDNoRH95TSUmKl9yeQQ5q1UyHA0sI11xO86guM++93HNhy1yekXr8kcB0QvuKaoJGZEB9SG5+mUfpCH37V9l8P70tV6VwYgvVqTQR6t8R4gabBhrdhGAz56E9wqlzyWc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToCwc+XF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToCwc+XF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457301F000E9;
	Sat, 25 Jul 2026 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964089;
	bh=udbxouOg1L/Ev+gtJSiKSGGXymJUYcnEGwb46URA5jA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToCwc+XFcexSZnT5mvMF7hJJ4d8nmNiCu2wazGNvlwjyE3JflMu9EchGp3qDZsmOM
	 o1bCLubv6ktN56MISF1GqSvsYpEixO0Qudt9z8L1Equ9DgUu1uTFvQDHnKchI6SMLU
	 raHb0Tk8BwoEe/TiQwf4H7hx9T7zpYQZQU88UZXo7hecy/QkOIefqMhUSYSUKlGrjT
	 OvgFXHKGo9WNcd5bPIVQDGE2iBJFXbvaaMhVwfprRQHxrKabcl/VPWofe3ddrblk4T
	 RELHlWs0E2Iw9CorCz2ozINNW033AD9p6t+Y0evT1ABrojTPSIt77WZiYMbkzRT0C7
	 K+Q6AONYboYeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/6] tools/perf: Add arch hook to drain remaining
 data before event close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725070747.81435-4-atrajeev@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
 <20260725070747.81435-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:21:28 +0000
Message-Id: <20260725072129.457301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] SIGCHLD incorrectly aborts the final data drain loop, bypassing =
the intended double Ctrl+C behavior for child workloads.
- [Medium] Final data drain fails to read worker threads' mmaps when --thre=
ads is enabled.
--

--- Patch [3]: [PATCH V3 3/6] tools/perf: Add arch hook to drain remaining =
data before event close ---
commit ed7d9849ca86c7b6e1369882d695adbc00355511
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add arch hook to drain remaining data before event close

While collecting samples using perf record, __cmd_record() disables the evl=
ist
once recording is complete. After that, event fds are no longer read and any
remaining PMU-specific data cannot be drained. This patch adds a weak
arch_perf_record__need_read() hook so architecture code can indicate that
more data remains to be collected before events are disabled and closed.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..e158197c2d15c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -693,6 +694,8 @@ static void sig_handler(int sig)
>  	else
>  		signr =3D sig;
> =20
> +	if (done)
> +		drain_interrupted =3D 1;

[Severity: Medium]
Will this unconditionally set drain_interrupted when a child workload
terminates and sends SIGCHLD?

If running perf record on a child workload and interrupting it with a single
Ctrl+C, the child workload terminates and sends SIGCHLD. If done was already
set by the SIGINT, would this cause the single SIGCHLD to prematurely abort
the drain loop intended for double Ctrl+C?

>  	done =3D 1;
>  #ifdef HAVE_EVENTFD_SUPPORT
>  	if (done_fd >=3D 0) {

[ ... ]

> @@ -2425,6 +2428,54 @@ static unsigned long record__waking(struct record =
*rec)
>  	return waking;
>  }
> =20
> +/*
> + * Weak symbol - architecture can override to indicate if more
> + * data needs to be collected before finishing output.
> + *
> + * Returns: 1 if more data exists, 0 if collection is complete
> + */
> +__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unu=
sed)
> +{
> +	return 0;  /* Default: no arch-specific data to collect */
> +}
> +
> +static void record__final_data(struct record *rec)
> +{
> +	u64 last_bytes_written =3D 0;
> +	int retries =3D 0;
> +#define FINAL_DATA_MAX_RETRIES 20  /* 20 * 1 ms =3D 20 ms max wait */
> +
> +	/*
> +	 * Collect any remaining architecture-specific data.
> +	 * The arch code checks if more data exists, and we do the actual
> +	 * reading here since we have access to record__mmap_read_all().
> +	 * This code performs the additional read pass while events are
> +	 * still live.  A second SIGINT during drain sets drain_interrupted
> +	 * and aborts the loop immediately.
> +	 */
> +	while (arch_perf_record__need_read(rec->evlist)) {
> +		if (drain_interrupted)
> +			break;
> +
> +		last_bytes_written =3D record__bytes_written(rec);
> +
> +		if (record__mmap_read_all(rec, true) < 0)

[Severity: Medium]
When using the --threads option, will this fail to read worker threads' mma=
ps?

Looking at record__mmap_read_evlist(), the read target is mapped to
thread->maps (a __thread thread-local variable):

    nr_mmaps =3D thread->nr_mmaps;
    maps =3D overwrite ? thread->overwrite_maps : thread->maps;

Since record__final_data() is executed on the main thread, it seems it will
only access the main thread's mmaps and completely skip worker mmaps. Could
this lead to a 20ms spin loop and premature event disablement while worker
threads remain blocked in poll?

> +			break;
> +
> +		if (record__bytes_written(rec) =3D=3D last_bytes_written) {
> +			if (++retries >=3D FINAL_DATA_MAX_RETRIES) {
> +				pr_warning("Final data drain made no forward progress after %d retri=
es.\n",
> +					   FINAL_DATA_MAX_RETRIES);
> +				break;
> +			}
> +			usleep(1000); /* 1 ms: let AUX ring buffer consumer advance */
> +		} else {
> +			retries =3D 0;
> +			usleep(100);
> +		}
> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725070747.8143=
5-1-atrajeev@linux.ibm.com?part=3D3
