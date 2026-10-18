Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76E3ACEE0
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333528; cv=none; b=nPqMqPK3ISRZJ68ryHERZFKuuGZyhFveZu6+eYdlPms7Jurgl4DqwvxqG/xGW4ti0dTlm3yimg83QPd+QvRv2UH8a3rTwlKUqqpGKNigdl9+eYFXN6YMV64lkAwfhOPXDWzZ1dhdYbJ71P6x7fa0e0OXLDQ03qtx9b5rVgoi+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333528; c=relaxed/simple;
	bh=EH/uh8Y5BfyaGtV1GScsiJPFMm/QLxtvuIpbeeXiegI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=o8jMXkCZV13Vu8l7try6NEiujNvZpZPKaTtYiA5xi8GLpOvt/j4IJTzxM6u/jbH+uAuCNzq80eeS4N1q0ssy5/QHE7Po2WoHd3XYKEDCbgYDMlfdoISWOO1j0OQ36kukQntRMf9vqp1WhDsj6Iy2Tp8lMAU0E5QPSajegvYYz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpwCTcVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpwCTcVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFBF1F000C4;
	Sun, 18 Oct 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792333526;
	bh=EH/uh8Y5BfyaGtV1GScsiJPFMm/QLxtvuIpbeeXiegI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpwCTcVs/W6dyv1DSnv2i3UkDVS/0vnNO3Xv1itkXIID07VR9Yl5UooVkY2QaBSUx
	 CU9/296n/ZVxA7I0//zw3YgmyPYl6eJJWKkiLKZXUj8lgPMF1TWqdKfb1T4MSA9RUp
	 hvlbhFDIzecK7vuZzAETfcBFG6wc8H1YAGabNQg4NZ3urHpH75IYb6j7KEdbdtix7a
	 OBOSBYIpwbO3lywn4RL9o6w+SFXu1nu8VL70ReYieis53obYneoVPwSN8TiWCPwlA0
	 qftqFsusJ9Vv6pHZ4kKmHDKDG6LjZ40cWald/sG1BGH4TOd6Fq7d+foLY47236CYi8
	 KArPZ83J0Xouw==
Message-ID: <sashiko-outbox-176195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] alpha: stop storing the user stack pointer in
 pt_regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-2-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
 <20261018-alpha-perf-regs-v3-v3-2-52be85332c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:25:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-alpha-perf=
-regs-v3-v3-0-52be85332c57@gmail.com?part=3D2

