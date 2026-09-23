Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DA40BCB8
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188402; cv=none; b=s16mhwfosTO9hjVQtdbFxw0oK9YxoZTcLePQxH1fRmGWNB+aI0jTguRSVif2grnCY2socKKYV281tQGOw6Sguoi8QWNoE85kicsNIN4CfudY1N7NexAB6pkrkegudXqrjZCUvGdPs0xW14HaT7Ung5JvK2vWmErzF/D6yBi+IbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188402; c=relaxed/simple;
	bh=l9+jO3LMdkNKJUS1UUtDX6c9LUMHaY9GB3UKZYC0lfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XLO8aaoAKg3Btytg9ALm1OV5yXVzlDwYnogBxQkm87o66DYWM6pllwsuIqtYEdBvv9umeaxFtv2+bhi998ryDv87EY1qh5JxzuOi8GsQAodi5l6Fhi2SaKLjpcnxhSj7ZMXoiZqi745MUvvimrso6Tku5huiwUI0FoNAtmiaxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbVfduHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbVfduHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2631F00893;
	Wed, 23 Sep 2026 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188400;
	bh=0DGyHLp+mnzHUKJCKtM3mQU7EoVPgUW5euE9kmlRkK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbVfduHdTZZmdI1jzHiiPwJN6r9aK1mGbP3uD23nPmi1XiA16lQ3MFZSXTnGVoL3P
	 YAY1J2XbF3IUCUVaUktKEfpsMk4FZhCfBCRtp3FsYcCXzv4x/m5gwWwMCLFvxwKpi7
	 6rYY85ygaJkj7xD/rmqjxLo0wVUkZqby99NkcJZT/26iNf6yX32AKnJt+esDSmyIP3
	 uBe6xKBUFkVUd7gVyO2EHI1inOWUO3DknTVvX3eCnjAFDm+rgiCkfvD4pEPyoBKp2A
	 0NEqSThK9JWO9rUKGV4//e0nkk6yC8/3eA7Pr28Q4xP2fX5FZyAHkN2AQernklcVh9
	 fd8FZ2vEnOODw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/49] perf python: Port syscall-counts-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-24-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:33:19 +0000
Message-Id: <20260923183320.0A2631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/syscall-counts-by-pid.py to a standalone
> script in tools/perf/python/ using the perf module. Avoiding the
> embedded interpreter and per-event dictionary overhead improves
> execution speed by ~3.8x:
>=20
> ```
> $ perf record -e raw_syscalls:sys_enter -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/syscall-counts-by-pid.py perf
> ...
> real    0m3.852s
> user    0m3.512s
> sys     0m0.336s
> $ time python3 tools/perf/python/syscall-counts-by-pid.py perf
> ...
> [ ... ]
> Add a shell test (test_syscall_counts_by_pid_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D23

