Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FC38DC54
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404460; cv=none; b=ZbMu/1MXslIOGrepdgne4ep5AhTok7gyJ0aQ7vgAJote+OZ3EBD6RRIrd4Z2XebDpLRw66tCPF3/MyAOKGpG+rxCIIxddi3f9o6yVxJoFYPkNc+ZYbxZiKDs2Gn/b6wuVangLFnJGVAQcmeT7Du1l6AFkdawKEForBdyHp23nz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404460; c=relaxed/simple;
	bh=8Vb5AOOJWXTY2FDc5naU3qycDJ8lnxD/yxiEeibQSNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UhRqftJaoEmcLeZEe10g3N9XOpibP3pmQlwHtHbbCXceTu0/wBev53KLciByArX/2eaxb3ugG15BfQXWzmlJsAQn9YxaZ7ungkT9o4F2LPREgiY4CkYd15RhXYvgDmLDb1rSxPVrxC04ozkL1mAdaTzKSWgvbf15CFG/XC1dCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moKcNzkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moKcNzkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8991F00893;
	Sat, 26 Sep 2026 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404459;
	bh=g/g6gT8YUFLhBGwHlvNkRDWTXKoRWiZf++QQ21DZFPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=moKcNzkN3FBfs/ngW3W3BL1Qht4+r6SRMAIaW0t0JqYLrSanccOX+XKWoSSrLMYrR
	 5AVUuWEEvDer4i2vNRXPcRVTWhrVXenuLI8IAmbAvRJ4oOGIdVmxrfOtqEP4Ppjo0w
	 w8Ow2e0lp6mVILktVZmCjzgwktPNras+9a4RNvooPOvZYwWtnUC0zZt0kSmGYS68eA
	 t1xQleXCh7aEDNpC+WBNIR4qDw59fkkxy/Mpz5XrF2G8LrZpo2X46+DTAxq4bpc57I
	 bvQZMbwR/F9QeEOcs2RPysoyHOqLPSNkqgeSJPpvQgh5AC3mOnhljzqw1Yz8cMm3cn
	 hC4+i7yjkyu1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 36/49] perf python: Port netdev-times to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-37-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:34:18 +0000
Message-Id: <20260926063418.CE8991F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port netdev-times.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a NetDevTimesAnalyzer class with full type
>   annotations to encapsulate state.
> - Collect events via perf.session and sort them in timestamp order
>   before analysis so multi-CPU TX and RX packet timelines are
>   reconstructed deterministically.
> - Replace custom argument parsing with argparse (-i/--input, --tx,
>   --rx, --dev, --debug), extract tracepoint fields directly from sample
>   attributes, and remove Python 2 compatibility artifacts.
>=20
> Add a shell test (test_netdev_times_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D36

