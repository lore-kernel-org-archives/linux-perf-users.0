Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3341D21F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269764; cv=none; b=hUbcS5jvxGx845WzH1Pm68xU4EFLbRPDBB5IPe8ydqwlCDsU1dTuk/0BbNnQMBj/540/K4mvMJzFdPnjHhS4H6wNw24cB7k9PP2X1ybHp169zgcEdv3dYSugEjDxvFxY5gms/Eaa0YXo0zHpth5++0thfW1ZR1DgEr9/HE3nAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269764; c=relaxed/simple;
	bh=YCmXj3yS7goyg8VSxiMdFd4FU0P5/2zuXHaCxPcV4K4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rNq9tWx5WZVb0Y0X8/Z/gaRO5dKxwsbzpSja4lcxxV+btWjcPTSiujvyt80f/1WaUOuRDerTqlMBBjIunc+898Tv5ju8LLef97967SUh2VtcopB9dFOr/CHcC3+J5/esPmF2obhPBM584QeMiYPcPmLrG4eXlecoyXKFNH8y+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjKsAn0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjKsAn0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F3B1F000FF;
	Thu, 24 Sep 2026 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269763;
	bh=kaUwbcdZiJZrxBwALE0yOxWIoEbO265m+CVpnNyCl5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjKsAn0hql7NzSu+nSAt/fh6ReI4Otb/u0yM841zRiu3EfJRKva4Tbptq4pzb9ofb
	 RqG8+aErlR0DCEGVH0PMUP9Wrh518VN0DlTX/lPOmNvt+huCn+r9wYz5uAvocm50eS
	 BVwVrQsrtBaMxkHGTYnNVYw63U5swB0Jg9PCXfyQZnoB5QEFKUd5b4ACrPT7q2AI9A
	 HCmnA5nQMLcSTszHQmcupgmtBJL9Comtb64kNdMaa7ZqJKuQ+GmVOepMrgRiLyGj7/
	 GCdHO5vk/pBONgdPLxH9tsJso0JipHPcOweq2exTW9NGZt16fzPrTM9yMl93VT5Axo
	 XdYzCEZSUmC1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/26] perf vendor events intel: Update graniterapids
 events from 1.20 to 1.21
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-8-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:09:22 +0000
Message-Id: <20260924170923.69F3B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/8732d043b432e9d04086a07feb23d9d=
f70a10f17
>=20
> Fix wrong encoding of UMaskExt.
>=20
> Fixes: 917f63ad7580 ("perf vendor events: Update graniterapids events and=
 add counter information")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D7

