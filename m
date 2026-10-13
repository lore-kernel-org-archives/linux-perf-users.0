Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD93F9A1E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912340; cv=none; b=PsSOIibFwbrOKudxj0EDlq5L1UxOv2Tp/In0KIM66qJS0iLanNrfDuIQTr51Ul1NRIMaeh84JzvCS3dqlkPX4je8xuk0k9NJvNgtpquqLJBUMMeaTvJSc+uDPFfINcTusxEQGWr7SEHgJQsVL92coFvYB0rar7rk7UBmuuJUf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912340; c=relaxed/simple;
	bh=YFpMWp8tOTtebYN9nWw1ZyR8xrUWQ/kgrNRy33tsG9A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YjPLCnIwgj1gkdbNGxK6fbcIUhoW0US0usDEqxrZ/a4oMLu1hpklyQb4zpyKBZdkUdRPIwWAe4qH2l1ge4kbMF1Q4hgcVN683Ye46T377gMs1XH1v19PPmBY689BSKUieB1VyI5uhXxFcHb1aE8ANtUPkhFfm//pQSZZbvsbIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5H5RCmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5H5RCmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ED61F000FF;
	Tue, 13 Oct 2026 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912339;
	bh=YFpMWp8tOTtebYN9nWw1ZyR8xrUWQ/kgrNRy33tsG9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5H5RCmg8nK4gQ3N8KCE7FSLa4JwmRwdgnayuV1WV/RF4ofVw7AKB5r60adtdNr0l
	 nmRr1mNDSZPZyo8u68rK+QY+1SXTqmeL+2C2nabP2WimoF8XAuATUzcw4sAtA795qh
	 AcG81i974r8+Qs64gQh0Pw/zGanaGBrr12UaFIjA04uGJdLVqUIJpAZQQCzwlBnT6e
	 3xOQm2puU3nyCu8LToTTe5AhyCqCPJK9dujn/cFpP73OBDgGzszV2E0Wp8SaAm90jE
	 Di9tABNV9mUuqh+9X7bmwoFeRvsnQdLStMsxA6YBbvIGDX+fu2JGi7kxCw+liCpenv
	 seZexpDESewRg==
Message-ID: <sashiko-outbox-170219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/11] perf tools: Remove redundant dso data init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-2-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:25:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The fd and status are initialized later with cache.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D1

