Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BE3914F8
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689988; cv=none; b=K0pDunmud4t/IsgSpW58qyLwBGL3804xA1HF9Rss8zEEwMqPt/6faiza5HsT6OvaBDnZxVFFTPoilHRkUAENom+VmrF4k8xd98oJxAY7Jxa+cuTjlT4D75ucYXHRPZWrZj+bZDO/sk1Z89MmXOF14VrfbkMa62pQh8n/cJ5cOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689988; c=relaxed/simple;
	bh=7MwvH+qKTpDcPI/6XZXKHWlw2ZBzW9V4LRcAsGRzpFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bp5udZ6e5Sc2WjDaTklJU1iW8S0hZt46MAbqtrcNrfA5FC3q3ST1J8P9XxSDvTyc7ds51ccAA93HzhiduO570kMtMT1MEv/n4vYi0gvaomuAGLpzzjTKnRn7/r5eek+D/7cIgQl8Qw1hNfQ8FAD4hfnsYJ/D/6EAoQso7gb3mnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS+xOazg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS+xOazg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4EA1F00893;
	Fri,  5 Jun 2026 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780689987;
	bh=oHBT7/pelCcO5FEgTB8J5qDYB51FaBkETyuVgDoGzhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MS+xOazgimuBr5qWP4k2WfigaIjhwa0OxoTwxgeV7hwLcg4hNzM4fQ7bJdt5/pIur
	 ssUS8Hw/22FOEAdBQLL5nkUQGxQFELPbUlpolBdL+TfdokReG/gV4Dc0LrGGzPLcF7
	 a+m2CWAPYkrkFLNfpWnBIY+33DwglAJMIz5cnWycPLqV4Py/BJ/SjU+SCvE4K4ZQK2
	 VvlKXjirCCVSlHWJipy5TF6I7Z1OsU3ZFhVB1sNb1dV45MfgRNPpkJp0lYzQAB30V3
	 mY+ecEufdDu1T78yBAVb+vGWp+zBQS7iK4tfsIel2ZNT3lHlcK7DE03qxyI0TaINHB
	 RhlqSAJ6nAPeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605194851.2533568-3-irogers@google.com>
References: <20260605194851.2533568-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:06:26 +0000
Message-Id: <20260605200627.0F4EA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling `perf_env__kernel_is_64_bit()` with a NULL `env` pointer=
 in `aslr_tool__findnew_mapping()` causes an immediate crash when processin=
g mmap events.
--

commit 8bfb4707677f93e242641f872dc50c16c412d50e
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

This patch adds an --aslr option to perf inject to remap virtual addresses
and drop data/events to prevent leaking ASLR information. It implements
remapping and tracking for metadata events.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..5a002dcecb8f1
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
> +				      struct thread *aslr_thread,
> +				      u8 cpumode, u64 start,
> +				      u64 len, u64 pgoff)
> +{
[ ... ]
> +	} else {
> +		/* First address of the process, allocate key and first top address. */
> +		struct top_addresses_key *tk;
> +		struct process_top_address *top_val;
> +		struct machine *machine =3D remap_key.machine;
> +		struct perf_env *env =3D machine ? machine->env : NULL;
> +		u64 kernel_start_addr =3D perf_env__kernel_is_64_bit(env) ?
> +					kernel_space_start_64 : kernel_space_start_32;

[Severity: Medium]
Will this crash if env is NULL?

If machine->env is NULL, env is assigned NULL. Passing it to
perf_env__kernel_is_64_bit() will unconditionally dereference it:

tools/perf/util/env.c:perf_env__kernel_is_64_bit() {
	if (env->kernel_is_64_bit =3D=3D -1)
		perf_env__init_kernel_mode(env);
	...
}

Because machines__init() leaves the host machine's env pointer as NULL,
could this cause a segmentation fault when processing the first mapped even=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605194851.2533=
568-1-irogers@google.com?part=3D2
