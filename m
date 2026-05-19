Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595C33344A
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169144; cv=none; b=dbD32XVlNTdBI30dsHfHmd1bfj8z7d1MCabFAaTi9MRMzs+BYgZ02OG+mnPG8Vk+T8NNqyg2ehx2MKQi2jfQRL6NNAjIEljBJMdxymo3d4n2povfQtv6aSbG8V1csGT46+MdLR8sB++e3e5Y8DKsRQzIFDu7tEZyezkvLaFWjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169144; c=relaxed/simple;
	bh=75Vdf6HvU3tbiAkemQbzpCESk0ikiRk1NQLD7QAo6nM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ru4gaOmhUyZQAfyRMfRMFw3s0Cyql+Kx6nSRJlsyN4gnBtBbe5r3sFiky3nAC28JwDzhO5uw/sRZaS0ne2sC9NdmVT6CQC1mvHRHRcn+P/U2VkevWzE2qQhm3BP1anXHHzljmjmgReGPW5bxeng7fZG85C7HuJ8Pluqjz98khCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8mW9V9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8mW9V9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1847C2BCB3;
	Tue, 19 May 2026 05:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169143;
	bh=75Vdf6HvU3tbiAkemQbzpCESk0ikiRk1NQLD7QAo6nM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O8mW9V9UNUKvoU5uooBHPUcb7iBBiBk21kYxDEXO5ohx3SCkd3UQLauwaMxRm8PYa
	 DSVbnQf3MobolGhBrVLkIkPtH7BySZhBWk049lV9NtOHLVXSn1tExYq33HXU6Rj2n2
	 RVH/Yeb1ePs29Jb7DxSAyzEsrN4tMyn1iVEhpkf+3Ks0v/PsKGPjGMm91hIpNaP+iu
	 ci6aY4bWiX4VPqtuwrethoEPSm5U4HzbM6eh+Sgw/HBg6iS4p1OsOLoK3kq0rMP27R
	 uZ7+ViNH0R5eX6cywygMvroHvuY5S+Rs4rzSJ8Bq1c8DE5ZvC8G1Ekyzhg0dcm6QK7
	 SEp3V6xYtxudQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf stat: Propagate supported flag to follower
 cgroup BPF events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519050150.3144907-2-irogers@google.com>
References: <20260519050150.3144907-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 05:39:03 +0000
Message-Id: <20260519053903.C1847C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a potential modulo by zero crash when compu=
ting `evsel->core.idx % num_events`.
--

commit d07a1cf9e5bf6b04df795e0b41782b1fa5a160cb
Author: Ian Rogers <irogers@google.com>

perf stat: Propagate supported flag to follower cgroup BPF events

When using BPF counters with cgroups, follower events are not opened, leavi=
ng
their supported flag as false and causing metric calculations to report nan.
This commit fixes the issue by propagating the supported flag from the lead=
er
events to the follower events.

> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_c=
ounter_cgroup.c
> index 519fee3dc3d03..dd1851634087e 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
[ ... ]
> @@ -186,6 +186,21 @@ static int bperf_load_program(struct evlist *evlist)
>  		i++;
>  	}
> =20
> +	/*
> +	 * Propagate supported flag from leaders to followers. Follower events
> +	 * are not opened, so their supported flag remains false.
> +	 */
> +	{
> +		struct evsel *leader;
> +		int num_events =3D evlist->core.nr_entries / nr_cgroups;
> +
> +		evlist__for_each_entry(evlist, evsel) {
> +			leader =3D evlist__find_evsel(evlist, evsel->core.idx % num_events);

Can num_events evaluate to 0 here and cause a modulo by zero exception?

If a user runs perf stat with a trailing comma in the cgroup list (e.g.,
perf stat --bpf-counters -e event1 -G cgrp1,), parse_cgroups() in
tools/perf/util/cgroup.c skips the empty string but still increments
nr_cgroups.

This results in nr_cgroups being greater than the number of events, making
evlist->core.nr_entries / nr_cgroups evaluate to 0.

While setup_rodata() called earlier contains a
BUG_ON(evlist_size % nr_cgroups !=3D 0) check, non-debug builds compile with
-DNDEBUG=3D1 by default, making BUG_ON a no-op. This allows execution to
reach this point and crash with a SIGFPE.

> +			if (leader)
> +				evsel->supported =3D leader->supported;
> +		}
> +	}
> +
>  	/*
>  	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
>  	 * whether the kernel support it

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519050150.3144=
907-1-irogers@google.com?part=3D1
