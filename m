Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D35678C4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188226; cv=none; b=rNNUKgKWmg/rp8g2t5N4CnwDWhtKP/7Sae8874erNj59nmJSaR7f1YAJvPqd87pLYi++bPxYZES0umbIMCEEQLvRMd8FBf/VCzzqeKQApumhaOUBvaAVyjdXyd/uKkiQfUe3BTfMQMk7hMa5yfQ1JqXm87jsbgVCDPcuQx2Yhps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188226; c=relaxed/simple;
	bh=YJBTxD4M/t0LA7TtYdrenZFNsfNF38/SYvU7HWdDCfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/wVa21sgUwHjrIyTND9eZM4WjrcfE32d2xyeQjg2TBTbqMVYF60bFhOaDuKaJTqZHGXG2Lqrp+EGZU+bvzdK+mKtLjxmounQh3K6tZqze9tJUY6954dK6/UGD1cb4+uQZl7W9bk37Xu0LKvWskvgdrXtPbAbg6BDes06XFJjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niWAMqoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niWAMqoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDA01F0089A;
	Wed, 23 Sep 2026 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188223;
	bh=Qf4Trmf+ik7JArTNfEDS56PC8QbQwX0Rm0vkvZAP2BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niWAMqojUeAYC0IwQ9JNKtGNT6Erg2RRiKwu3+QzeOi/110dizygEFwz2P7N+E/V9
	 jTbiDJyWM6KfK2khCuIpLFqjn89KczHVelsfYClRz4MlQUts1Tg2yAy7M68/uXoYY6
	 JY9Kv7/u9E1ncf0QgUrd9EqsWLUFYkHamH/YLDipO40KvEDRHgKDzqyAAI9fzwYxsT
	 opj9RB6COX3C92HQKh2BfnInj2KcaPZ6eVthmeXbi2IgAVYbh4JAZd9gUMOz388HUG
	 3jPMbNBNkuhNXz2YZE9EQxCNW9FUxFmA8U7IQ2r86O7HDsgwSA1GOnGnlfFCU/RWil
	 WV8YihIIGnkYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/49] perf python: Port stackcollapse to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-19-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:30:22 +0000
Message-Id: <20260923183022.EFDA01F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D18

