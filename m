Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F48400978
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589330; cv=none; b=sjuWKkCo06AqWOsqA0rU6i9MahonxwjkPetsZhErqsHJT8M5fqGYem6aTRFB3Wwyzlym9jMPyWPrkK01GUca/+mjc5Vbmupn8aT6NpLhiNSXUGR8j8KL6zOhnV83QsPYOjqF/ehYY3zqlQy+TIrUpa9va8AMbvZ8IvCORZAE3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589330; c=relaxed/simple;
	bh=KOSmSinrizcJ16KqLC1NQPBemKsaSb4HLvU7Y8/SIco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N5m5PiizqdBCkKoDvZoftYpbe7P7RaQ4oQyZ6sODmQlU/2O/2mJvQmnY0P9/UXKkgtWnfRpMl6gxMp0jqmMFDszLn6oj3ik3B3Hi49yhROuUiC25gO9u+wtGyTlKy+CHEWWgANZU/4zjDswrpNoDSqeDYz4pSdDaaQm7rzAEEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoYmT6Ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoYmT6Ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605811F00893;
	Mon, 28 Sep 2026 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589328;
	bh=n1s0lFnjwsUuaR6BDzzeKyNyHq1FKSmYbKdXSla3amo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WoYmT6Kip3xDG2NiYm+IfHFWWHvo4TPFarhO6sq5Ilcu4lh0hRbueloFVg1Uuh202
	 o1Ersr3zCkkS4QSvXP6IVIIJihf/ESH5X7VwFgkhn8UPZSpPULUVB3DqV5/zupahMi
	 f9FxFiWk06Uc8ikjCd/S6ogllHZGsPL2PvpESRksJ5FxlR1u3U9lcihCNmrD0uvol2
	 lT7wlGtHA/KKfvgZaxgh4gqEIqPD8bMAlSekJN7F0agtj1wbaYM2oGplVKHBnS3ZjQ
	 829fsYJq3iqxVEhxgbIu3zpCKSJGycZPCkg1N0RP9ZNJU328ajNIv7K0KDRL8W7dbN
	 ph3Pi+k8crZHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf tsc: Replace the compile-time TSC support
 check with a weak hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928094739.2605-3-cp0613@linux.alibaba.com>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com>
 <20260928094739.2605-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:55:27 +0000
Message-Id: <20260928095528.605811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The "TSC support" subtest of the "Convert perf time to TSC" test decides
> whether the architecture is covered by matching compiler macros for
> x86_64, i386 and arm64.  That list has to be edited for every new
> architecture, and it can drift apart from the set of architectures that
> really provide a counter: util/tsc.c already ships a weak rdtsc() which
> an architecture overrides with a strong definition when it has one.
>=20
> Add a weak arch__rdtsc_supported() next to the weak rdtsc(), let the
> test query it instead of the macros, and have x86, arm64 and riscv
> override it in the file where they implement rdtsc().  Support is then
> declared next to the counter it describes, and a caller can tell a stub
> apart from a real counter without keeping its own copy of the macro
> list.  This follows the pattern of the other optional per-architecture
> hooks in util/ such as get_cpuid_str().
>=20
> x86 and arm64 keep the same behaviour, and riscv starts running the
> subtest because it gained rdtsc() in the previous patch.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928094739.2605=
-1-cp0613@linux.alibaba.com?part=3D2

