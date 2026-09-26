Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD1388E5B
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404184; cv=none; b=oT6tn9dErBCKus99oyWelI20R4M9gHXpxxNU4u+LqHNTrIySICP63BPbfMAd81i0WOf1StTRvRDSgNJ9D0Gx1zjrj9JyEbS8UE23RLohKmdorNJlAdzLY3IsBxwfA5+WH9QqiaxOwsX3fDMXXF18aCqU/wxriew4W/VMisAFnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404184; c=relaxed/simple;
	bh=vzuUDHzLo7DsoTYyGxmpmxc25NUONBifGTdPplIjx/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPCs4mw6BVZfbGIPz5Nzv2WZc20tK448P10E3VEfU9ezttfzonvSV6VgZQzmYq84XBsYa0S8UWWi8yr2fdGZwm8nP3/fWdTjQ1mO+a4tPHgM1fkQdgPIwm2DkJ/uvbdJp833jsR7DMIR9PgYd/bkRRSrNi00zTVNyzURXBX+tks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGuzh5bP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGuzh5bP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFEF1F000FF;
	Sat, 26 Sep 2026 06:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404182;
	bh=hEuCdV4fAl6qWS03qv8CuZ3qOCx4sThdK6fcEzzyWT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGuzh5bPpVAX+dBVmruhJ7LXn3K88llh4k0PpnPUdkpoYLPVv6m667M/exkcDQahf
	 LjyaaJFizwUB9QoE0rNIyvUZxNSNk+twLuG3M3fRoABAT53HHt1gSJGP2XSlZZtzoE
	 IzcSb6g+8JlaHoPNo+g7OTPb3pOfaLqfC6Xg8sjt/qapjqUBxxL0JzZ5gEB1B/584V
	 aIVt5rNDm1mngRdxnYp3za5jw7hollvKkI+NCP9rnttrUmlMyeFzzmzfCLLe7ITE6e
	 gHKfQMy2KNe0Ghd8eoD+2yjRrsb2SToKrMJrMcyTW98s8AMp4/9bp3qLKgvp/4HwiB
	 3hDwwAEL175eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/49] perf python: Port syscall-counts-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-24-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:29:42 +0000
Message-Id: <20260926062942.7BFEF1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D23

