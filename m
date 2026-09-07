Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86944B67E
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746720; cv=none; b=aN5QbNAoIUIaDIO01MupoALH54Dq87gj2rNsj+beiCCofyJJVug4fM+4lqyQaSYjYfgYHT8ZpMDNmox+t+bwzYHanj/ITmPvqasc1OqbqI6t4SvZ3hx4DdoDR48Qcqz4do57KhrGsVGDadQAotjt/FecZCAq5miY4owbPDEc2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746720; c=relaxed/simple;
	bh=aliZCMk+ybBprMmJRV/1iYxMBgHfiHHLnURJ9aP6+Mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oNSy23RQCHYwnmxbKN935+u+StVVMllVdb5DmIlIdefvJ/Kdc8LvUZmDPOqVuXu7o4Ir7dV9q5/Otij5BWTcRLbZSQvnvlErfOjqa/e51y9e9B0qn3iu5sbxvQRsxXXHj8YqwFlw/I0Lxr9QHvMz2E1p89AFimEuZ3I7tsanjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzPT2v1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzPT2v1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2678C1F00A3A;
	Mon,  7 Sep 2026 02:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746716;
	bh=MpsvgQWDkyr+28UAR6xIIPLxp/5JU0w+biEzDWkEXn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzPT2v1GgwUYFY8a5eKCAUvi6U3kpMASgKlD2q5kUAW4U8F1F2lr4qaB+iA3RQ6/j
	 zPNUz8zJ5mIdw5EOV6MSOpBP0GotNA5lOnXfEisy3CuDEOAUbZgFJ/v05HzdZRMsZU
	 ynVIohVPlIwIaCrPo3dJrIeDHJa3MgVcf0sjTml6g86CzZJpKZQARDIgMJycJXlism
	 SRpYpUHrmHFPEF4SGiXQVvt+Jndth2oZzsSczjmCPzSpNjzbbL54g0mqhGAZMxhjvD
	 zot5ouyujIbSVe9sb1jKg5eVi33iJTRyfnwrSyUpMuUcOotuJWSCK2KVF4Eanv9hUD
	 c7J2IouNfaY9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 perf-tools-next 4/6] perf trace beauty: Validate
 payload size in augmented timespec beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907015140.363076-5-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
 <20260907015140.363076-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:05:15 +0000
Message-Id: <20260907020516.2678C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Validation logic relies on the host's native `struct timespec` l=
ayout instead of dynamically querying the trace environment, breaking cross=
-platform analysis.
- [Medium] Validation relies on an uninitialized/stale field from the BPF t=
racer, silently breaking timespec formatting.
--

commit 8e3c4b6ee60070e35799a1584520842d1e0f8b14
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace beauty: Validate payload size in augmented timespec beautifier

This commit adds bounds checking to the augmented timespec beautifier in pe=
rf=20
trace to prevent reading past the end of the payload buffer for malformed o=
r=20
truncated perf.data records.

> diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty=
/timespec.c
> index b14ab72a2738e..fad503bd953a6 100644
> --- a/tools/perf/trace/beauty/timespec.c
> +++ b/tools/perf/trace/beauty/timespec.c
> @@ -7,15 +7,28 @@
> =20
>  static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_a=
rg *arg, char *bf, size_t size)
>  {
> -	struct timespec *ts =3D (struct timespec *)arg->augmented.args->value;
> +	struct augmented_arg *augmented_arg =3D arg->augmented.args;
> +	struct timespec *ts;
> =20
> +	if (arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return 0;
> +
> +	if (augmented_arg->size < (int)sizeof(*ts) ||
> +	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_=
arg))
> +		return 0;

[Severity: Medium]
Does this validation break cross-architecture trace analysis? The check
relies strictly on the host's sizeof(*ts), which evaluates to 16 on a
64-bit host. If a perf.data file recorded on a 32-bit architecture is
analyzed here, wouldn't the tracee's valid, smaller payload be incorrectly
rejected by this bounds check?

[Severity: Medium]
Can this bounds check fail randomly due to uninitialized data from the
eBPF tracer? Looking at the eBPF side in sys_enter_clock_nanosleep:

tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:sys_enter_clock_nanos=
leep() {
    ...
    bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
    return augmented__output(args, augmented_args, len + size);
}

The eBPF tracer does not appear to initialize augmented_args->arg.size.
Since the augmented_args_tmp per-CPU array is reused across tracepoints,
if a prior syscall (like open) set the size to a path length, wouldn't
the new check here read that stale size and reject valid payloads?

> +
> +	ts =3D (struct timespec *)augmented_arg->value;
>  	return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" PRIu64=
 " }", ts->tv_sec, ts->tv_nsec);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907015140.3630=
76-1-atomlin@atomlin.com?part=3D4
