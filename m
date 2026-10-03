Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2473749F5
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991205; cv=none; b=IH8FyIZ/DUNa2J2+HLUtK7iks86/lxlZhhBDWNWx+uU/uos2EwU5UBH4Nh3yKxskN5SJiPigTczeJyWeTLuf7bxL/0S/IZ+neG9ZovtCG4ZxrEYKGEtS4PCb9s7OJjFKitngWBHwMwlq8+Pg+9z9W4QAjIZrbhqQr/KRG8mfxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991205; c=relaxed/simple;
	bh=QmWeQYp/wqRQHL1hYmevPEohRF4p8yEEkETQIUAc9o8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNSM7hW89B6I2eSGZ60dnmDHUI6S25r+KT0GofeB1wskQ/4YZjGDveV/0XTjCMTeIYi7nY82PJio3v86FdMVgjV5TEcXksFdaHo4DP2riLeFqvTp+kbmcW3TMS0TnYPELsEx98aIh7jutKFZ9Gn7Kvltsc/eklxtndnOnseabJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5OtUzZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5OtUzZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862EB1F000FF;
	Sat,  3 Oct 2026 01:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991204;
	bh=QmWeQYp/wqRQHL1hYmevPEohRF4p8yEEkETQIUAc9o8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5OtUzZ9w7UVS2uU2RTqGJEuE23X/kdFroXSCh78oMTNYsscCamuLZ2ZdLgvfSOPg
	 6b6FEdyf3zIQeJbxLhu8BrmffqHhWhCQLrDtk5UQ/LKiSdyX44n9jQKsPUqf0sb/bT
	 oRBWMdCIJ2n5yvVmSs/ruvbdqs68zfWZtLVNXuzQc3Hv6uGg2bsPoXKJ18NgYxSP+m
	 TjM8B9zFfEePrjWj7oRYdnneH9LrXlnIJ/kbjXQAed5RYJhnCwhq9FLWkTz8MmDCjY
	 nAQ1r92G6goN6F6rYFHuP6J/77MoVP9PLwr//FDRfHWLwbfFI2pgyTff+L/DTX3TtY
	 o/fhL6P6baoCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] perf/core: Add BUILD_ID_OFFSET to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-3-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:24 +0000
Message-Id: <20261003013324.862EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D2

