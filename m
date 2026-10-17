Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0F39060A
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202456; cv=none; b=trakWp/2vd8fQENSWkYyTRL4r2F4Z9O3IBXFO+4oVzF5V7WjsdnWBcdP/cJ1NuIU86d1qy+5ZYLPtAY/dPBKKF/ekcUvmVIja42a8I+ffO6MihThzSUJpg8MkEJ6XQs6pXlDuX5EbVwjhvmveuYR5ZLXM7ZtObYrQcypWMPUIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202456; c=relaxed/simple;
	bh=CFdU+j/dGmZgZzQw7Z6sK4L47lwxTGo4hNX56gRNnQ0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=S5V1I8KP5WTg2lO86G5enMFTUvuOgEzAEiGFN1Caa5GhpgByrhLYA7Dv2rMZKagWlhCmbKocD8mqdN6aqxky0vPlFDoYVbOZtjBN4uywNEdqMnmvWNKwR6Jy+PPaH6W5Y4NylnbZBoBehpHtuERSqIB107hf+ahIZntaOD8MRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT3vKJaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT3vKJaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5771F000C4;
	Sat, 17 Oct 2026 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202454;
	bh=CFdU+j/dGmZgZzQw7Z6sK4L47lwxTGo4hNX56gRNnQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VT3vKJaG00e1i9b6Ru/XpG1KpmecZfbFEnZKTHr0zL9esAYR1RU0tFBcf4fCsBUqh
	 Flj2xMUTPdYdoj07xTDA2xsVb4Nzycxvk4QNttWYTOVmn4pS5qGusjWLKnehyhdZHs
	 RIpPM5ApiJrNHrY1hPmBi6WCV/H0eZPRq0FUS63vT0lwYwoCw6NrvOOpF9gt8KL1IM
	 cMEgRw34SAMkv/cUvcEx0AbdbpAirzivCk/EwRV4cmN22nB8YMPpnbhPHsHc2IRrPR
	 uvFSS2fD/ZMFk71FAt9C+I2FbwJ0lxRvZDvxugFEuxntSoyS4bzspnXK/ssEkiWpBj
	 x6O1qdLu7KqDw==
Message-ID: <sashiko-outbox-175172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] alpha: stop storing the user stack pointer in
 pt_regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-2-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
 <20261016-alpha-perf-regs-v3-v2-2-17654742226a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:00:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Nothing reads pt_regs->usp now that user_stack_pointer() uses the PCB.
> Drop the stores, which saves a PAL_rdusp call on every syscall, and
> give the field back its old name.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-alpha-perf=
-regs-v3-v2-0-17654742226a@gmail.com?part=3D2

