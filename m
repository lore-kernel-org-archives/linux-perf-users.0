Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021274;
	b=dT8JbvTH1c7KHJFEPC9C3gBESRHBvxNLJ/ApI7lLUzccYif/u6Otj/O/VKbaXT8BHoCA
	 fkqGWd/Jny8rkoomdtjSWIzYdyDySkfdH09pfZ8GBSuhz9U5UIzNqNCJjRjUDvIu8OfRe
	 J0yGYSj7BHZ5KcWD+5WNPziL8YbK7XUA/NwGiOqkoWPtdqWAmY9wsPQpGtV8uHgx3gw1V
	 S61mgkpOIu/qj/8aVQDtXTByBvbO5Mdy6oZvpheVIZcFH7ATK9ksSPLgVsL9Zph7m0qoR
	 60IckDNa0jK3ejB8++x4nTkBijW0VS2uNjY75H65SCqtQtle3xhI9sNNqRszETHU5kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YEq85/LznpyaCJx1A8DvjDpYYxTBFzCYU/3byUYLyDg=;
	b=MWQBB41zuFPeF1WryNiRCFcNni6iIH2esztjGc6S2b/1yM46xJWCa3eTz/o6Vfq8xMji
	 pn6+yEpAWso/vdnhzDvcMexK+4uO14EnWxzrKbfW3tl1TT1DadmG0T5OM21SxkwL6ZHVN
	 Z4ipy2qBLVCKH61eS6a6bJAPUtTRUwrNnQN5TkAK8m4ZzR9NbvnYb4d2Z57SNacDlHBFs
	 FpL3Yx+zXhIMyKfFLPtD9WHynxamc3bBH4QlRpZiNb34hbwz8eVtPP74UJARf+cwryTgS
	 1o36Rs8RXH2NfApQjADyG5X1b03D0gbZ1mJe8M/NBcOE5lgop/TKUuZ5jlCAhbGNufA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPp09EzY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60E606A32F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPp09EzY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F21D1F000C4;
	Wed, 18 Nov 2026 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021274;
	bh=YEq85/LznpyaCJx1A8DvjDpYYxTBFzCYU/3byUYLyDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPp09EzYk2agQ1uLPu4RyL3yTxJrDgfYzeT1RIeNiOLc0x28WRMCvcUbhwrG11fVK
	 dY/YIJEZwvvN4fGyR2cb7BYatgVQTuUpA8c8xvyDRpBP48TGxC1SssCwDfpdjOcdd3
	 UeKLCdk9xctvoA39PxpKYFZrkrBqixiJwRRi04oifE7eNhs+vDoo47xMbDM5k9So94
	 jJR56UwHNtgcGcnXcE8dhrMUPlWZaKGUq3e3/OqdllQY2CFsuI3Ng7zcUm4/ghKXdE
	 AuiASHB72sCD4tN8hoC1ydg0Lq3YzKzFEn8jBv6MEDKkOXZrV1nFOkUKaGf3BVzjTc
	 K32ww286GwOxg==
Message-ID: <sashiko-outbox-221572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 34/34] perf test cs-etm: Add an HHVM JIT call stack test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-34-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-34-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:01:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf test cs-etm: missing -vEval.PerfPidMap=3D0 in hhvm-jit.sh
  leaks pid map
--

commit f7032172008e6136ce49523768041a0dafba72fe
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Add an HHVM JIT call stack test

This commit adds a CoreSight shell test that records a Hack workload
with HHVM jitdump enabled and checks the decoded call stack sequence.

> diff --git a/tools/perf/tests/shell/coresight/hhvm-jit.sh b/tools/perf/te=
sts/shell/coresight/hhvm-jit.sh
> new file mode 100755
> index 0000000000000..cde8725519e6e
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/hhvm-jit.sh
> @@ -0,0 +1,89 @@

[ ... ]

> +# HHVM deletes the jitdump on exit unless KeepPerfPidMap is set.
> +perf record \
> +	-o "$tmpdir/data" -e cs_etm//u -D -1 -m ,8M \
> +	--control "fifo:$tmpdir/ctl,$tmpdir/ack" -- \
> +	hhvm -vEval.PerfJitDump=3D1 -vEval.PerfJitDumpDir=3D"$tmpdir" \
> +	-vEval.KeepPerfPidMap=3D1 "$tmpdir/hello.hack" > "$tmpdir/out"

[Severity: Low]
Does this leave /tmp/perf-<pid>.map behind in /tmp after the test exits?
HHVM enables Eval.PerfPidMap by default and writes /tmp/perf-<pid>.map
outside Eval.PerfJitDumpDir, while Eval.KeepPerfPidMap=3D1 prevents HHVM
from unlinking it on exit and the EXIT trap only removes $tmpdir.
Passing -vEval.PerfPidMap=3D0 would avoid creating the file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D34
