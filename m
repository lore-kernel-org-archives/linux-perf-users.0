Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BC470E8E
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932390; cv=none; b=eeg9G6/5Us/D3iXYACrJ/zh7gKp/2vW12fjAsS+GmPp86Xa9SeBL9yKVlNSD/oYeyIVA1b3WNNZpsdb6EweoJmnsOzrRYQm4EDEed8ie7bDT+qpqhz3B2YI2z/AH8lpWLejCKAOQXGsw01M4ZuLE47pouSbkRlENYoCLvX2nuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932390; c=relaxed/simple;
	bh=Ei6gT0LJGhyx032x0iJYwhO5go5riyRjPogUpawml78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RuDWlHUmfOMzE0qgxZKvL5Jd3iFQGNmkNqqIm/Abp5KR5abbdJ+NwDHw6rPrxR9lY9KSxhTI4sdgwtGxBo115EjLf+K7vicXS4gF3cRh04oICaBB0cQDgkjSkuwIlSpAdGN5I6vb7LNmVy/I4JX+WaN5zXdrvDuB7eWzzPCNkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCYGMY+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCYGMY+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA31F00899;
	Fri,  2 Oct 2026 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932389;
	bh=wdKr3kSVxVslwtGEWaCoENBR5Il5+cWUlgeLh4aq3KM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCYGMY+dxAOHFhfUFr3SWHxcOL2OG56lTZ7LNPq3Wx4VMfEa4U1uY02+Txi1nzm1Z
	 uFeOMcljFRAZMqXdZJ2sAePZ+Scc21tQe/ZjPS9+UuOJ02DB+U4fp1ge3iHHX5yRQq
	 pg6MDVCOjt6PMAbf9s6zyHTVQQj6XCBYPts69kcDA9wO2vKbdXOdZ4eX4o7gGOTXV7
	 JaULKUwYhsunbc4AiPSYJNcTXXdeugXYbWzO3haYhzNsYcJaJDNmsr3qEqGLobfr5O
	 E4CLryNAieLHpxcJc2zUgczSAvVJGvIFRsjiMBLyzlnKNXrDnL37zxAs9WTaE0hH2f
	 7sfPcikyKyIqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-9-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:09 +0000
Message-Id: <20261002091309.77DA31F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one stuck in a
> loop, and there is no way to see where without attaching gdb.
> perf-stuck.sh samples a running process' /proc entries and its progress
> line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
> the perf-die-chain command) when no progress is made across two
> samples, printing the DIE chain a DWARF type chase is stuck in.
>=20
> It is a prototype: the plan is to turn it into a first class 'perf
> stuck' command.  The process name is resolved with pgrep among the
> caller's own processes only, as root an unscoped one would attach gdb
> to the first process of any user with a matching name.
>=20
> -i and -n are now validated instead of failing later inside the
> sampling loop, -x now requires -g and gets the same readability check
> as the default gdb command file, and gdb_done is cleared whenever
> progress resumes, so -g can fire again on a later stall instead of at
> most once per run.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D8

