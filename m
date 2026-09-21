Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7A359A99
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969086; cv=none; b=GwdgRlwU2hb58Klhz6DCKqbzqwuFNok8VrOTzlXWtyojsZYU5lBOt8OdYFvmarjEB8j3cBvn5L/+M5v84WdGwPGX9VNc8x5+lu7lbrmWdYZrWGj17H0z/Srxm38GujwbpD0Q9O2RHUzjf/2TQQNIYNsEKfzgdXFPlywjq3tjEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969086; c=relaxed/simple;
	bh=qprtVm4KX0Mcwf0gpbKrxynxsHaq1LxSy42UWRjpNrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qOCKaQL1F7o3latkuuNeu04gZMkTV0m8J2V3f28MIK7uQETaCAzbwQQyCecb6RG8WpwJk/1euNJfuA5BSs98SP3e2UEx3ILuUB8KgzRk2FI5LEbUBN49WeOoZiqz/6iwpuoglnZ6Oo9jMNhsVD8gA1IuzjR5O/dLj/Mh1FZAxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcLwozUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcLwozUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F521F000FF;
	Mon, 21 Sep 2026 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969083;
	bh=StQSwnzZ8XDylyn8SS4PIw04gSlNoW1TLqePRv67yJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IcLwozUtQDuWlJlSyZ4vuf3cngNntD5zpMBOuNpQ1FU9W8/82SxSPpggdLsF5Svj9
	 lBMCFiC1DAVJu+gnDVZ6nJnRoQ7RWgVpY0dLSAvBfi11kioLtuWcbLICReylPOC7bJ
	 0Jd1dlrqPpEeghCAt0YQU/VQrtML+obCWybmJ4pZ8F5JYdtI7apdi0O1S4enhfDQ0d
	 mnszn/vz1lbWUwj6lnOqdz3ONcu0enEx+l1JzJdJoejRy0H4Z6uphqV12pUJG1x8UQ
	 T9U+G7XbnxX/IYwwXrT0Z8TAF3LEZgbD3KKerYCjV7sc/hzA5y5HqWmxPQzVHQQmWV
	 0aFNUsEyiFbQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 30/49] perf python: Port futex-contention to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d3193a91aae805cf91f36cc2201fbe824cd91c73.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <d3193a91aae805cf91f36cc2201fbe824cd91c73.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:38:03 +0000
Message-Id: <20260921053803.88F521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/futex-contention.py to a standalone
> script in tools/perf/python/ using the perf module. Avoiding the
> embedded interpreter overhead improves execution speed by ~3.2x:
>=20
> ```
> $ perf record -e syscalls:sys_*_futex -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/futex-contention.py
> ...
> real    0m1.007s
> user    0m0.935s
> sys     0m0.072s
> $ time python3 tools/perf/python/futex-contention.py
> ...
> real    0m0.314s
> [ ... ]
> Add a shell test (test_futex_contention_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D30

