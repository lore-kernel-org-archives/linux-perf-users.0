Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02B468C0F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750616; cv=none; b=EcmbLAwd5hRV4XEgckHnaidfVULElw52NKQg50EPhQJJadB3K4CDirWUDBO/1ePfhEq3Hr+hFPVzzmCcTe7fc7h/6FN900b/cfoNXZbsF0SE/IIsQUApupOgCl7pKqUyJsUZn5Iddp34UZZS/FoyPxnJ6TTvgc+Zgezu4RHHk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750616; c=relaxed/simple;
	bh=cck0gVlLbrgJ1KIPb4bHuvs9KpsJ8y8tjNrty/1ldtI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FFISIoNXRgGB5fqr7RD6I3Y5kr0H+3DTeZcRuD9TxmyG4vrlz+msfNiz5SxwG0yw5120j7779n+4WJPCLAr2UB2G8jvtiplVBRQ6ilyq8Jm6e0jsNYXcOBaT0OkyUo3ALfH7AmN9DE5BeeeID6V7qHNYeifNaGSdeG9MlmFajnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCEaWXZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCEaWXZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719681F0089B;
	Sun, 11 Oct 2026 20:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750614;
	bh=cck0gVlLbrgJ1KIPb4bHuvs9KpsJ8y8tjNrty/1ldtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCEaWXZzb3yfvTbaN0UPB/iHCB2b+fXjGcdIBSduovWYZgP4Sz3MQyPp1buV6Loaa
	 BuJb/n2JXjRY81nEl92ofq2Xdt5wH/t9aT6I0Yx1Le48Jeulu3fqIRkT43Miereo9m
	 /aFEZlI2AQ3F5GRuC09YDWZZAwECj5x0r6EUYUNfbuhLtepyQWgPWWazimqY3PdWPS
	 TNKG9Vy2mdYbWbTSlraVIhMdCfNnlorKbcrFTaw3TuU8doPEdro87CRohr+XRBMNf1
	 UxAI2SupowAtTTW1LSTqI0d7SkKt7hbKSoHOs49Qp3xX1Dcn8wMCNe32Bd182uW3zD
	 WmD1ZTmxfnu1w==
Message-ID: <sashiko-outbox-167450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] alpha: stop storing the user stack pointer in
 pt_regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-2-eaa625a39712@gmail.com>
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
 <20261011-alpha-perf-regs-v3-v1-2-eaa625a39712@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:30:13 +0000
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
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-alpha-perf=
-regs-v3-v1-0-eaa625a39712@gmail.com?part=3D2

