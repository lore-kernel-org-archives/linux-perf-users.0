Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7093D47A6
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393854; cv=none; b=aI41ManryWYY1YIEvBnxPR1lo78nfZpQZeQS1N4eR4BrCfEHpv4skn03G5ElykFfBHCAHQ0CWJf9jOtJ3hlWOP5skbsYmLkT+N7/b6K7WY/a6qIu1iGPk92aRJRzLFMrNwMdaRZOG6JfRiIiZ+Pthbtb4pXxhoTV73+a27Ykhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393854; c=relaxed/simple;
	bh=A956F76E1G9rqNrkmZ6eroUrMiPXmAkj7bRC5LSS8so=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dhpaooIFFhcyqyfigtjJObWyE5W5q6DV62kSwd8C/TVArBA6t16nlNAUYdVMl9ys1z7ZFSVtJ2gTMvhCpsfJVRTASE/r7OVFJbsRf9q6wZxj7f2E5mfv3/BUbc3KQt+ad0dEbbuAwt69BJFviubHruAIyBgLAS9o1qQqWVkCVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN6NRTN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN6NRTN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEA21F000FF;
	Wed,  7 Oct 2026 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791393853;
	bh=21rpATCO8li0GnokEXbukBVl43fJ94XgBlfxFiC2y8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MN6NRTN0LiFQdB/AO3NXQKlYrfAHEbLGJsgwJATJIZHOFgEVbuZdxDNPF9xOaUPhH
	 4FcGBOP+CCQXsevBxlIBy8DZRI6qhFgF4jcnvhmrWTDGFP5Fbw3TKXflOwoQt3z96Z
	 LS2cTSk4vZsEod7MUrHghAKL/2pVQrlOH6mIn3JKai0uIfATDeE+ORs2f5352lFKdW
	 C5O3MpAvIlp7UxKjmU0L7VG+pFEy/7odcX2DszdZ6fvyXijb63XMQ+WgtzXEK7I2Ww
	 U47/4i5EIXpuE0hYu2v+OO39nUK/wyQ6ODAZ+TmQiw8Hnj4Gu3+TsvzdkBtphjDEJ+
	 xxQH/Tf3w2DRQ==
Message-ID: <sashiko-outbox-163240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Fix double put of the system-wide
 perf_ctx_data reference
Reply-To: sashiko-reviews@lists.linux.dev
To: vineash <vineash30640@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179139291278.1120510.13167877618594247003@gmail.com>
References: <179139291278.1120510.13167877618594247003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 17:24:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The reference on a task's perf_ctx_data that belongs to the system-wide
> events (cd->global) can be put twice. __detach_global_ctx_data() puts it
> when the last system-wide event goes away, and perf_event_exit_task()
> puts it again when the task exits. perf_event_exit_task() runs without
> global_ctx_data_rwsem and never clears cd->global, so nothing stops both
> paths from putting the same reference:
>=20
>   CPU0                               CPU1 (task T exiting)
>   __detach_global_ctx_data()
>     cd->global =3D 0;
>     detach_task_ctx_data(T)
>       refcount_dec_and_test() =3D=3D true
>                                      perf_event_exit_task(T)
>                                        detach_task_ctx_data(T)
>                                          cd =3D T->perf_ctx_data;
> [ ... ]
> put it when they are freed.
>=20
> Fixes: 506e64e710ff ("perf: attach/detach PMU specific data")
> Assisted-by: Claude:claude-opus-5-5 syzkaller
> Signed-off-by: vineash <vineash30640@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179139291278.112051=
0.13167877618594247003@gmail.com?part=3D1

