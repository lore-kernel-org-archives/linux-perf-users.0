Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039302;
	b=L5Em1GJPbE60i9CBZgk0Wuq4TgHM7GCo7wtmKDAo4Vl/SQWBzWU9bpFBURIc4trBQKXo
	 KYv4WU+ya5fk9n5JvLPICA1Zc6e9p06L2ngKlSNqCTaU3u8HrmwUoBatsJaeaAJr1HT1t
	 x9YXa0ISctu0K4xN/ooUcXmF+QZEFxtnsVLM8XQObL2pW4H46wna3jZIQWnZhJ9mIwFE0
	 PwOXtyU7VRo6Y3GZTMx8j7npYN7ynEp/8oUKzVCIc1Vkr7dNz0xZ2TK3RfD1QscDpzx08
	 /ceIzMjiYr8JwCPNxX69q4ql8w8vWtUk9PJrgN8wxrRlh0+x6DQBcVyoIDcbeI1qavg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NcxWCVBheD/xajPSaSVHmZjhutz1lHSkf8UPl5APDUQ=;
	b=C8LUWCk/wVlD55GgBgipb96ACfBS3vo0EtPUDXRvWHs3P/d9pQ2QNKtrX94/vIvfxq0H
	 6aqfVAT+dfF4QpH5yedcWG6aUpUC1NGIUV3Rc1qjWIHk02/Z7kn2SbN6bhR9cnTuNKdlp
	 8PqsG7jZCCmo9gKrhGNlwxjHz6xznPd586+HiP78nc5vIR6i2VjFMo8is5LarbR1+THCr
	 6EYCS4O9wCkbAPJXhlIDK7xwiz+jcTJKWrQ7zlnb8BkQtsPinz5lsmumL62Xky8AL58cU
	 ptkVyPHXX/ne/o5YeiJAw5Tk/lgJRVbCdbRTA012xraJ0YTM8lQW8/SJMUG36Ije8EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhNSmk80;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A00606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhNSmk80
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDA21F000C6;
	Wed, 18 Nov 2026 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039301;
	bh=NcxWCVBheD/xajPSaSVHmZjhutz1lHSkf8UPl5APDUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HhNSmk80qdMbN8QuLGXRHXf+f52/CktnXVerpuix47KGZBdrIm6/UyPCFx7q8WVXQ
	 GHhEMMBBTPRBSzLicOVPIgWYSf5LG0VouZBHf3epTrwRo/BNHYMYB3GQm2e/8vY18V
	 GZxlWyPmwElGy6erQplTvCDEea5ZYd/ATVxFGlV1kGzMEVfM/FAGFWb4GmOEz9RmZp
	 nORGWlMCG6vOXxtfySLXu6b32Jn6FLZszZuHeexUwXK3QsVUxFBENMHF+IryAA6ej2
	 eH+1acIBZsl03gEcxKtDbGKemJAcw13zpicM4xsIVqEXIl5+7P2FoOyczm12bSyjxA
	 s72xlmD1fDYxg==
Message-ID: <sashiko-outbox-222067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/13] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-6-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:01:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member; find_data_type()
> folds offsets past the struct modulo the element size back to the
> member's offset (+0x4 for char data[]).  The test skips on 32-bit PIE
> builds, which reach static globals relative to the GOT base register.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D5

