Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA74497B74
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767899; cv=none; b=NAakMG9gjPNVIQoXzNTqKA4zb19Tdn29tsNrNkbCUKjNf5gpxSyjxA7gML9f2Jva9jbBUm9PW1+RqM0nqDoBbSVWEKPVlHPTQfn7zYEynsMfm5T7ERBJyNFjgRuHU2P/Tgq2rP47GKZr23bWbGHK1aXOnOfjTCZ7ais8XgrIx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767899; c=relaxed/simple;
	bh=1kBx+xmtQJiTPK9WVHlMFceRxgR8iD20k09S0kxwkk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFva9wPkreTvB9tI6ku7UxJRwl5YxLUq4MqCVJSJhg4P4zQb4lWOi+p1gF9BTWeG3OTSd/fAOfqDMvcHUvGk0dd1knDSUJNSdoj//EXQkJ/5bruG86fZatSVFVVSdL7jgfMvUT2J7Gp77zEqqB4SL6mlETfhvPCUldF2ivU73t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biuio4lF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biuio4lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEEA1F000FF;
	Wed, 30 Sep 2026 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767897;
	bh=1kBx+xmtQJiTPK9WVHlMFceRxgR8iD20k09S0kxwkk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=biuio4lFBIf3PKpSSHeR7hYYbWaPH4vfURRlqTb24GO83FrRtQLmbyjOqJtZA3o46
	 Hv+ORrcpg8mby9NRECvRIRShc9Um71yeocYnDLwMgSjhjmKBPKJEbjYdkbnvC9vFO8
	 BENejcBqiiDzPx0wsw8oq58Ew57nSMg1+FfTxBpZBiJ1jXAVmb2OJeLiAeJIa8kv2d
	 whGSL0plVwwoPh1Mb12kJyvAqX+P980ik6Qtd5OFKJWvkkk8wN0dz5wFK5oGASUdvV
	 XGTznstuo1XXw55LymXDtNWSRbdAKVMBc0Dnb26R64S/0Ato5dEnLhxzZIii6GJgHB
	 6QEZPVqFYJfkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930112454.16331-4-acme@kernel.org>
References: <20260930112454.16331-1-acme@kernel.org>
 <20260930112454.16331-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:31:36 +0000
Message-Id: <20260930113137.3DEEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Now that --progress is being added for the stdio case, wire up its
> counterpart for the browsers: the TUI and GTK ones present progress of
> their own and there is no way to turn it off.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930112454.1633=
1-1-acme@kernel.org?part=3D3

