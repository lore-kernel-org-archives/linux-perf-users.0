Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622191;
	b=MKWLzny3oMlBnyZnGIvI7QXXWjeXEoQBKFIaPu4JqY3/PPhIlh+wJ4jwsr5f369Cprss
	 IAyLVxVQ7yIfgWjxdGHlB9+DjW3ERHglOsKadZ0+oLRXfNSeBrwrPGmGA13hUJ9qpys7S
	 XXGgpWVu+AkSHVYRGQzeHuSjXwUyMghbGx7KihuCcszZAs6/bX0058FRQc7p4ZC5Nu5+M
	 jfPtVSUaRdkCSY5lSLv0bvNFVbilyGh9kulunx/pJd6cQsY6NlnjJ80IHPBqStZW8KB4W
	 AwYL4EWALu3OzsIU/P6ou0O4sDiVEVX+G5D8OfIcZ5FUFFUiYQl2m5I8tc/eyld85aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aQ9OUKSCybTMVO32at2dgr7rMe2FphL1GEt5vsUombU=;
	b=yl/tHcAOJT1L734OIiUdBYxX9u+qQSODfvXdad+fOirxiVktUTwHrzu6JOJvSRcwZnxu
	 gIwexZ3GltP4BXYcHV7Fn2l2Nn2zRhL3rHTaHRwqQHBLHv8IOQoIM/E/V1f1PlgYrcQup
	 /QZLmsG4mksAhcmNaYvLkhKaq/e4qTe6hbGO6G3VnnVyGMEFglA4V58mIeSl4mPWYi0zc
	 4FsqPUv6UdifpmztjDZs5nVqgmfuMXJEg+EdvOGfAkKHBHNx+nzHYq7U9lFtniJscYBNz
	 IeGpQQQSGXwByyO0Uy2JymzWLNUcAXpnSAR9Q6cfbNImPcv9z4MO9lHKW2ZL5kbgNkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2gXUBnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE060A260E
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2gXUBnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17361F00A18;
	Mon,  2 Nov 2026 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622190;
	bh=aQ9OUKSCybTMVO32at2dgr7rMe2FphL1GEt5vsUombU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O2gXUBnvp2zweP4S+KFf1cVotVFV7Lg6ZqS5olVf7gjbr3C2QKKqSzEiMwOM/sC3X
	 cWD/UZenGbXY+Ck7HVESyH/UhxC6eRQ9/4np6JVUIs6NFlTdg9kvU5N+K9S6UdDIwc
	 cfWM11iW2Mf0MitnFJbJyg9+AyX9mDOppfRDsP7eiVjt79q9bfBDCzkjKt+sX38G2K
	 kGAmEsLFygYU5NMKMq9HvVN/p9AaVvM8TYQvMiBUYaoI8SmbkIdJufjHVKsPBypYUv
	 NaboZTWXXEwkz6aStF8Nf9kPimO1CM0k41ab4e8t09KRcXamzUBys1uMLUoo9MTBAg
	 FQK2FZcQy/v/w==
Message-ID: <sashiko-outbox-193393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/18] perf python: Expose sample instruction length
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-7-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-7-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:23:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Expose perf_sample::insn_len as a read-only insn_len attribute.
>=20
> Trace decoders supply instruction lengths on synthesized samples to
> indicate whether an instruction was executed or not during a call or
> exception. Let scripts read this value directly.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D7

