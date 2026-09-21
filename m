Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB632D8796
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968750; cv=none; b=aJYg8Km+q4vMcFBRKaN5e13mkie4v1ci9JFA3/4Ngp6ZpVVPs/0TE3OGkDC2iWjh6wL89g3CiwkioyNucdMvke3bzSATGKprSO7syvuTEumo2LS4+NvAzj/T0H8MZdPKA0hP93MKS9648KZ+Ss521t1vF56dkum3KIagykLdlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968750; c=relaxed/simple;
	bh=dbliI0HBRGIwKsyhM6KL/CSXVvERgEo7FM+KhT4+G34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CJXM7rt1vHvDLy04kqw5CD7Vcrd/vO1Fbw4NqnDnR5THAcjdoWOO0RVRIZ/H6kpmck2IhW97LLzTYfvx21ehie19XCR1MZy3+OPgFoauA9bucm9zWul3hVvejiDlAVwXl3QgYMfxpXjRhdQpsh8uI0OdlhpPHcSyUgoChgyxIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijL8ahaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijL8ahaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FACF1F000FF;
	Mon, 21 Sep 2026 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968748;
	bh=MdIbinavMIO74tKjn9ugyxhQmc0hADgk3Oaj5qAxQJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijL8ahaq2bu1CCMOwpjFWeNzIc0lfSUHSih+IrGViArPem0kRxrPHeXL1heASKIhk
	 ThJ/6Xs5mFJY3a4S/t/J+78KcVDTz4/OiGIhK7EI8ie9MHdri1+WqatLqj91GajJRH
	 /uGUvm29M9wYOUHCnV1KjRhmeUDYZvVfAEiYBsECvZ6NTOI103dy9fVolgNSY89Bcc
	 mjWiZd15CAxIa37PwAmyeZMJKtjMZApxKC54FpB3KQGSQHyLGFU5jwW6Vksi7fV/x9
	 d3Vo12qZMG5IKwwof/37wEBZTd7OdNmcsFrrzgEffkxPYv6KkfBso8vkdxp5rmJlFd
	 Z/T3LX1aPrO1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/49] perf python: Port stackcollapse to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b37da28d0a8a995bb2f30fdb2d9fb5a462494073.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <b37da28d0a8a995bb2f30fdb2d9fb5a462494073.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:32:28 +0000
Message-Id: <20260921053228.9FACF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port stackcollapse.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/ refactored into a StackCollapseAnalyzer
> class.
>=20
> Improvements compared to the legacy script:
> - Traverse sample.callchain directly from perf.session without
>   allocating per-event dictionaries, and fall back to sample.symbol when
>   a sample has no callchain.
> - Replace deprecated optparse with argparse, adding -i/--input alongside
>   --include-tid, --include-pid, --no-comm, --tidy-java, and --kernel.
> - Handle BrokenPipeError cleanly when output is piped into downstream
>   tools (such as head or flamegraph.pl).
>=20
> Add a shell test (test_stackcollapse_python.sh) using a CPU workload
> (perf test -w noploop) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D18

