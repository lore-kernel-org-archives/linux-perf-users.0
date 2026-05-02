Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BA19005E
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705891; cv=none; b=PmQPY5ThRAi4wArz1kGSQ+//hwgDX9kPlV/AtdURvtZDJ6gCEsiqssHZXcKx8/j+tTtPK/VqexlyxEs419iIoCCVsi4nwQiOBgu7sXEKFBbJJDdN4Ta2jzAZFE6C4eV6MMvcHvknJzr7OdaxnGzrHrr60NJX//t2Aj3Hy0TXQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705891; c=relaxed/simple;
	bh=luBzAD/YDLMY5eCIIL530HT7zo3KUem7vEKa2XLDZCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bn566WVmK4WH3q3qR8PCvZSzs2tjHxegmjIXc45ElHtFzZYnWNckbfTmUEwc6Jt59l+DHyxgb8W8AZgrHWPe2oi0pfap9vdBsZENXN6OiXScGMI+nN9GmZymkmgqqWhIt8LR43BAlkMUaWW5dU7ECiR5DvThvzuSeDWuWZuUpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rndsVCC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rndsVCC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CF6C19425;
	Sat,  2 May 2026 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777705890;
	bh=luBzAD/YDLMY5eCIIL530HT7zo3KUem7vEKa2XLDZCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rndsVCC+3Bxs2qhXhNXwjsWshq2LEH2W0MU2xtuRCbLUaBD9VGhloKDL6niWvsQfO
	 vyKP0PsSOEXeueTyP51AjlbHajK1y5TpBpldmmjM7ej8Ji6qY/Wpgf2dS7mVqe8Y8D
	 zqocBBv9NSif3lChFSDr7XvFOYT3gTlHKkYR7phgZ5+UeI65XUFHbIl297JG9uVXbi
	 /+g3PJZo+YRP1W4UiLoUk1ZE6UklJWrsgZ9D8kzV93zVYJmMoHMAu8bwXbCIQIetNB
	 DFE0PvmZpQi8YOPIQfugT5L93oIb5biwL9oocoVPaa/NPpMVQYo8wk9fCC4Mp7AahR
	 AKaKLMxNucgYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/17] perf machine: Use perf_env e_machine rather
 than arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-6-irogers@google.com>
References: <20260502065935.291960-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:11:30 +0000
Message-Id: <20260502071130.B2CF6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit changes the visibility and signature of `machine__is()` =
(making it static and changing its second parameter from `const char *` to =
`uint16_t e_machine`), but fails to update callers in `tools/perf/util/symb=
ol.c` (which still pass a string like `"x86_64"`), causing a build breakage.
--

commit 43e3a53fa61bf39d387266ed813f417208baa8e5
Author: Ian Rogers <irogers@google.com>

perf machine: Use perf_env e_machine rather than arch

This commit modifies machine__is to use ELF machine constant comparisons
instead of string comparisons and reduces its scope by making it static. It
updates callers within machine.c.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
[ ... ]
> @@ -1611,10 +1611,15 @@ static bool machine__uses_kcore(struct machine *m=
achine)
>  	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL)=
 !=3D 0 ? true : false;
>  }
> =20
> +static bool machine__is(struct machine *machine, uint16_t e_machine)
> +{
> +	return machine && perf_env__e_machine(machine->env, NULL) =3D=3D e_mach=
ine;
> +}
> +

Does changing machine__is() to be static and altering its signature break
the build?

It appears callers in tools/perf/util/symbol.c still pass a string
argument like "x86_64" to this function.

I notice this is addressed later in the series by commit ae1a01cb2104
(perf symbol: Avoid use of machine__is), but leaving this intermediate
state might cause bisection failures.

[ ... ]
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -227,8 +227,6 @@ static inline bool machine__is_host(struct machine *m=
achine)
>  }
> =20
>  bool machine__is_lock_function(struct machine *machine, u64 addr);
> -bool machine__is(struct machine *machine, const char *arch);
> -bool machine__normalized_is(struct machine *machine, const char *arch);
>  int machine__nr_cpus_avail(struct machine *machine);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D5
