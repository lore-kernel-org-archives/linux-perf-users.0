Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754FD531;
	Thu, 14 May 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802340; cv=none; b=YR5e6sH1/rbsA4xJhHrA3TOdqC56bN/RyBPELE9ob+sOYoHFggIvseA/KKvajmBb++ufvljUhi4vN8ATLW+j3K96G+1YZyja8anMbQiX8J3WHjUkX8kBnknkrxJgI4Ucu1belSBnFZZaHj6tQ+d+zBh5lFohkYz9uoRZNbnYz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802340; c=relaxed/simple;
	bh=f/cmPCaexxgWVsRlQPAE48N5w4cb86BUsvJZbzboy/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LsOVfPsVoRgPQevrUCVWbdzIrdq2PVpRGCxKlY7EBSO5Vg7MCocp69TkgpRs3tqaHGg/jwlyATueReOVeUaw+ZjsqxfJLkir6FjdLwUbtwAusoutcy//lq0E5HvsxEaHuVWPGO9MJl8rxhb/jSrauXRXtBKkVmHZ6nbVUY5flVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYujy4TE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYujy4TE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A755C2BCB3;
	Thu, 14 May 2026 23:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802338;
	bh=f/cmPCaexxgWVsRlQPAE48N5w4cb86BUsvJZbzboy/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dYujy4TEMuVc5rBfmiAUVyMzmPPhevW7zp1bikWBO2cFih+8H0bwP/rzJvVVTtTAj
	 Nn/kQ4i/Q0AiGJZwa2xxsPvD67jTqq0B5gJ8zBPb/oj7tLvt45j0h0aurAWddKfLso
	 qYBfkEOM7wW9hj63FAdQOqcYAQH0Cg4PAXHAR09u08c0rRdFPmAS0mpfb1YVdiEcft
	 fDwrlPbvKQby8xJvfrdHJhOgMnm6ixvcFVli9FW6hh+qh3OX6dVxIvErSHddCl8G/6
	 DIQdQuTLH68oNjaLsV9XRwohcT1JDtKlS6VvNoihvB6rHBNc1EuilhzGAbuO0sHL2X
	 4v9EF3/zWleMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/17] perf build: Pre-generate BPF skeleton tooling
 during umbrella prepare phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260514163409.927816-11-irogers@google.com>
References: <20260514163409.927816-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 23:45:37 +0000
Message-Id: <20260514234538.0A755C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `bpf-skel-prepare` target relies on an undefined variable `$=
(bpf_skel_deps)`, causing the pre-generation to be silently skipped and int=
roducing a parallel build race condition.
--

commit aa0df16c70b52c768c1153976cf365e149c64c2f
Author: Ian Rogers <irogers@google.com>

perf build: Pre-generate BPF skeleton tooling during umbrella prepare phase

This commit decouples BPF skeleton tooling generation by attaching a new
bpf-skel-prepare target to the umbrella prepare target. This is intended
to compile bpftool and dump vmlinux.h early to eliminate sub-make startup
bottlenecks.

> diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
> index 30924ad140c49..1fbd8dfefa5eb 100644
> --- a/tools/perf/bpf_skel.mak
> +++ b/tools/perf/bpf_skel.mak
> @@ -15,6 +15,10 @@ ifeq ($(CONFIG_PERF_BPF_SKEL),y)
>  BPFTOOL :=3D $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
>  VMLINUX_H :=3D $(SKEL_TOOL_OUT)/vmlinux.h
> =20
> +.PHONY: bpf-skel-prepare
> +bpf-skel-prepare: $(bpf_skel_deps)

Is $(bpf_skel_deps) defined anywhere?

It looks like this variable is never defined, meaning bpf-skel-prepare
evaluates with no prerequisites and executes as a no-op during the prepare
phase.

If bpftool and vmlinux.h are not pre-generated here, will concurrent
sub-makes that independently include bpf_skel.mak simultaneously attempt
to evaluate and build the missing $(BPFTOOL) dependency?

This could cause multiple independent Make instances to concurrently enter
../bpf/bpftool and write to the same output directories, leading to parallel
build corruption and failures.

> +	@:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514163409.9278=
16-1-irogers@google.com?part=3D10
