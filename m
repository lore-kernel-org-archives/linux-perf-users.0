Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80644BC97
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185971; cv=none; b=cLWGnjQBZSx8pKaZECWfHorQh2VLZoxLXQ+W2qas5n6C+9A3M3yGYQauMRNoczWy4s4QgxbRpQ12W2j/TO+33gLPl/OgYZyeGs+5dGpWhgmZXCREKShI8SB6qaa0KZpfe3cLpKDmQwzIAM2QzM/Ly8KZdQ+Xi7e7yO7auafducc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185971; c=relaxed/simple;
	bh=8uZOj+7Pur82ScXzlot4GhluMwp5juQlnz+rgtE/Yoo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b9mFmGrcoNIF5ilv3seWcIg5K6Z9UhtGbgNfRehIagXdn/JMMaCYKG/S4BXCtNW7svqOqrtkz6xUmiWt6//hLouCeWpZTAl/pAcWnmyPlfZ54bPEm2YWboNlpnmu4howO/qJ0lMjNbNxL/MrpMjbZPOsuXxBOkjiYhyKEC6hCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGCoTxhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGCoTxhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B31F000C4;
	Fri, 16 Oct 2026 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185969;
	bh=8uZOj+7Pur82ScXzlot4GhluMwp5juQlnz+rgtE/Yoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGCoTxhFRD3fpiYw/PEmy8wvY80fRZ34GLhwmurHdE/8LhQJw/KCEl+mG24YsgVfk
	 zxu3NUdkHRD7E2PQI5oow+wTFlpxjTLq9lsWQl7/p4a7xDfqsEGTWcWITHTNnSevKz
	 2+b2nAgzhrmRWhCR/jxATElQddmPhwQvisDP1q8G+zGpFekPD3pzRRCNYCekk3XGWH
	 XADS7GiNcu25pmDkEqUwQvz1GhJIsjzTex7n3VHuR/NO052aHvEqMWLBcQ9rVzekr4
	 SCMMaUjfIr92C169c5PjbLSzbpm5BVcXgfiFrVw2lnTq9wa8lEBtEc1qqufbE3vHdc
	 jcmeltgO4uIDw==
Message-ID: <sashiko-outbox-174969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/21] perf tests: Mark the shell tests not mapping
 perf ring buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-20-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-20-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:26:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Shell tests run perf, that maps ring buffers, so they take a turn using
> the per user budget in kernel.perf_event_mlock_kb by default; the ones
> that don't map them, like the ones running just 'perf stat', say
> " (no_mlock)" in their description line and thus keep running in parallel
> with the ones taking turns.
>=20
> The 'perf sched stats' tests are among them, they synthesize the samples
> from /proc/schedstat without mapping a ring buffer, and the tests already
> marked " (exclusive)" don't need it, exclusive implies every other
> requisite and keeps them running alone.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D19

