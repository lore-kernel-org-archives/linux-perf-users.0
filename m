Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F4233955
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202832; cv=none; b=udH9pJVMwofgka65pVcULXKufv4nedANQ3ODkHpDHFFiU34dpoJveUijwkLEzdzXDhBMNtjhk0kXM+pXngLJhXCLp9rv6dMb+tfUKEUnZ75K2HT/ZzNpkq8mhn51+f+hejF9bgrQX7UKG6Kc00QwGGtrvJQDemcFptPCzYcltGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202832; c=relaxed/simple;
	bh=Hw4MDsr3gVka96f6nZ2GFoPd09XsOHFH1NwpbInf6+E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=vGmXlwob4rQhZDQOJ7+hExcHeO1YJZ5RurVU2wE3D+RCshllTnwzOy2xGWvful9Mpl4zTexUkCk9is8Ae3e0i2F4woSAqdnM0/enRHaeaTRIbUksVQhKwv15K52aLNAEfRy5BejBzA6pe3U8n+bhi/xUscv9ohPejV/0lK0tZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFMxoTGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFMxoTGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E4E1F000C4;
	Sat, 17 Oct 2026 02:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202830;
	bh=Hw4MDsr3gVka96f6nZ2GFoPd09XsOHFH1NwpbInf6+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFMxoTGRMvM7SAzSIMDjJwdbHZWcxtnVdiy0518766mp8CJivsjahgur+CPbLSQYa
	 gWVrx7gYqt4VnseiuLNDRA7NdOvfGphu3O6RvDUNCNq98OauEWW4YFcLeQtdvwjZst
	 uyHoEu64I6gKkVGsO4Q61CBqZcfqVry3x0Csmc17N9N8YIg/iGLQl1gfBWWNV8q8xs
	 Qbr5IOBdv/kLWWKmYNNw4y4S/F1+k9JKV/CG297LVIOqKm+/fcj+wm7n70vb05I9ZA
	 4Ua7RMgQOKAyYklAB7kMSwNTxV0gfUI0Mxl21NXNICoCOR6w51+462Kd+uT2egigUG
	 hoiynEh1+XfAQ==
Message-ID: <sashiko-outbox-175189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf regs: Add alpha support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-alpha-perf-tools-regs-v2-1-406c9628320a@gmail.com>
References: <20261016-alpha-perf-tools-regs-v2-1-406c9628320a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:07:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the alpha perf register tables so that -I/--user-regs and
> --call-graph dwarf work.
>=20
> r9-r15 cannot be sampled and are left out of the mask. Perf register
> numbers 0-30 are the DWARF numbers. The pc is DWARF 64, the column GCC
> uses as the alternate return address column on alpha, so libdw's
> frame_nregs is 65.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-alpha-perf=
-tools-regs-v2-1-406c9628320a@gmail.com?part=3D1

