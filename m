Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A323BB9F7
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341609; cv=none; b=b6oK99IxEP3FqhrPPKHAgrr3ZK05x44+g0G9adtH3dqGwWCjqo5Esj4Fz8DPbb8pKFqsWeEBI2Y7rLoMhT1+Ca13p0ce3iTPmWQ/P63C7FX8jUC5W0hDRve6V9FFs0NlO9NETspeaxaL1SThXjcprYvi1vt+Uf8o4xbjhpv8j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341609; c=relaxed/simple;
	bh=9wJi0jc7scaP+57urV96oqcMY761PmMtS3QIA/3HaUY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cNQ1AVUzOzmwPsdJ0T0OU9DrDXYg/Xo3Em2lDnXte6umBiScwSVz0IPdfgIaF0LeVr3diBUgJnu4mGb3oXikvfASWrA7mlz6DSNZYbUFxfKa9aGkmFIwQ0KM1jSDdIBHqrLsOd7djBLnWH001RvnTnNpQq2zLSutYMtc51bcIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOO54VgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOO54VgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968901F000C4;
	Sun, 18 Oct 2026 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341602;
	bh=9wJi0jc7scaP+57urV96oqcMY761PmMtS3QIA/3HaUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOO54VgVcRLWhsPk4At0ini1WW7RHKqMrds4SC3XDpudiVYSegkZY9GpKUcO3q4rk
	 TqH00KAzmnZyeelG5nA9aS43BHPuYvW3tB4b1NHm+SZtattt7xnh0v2yH8rIi3qpiH
	 Z6aUvcEGGHNEE6bjL+5c13wElUTZLNS4c4S/Nwig9fSEyFJAjqSMpnljXMc78BlNPr
	 gmw8yvQo2kHc5SNetXwmv5eDBeKBHHEm4gXy0zTu3d/Gad8LsOSKZAd5GEwbAxqOHV
	 uK2RQ/gOenoXcbxBDzTd2DlR2Ks0cS2EP11Drwzawlb9S527fPBFP6vcb8YcuK3JVy
	 +MyHa5SjBGdZg==
Message-ID: <sashiko-outbox-176281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] perf symbol: Check result when reading section
 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018163741.850434-4-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
 <20261018163741.850434-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:40:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Otherwise it may access uninitialized section header struct.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-170233@kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163741.8504=
34-1-namhyung@kernel.org?part=3D4

