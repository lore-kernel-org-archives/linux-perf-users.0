Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601205;
	b=bl+X1O8a7WALnW9AOPYVDAwr+amJcpn4mtbXTkmyiksBB6DlOMKVUkeIJNIqWvn1RebN
	 coThzEONQqzu4+f4dqQqIDu6+eghIv9M88pP26hlCwLeNPw2/2cFstSMgJFzdCcNllRej
	 iPmzvI2lZ9GSQS1FcLX94ARkf1rIilGp52fkRH2BSTz05zNFPO3eUZnbCMEB1LjLIEc9L
	 PUu6dORVF6qH07tgB40+qJaJViOKuLc8bKqXpO0i5ZfWvZb0xgWnw9RNOZKy4ydQue9hI
	 joD7TVRuWccAglFk/l/3yeOxiu4psdz5QKykuNj0fRnAXlEfYUSc12iGJpLirUQY5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601205;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+a0aSihpVoNIkt5b/94NanpArDpbx/GsPqX06yQ2tpI=;
	b=hn5WkXDVADUKECw9M8LoJ8dH2CUlOTtOiqi5M34jK6CxdGApH+yUjNVIo578yeHsKRx4
	 Au0CoNqb1xAP7AxhjPkk6KmJ0C4TI9uI6fo1xg5w1oOvtwPuX+iucJPzFetl1XXhT6rU3
	 Qh4+/99bCxklBGpZVSjFucw9HTmQRVpZXXkyECGyZ/CJju/PZ/AymZlBZpQoe5chcb6kV
	 yAoFnzyOC/GxJ0cY5pOOHn5C9tRq8SKiKLj6OrogL3Z1d0KN0HLBD/nsgnV6vRkz5fMO5
	 tCEI3/7rRktEVtFr045nQo4ZeE4Nx8Zl791M7PLbxekCdI11Fzg5l0fIY9ULqpPv3Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGirED9h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8F606A334
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGirED9h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D6E1F000D4;
	Wed, 25 Nov 2026 10:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601204;
	bh=+a0aSihpVoNIkt5b/94NanpArDpbx/GsPqX06yQ2tpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGirED9hpm/7ojaaBINptAtkiBNdWoj4mevLaAId+nlGXP2DoJvsV/pXbo47YX6UF
	 Zb9cMwcpf5i0I1AOSS67QYvIj7utjOGbcwh7y6uQekjSUWPZCIB5IpPju/zzy7Ej8E
	 eptC4O0WRc0Wf8/Hxa1n+67sxBYnZ6KVlQJsV89HSDKXi4hPR1LE6Y8e37GvDpkF7I
	 iEBwA/s5q1y7zXXJOZWr6+hBDtzWFl7/kn6iLGJpSwUuwrcrymZ8XaAkQXzkK4J3IU
	 Zo+6TC119fuYUAdyLRzWnFPTU5ckKKotroiVzx0FDhKvF+JimaLm3nzJ4kA5oWYy3H
	 dpjI2QMM+Xgxg==
Message-ID: <sashiko-outbox-233086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] arm64: perf: Drop the example the userspace counter
 section points at
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125100357.1937729-1-takano32@gmail.com>
References: <20261111034432.2020955-1-takano32@gmail.com>
 <20261125100357.1937729-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:06:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Documentation/arch/arm64/perf.rst points at
> tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
> target, but that file is not in the tree and no commit in the history
> leading to this base has added one.
>=20
> The section already describes how to use the libperf helpers and points at
> tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
> sends the reader elsewhere is redundant.  Remove it and the link target
> rather than pointing at another test, and give the commands to build and
> run that example in the How-to section, next to the reference it belongs
> to.
>=20
> The edit and this changelog were written with the help of an LLM
> assistant (Hermes Agent).  I reviewed the diff and the reasoning, and I
> am responsible for the submission.
>=20
> Fixes: aa1005d15d2a ("Documentation: arm64: Document PMU counters access =
from userspace")
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125100357.1937=
729-1-takano32@gmail.com?part=3D1
