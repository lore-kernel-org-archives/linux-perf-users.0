Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AD4D90D6
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559851; cv=none; b=I6lo4tttC9o2FKa9XzRaMdejas1M73r+S2c4sVZTs0eoXskJQdglD5RY/lI9RGhkoTYj6pz0Jp3KihDtcUmGajyjqxWlWhC1TKOrHRnFeMegTZfcwbHLSP3hOaDJqOgmTWsFQFFDnrI+vaQHiz2nvlkDmHKqMPsXQIy4K41tOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559851; c=relaxed/simple;
	bh=1fN9Ok/xmwjI7URc1nsA4UR883Mc6Fnhkp5nYXERgdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZLOzURkMnz10MQZY7bsQWXFJ/K++a7LbTSa2qL0Sdn9UxPzt2E25fuuBE+9RokS1mSwG8P6XlOORfzy3cyeA2mEhcW8GBvJcwiSQwTKNJtcxPHGMs9R5DD4IGQNmx9EL5mR0RL/SyZtFFXCSR1cJKfi6UMCFVhvuPLWYcDb0bLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmVSvHPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmVSvHPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85D71F00898;
	Wed, 16 Sep 2026 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559844;
	bh=6WhVAO3GacHLScevUgrTwXVVdf2cQ4RCEAs2LVkenrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmVSvHPcbVv2qtOOD5hJCtwcbJm9PzHFCwLPRGJozv3ryRyOjsSyllOw8phdl0PME
	 dyM6FMwjVgrmgvgMULAk7+33dec1R/BOAGeXUejHUu+cq++s407Cubim9tDrM9cuwY
	 c12Jap0ypyuJBwWj6lhqCMyrP2z+hmpNEDM7dU+we4n8KtI/Pjlp46FANWKGLwMLXI
	 Bs2exSj+Txs38JKOEzvjGHNeccWxElTlTzHi1JWlEEtQee4DVtZKcNuHcb791j2c6N
	 FVQY99LcMI1MQkHq7x/7/yheByLZrILCYJqwfcFPw6Zi8XbutAIx+m2nrSh4+Ixzrt
	 F9QgNsrE8E68g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-3-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:57:23 +0000
Message-Id: <20260916115723.D85D71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf already uses debuginfod to fetch source files when annotating
> (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> which queries debuginfo keyed by build ID when a module's debuginfo
> isn't found locally, largely the same thing this adds; eventually
> that one could be moved over to the new helper.  For the analysis
> tools there was no way to obtain the debuginfo for a DSO in a
> profile when it isn't available locally under the name the DSO was
> opened with, for instance the vmlinux for the kernel a profile was
> recorded on when processing it on another machine, or after the
> kernel and its debuginfo package got upgraded in between.
>=20
> Add debuginfo__find_build_id(), that uses the debuginfod client to
> locate a debuginfo file keyed by the build ID, checking its local
> [ ... ]
> that make NO_LIBDW=3D1 on a system that has the debuginfod client
> keeps linking.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D2

