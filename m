Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926133DB33C
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849591; cv=none; b=majsSzF/aNMeHQZ4v7TpveeynPPBIYZedfYOgeoSEXM5lHwEtbRB2FDfPD0r5eHaAsXI6hQaTQii76OEJIMNDyrC/SeQMIgg3zyeb6PzMBI/99c+Dgr3oUNG4lpP7mAg3UKmCJdRWRj5qMXO0g6M+Hc1o5+cbFxVebnvoinDnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849591; c=relaxed/simple;
	bh=3I9v1+JH97DRGdi7rTg7lucvHtgTA8r8DIZJzh1FxHw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MlYoTKC3cNDEysL2TAXdztcCIn23JF1ekaXXOhQBD7CJelYtJrGzQDLI42qgPYn/KrLg3MdI2pBwXgaWx2M9aVBdBpjuI2Z2dH4nWS4Uf7OGMZ88jBm9ChbXem1eBY4df8U6AOKGewcGRlMniUTs8AQ1RmMQKkHlac9TDMy/+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZe3Fp7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZe3Fp7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080CD1F008A1;
	Mon, 12 Oct 2026 23:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849590;
	bh=4xd5U+R8gz1J5VjQpoLC8MEFG3A2fIcbGneG7ESMQ/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZe3Fp7gIDviZQgWX/LpqeNMJRtneOs9jkxaZ1xCpMLCtEXTnmBjzRBJVmy4KkaC8
	 07l5ChUHL+pjgI6lQYbDnin6I6Mf0iSrrWkjX64jTPTPINGydsPi03jF0xkf7J3Zfa
	 7OaBIFYQsk861ZBZMCcZ4EjOlh8LuxBf5DObGYQvIHWCFvVD1m7kgBRf9IgqakXENC
	 MqE5B45tT70XwKSMYiwvwWjC9OgJDakKWVq6Ta1/6B2EKR7r9n3YRdXZ8YGrv047dt
	 hCSCWz2ENhUMYnXlLreRo8mJxe0AuAuNuL4PF9vSSD58/gSA46JXmhgcEqMzpOdBSS
	 NX25pGoKC0lPw==
Message-ID: <sashiko-outbox-168761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] perf symbol: Set binary type for JIT map DSOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-8-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:59:49 +0000
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
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D7

