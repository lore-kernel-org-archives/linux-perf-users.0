Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738883;
	b=qRqlYqiwU/RTVmlfh8x0gEVH1BS8EWnwmMlP2KWRQGiFRUZroShsbtG7GwBjCL7be4V9
	 HG9ncvI1TLs0SRNhpGTjEzedU3pdoV7uqh5SNOVAy/JCGG+H0MZ+orDj9h7/LMjWXexn0
	 xudUq0SEzm+PybJMqLv6Yx8j5eEGnLkjvDI3D7jOybrjYmrwtbDtrdPW3hsb4YbP5QOxN
	 sM2OJZovZiheDNn9sQAv8LxEiiNOBs3cm0ZmKYEiUWu5eJ3i3N96lABIrMdTrdYOYJ+Fy
	 TV6LUYnZysnIMwWXDCzB8rLwGB/h8GK/KU5oAbHlIZnYJeyHkzHDJxf5Iepv0wvdNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GVRUF3Gj202ReJKqj6ISrfRznVfO8qG5Vz3LczwiRBY=;
	b=YvHgbMrg6fOUjxWEGJ+EaGklMgHS1RW1nju0f8qF8C4kntA2UXc9wJ0b5+W0CqGbgQMp
	 cg7U74tAMed+jslcYqk3CGH3wI+/A0iupM/sitWbWKpFWdu4wSsnf3L/HLeGgBbm1oIeY
	 70/kivdyeESy5zZP8sjX+FcIMMifK1LqzVQaiIq+fMlAKFPT7omM8CzbaNd0DI3MUinKK
	 QdZWnP7j66k9ZLHW69pp641zPX/1iafp4S+nJq2vjzSVYSWS5TS4eE4KGIysRTwVjzl82
	 Bi4YnIW5Mi3BK/dUYvyFA8O14Bij6hAssNNF+oYEBcTPdOdsq3PLi0FrQu75mIxTFMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOAQu8L9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A68606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOAQu8L9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB21F000C1;
	Tue,  3 Nov 2026 20:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738882;
	bh=GVRUF3Gj202ReJKqj6ISrfRznVfO8qG5Vz3LczwiRBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AOAQu8L9XAjn4zZMyfAJBbCKPM6lgxZuOOV+gKS1Q1c1RfjCS2R9yanzGfX2abVuF
	 KucOKqkIFZ0o5xXQ5gD2qIcVGUp1l1SthPCXm/HxEtKpP+P4+kyE5XtkuM0gSItmqE
	 iK9+p1JbV42UVlrI7Ij8LQ82Hsm7cz8y/9caQmJ7fI1gWxcQ4o0ynvseJdBsCSNyAe
	 faFCLYJUFyZ/t7jt0WSsMs18So8yccRqxBBRNVYA1Mn73SS5ECd68OiBisTuvCWJZt
	 nPSfT+P0xcaqLvtffmwDQQMBAAaHlUaMW7ThBwHhlfVWXFupiLelOjtjyBoRglF5PW
	 Nn6uVnnPEjHlw==
Message-ID: <sashiko-outbox-196014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/11] alpha/perf: report the data source of
 ProfileMe DTB misses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-9-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-9-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:48:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A ProfileMe sample whose instruction trapped on a DTB miss identifies a
> memory access that missed the DTB, but only in the PERF_SAMPLE_RAW data.
>=20
> Set PERF_SAMPLE_DATA_SRC for those samples, so that the memory sort keys
> see them: mem_dtlb is an L1 miss, and mem_op comes from the opcode, as
> I_STAT does not say whether the access was a load or a store. Samples
> that fall back to the interrupted PC get none.
>=20
> I_STAT[TRP] is ignored for an instruction killed before it was mapped. On
> an EV7, TRP and MIS were seen set for killed instructions that are not
> even branches.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D9

