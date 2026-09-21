Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967A27B340
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968494; cv=none; b=n8Y/+xBdHCMjWkWpgtuv4vladYzyxuo825nR6uW1i0u1KwZ+LI1ZjYAn13dZt7QijSAlB7cpFR0f7ogUZcT6OnvDevyA1lafDXTj6GQTIoppSleYAqQw62C4WBJyG4qQlO7UITAeNLMnAnu62pDQR3zNtcf8BMR0XltWKHFdZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968494; c=relaxed/simple;
	bh=mSqbQeisxbNBmALmP/qNi+TydaXV8g00WeClMFUonns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXtfn3q8mkNmmsCSxN72dqH3AA+bVjyRhsUTJm2v/cLxWdL0KHQy2YY6h7ifR69qJwebPnNmjEaluzMw5CRC64idYngXRhhOxuvCxA8Lw3LknukprmaytKA5Cub2t9PyfaYHdowVRHifTxzul9Tw+vkJPO+iaHV26YSrEkJTQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFKEHmhs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFKEHmhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523A1F00898;
	Mon, 21 Sep 2026 05:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968492;
	bh=mSqbQeisxbNBmALmP/qNi+TydaXV8g00WeClMFUonns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFKEHmhsRZmkG07W91h2prRp48Geyx8FiykJkbJgmREq7hKK1GdPnY3sAVqfhlnws
	 MhPeRIOcb7ZgN9r3t5mr6YJI8T0vShbE/GWEWw7XFsMqLu/mekP2fyQQxctFRgZoRp
	 mJ6ApZLtyM2R1XaBnGJj1OgP8tksoI1228k1ALhBZdDnHkiuuhUeJG5pG9/ffaqaPS
	 c08O5/HjT8lVA81MsKL5HIt58RIX+tnjoR6WGPSmxuvfNOK33zfQWJVX8JLVWn1Wbl
	 T5Mcyb26eN6gGV24D88HUDFcXWRAfhqE1/r+6h+ZAdbxBqe2/PaJBbP87kaEN4W6Je
	 8SmRYUPn/kNwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/49] perf python: Clean up pylint warnings in
 ilist.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1f3c3ace550e42f8bd3a5d14dfcada5c72d28d91.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <1f3c3ace550e42f8bd3a5d14dfcada5c72d28d91.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:28:12 +0000
Message-Id: <20260921052812.A523A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace bare 'except:' clauses (pylint W0702: bare-except) in ilist.py
> with specific exception tuples (OSError, ValueError, RuntimeError,
> TypeError, KeyError) and use a safe '.get("name", "")' sort key in
> IListApp.compose() so that ilist.py passes pylint without warning
> suppression comments and handles unnamed PMU events gracefully.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D3

