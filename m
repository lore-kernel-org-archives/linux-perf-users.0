Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649D3EFD04
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341729; cv=none; b=SJnPm2Ev68dVt81aCKvkRHvcXbiYnpwkNfQlRtfhHcttBakpBL/MbAqhqpCeZneC793TQiCGS0IXQPP84aADOhWpbeHZSpffpqbLuVphXs7S5HcaA8I7K2HuOPyicUBf5OkoD+i8DT4CV6+35mexrLvYT7/vyuxoTS4kDjlisSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341729; c=relaxed/simple;
	bh=l0qDrYMGbLJeFUtYNcjp1qJChmAp3eCFZCVxIsPk+K4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tHxML3hYMo2a5+sZwFAW9FeA4BV80Ez///g/CbbYVaO1emFEh4T+dgVH3y0tSLNydowz/vRYBLeLVBGM/woB/KucSOyA6MJ2M52g4RKFp3MHgK16jr88XYRAYoNm+SgJFYdmsf02QZSVKYUCXwH2HOESa2A7N/PdySDfWIxtCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bas2AqqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bas2AqqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23DC1F000C4;
	Sun, 18 Oct 2026 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341725;
	bh=blgwCANruFBJDfq71J+P1yT7LqMMCG8ccdTYMm7lzS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bas2AqqO6iG2c/VnsabEAZp8r8NZ4Oeq3zKjRxtA85zPyd7V1atJ9aTQA5pfHj7MM
	 tTZnuyYuAcUp0U7XiWwq4tVkyYqe4MDx22E3QeIVQkAoRGEdXA1B4tIc+CcAiRDOyL
	 EtvSw3uDzxoZGCVWo2603ZiZfJyvOcE+8DRlGajd5vNS+ZsDB4iJF8w1wQgtjOo6vx
	 xBdo0EBQ8NpmBSmtij2vwIC5s8njWQkawjWqZS4DOMd7bi8PIpZemVaaq7WM7IEJ98
	 bSx6tzNbl7Gng72zJtzW1CaiRZfGjJpl4j7NzDser2hvWXd6l9UM3KlIXKNEpwePin
	 S8SJpGAsvRVUg==
Message-ID: <sashiko-outbox-176285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] perf tools: Remove NULL check for
 maps__machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018163741.850434-3-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
 <20261018163741.850434-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:42:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now maps should have a machine, let's get rid of checks for the return
> value.  There are already many places to assume it returns non-NULL,
> so having this kind of check could give confusion that it can return
> NULL (which is not true anymore).
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163741.8504=
34-1-namhyung@kernel.org?part=3D3

