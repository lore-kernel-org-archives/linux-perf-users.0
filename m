Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD432D3225
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202344; cv=none; b=aiMeDoE/3dFx47cwGqUShbcJzzVMiSNNxd/IXU9eBZs4YCCCZHpSKtafwanna2gMqrCc2VUJ4KSl5dyqde/dstVkRHfmYtmAGLgKNal6FhtVg7sOj8jjlsQeyLgOkVMwZdUgx1g5nVKvnX/kcLjklGlPD6OTUArKgfoGBVs128w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202344; c=relaxed/simple;
	bh=iVvqCN2jIvGYzG2ip/MIeScIYsXEeQD/7P1ue7Qqets=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NO06Sza53aNvkZV3O3kF/jPaqOK+NsbAmbZUKF3FFGLLQGL5HxTmKdjTbK9tJuNxKzzkrz9LW+fZpwPSlLjMX2ig3XCPnEh3cah4Sweo2/x4ATyOQX/6eLPo9QVVSbHvTNMb4y47jFjOt8lbrbdEFSpTDj7mNvCAJoc+8turDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvfL4Apv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvfL4Apv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC94A1F000C5;
	Sat, 17 Oct 2026 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202343;
	bh=iVvqCN2jIvGYzG2ip/MIeScIYsXEeQD/7P1ue7Qqets=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvfL4ApvzzjLVlMmziKJCA1nvaGbtlWQAL/AaMn5Jz/HaVkKfWv9QdAdt4VkSlPle
	 kfW7a0D4ByAZ2OyX4Rql9Pkb3lpyKXuajpXucG4vpAVuQoz4WbgHMLWwbw40HNaCxt
	 Mia7BUHK8ELaFYQkoqHmMvBHW+symL0ibaPvKMbayRJYf17uJGcUONN4xk2C98XZP/
	 68oZgE1d5t5f9weoX650ZlgbGHduJ1hUv56DyP1+u8ySX9Eytj3cP7uBcgi+kUXweA
	 9VFeepyiYAdzpprVyrTusUsT7n0z4GaWrBGyvXvm0JpiOGrGD09fCspAP/6y5vP/0h
	 oM4DkfjsTD+Rw==
Message-ID: <sashiko-outbox-175170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] alpha: use user_stack_pointer() in KSTK_ESP()
 and dump_elf_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-3-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
 <20261016-alpha-perf-regs-v3-v2-3-17654742226a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:59:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Both open-code the same PCB lookup.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-alpha-perf=
-regs-v3-v2-0-17654742226a@gmail.com?part=3D3

