Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738766;
	b=QynV9Acb7KAmTgxF6bsWWl8aDPKjSYBJOW5QGgyacYMMQFgWMrQhPdssiC/nKbE+MC42
	 rJS1iCLF7bwthBOrTwDBZ8iPJf1ZCW3hx3mMsm7kLORKgM/Es+Je72LEHoI6FccKJyz9K
	 4bQyX6U1wbLQPVtMuYWWSuK78cdGJjMRZDCULLqbpqFV0MY+wJ8Hod2ew4lhK3nr7jGPa
	 gZAhOn7NcKnpnthqqloL+hpiXN1mzA66HgsD1SiwUe9PF868bflmfewLktDjVBFrTMieC
	 OK7rqumXIziQbfvXtJetZlRXDg59ka76ljAOtsVmKFEqyoYco1PgPa5pBvxB4gg2ung==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9M7iCnvJB/hrBg6FIghxOu5pxby9gl/eYcNgJFVOwrc=;
	b=Nlhn6bUFX7QVvWLXpzLyl0pP/qRQ1zW5BSw/fk134HxTxGFVjLguhFjdBjrfIuGt5QHa
	 lp0rA51xK+1C2jh94bY3sIEttbUE2gZjdJKn+O1Yw0wv6n1MVOAamR69d/jsdeiacpCIv
	 qJhr0pyTxaMHgjc++nihYx+Wz7bGfo0q+1MzPH7sw8tbK5YE2gAPswvivvd1up2UNJvuW
	 WF4VggVlXfjmpGpbdZ8nZ0jZkhINteXeweAukxoREnfcICgg2uGmjW2gGoweX8kG9STNo
	 2O5zFN+arGrY2LBOtjl73aP37cDcQ8iytVil3uMWTZTARpEDHqgREkjUfxyXIMjDxpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd6VcQh2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD8606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd6VcQh2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB811F000C1;
	Tue,  3 Nov 2026 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738766;
	bh=9M7iCnvJB/hrBg6FIghxOu5pxby9gl/eYcNgJFVOwrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bd6VcQh2a9G/Ka5kHcEjwgs4nAkU/7fOm2CZ2xWbr40/W9vSWyM3QfqJg35IBs/5j
	 7pvzdTgvNpoYUitmPVOoSidSSaHlFr0Du0i5HR7N3qr3Jmv0/fNXxn+Uf2LQpkfA9w
	 G6Igt5tCvimvGinJlPV8QvWv134j15/0EZ5RI27XU//K0EK3WIS1K82bWeR7lm5y1m
	 SNjWuvWXYzrnYRwViwvTC6ntWEj95azhI6a+MXjUnzVPmiag+FuBAU+5Mi5TbgD2WH
	 lpZWksjgRlIwxvdVZrr8LjgPgDp3OO+9b1j9rBro6cD2O4xaFFoJy/u7zgPcoNQrTC
	 a1paM9SudnN+Q==
Message-ID: <sashiko-outbox-196010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] alpha/perf: do not report user registers from
 the entry code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-4-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-4-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:46:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_get_regs_user() returns task_pt_regs() whenever a sample of a user
> task lands in the kernel. But exception entry runs with interrupts
> enabled, so the sample can land before the entry code has saved the user
> registers. Only the part PALcode pushed is valid then. An interrupt
> taken on the first instruction of entUna, say, pushes its own frame on
> top of PALcode's, which overlaps the rest of the user frame, so r7 and r8
> read as the interrupt's r23 and r24.
>=20
> Report no user registers while the interrupted PC is in the entry code.
> Such a sample also gets no user stack dump. The range is all of the entry
> code from entInt to the end of the save in entSys, so it also drops the
> registers of samples that land after they were saved there.
>=20
> An interrupt that nests on one taken in the entry code still reads the
> incomplete frame, as its own PC has left the entry code.
>=20
> Fixes: 9280e99d87dd ("alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_=
DUMP support")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D4

