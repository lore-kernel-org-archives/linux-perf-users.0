Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780F2EEE80
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786596222; cv=none; b=bIdTGDImPSSllWKzm8BFC/kE702POomONAsgJ5gelDf3ie08rn1FYg2HEwVe+VEI+bpORMThuVqJapA+l3l1dW15zG9hiIKxUrraABR59vG58D+31iE8epLkrFuCPahzwm58tY65+fSxmq5m1tSqytkXmlbliWI1sCe14txfGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786596222; c=relaxed/simple;
	bh=Xwh5CY9yRS5NsOXbxoyigkMxfrW+NjITc6rztuA6Azo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cBtjBvJEkwQ1y61baeMk5qSGfLF0Q6fOGsEq3RQVeKhmvsnO3UWlPSLkd1OH2dHSKad7KHjFXkK+t6qRdiTXWEsZ6DRiKLFdwIaNNs4rAGSsOmClTE10a3bom9OvW0QJHR+tjaDfhS/c6xj8M3xYNu1ewcFmgSyk5HXQvSyohq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIPkL0Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIPkL0Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB41F000E9;
	Thu, 13 Aug 2026 04:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786596220;
	bh=Xwh5CY9yRS5NsOXbxoyigkMxfrW+NjITc6rztuA6Azo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIPkL0Euhhn8qcUFYpCSu0Mag94KUcXNGAnNmWZzyfO9QVVF5cYlOBpcpgknlWBfX
	 o8reMIab5GkVeJ+BAZ3oATV+nof4aWfqM/QU8uWrC1L/vkalz4+lEhQey2wg5bJh/R
	 rcJ90uin+5lC9usJcQW7xHewVAPYDGK1E0kCTDlq9UZpFXO/naBXvv/zL/CrImemkI
	 1z3Msb4lSuPO1h8Z82XWEkWmAAwjGXwbOMf8WEvI68vXsO7Zf9gx7pfKXVUN1d6wSL
	 /INbjmOz5v31KTiP8DDXvj8FGHdj000WMFBu5jGJ3bhzzqYR+fS+ySFgekYP+T9yCP
	 2XMXU1CRtB8Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813043533.2744442-3-irogers@google.com>
References: <20260812230145.2644281-1-irogers@google.com>
 <20260813043533.2744442-1-irogers@google.com>
 <20260813043533.2744442-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:43:40 +0000
Message-Id: <20260813044340.91FB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Expand the Raspberry Pi AXI PMU driver to support Broadcom BCM2712
> (Raspberry Pi 5) system monitors, PCIe RP1 Southbridge links, HEVC decode=
r,
> and Cortex-A76 DSU L3 interconnects.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813043533.2744=
442-1-irogers@google.com?part=3D2

