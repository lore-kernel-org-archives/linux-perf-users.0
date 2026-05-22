Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF934EF05
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490422; cv=none; b=P6PReH71fMn+IcYKUM4n0XiuLskdQRa10XgqZyUY2sOTORXyQGKE66oYz0VBiwUPj1VYx2SiJa8yAS8twt6LGWsqQ1IuHhag23dAAeiA/KSCiIsuONTLAEIqhU3DNA/mLkLyKFEwZhT2LuC/puf46FPUqVEBrlF1f2285dWBSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490422; c=relaxed/simple;
	bh=T96Xuxw3hLzu0ccckEW3zFWJKNL8HEH1HeGLU+x45zU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LALPqQ5jA1Gp7HrffxPSiM291OOfMQOHvDKm9QDsUbGLhTaKNItT3aifNgL/5kZFov3LmL+VC8bYeZ9q0jjXXtIiTGUhhzoK8R7F36F5ZA+bttyrvCTQk8SGuHLBcLXvdND3489/aDiSFfoEYunCMfosc98KkZEAZqh+Ne5Hxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPE7FUz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPE7FUz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652B61F000E9;
	Fri, 22 May 2026 22:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490421;
	bh=cBnNiTYGmyJjopdef8ZaQ5cxxThFFQ8KvCaHtyof9bU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPE7FUz5qKlembWG5tg2v45yJVLChaQfxT1JzGXle9r6nDWCCgyAVe/X/F1oyj7R1
	 PbJvnLF3pKIGJN5qf8pQLylx7qgzwM81dc58B1GLqovLooUL2afmTbezqB8Tb54R1S
	 bmRwxV0Y/DJ657XDMcDFibZVN3/q1MCXC00kAyq6GtWxA3mNqc+u0TE+Ka88YzRBca
	 lUkjWRqLAl2MCCu2iISAVhPZ1CsomRFKyIaf7LZhTYg5mwidJWx7UgynMMW7dU2fnE
	 tSrn54+CwOREkm+sK1EvQ9P5CXVYG8ov6y8kgsMZX3MqYt+cGhryFJlQa9HOcAW7wI
	 qHG4LtuBejsvA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 11/14] perf stat: Extend JSON output linter to
 test core aggregation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-12-irogers@google.com>
References: <20260522223342.2393553-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:53:40 +0000
Message-Id: <20260522225341.652B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Reusing the same test functions for the `--new` API pass results in=
 indistinguishable log messages, making debugging difficult.
--

commit 757070262571c3df3509bd31055f9fb6103f0ded
Author: Ian Rogers <irogers@google.com>

perf stat: Extend JSON output linter to test core aggregation checks

This commit extends the stat+json_output.sh script to test core aggregation
checks using the new JSON print API. It introduces a perf_new_opt variable
and runs the existing checking functions a second time with the --new flag
to validate the zero-allocation print callbacks.

> diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/test=
s/shell/stat+json_output.sh
> --- a/tools/perf/tests/shell/stat+json_output.sh
> +++ b/tools/perf/tests/shell/stat+json_output.sh
[ ... ]
> @@ -36,7 +37,7 @@ function ParanoidAndNotRoot()
>  check_no_args()
>  {
>  	echo -n "Checking json output: no args "
> -	perf stat -j -o "${stat_output}" true
> +	perf stat -j $perf_new_opt -o "${stat_output}" true
>  	$PYTHON $pythonchecker --no-args --file "${stat_output}"
>  	echo "[Success]"
>  }
[ ... ]
> @@ -232,5 +233,21 @@ then
>  else
>  	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die =
and per_socket since socket id exposed via topology is invalid"
>  fi
> +# Run New API JSON basic and standard aggregation checks
> +perf_new_opt=3D"--new"
> +check_no_args

[Severity: Low]
Does reusing the same test functions for the --new API pass result in
indistinguishable log messages?

The status output (e.g., echo -n "Checking json output: no args ") is
hardcoded in the functions and does not print the perf_new_opt value.
This means the test log will contain duplicate identical lines for the
two passes.

Could this make it difficult to determine which API mode failed during
automated testing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D11
