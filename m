Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C468480345
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937108; cv=none; b=Fh/W626FOaJ/480RcuB4Rlt6grUNPv/+mRBwue9mu2f9Gdr9x++iZ9kHGl9QQ/IISGjsfGbG4dlicUAg2IhJDBPibysyts9d/96dGmeujzyrOsLpSNmkRt8MYomn82rSk+B9NiMYJjqdXXxPckfx/7b1X0pCeaB4dMYxFrPd9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937108; c=relaxed/simple;
	bh=nfGFLbdq4chR2wWcTHl1mAJFtKoyTi0VIt2Bpqq6mQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=byBdBeihnxAf5Z5U8B0gojnGsvQcy8k2hB1nJvP+UAZaFffUpWxdZz1BgPz56KJ6zRNTiKdd92hqh8p5aLceyewHPO1aS/uIgUDb/YWif08oGxNvZWo/L07qKMDe4p2Qyjf9s+L+lH9k2s8awOIRSZYeDYfpIaO4rGczoK3xMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d18L8JxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d18L8JxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BABA1F000FF;
	Fri,  2 Oct 2026 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937103;
	bh=nfGFLbdq4chR2wWcTHl1mAJFtKoyTi0VIt2Bpqq6mQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d18L8JxMxCssxD0MYs8hWk+dItwVFZFdbVTPmi25uyP7u93kaiwU374EC3R655TW8
	 t60jV43TTuaBzGd5aedlrg49QiKvyTNkG3Xl6c/iKGgSx9P9zKibFXdsnGl2OwtFZ6
	 nekkwz7CfD2mOixqufL6hetuDwfLuyXjr3f+zElW0bR6JVZec9Ck8F1OKmLi64+Iji
	 YlbOv57qKleixYFJ7XbvxQFfWn4NKtn9oWAJ3gMMFlj7SsTfLfV3+Fdf9nJKb2h9Sg
	 snx+mv/FOxdMc8qmMDiKyQ3YU7v7ZN0H6VpkfXlIixBJk6JEcxbYbzY/IDZc31Fufq
	 JM6j2bBMaBYsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] arm64: cputype: Add FUJITSU MONAKA definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-1-4aec0b0cbe34@fujitsu.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-1-4aec0b0cbe34@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:31:43 +0000
Message-Id: <20261002103143.7BABA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add cpu part definition for FUJITSU-MONAKA.
>=20
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-monaka-fix=
-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com?part=3D1

