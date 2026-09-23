Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12165678CB
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188226; cv=none; b=f/Y97fSO6yDaKPAhgYNpcl7T/JSzSoEgj+83CJ/Ch7K54dd05//JTpy9XXJfF5KnFRPn2YC58HiBpQh6G09H3RCrsHY/w+7Vkb/TQhJE+sW/VGjLTW96vBKiDvgGSmWJJoRUCQvUwtXaSGlsGVbjv/aXqutc9KTaXLCPotVoYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188226; c=relaxed/simple;
	bh=Fd99jNXvADEYMBMXV8f0opn8mPGWYFanlmpQUOPp+Dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YkKEaFx1u3OUos4hbuyntv/rqtxfQNjiV48biDtQt+QTUfPGymTqF0K50J0qBs3HpbMYWA6SlztGtvWXms3D6EXzvwTT6Yd1BsNU0sB0kgZ5s17qa13V+NPVilG/spXDzPnYuLvgRITUO3b2lsABZYGtrL/4474fsJTxNCXP+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S23hwIJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S23hwIJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7EA1F0089C;
	Wed, 23 Sep 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188221;
	bh=nG1KSaJPDt8xUmj2jqojAKEU0aS+8eQWQXd6jLoAebM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S23hwIJDtRyzku16IHI0LQKvoBH5BrdQFuzvhuzfvVa+Kza7N0n0ko4lq9SejR9bF
	 /gAeIOVYtJfvWbost0ihmveaV0yQ3HtJe/7En6WwrcN2Ey4C7mYI7MQtPEp0LUkUed
	 uyb6udV7fExztWzquuqqw9OHI1qQlHh/OuyCCG9Pbsov3AmaFtoJmZgb8jbHNVgqDB
	 YLY+erTIgGRKRwQTaGK1InFdqSNfmA85sy9o7DsrDphy8p9YYr6GU0QB41kyODB4xg
	 3uw7IRVlmLSECyS0DwRSltwZ1Z9yqy9cXrL699ZNXbKSiI7+lFToy3YSM0OCMCuKwa
	 Wsw6b554m7omg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/49] perf python: Add Intel PT call_return and
 itrace capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-10-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:30:21 +0000
Message-Id: <20260923183021.8C7EA1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for Intel PT call_return events and itrace options to the
> perf Python extension so standalone Python scripts can decode and
> inspect low-level instruction traces.
>=20
> Specifically:
> - Add a call_return callback parameter and itrace option string to
>   perf.session, treating explicit None (Py_None) callbacks as omitted.
> - Expose the perf.call_return object with db_id, parent_id, insn_count,
>   cyc_count, comm, pid, tid, call_time, return_time, branch_count,
>   call_ref, return_ref, flags, and call_path (resolved as a
>   perf.callchain ordered from outermost caller to callee, populating
>   frame->map and frame->sym so call_path entries expose resolved symbol
>   and DSO names).
> - Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
>   perf.CALL_RETURN_NON_CALL flag constants.
> - Expose session.e_machine and session.is_64_bit properties, preferring
>   recorded thread ELF machines (perf_session__e_machine) over perf_env
>   so pipe-mode traces do not prematurely cache host bitness.
> - Support optional vmlinux, kallsyms, and symfs symbol configuration
>   parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
>   PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
>   symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
>   ptime_range in pyrf_session__delete().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D9

