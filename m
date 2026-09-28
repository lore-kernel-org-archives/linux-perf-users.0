Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A93845DC
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620723; cv=none; b=DpU6TlK5LShy48oKEEeZPOfG8foCWzrgQRnsTeeSCbM8nPeskmto4SEAIH0NQlT7ZsghRZ+U+kYwy3fAX4uxi4xhryMMAyWsEs5dO9Oqk0fByHKMocqbD2ITEgPxuqMFbRzEvGvY7L6uKtBYe3dMaqocZRCAmd7QYn83FsWC5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620723; c=relaxed/simple;
	bh=MtMG488LImR0DuRo+pxrnjOVXgTOEOg8mO0SwR9bwo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uunv/yzIBt7XuMqAJeh9YkTdm9l7bPTEwsUyqwR2BnYgtj6VgqJRvMdPnYFyWvHbEW4ruR9+LqYBLoCKIMF5ibSxW5rzNf3gejTwkvGspo7zf28G3r3hiCu9eKDqsr4JLiIp896ROAqWsKFgRVTxGFsOAd60sjQxLTMR5abTtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtYptp7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtYptp7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10301F000FF;
	Mon, 28 Sep 2026 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620721;
	bh=MtMG488LImR0DuRo+pxrnjOVXgTOEOg8mO0SwR9bwo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZtYptp7ye/qTs1hSvnSvNV4+48mMlOhVQPGd+ndpptV5qvOCtPJK6+2tjL0srN1Yu
	 7hk6/KNJdk64oF1BVcXm8TSCkA3zUCEACHzHS+34CGAT/9amDoH0pFQiHhNqCiGy7x
	 pHl/I1qgy7WQSEW1p7IgzoqUJsEShRlcABr4kYxBbKHseer6tLiG3wHtPson1Th7E0
	 kOVwvAFdXb7r3BLhu/ZAe85fg024/wMw1q4SeUIrYsWPRUxBqb7c55DaJ9MyYlwusl
	 xnRyfJYqlceDSWH/AefCqvRBit3hxidmTPt46mOsvwB60+qLuWnNgWPp7tapiwZqvU
	 X+j4aygJNvb2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-7-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:38:41 +0000
Message-Id: <20260928183841.A10301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The BTF augmenter copies sizeof(struct sockaddr), 16 bytes, for the
> sockaddr arguments of connect, bind and sendto, and runs before the
> sys_enter_connect and sys_enter_sendto programs that copy their length.
> An IPv6 address needs 24 or 28 bytes, so the rest was read from past the
> payload, and now that the printers are bounded only its family is shown.
>=20
> Copy them as buffers sized by the length argument after them, up to the
> 32 bytes augmented buffers are limited to. That holds an IPv6 address
> and doubles the AF_LOCAL path shown.
>=20
> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D6

