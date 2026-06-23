Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35588340286
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198781; cv=none; b=lyJJ8J085FzBYgfmcSUzkmeeJ9sPDAk4xhsL9MChjaxYtmvi8uN8+rdXz2zy9Z/EWnUufzhTxaBgcHj143MzZ5W4aOSMdUrZYcYsZD9qr9pkVtvIzJbvVFgCoQWnPVBBwiOTvgKKWzSO4T06afvEvp9vII3KVtUDmd02ZC46PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198781; c=relaxed/simple;
	bh=2lZ8uyfvnCaCUcbMe0Vs//HFtHMQRztBdB0Ve6CxZno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MfqdQiom7Fz771JdktQH8qOkWR1A9vXlaSLEf7v+lMaBTLm48MBTwDZlseuN+mYsiqBQKM5fakDBeWoI5a2B7EWZZFHomtqpf3u5WWwB3AE7dnSGyNpy49jusphMfdDYhZSpo8IguWOt51AWiKHkRTu/oHKBKwePMBzpbtlbnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSR/f/yE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSR/f/yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36A01F000E9;
	Tue, 23 Jun 2026 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198779;
	bh=qxLJ7+i9qxm4ttYN9D1voP3xyvVfET7FhNkGO2pcyp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSR/f/yEh7t6/ofgYf1DDdDJd+BrJij8AoAeQgSSCRBeheJWmKF+Rc1o9HSMUrUqD
	 JIOphl25utkU1wEi/eKio15nu6U5qxsOwjiU6be+HvlfP8pLr8xeG/acPEy8BHpOvJ
	 GpUKCIggoTYiQlAlufvieI1R9LvO8U80qaf75mZ+cy1C4rhihQF3C0ZDS27vuVmyDQ
	 ixChfv/GAg8RsX2CpDcG95FKKbEon7rCU8FrzeLyM8r1utQUUaqDoZeehPqlesIcPv
	 5ScWjA35bTV9eHsdD2uclHhVWRPhzl/AcBeofB3DequnQ3kshlDmJRQFNNlEaalRTt
	 e8bp4vsgRGB/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf kvm: Kill STRDUP_FAIL_EXIT()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623070313.55225-4-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:12:59 +0000
Message-Id: <20260623071259.C36A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Memory leak of dynamically allocated strings in PowerPC default =
arch events due to removal of array cleanup loops.

Pre-existing issues:
- [High] perf kvm record unconditionally crashes via BUG_ON() on non-Intel =
x86 hosts and architectures without default events.
--

commit d3c8251de71559c69211fb2d23ba99dd14669107
Author: Namhyung Kim <namhyung@kernel.org>

perf kvm: Kill STRDUP_FAIL_EXIT()

This commit removes the STRDUP_FAIL_EXIT macro and replaces dynamically
allocated copied strings with stack variables for passing command line
options. It also removes the cleanup loops that freed these string
copies, addressing a subtle double free issue.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index acc6f2a706b35..477c28915c037 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
[ ... ]
> @@ -2008,9 +2004,9 @@ static int __cmd_record(const char *file_name, int =
argc, const char **argv)
[ ... ]
>  	for (j =3D 1; j < argc; j++, i++)
> -		rec_argv[i] =3D STRDUP_FAIL_EXIT(argv[j]);
> +		rec_argv[i] =3D argv[j];
> =20
>  	BUG_ON(i !=3D rec_argc);

[Severity: High]
This is a pre-existing issue, but can this BUG_ON() crash the tool on
non-Intel x86 hosts or architectures without default events?

If need_arch_event is true but the architecture hook returns early without
adding events, rec_argc will be greater than the final value of i.

For example, in tools/perf/util/kvm-stat-arch/kvm-stat-x86.c:

__kvm_add_default_arch_event_x86() {
        if (!x86__is_intel_cpu())
                return 0;
        ...
}

On AMD hosts, this returns 0 without incrementing the argument count, leavi=
ng
i less than rec_argc and triggering the BUG_ON() assertion.

> =20
>  	ret =3D cmd_record(i, rec_argv);
> =20
>  EXIT:
> -	for (j =3D 0; j < i; j++)
> -		free((void *)rec_argv[j]);

[Severity: Medium]
Does removing this cleanup loop leak memory on PowerPC architectures?

While the central code now uses stack variables, the PowerPC architecture
hook still dynamically allocates its default events.=20

In tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c:

__kvm_add_default_arch_event_powerpc() {
        ...
        argv[j++] =3D strdup("-e");
        argv[j++] =3D strdup("trace_imc/trace_cycles/");
        ...
}

Since these strings are allocated with strdup() and the free() loops in
__cmd_record(), __cmd_top(), and kvm_events_record() have been removed,
will these strings leak during command execution?

>  	free(rec_argv);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623070313.5522=
5-1-namhyung@kernel.org?part=3D3
