Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238F44BCA1
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388794; cv=none; b=etgI6fKHjUtv8n/2BIxBZTta0yf5FwZ5i+S3NPO8Ckf6WWJstouxXZ40F565BBN7S5fbur5/NdGKjBrK+NGV6nIixLMyRA8QaMawPLsgY6XQ3PKQvn/nbnXm1q7y1unNCe7nnZYL+MRf6S6XH832KXoByYwEcUnWAwyIFgHdWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388794; c=relaxed/simple;
	bh=IUqgJdVHf/j01mB4Yq5iXQFbaWNTTCrk25lK3DnRR6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C5D3LU5qI2kfB5yyVJo1AokO90YCSbgszA8dqAecX5MLz5gbYfN9cPRreAQ8kqQgQ1XKvv8oDhdhxb1+6TESjuovmH17AW7VhwR/7Lo9S8XD+LmclpEKaXNM7zCe0tUkvllX77mIG5VN147g43u9BZ/B6k21GvWY10G/4upUyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbV8dqdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbV8dqdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED441F00893;
	Mon, 14 Sep 2026 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789388792;
	bh=IUqgJdVHf/j01mB4Yq5iXQFbaWNTTCrk25lK3DnRR6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbV8dqdgrH9XRIL7/7Hpb5h2LktiCGPLQ4eOTLpDtfnKV8t8icnTOURJGk/jYRDp4
	 XgoHT8ss03jvw6ovjtNDymiLLBwj5c/xN7+FX/9MJVHPUs3Bn6Jhph/hGVEbqKvSUz
	 VjljWc96jpa0yWGCM01F4BR+UzDnbHR817QQm2e7cFyl8+UhkZMU7y4ZXa1xoc7oca
	 K/emzesx0l+nl+W14ijJ7aL17RmofTmHaKi9zWvVTBCKksobXGT5ZUui/Uh4BeUgf7
	 6CRN3p4DJ4w10iclSrySow0hOh4q/sBhK7CoyR0fdUcpTb2/p1ELw3bHF6NsCVnHIA
	 QRJYc/98g4eVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Fix a leaked map reference in the arch dwarf
 unwind tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914121903.1212-1-cp0613@linux.alibaba.com>
References: <20260914121903.1212-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:26:31 +0000
Message-Id: <20260914122632.3ED441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> maps__find() has returned a reference to the map it finds since
> commit 42fd623b58db ("perf maps: Get map before returning in
> maps__find"), which updated arch/x86/tests/dwarf-unwind.c but missed
> the arm, arm64 and powerpc copies. Release the map after reading its
> end, as x86 does. All other callers of maps__find() already release
> what they get.
>=20
> Fixes: 42fd623b58db ("perf maps: Get map before returning in maps__find")
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914121903.1212=
-1-cp0613@linux.alibaba.com?part=3D1

