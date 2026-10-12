Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52382ECE86
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783246; cv=none; b=BplnrvU1Qpl5qPltdppBZ95+5LaAblxr1olCtxAfZ/i1OdNckKkBpLrIRo/zYvGzyd3JblM8AOVYVVyNhDPTi3r6Mh1BGfphgW9CfrvWpxLbu4+szEupa1YaBQ90SGs/axqHdAlHc2hPZiaHxexS4J3LBHOIP5trVClNwGdqvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783246; c=relaxed/simple;
	bh=K1RVkCg7tfiIEzSJFGrNEHah3Npwe0uIVuFFM6MPiP8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eZaxFnXv0DNPaO+EV3t8cZz89T8UAzhahqMmKTfIIjdW2TUj1Qv6zDI6O7G8GFecsbld/N9D2sq31ULKSgnv/U2WpAvd2P2BgSOX5RWcJUzgArGiJhIceReyYEFD/oKrbyruKKmTcJyMxhb9YpUM55Bx5Pq5O6MLno0dVMmaoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfiI4tNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfiI4tNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C871F0089B;
	Mon, 12 Oct 2026 05:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783245;
	bh=4Zo6S2IvDESHHm5WOsSZWL7qLPTjD9JkLHydc9Hg+1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfiI4tNYx92UfgcTf4alQbEua95zzR7T1ZAgGMk9iET4jIs6QSRGYfX/42Fq3sK3L
	 7DPs1eevcHuJgV+BYAzlKat+rK/k9uuA+z/aDbEa37grpEYUhvHP1RncjC3h+j3KN8
	 L9R1kdAoSTDdwquGb+bZ80ipm5vrQgKDx3RTqIVoEs3B/ruS6rflvoYYCCnbiF1lvj
	 l+DDfslKoUF53qDVHJa8MU0+m8o0EPFZsMacn54k9D4Iiij3/8I/E/G5+l0PRh97dh
	 uLjoxwoS8xkZgzgeh02eNVbYczQMAYUIvpnkIdi4CALJnSUkVkNV4UPEw9VEdGI2GE
	 YUka2G1pKVJPw==
Message-ID: <sashiko-outbox-167673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] perf symbol: Set binary type for JIT map DSOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-8-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:34:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The perf-<pid>.map files contain symbol name of JIT functions.
> As they don't have the binary data (instructions) no need to try
> for dso_data.  Let's set the binary type regardless of the result
> of symbol loading so that it can be ignored.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D7

