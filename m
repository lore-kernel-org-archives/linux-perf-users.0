Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0431E848
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783668; cv=none; b=XwjNdBRFUMSqFna24L7s2d702C71VNAaaxBRY9x1P0Y1AuGaffUlAq8EvmMsJLT/IK/o+WeZutPDATELZUUTui65SMKyhhMaFetjU0M5TqR9wLsEkl1R5VogvgzEDE1/iEL3dzybqlHQhsD+DfJIWTXxsNaXi/jAb0EaayLs/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783668; c=relaxed/simple;
	bh=uDdFPgHm/1VtC95YiVCufr606OS7Hu8ivTZ8Oo4TPCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ikekL4nRLr8+mbkHsol+Ph9L5eQj9qvKQtaGERf6tG8EYj3pMD6Ni2m64dLh9GsPSegY5O0SfDfJiDCJWzzBd7ZUC7wI7wvCCtVbcxgoAyIR2B46+1Hc+4uv65KNGrcBsKWhm9OCUqc05PnAY3Ly2jbpveM44+hjEWBudd/8BjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr/V7QZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr/V7QZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7864C4CEF7;
	Fri, 10 Apr 2026 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783667;
	bh=uDdFPgHm/1VtC95YiVCufr606OS7Hu8ivTZ8Oo4TPCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cr/V7QZ8hgLTSpflaK559TFutu49uXwi5aUURaXg05KOW45JLXWKNklso6Y5e3xp5
	 sRLTv9VQJJ+l0C8u6x2irux31Y9Q0wGjGvldutst/MuWS+kZnUDz0rAmMsdDvWW4fG
	 1QfO8bQT8by7kTdmbEC2QEioTHhYIrq4UGx14mwOuZbrF5gcC+2QTNxJYDp/KGj9xz
	 z52fxPJhN91UBnJuJjhWT4ezHn6UDoqQjv3/cchpXvQ8GXcrJtzTEGpO+wDZkLsMIP
	 9o2Pxv7jLAixtd7oAiNG8FC6N0bHiYB2YWE1nteb0tm2ymrpVy3KtWp9Q+FBkEF1TA
	 TxdCajgkYZOZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] perf header: Sanity check HEADER_CPU_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-5-acme@kernel.org>
References: <20260410004000.148138-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 01:14:27 +0000
Message-Id: <20260410011427.C7864C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch introduces a deterministic NULL pointer dereference cras=
h on malformed inputs by incorrectly freeing `env->cpu`. The author changed=
 `return -1;` to `goto free_cpu;` (which calls `zfree(&env->cpu)`) under th=
e mistaken assumption that `env->cpu` was leaking.
--

commit 725d6d7d1ccd2df010084b584d9517330e1864ac
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_CPU_TOPOLOGY

This commit adds bounds checking for sibling counts against available
CPUs in the CPU topology header and attempts to prevent a perceived
leak of the env->cpu array on error paths.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 2d23dbc666b67..a7df8ed9a69e9 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -2866,6 +2871,12 @@ static int process_cpu_topology(struct feat_fd *ff=
, void *data __maybe_unused)
>  	if (do_read_u32(ff, &nr))
>  		goto free_cpu;
> =20
> +	if (nr > (u32)cpu_nr) {
> +		pr_err("Invalid HEADER_CPU_TOPOLOGY: nr_sibling_cores (%u) > nr_cpus_a=
vail (%d)\n",
> +		       nr, cpu_nr);
> +		goto free_cpu;
> +	}
> +

[ ... ]

>  error:
>  	strbuf_release(&sb);
>  	zfree(&str);
>  free_cpu:
>  	zfree(&env->cpu);
>  	return -1;
>  }

Does this zfree() cause a NULL pointer dereference regression on malformed
inputs?

When a parsing error occurs, env->cpu is freed and set to NULL. However,
perf_session__read_header() ignores the error returned by
perf_header__process_sections() and proceeds with the session.

If the session continues, tools like perf stat will later call functions
such as perf_env__get_socket_aggr_by_cpu(), which unconditionally
dereferences env->cpu[cpu.cpu].socket_id.

Was env->cpu actually leaking before this change? It appears to be safely
cleaned up during teardown by perf_env__exit() even if an error is
encountered here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D4
