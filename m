Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF13EAC84
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228633; cv=none; b=gMnyDpGaKB28jIso5IxXQoWzYWUdTqmerUwj/iEr34QCJt5OOqkPfaKEt4Ym6V5vU9ML4/REQSJ0x0gyFPvqyzav2nm1cJNgdyGnoPXegukloAF8MoSmEg0GiOk2SGyGjw/rk41TUwIDPp9acfbDoZ6ZDuM8Qoo1mnN4EQvI6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228633; c=relaxed/simple;
	bh=PUkQoHhusmd0+LcCUYMXUXrcV6YGx20ZRzZLLvEl/HE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NSkPXLY34nhbR09EezlFiQMF1u+PwbxPVDm4XBXiQnoDW9nOmfPMRDFupXdcJZ12+wpUhqUo3Yf4QFvhhejpe4K/RGMnBKkTog3AKAne0qX4bpXSPjom6++TJkMaLjs9wdNr8Kth7RyZLBYm5EExnhm0EL/id+ahbBSil6e6GhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noAui12C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noAui12C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C36B1F00893;
	Thu, 24 Sep 2026 05:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228632;
	bh=gIP/J5jc5aVK1lRzMHMixWwsjBUNMbT1NeuK/Eo+wBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noAui12Cs4Qn6gSK5FqhS1EDmwtDRbnl9Yn14lWiDE/OrVM2ET6+YWxImQHnU8SGi
	 QNaLE56EcsIXmwupCgF3EjEFDDr1BG0+7n/4gGJoJAbrAW/UNTE9fJ0fHfB7NW34Zb
	 QfWc5xmDEoqVaaFwZA1vQmX9GphRTKtual92d3V0iPEYRn/bg1ftuCaW1g214qyY2o
	 iwd+g3/ctEdNSFCGrF3k0gFdezvYIKL4g07rTVwa3h/blk2CgEVkGdx7fiz989BXAV
	 sbSGv2JE9fbvRcLE2MW7q5ku6c9dOg9bTXAKfa/n1CBoM2tLTCBkfFlINI1/OGaxzs
	 zYcTDtdGYQW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/21] perf vendor events intel: Update ivytown
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-13-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:43:52 +0000
Message-Id: <20260924054352.8C36B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D12

