Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622291;
	b=0qzfOyiOAyTanhQLpvLu/8nAgRBDGhWCXC8blv+ttnk/vUgXZtYfbT6CmZXVakEjA+7J
	 ADuleLfGtlvBlsAcq6KoMXxBsCyKYqYWsN1Yi4uKvPY/UZjtDCYfEVdPnVyHEx5pYo5vs
	 8GUqwTfyp2gBnR9pPHvV0FuityzDerCOuSHIMzSwQ6IO5IboK07CNYZf20fGduy/gCWUk
	 z+EfLO0Napq/mCtyc1JY6h5Y+kkBhzlsYCL1uJyvmWhfKlgokW+/0csZv7PVnDkxm4GOn
	 zzan6wK/p38SUWsrH+O3IYNfXbHxwrOD8oSjxIw/9Y1MPr29NBiFN4jkk7prS2seIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HweXTDjP4IZKaZmCl3BU5RsFwbMnbtyUlKxH+qTz9Tw=;
	b=BIWDt+JNWTjovPTt2qVYjvKPzWoldmO4ypnQqq72ds76owXO00A2QrovgwwYtkDbdRkL
	 c5j/dz0bipSO+A5xv3XChEia93WA7ccR20VAds/t/4Z+Kkw42MpdESYOYuc86DZZryEsq
	 bdI3NHxb8TS/vPNJrMBk9KghVo4Hr6QfwxJgYAqtmrrEnUDjpxhEIeWRb8U9upf1vubzk
	 mzXW4UEU8g0z7C1tDNx3DwVrRAvNIIpC9nfWk6s/8Ry6E8z+zcJuIgQF8agWLYV+opu6o
	 jI7VTJteO6Rae5F+aN88bED8mIqd6eN2M6V86ayzgFYUbk8nfzc6gn/y3rWP6wcaLTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOun7RG4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA089606AA33
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOun7RG4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D62F1F00A16;
	Mon,  2 Nov 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622290;
	bh=HweXTDjP4IZKaZmCl3BU5RsFwbMnbtyUlKxH+qTz9Tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOun7RG4QShRfRRfdWK/ySWHv3S3dImucUTBhjnnueeOLz4XWAmaMgdbUXLglp5sv
	 GHZgoRfXgevtAIkBO7YTNwYp2GlzRYwduUrrkfZ0XE+AItUcKM4xo8ChupC6qIdnKQ
	 vx42Ja1YG+45Zn8eksiq00cUTrF3tDL+c5ddzA//vhuEFg7ftBSfZocaUTkhawM0et
	 5MOKDAjKsEfEAXS3Cus7p3+R69em05+uRxU9bbJU7znQ8Ui0xivtNT2Si5qRLg4BbK
	 QbzB7Xy/219Thzxn4H7OaKTXQxh/csu2QDuv0dtEjba7ECr9QOe/+4fiF5Yf4wloO/
	 M+2xYW02djBIA==
Message-ID: <sashiko-outbox-193399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/18] perf cs-etm: Use instruction length in
 disassembly script
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-8-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-8-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:24:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The disassembly script adds four bytes to each branch sample's IP to
> include the final instruction in the range. For an exception sample
> whose IP identifies a faulting or interrupted instruction, this
> incorrectly includes an instruction that did not execute.
>=20
> Use the decoder-supplied insn_len to calculate the exclusive end
> address. This preserves zero-length exception entries, includes executed
> syscall instructions and also uses the decoded size for Thumb
> instructions.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D8

