Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C883019C8
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351070; cv=none; b=jYjrzuRXZSgSFoqAAMViak0tcV2pNDNKhSi4tqYTHV/1HKD5ppES4w350W25K5Eyu/i0pufE72V0AE/dZlCxhc2WhbERBuSip7lfKBDtIYhYHNzrZmIo+Z6iuNnp66hFLlX4/5fOJ/h3051wkyw/4tTD4b7VCb944H+no+Tzjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351070; c=relaxed/simple;
	bh=UAkFw/F29NjeS6LmXYMmlbRVQEAENb4pZ0FyZVsIHHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hCMV620ALZsc8NM9atb5TtYztJPdaRoNwx5EhgL8H1G1pCiV2JnHqt3bkRaCD9ZLtcqNsQfy8T/sgJZtdi1N61ibBXN7wNfQo+RFpa14o4k7BERDpCbtaRsTC0eRtwUrgdLNOTSY6kVlQIZZIKcXMXpaXFDcjhQLJ6wGjr5uO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7JNbLHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7JNbLHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42811F000FF;
	Mon, 14 Sep 2026 01:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789351068;
	bh=UAkFw/F29NjeS6LmXYMmlbRVQEAENb4pZ0FyZVsIHHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7JNbLHtOEJ9xeemUJwjK7TtN/tS65S/nJyrrB0jNlU1EeRHJVtSOnoqlIpi/kNVa
	 Z9CAS0lYIhmDliNmcvVpv/zQw/6WTzFgLacULCEeG/vgAuzhal/ZFdxr7xx9mlpwaV
	 P2ExRfj7kuISAo76Czs0JUrrcZlfBrrameWmCJqhSaPwIaKlK5vZch46vpmhCKUjC3
	 svgHIaLAp3tXldA/vHluHMYZ1d6OFRi2qt4i0MH5kI8tuB5NAvhiqBzEUNtciv0EV4
	 z5BqWWL8NqrwbpEABU+1tB+8RNVSjn1H/sBxtLfKTi1MFsdNiQBiKYvm429zOvOnbQ
	 UlbHn7zX+Bglw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 09/10] perf tests: Add x86 eGPRs/SSP registers
 sampling test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-10-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:57:48 +0000
Message-Id: <20260914015748.A42811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Validate that eGPRs (extended general purpose registers) and SSP
> (shadow stack pointer) registers can be sampled correctly on x86
> platforms.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D9

