Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754101;
	b=1wrAiAhYzBCLgZPSPeFCtOh4W9mXbs+gRur8TPGOx3s9q02o7iJiJl5x9jcGxZXlYasI
	 dD6YqCzqClmu7U+p0y9d0Xbx8UxnAoH6H9RKtHYzl56ruHHy4CpeQBV4hvqVflrqRr++U
	 vfy9RF43O5dvXAwblGu5+RhLECHUKUOYXSODDZUzS+jW6+Ns7lK0cjj2ZYz1Hw8K6gdsT
	 q1Hn5gkO4Htlz78mBKBGqhJjLUMDm8lveVBLjYUau6AjHR8K7C7So1Ut38xTj2W7x8fBN
	 LxVy6U0i+Aua3YLPIRFYQYNEWWtfonItP2VKgBn2zYgVmwmMnSJt4s7xVThvZ7FDKVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dg7tKDwhywzJUK9kE7bg46KY8PwGeMznRUs8bymcAlA=;
	b=HV81aiBQck5+RTbRZx/83jsc9u8ABVUF/A/AQ1vMxe5uZlqasgXG8MC0VYNWH79Pu6ed
	 lGIxmsQaBEKmCosL+23Gq/TGcFKB/DF50v4NChIDwgp9SHFUnZ57Pn4L2qGazEmMbejOp
	 viz0E/wHUtuwZnrdBLlQ29BtJICUWZaETLTjplghO7PlShC9KHnNap/hA1a6mOK81sgzf
	 76ghhJ0NRr1fpCIcONAbvarWbnhcIQ9vQpHzkrNmSsYz6vFQQsIUzB9P+eUkJn2tJVUCZ
	 ePq2d1W5a+4UaRkMccrQqaYUg6OkEdfE3tQf3FQWeWLmMNB7rlYtrNw80JrtIBqEWPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwOhgrwX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB7606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwOhgrwX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5171F000C1;
	Wed,  4 Nov 2026 01:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754100;
	bh=dg7tKDwhywzJUK9kE7bg46KY8PwGeMznRUs8bymcAlA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dwOhgrwX6Yj+h2PNQ4cEXeB7/g1/sRQ0z3IPSlZorwi1i/1TNMYwz3d/TtXWa0wOB
	 z3jFKPgzSjsoMPaioEx1G6pZstBcQgIn1mdhQW0tfUwVT4hYDwpECpfm4X9jhwD4OO
	 271RbBSAsHnuhSdgZbv1z9glk1T3ud7irRisDY1Iyrmdw2iYScvKX634k7XviiTcAS
	 9djqxGnwzHJhXxMnzX3RbZ2tTuWLhRgv+X8Y0CoCFhdlyXAfZDvOxIh6v4nCu36kLW
	 nAvlx72YAk2mzndOZP/4Zk4IhCPjGVZFs7Ch4LwIDhCe4Atu7bC5xHa8Vn4B9WCtFj
	 MJq4J229nYj+g==
Message-ID: <sashiko-outbox-196331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/41] perf pmus: Pass struct perf_pmus to scan
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-7-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:01:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Update perf_pmus__scan() and perf_pmus__scan_core() to take a
> struct perf_pmus * argument and update callers to pass the appropriate
> environment's PMUs.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D6

