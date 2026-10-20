Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505141;
	b=wZEDAJ2quizRsPuiUtfZkHs4LU50wiFAYouqS02/LEejwsy7xoSk58DKGhJ2iKSBeKjb
	 b5+onXu1VN0Po2GdxMHL3p0xB3+mBBfGtjCoBw4/FpcQdj9B0MEMgOwTsN3YCNNBXbZ6i
	 EmpG60i24ZiWL9lEST/b2L5QEqKZrgeuPi5zNQik87WSlkcH1y9g1JR30qR5+oiXVQCFr
	 HrUZ21Knp4+9ULKogoT1e8w8N1gCDoY0ai+vgfIfraJLv2s0HSbpOF8FDPvji3x0pcJQM
	 tcPrb4T1lDBjJiMS+tiYNZ/RrFN4zWIOKtR15pG8R1kXhqApvblul+YP596qzY1ANcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E9Dx9/9Pb/BLYQ9FF/k2P1UknXGNbuVg+8CLYXY0tVs=;
	b=bWqV4ZaOWZNWjX1mePeHw7RJTphQngrAMq4nfVDE759Z7beSzq8RgDYEMCT11aU+Gl3y
	 XIbAoq+MWyEpWEZ8J89o8dPC9hhxYEdu4DLK92MlEGaMV6L7+5GxOH/XVTwPjWyk3pZ7a
	 rEWHyC1M5+raQEtGS7d5ExYo+U7PpA53KDNTQYt3WSzZREV7AJ1/0hglU7C8vBSecI2dd
	 22SuCt5qH8gfeId5SA0alCnB4hcScJj0nr8NFdGNnTP/B9A2M89qHNIGwhHLHAL2wPjRm
	 BljSTmXveeE/4JVkH/43P+noNYbuTgqAviQrYCPcWjl+uewbfJEA9VZfjEL+I5KeAww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxlE+GRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64E606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxlE+GRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845821F000C4;
	Tue, 20 Oct 2026 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505140;
	bh=E9Dx9/9Pb/BLYQ9FF/k2P1UknXGNbuVg+8CLYXY0tVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxlE+GRnNzf5S2Nau1LbMoAVSrj3GR+TxVM8vrCUKPo93qxhonupZUiiKpFUOY93m
	 I8JCpWW5C6c4f2naX7MHAQiuB0qqzLyj3KGl2SG2S3EuM3woy0/szNV+/NigTvnUaz
	 tQqWHyQdKN02CYOfwzFV2jUSpAnlFcbLRK5aY3FkvYm/0NekJeoYxKOO36TLfhFPzA
	 3S79DW9Pegwj1oxHFJNkLt7zWYj2BTwYZs4YtKGGgoQfY2vw4Co8UDXpAeDDchva2s
	 Fv98N6nUM1uGL3llRZmLnYFl8TY4qCG79UqLwbwB4LXcWxCgXXzffraOG2KXEQA5LJ
	 Ip4fpOdQvjIZw==
Message-ID: <sashiko-outbox-179082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/15] perf annotate-arm64: Enable instruction
 tracking support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b216cc26455f9ee39222fd9d5efc4dd53ec83e24.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <b216cc26455f9ee39222fd9d5efc4dd53ec83e24.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:05:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable basic instruction tracking for arm64 by implementing three
> essential functions in the find_data_type_block() call path:
>=20
>   find_data_type_block
>     -> arch_supports_insn_tracking  (1)
>     -> find_data_type_insn
>          -> init_type_state         (2)
>          -> update_var_state
>          -> update_insn_state       (3)
>=20
> Changes:
>=20
> * arch_supports_insn_tracking(): add arm64 to the list of supported
>   architectures, allowing find_data_type_block() to proceed with data
>   type analysis.
> [ ... ]
> inference during instruction tracking.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D2

