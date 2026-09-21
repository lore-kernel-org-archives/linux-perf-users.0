Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5021136351
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969002; cv=none; b=fPIli4acaUq7HLJ8xZ0xciAabmNt7Ujs0o53k8tMMmROh5NhMmHwvIYifVIQ+PIWhkhtv0PyppXpCKdC8ZslFm+utKqquq5fVvO8xrH3IO6wZach+HbDnw3HICNGsYq93aHQPR6+4iQugZJ2ug6Rjz1uv2O0yhFxbgtGsl0CKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969002; c=relaxed/simple;
	bh=pIaKp/zSGi3s36QJTeutbLhwE4o4kkmhPU30nk+GM6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPIpRlLblShpd9uhph0014j+vQ+y8WZ7dNBjSu+HyWTehN5MaBPLVPWEVEP9z7hpq1r3/jkvU3DnguEsULAVpxbsLvzlCNXEf5RchNr0yiL91LIBeJ4GUKKRLN5pDO09sy2+lwjQWywn3GhPav4yDZCjSRwX4Ze1ycR9xBG7CSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5BlQhwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5BlQhwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E9E1F000FF;
	Mon, 21 Sep 2026 05:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969001;
	bh=q3xe7XNzNzSnCfsxnQ9Fg5v1FJfE0RkaUr9/kydhxig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5BlQhwfONueBtM0NnRV6U9qX+TqvuE+C7pglW5zPKSlkqn7Fb+aQRZxNFosIzLnA
	 WJfO9f6tQ19i3nIHo7Gfkc41OrLjuce779FC/ZDOOLb97c/KbUHH6QSPAmeUHz6CAq
	 vWyVXnwUJDBTfgvplQliLNjiSILezULlahQQwUefZ4rGtNC510OnaYzWvHVtiy60/J
	 h1uibfq82h2zFRFrI1T7Fi8BC0P/4vwbcHQOw+cJWm+CAXUMkKsSdZnWvs6oY3QAxt
	 IMalUVne/4SFoGrQJwNgyadri0gIcvXLNrHgAs1h5vvt9r1HhD2TezRNfe74H/eCU7
	 M4IdX9F9KRS5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/49] perf python: Port syscall-counts to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <358959ec80e586129cc202a45190f8fa6443801f.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <358959ec80e586129cc202a45190f8fa6443801f.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:36:41 +0000
Message-Id: <20260921053641.78E9E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/syscall-counts.py to a standalone script
> in tools/perf/python/ using the perf module. Avoiding the embedded
> interpreter and per-event dictionary allocation overhead improves
> execution speed by ~4x:
>=20
> ```
> $ perf record -e raw_syscalls:sys_enter -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/syscall-counts.py perf
> ...
> real    0m3.887s
> user    0m3.578s
> sys     0m0.308s
> $ time python3 tools/perf/python/syscall-counts.py perf
> ...
> [ ... ]
> temporarily during the transition to maintain bisectability and are
> removed once all scripts are migrated.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D22

