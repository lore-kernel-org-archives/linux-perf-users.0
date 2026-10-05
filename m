Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FF4B66E6
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222114; cv=none; b=XrToCudDpux27RlD51m9tPs5LfcyLifVxjGj0UqFEYh/PTht2AHG19+mGyoEaYIeattJ3ngbqC8bUrBtrFewvUsAjhXKnfemcOMmtHpe0W3Z7DW47Kqq9apHL5BhzuQLPMb5MxVcXPXovho7sMo3LncqyEwtruM+aqPGrOPIFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222114; c=relaxed/simple;
	bh=O739V31gl9OrEY4nOdyTDia4qneZioIRE7Pf04i8CnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKHKTXZ4/GZT1bwnV+YZH6O0eEIfGMtkuGIcwL8/uqc8M0v+OAf6ZVPPQ/SJcGKJaUXk7AbH6SkOJHUMX8P9Buo0YtllVS8nKZNcaP7IscPwwYoLAVFVUq5ov5IS8AGaKgFK9fds84KHPkr/bKkTM+CYSV929CgJM5GC2FEm8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oydt3geB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oydt3geB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242931F000FF;
	Mon,  5 Oct 2026 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222113;
	bh=4TXSGAuAlz1HDEh7uRb6Fha+ZpVNG1uxTbPutZhs+mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oydt3geBuBFD+xwZgFnJFtxyEtghyUUIB6P2SryVBDL2qNIK+uPay1m+PlT2q0zOW
	 BKCQPGHuI4xAl6SCnfqIIk+SjHK2NupwGlEhP7qYdM88+V3P8AD/YdheZ7Xt8fR/Gg
	 4Gwm8LkrJ63kpKuxSDXe2ILUP39msHjNo9+TZ8QOPul5qJpOXUJ7nQBjf6vDupHE8J
	 E1q5rXe8UNZUxF6L4UU75MVVd25sybag+Yv87dqK2074OZL5GcqErH983oYcJA8ghj
	 PopY2lsVjFfq1VrwwkGxRe9L76+lEw7YvJRL1NvLuwicp5lERlif2Myw5UZkhYaqJt
	 LITT8RIaPQlBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] perf test: Test lazy symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005-perf-symbol-memory-send-v5-5-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-5-165dceb2b049@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:41:52 +0000
Message-Id: <20261005174153.242931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Add a perf script shell test for --lazy-load-symbols.
>=20
> Record a small callchain fixture, require evidence that the controlled
> perf DSO built an on-demand index, and compare only extracted occurrences
> of the controlled test_loop symbol. This avoids coupling the test to
> addresses, diagnostics, or architecture-specific symbols for which the
> eager and lazy loaders have documented differences. When run as root,
> also profile perf in a private mount namespace whose build-id cache
> directory is hidden by a tmpfs, so that names must be read from the
> build-id cache in perf's own namespace.
>=20
> Report unsupported recording, missing controlled output, and unavailable
> libelf as skips without replacing a prior failure, and keep helper
> [ ... ]
>   - on x86_64, a binary with an IRELATIVE PLT slot whose IFUNC loses
>     duplicate selection to an alias that loses to another one in turn,
>     so the PLT symbol name depends on how the IFUNC mark is passed on.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-perf-symbo=
l-memory-send-v5-0-165dceb2b049@uber.com?part=3D5

