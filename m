Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED947DD79
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055028; cv=none; b=lKn5dcILO7C5NKKd44qeJMh+1xuK5QDqMf9MhdT7MJqgT3BdtszStRsasKIYnOE3sb+frzFqlFMXXw7A1JHVEQnIAA0g39oay9VOyWk2r7jV0yKMYdjll5xrad/sm3K3NMjRqU7aM3ZCgK3vNCarf0xrZUokAOegejMZssSfbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055028; c=relaxed/simple;
	bh=L0YIYwGqu7V5ReYIuWrDleYFpCLt/m+WRmmr16jOwPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=laTdthFVoNEInhHrDdiEqcd6+rURqWTWD0jSetghKfpMygDl7YXUDM7fAQuMNTyll3Umgb5VWVWKpmQ7uOcWyjeMYq2iyxakGKO1L0NhHfx2JGshS+3Fn0ciKAgw4OpmqWs59LvIRTpwKvlaVPe+VWMpzAVgNGXO9Pzz0Vl5bEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEJ0kBN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEJ0kBN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BBD1F000E9;
	Tue, 14 Jul 2026 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784055025;
	bh=NpIFbZNIQVF+eUMI5vA3Pelm9dG0SvM2eZX+Sz/39Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bEJ0kBN10HKhwQP7rV2zh68XGXELiEPshWxhtWTZV34VdJPZNaFZa1TeydX16PlDw
	 8jJ4aNI3gnhj0NudCFM5oyeizwiCY12c4WzpHpxeQWZtSUPoykn04TxJzDU8duEVFs
	 JXND65M/k4GNSHHl+l9/oTSYNjBSQb+CXkDxYy4CcMhOfJu+s/cD2Z3MMAUFKZjGSH
	 StVwfZcieLidbfodXi9zapM7qxLyJN2YohBouPOutvO+9UhC+1p6N8QngnvVWekMc/
	 08GOtsAJ6TJ9FBr16yNAHBmYpQ9yTyGdO9vztcfx9wCMrkGKjKG6LiFEMK8FpAm7vs
	 Z8KqArFNQ9Ltg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] perf evsel: don't set PERF_SAMPLE_IP for
 unprivileged tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183150.292861-6-ashelat@redhat.com>
References: <20260714183150.292861-2-ashelat@redhat.com>
 <20260714183150.292861-6-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:50:25 +0000
Message-Id: <20260714185025.A2BBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch erroneously drops `PERF_SAMPLE_IP` for syscall tracepoin=
ts when run by unprivileged users, breaking userspace IP collection.
- [High] Uprobes silently lose `PERF_SAMPLE_IP` sampling for unprivileged u=
sers on builds without `libtraceevent`.
- [Low] Using the `__probe_ip` and `__probe_ret_ip` fields to uniquely iden=
tify uprobes is factually incorrect and misidentifies ftrace-based kprobes.
--

--- Patch [4]: [PATCH v5 4/5] perf evsel: don't set PERF_SAMPLE_IP for unpr=
ivileged tracepoints ---
commit c869f5208b9d673450d03276805401f2ff1e6af2
Author: Anubhav Shelat <ashelat@redhat.com>

perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints

For tracepoint events the IP is a static kernel address.
It doesn't vary by sample and provides no useful information for
unprivileged users. Skipping setting PERF_SAMPLE_IP for unprivileged
tracepoints avoids exposing a kernel address that reveals the KASLR base
offset.

Make an exception for uprobes, which are registered as
PERF_TYPE_TRACEPOINT, because the IP is important for their
functionality and is a safe userspace address. Detect them with
__probe_ip (entry) and __probe_ret_ip (return) using evsel__field().

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ea9fa04429f08..1d85e5503cf3d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1571,7 +1571,19 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  	attr->write_backward =3D opts->overwrite ? 1 : 0;
>  	attr->read_format   =3D PERF_FORMAT_LOST;
> =20
> -	evsel__set_sample_bit(evsel, IP);
> +	/*
> +	 * Don't set PERF_SAMPLE_IP for unprivileged kernel tracepoints to
> +	 * avoid exposing kernel addresses. Uprobes expose only userspace
> +	 * addresses so they're safe. Detect both entry and return uprobes.
> +	 */
> +	if (attr->type !=3D PERF_TYPE_TRACEPOINT || perf_event_paranoid_check(1)

[Severity: High]
Does this logic mistakenly strip the PERF_SAMPLE_IP bit for syscall
tracepoints when tracing as an unprivileged user?

Syscall tracepoints carry the TRACE_EVENT_FL_CAP_ANY flag, which explicitly
permits unprivileged access. When a syscall tracepoint fires, the kernel
passes the user-space pt_regs context to perf_instruction_pointer(), so
PERF_SAMPLE_IP safely reports the dynamic user-space address of the syscall
instruction rather than a sensitive kernel address.

> +#ifdef HAVE_LIBTRACEEVENT
> +	    || evsel__field(evsel, "__probe_ip")
> +	    || evsel__field(evsel, "__probe_ret_ip")
> +#endif

[Severity: High]
Could gating these checks behind HAVE_LIBTRACEEVENT cause unprivileged
uprobes to silently lose their IP data on builds where libtraceevent is
omitted?

Without the optional library, these checks will not be evaluated, and the
uprobe exemption fails. Uprobes would then be treated like regular kernel
tracepoints and stripped of PERF_SAMPLE_IP.

[Severity: Low]
Additionally, do the __probe_ip and __probe_ret_ip fields uniquely identify
uprobes?

Ftrace-based kprobes and kretprobes contain the exact same format fields in
their definitions. While unprivileged users are blocked from opening kprobes
by the kernel core (via perf_allow_tracepoint() returning -EPERM), this
heuristic still mistakenly categorizes kprobes as userspace uprobes.

> +	    )
> +		evsel__set_sample_bit(evsel, IP);
> +
>  	evsel__set_sample_bit(evsel, TID);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714183150.2928=
61-2-ashelat@redhat.com?part=3D4
