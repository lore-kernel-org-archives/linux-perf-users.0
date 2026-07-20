Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316B2F12AC
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546163; cv=none; b=n4Ilkqx60qYfilkIf1Z+MIzb7h7EsFX7idzkejyYWgPsCEYwstfMBIxH5HudSy3zGR9zGJRbpeZVncwwGldsOCp28DwVwz8RG3Drxhh5/3ecRJY9TxtaxtaQFDvcIKXIFiWf7FNYretplH6DcbJaO/Iy0eo1x+W3qYandIFcA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546163; c=relaxed/simple;
	bh=iovoVHjujZqOc6AcRTwI8lu6HHBqYaqGHLVnoc2xxwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iOoD0WwsNTMvN8YZH8jw+XjKUhMUHlj3sQyTwi/eUtyhLwObKRw3oMmIaETb9y7+Qvj+wD0+2NH88Unlp20+dFgaR9l+jmH/8nVyk1dNDabJdSthJuRvbc4ISlk4kI5GzJ/mMhDunvm7BNQiikm/cytNLx1PjKxTyPf6YGhZXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpIoE9KH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpIoE9KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9411F00A3A;
	Mon, 20 Jul 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546161;
	bh=FIXzcITnOmkkcCXuly7j7dXAD3xs1LgeQN12vEjlvpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpIoE9KH9axbkpiHd8/Y++Rctwwgv0PAhM+JJJe880E01VlH/U9igAddSHpf3DUZz
	 IaiM8wCjbkJiNcirA425QlPMAcBM0cmuHFrx0/zENUVT1AoCH2YvtQ7i+fgjdMDCGP
	 AVmvGIZ7bv0+r3bAgl6yOzI+tLkHEqxh0PTq1bZxPRiRM0zvOTw77Eu8xEMQdGu+H+
	 GCLCSGxFuFG5k2GEJCOcc8OCeg01OGCmjf7VKg7qO2rQ1tvD4PWFEQS9Yxb5LyHVGi
	 FUxhArdM8wPK5MrF5ZbkvFqHU/CDguQfZDMUFMPaISTybSi4W1kngh8Pq4cCNrn/YI
	 rQH4G4zzOrIHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/6] tools/perf: Add arch hook to drain remaining
 data before event close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720105218.14277-4-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:16:01 +0000
Message-Id: <20260720111601.BD9411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] `record__final_data()` fails to drain architecture-specific data=
 and falsely aborts in parallel trace streaming mode due to incorrect byte =
tracking and thread-local mmap limitations.
- [Medium] The final data drain hook is completely bypassed on normal exit =
if the normal event ring buffer is empty when the termination signal is eva=
luated.
- [Medium] The final data drain loop aborts on the first empty read pass, f=
ailing to wait for asynchronous PMU data to arrive.
- [Medium] The force-abort mechanism `if (done > 1)` inside `record__final_=
data()` is mathematically impossible and will never successfully abort a st=
uck drain loop.
--

--- Patch [3]: [PATCH V2 3/6] tools/perf: Add arch hook to drain remaining =
data before event close ---
commit 912498764cf4d44940ef92ba0d9b5b3fa62c31b4
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add arch hook to drain remaining data before event close

This patch adds a weak architecture hook to allow collecting remaining
PMU-specific data before events are disabled and closed. It introduces
a loop in the record command to perform additional read passes when the
architecture reports pending data.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
[ ... ]
> @@ -2425,6 +2425,45 @@ static unsigned long record__waking(struct record =
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
> +	/*
> +	 * Collect any remaining architecture-specific data.
> +	 * The arch code checks if more data exists, and we do the actual
> +	 * reading here since we have access to record__mmap_read_all().
> +	 * This code performs the additional read pass while events are
> +	 * still live.
> +	 */
> +	while (arch_perf_record__need_read(rec->evlist)) {
> +		/* If user presses Ctrl+C again during draining, abort cleanly */
> +		if (done > 1)
> +			break;

[Severity: Medium]
Is it possible for this abort condition to trigger? Looking at sig_handler()
for SIGINT, the variable done is set to 1 directly:

sig_handler() {
    ...
    done =3D 1;
    ...
}

Since done is never incremented, could this block of code fail to force-abo=
rt
if the PMU gets stuck during the drain?

> +
> +		last_bytes_written =3D rec->bytes_written;
> +
> +		if (record__mmap_read_all(rec, true) < 0)
> +			break;
> +
> +		if (rec->bytes_written =3D=3D last_bytes_written) {
> +			pr_warning("Final data drain made no forward progress.\n");
> +			break;
> +		}

[Severity: Medium]
Does this check properly account for multithreaded mode? In parallel trace
streaming mode, worker threads maintain their own mmaps, write to their own
files, and increment rec->thread_bytes_written instead of rec->bytes_writte=
n.
Additionally, when record__mmap_read_all() is invoked from the main thread,
it only drains mmaps assigned to the main thread. Will this cause the loop
to abort prematurely with a false warning when running with multiple thread=
s?

Also, if the first non-blocking read pass yields no data because the hardwa=
re
needs a moment to flush asynchronous data, the loop breaks immediately here.
Does this bypass the usleep(100) and defeat the purpose of waiting for the
pending data?

> +		usleep(100);
> +	}
> +}
> +
[ ... ]
> @@ -2845,6 +2885,11 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>  			done =3D 1;
>  		}
> =20
> +		if (done && !disabled && !final_data_drained) {
> +			record__final_data(rec);
> +			final_data_drained =3D true;
> +		}
> +
>  		/*
>  		 * When perf is starting the traced process, at the end events
>  		 * die with the process and we wait for that. Thus no need to

[Severity: Medium]
If done is set to 1 by a termination signal (like SIGINT) and the subsequent
read pass yields no normal events, will we ever reach this newly added code?

Looking earlier in the polling loop of __cmd_record():

    if (hits =3D=3D thread->samples) {
        if (done || draining)
            break;
        ...

The break statement exits the loop completely. Does this mean that for
low-frequency workloads, if the ring buffer happens to be empty when the
signal is evaluated, the final data drain hook is completely bypassed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720105218.1427=
7-1-atrajeev@linux.ibm.com?part=3D3
