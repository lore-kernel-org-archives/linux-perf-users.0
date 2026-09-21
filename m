Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E16353A83
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968816; cv=none; b=EGoYBNIJnscQjfPPhdG5OoJsZEw4ZKBJKD1F+Z+dkGvSB5ZKazh6AJF3MnV3CTfLX8aRRoEHZ9N4FQYeQUdXic7gHto+Bd8L010WO/npx6JIAuwKgBdtKTvg0inmEMKnHr84ejjZdNu1LuqtlxCKLk42Yg4i5c9rXGht1t7xTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968816; c=relaxed/simple;
	bh=94LG7ojDLOtiPGPaUgVtcxseQYlVBunlrJHLhIlce5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XuJuZBn7DigLCoGhkh1jZ7Snaq9Qxl5hKA7FPzmDvFA6PEahqk0n0r5+i6nfNOae0MtKNcvZFnqA7NqjjjQ3Ukgb0EC6LHMGtXIp+roHMywTPC1PsLJdZmPU30+Rs1G0GdJwKv11+KjMRrjl2YhmINfCYy7wh40i9KPOM78kBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx8k1fQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx8k1fQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10C91F000FF;
	Mon, 21 Sep 2026 05:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968815;
	bh=hyCugVOyc/Yr0muDXKxZGVtEnE0fWZCplFFap0sTJ8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bx8k1fQpvP3BU60bqce0V8LCbbiLk/MYso3JNr4nUcwRpQljrndnZkvnenIBqrezt
	 DZ6+12TmOV8nkqvNoJtoe6q4k8YFjL41DWxHsF+EEkp+1lt944OO2dOzssMBua/cnA
	 aXBDKyVCJC7izfRpAVadJw/dj5J9yjlbPuL3bVmDy+IB4hks0UdV/nL0v0RcfOgyKa
	 4BY4cVwweNicY44k37U7ISnibPUeeuZFE3qWbzqrh1K2Y+ZLTI+jtrSANBcpVEe/lq
	 b/vZNeLVSulEhf1DkfR1SjrcTtrtCE559fGAf0xH77oUIgvK2iLfqTRC2Tyrq/TG20
	 4VDM7fRDvQTog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/49] perf python: Port failed-syscalls from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9d719971e25d7452b00b3d669d56a096f50353f8.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <9d719971e25d7452b00b3d669d56a096f50353f8.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:33:34 +0000
Message-Id: <20260921053334.E10C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script failed-syscalls.pl with a standalone
> Python script in tools/perf/python/failed-syscalls.py using the perf
> Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both syscalls:sys_exit_* and raw_syscalls:sys_exit events (the
>   legacy script only handled raw_syscalls::sys_exit).
> - Use session.is_64_bit to distinguish 32-bit vs 64-bit unsigned error
>   return ranges (0xfffff000..0xffffffff vs >=3D 0xfffffffffffff000) so
>   valid 64-bit syscalls returning ~4GB values are not misclassified as
>   32-bit negative errors.
> - Add argparse CLI support (-i/--input and optional comm filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_failed_syscalls_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D25

