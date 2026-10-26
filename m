Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004556;
	b=B5M6J5dlrClOcGEa6SGHkVFAzphgbhC/H6yzJMXdvr0Op8YDMPEoQ9JZoSTifkpxwNv9
	 /PPuXChRXX4bvn21+XNMmgmaSKTKOxID0+X9kDFh2TbjwZlvmwQCP8Fp7z890NrUD0I/e
	 NbYalJXTdtqzwQDfgZTFx2kO68wFDHooqLa/4OtBJReYqn7GCrZq4b1t5Jxe35IAb+ZHu
	 ausDwMVmf2bsxp6N/Wk2d+FOOW9yuZD37OFfX1V7BYDCHyvovQXPZYxbhDMr3K6AX1Zu6
	 i+Y9fXCQ4YDOIjwEaF8d+Ppr/siXwj5LQD7kMBB0SA6U4Pga2KSfj4CtlTNKe88h1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004556;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DY9hM6TVBcOzYr+wmH4q5B85xgccCHzKx6tmBTYhaqM=;
	b=Xo73HQFR2u8vqsw2ROvNw9iC+f3sudeWenp2IZCwLN7+GHS5LK03GCnZ7Zvas6Ku26eo
	 asGHQNAOX2wqmkeVTVXxBqFRn4GP9wOTHqiCFqE4A5kpH3tvdlLPxolBOMWSSjbUCcXI/
	 yu9Jkr5MQtl5pLYSYjmf95P/u+L6VDu7IlIh6OldxyZ7J8SnaIHiBdXzFf+//DgpAzOYw
	 T9nIn/4ydKEBPr3l3HJ70OBvNPMdC59FJsqyzDb11yYqqIxN/DqwlZixX0UY9SXgxSM1s
	 xnyeOJ5Qlj1/VLD/lB9ue1zoMmQ9YtsxEu9pRVieHoNizrWiqJxxPEMa7a2xyNUt9yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kclOtsFX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D8606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kclOtsFX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FCD1F01825;
	Mon, 26 Oct 2026 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004555;
	bh=DY9hM6TVBcOzYr+wmH4q5B85xgccCHzKx6tmBTYhaqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kclOtsFX1ff8vHFk538FrIQ3UZMMDlqJ2IkChdAzfv4hqk6OeMTSdsk2neVJyVvaf
	 BAS4pYoey6ONART2s1U+zfg/tOoeHmFnJYyCNchDWlttYJ4qqVAYuqHzuM6PubCjaJ
	 wlwrR57DnPY8LnlbOk8w5M4qc1zYvP/zt379plPS8rysJ4ozibW5PTI6sZGR0osAbm
	 vSzwiEfixo/G5EUFMNRPD99lktWbdqr86f7c//+a5Y5Q/Iwa8z2lvLB9wIRNxE6C4a
	 B7WP0oIZXe3DSY9zYkNabeNKPI0rUrlxfTkW6tbwCJwk1HYmLh+EFN4VRO803PiFIu
	 UD07QATBIidVA==
Message-ID: <sashiko-outbox-184694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] coresight: syscfg: Match feature capabilities
 separately from device class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:49:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A feature loads on a device when the two share any match flag. That works
> for device classes, where a feature wants any one of them, but not for
> capabilities a device may or may not have: a feature that sets a class
> and a capability would still load on a device of that class without the
> capability.
>=20
> Split the match flags into CS_CFG_MATCH_CLASS_MASK for device classes and
> CS_CFG_MATCH_CAP_MASK for capabilities. A feature now loads on a device
> that shares one of its classes and has all of its capabilities. Check
> this once in cscfg_load_feat_csdev(), which both the feature and the
> device registration paths call. No capability flags are defined yet, so
> matching is unchanged.
>=20
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D3

