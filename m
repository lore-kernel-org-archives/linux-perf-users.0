Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69E26ED59
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075136; cv=none; b=JbJKfjfGiPaBfJVAqR4ZVmcHgsXO6DV/vJjPJy+b9cC9mf5lneAMWFJw7Pc0eqliVJ1tDD1IYIYYlt98nlVH/YscoZHDFqRjyxBzuwFx7vjF0ydtwJq7wkUH2sz2/eEBIKQvWVNkEFALGpnel/Mrdv3Di8ngQVuN6unBVA7Jv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075136; c=relaxed/simple;
	bh=oRKAEJeMUTZgnRIaqlaWGRCcvq2MUdFnEPPAmAVDGzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IKH2l5/4mjSH5k13GgdR4pkS43hoeaJgr9CFvFCzEOJPrCkHWVk/Jr7Xo3wRNeByz8E/jGElIzOuodLssHXDFs/aM46nx7d0D+g8gyASVCAkqPrc7tqXkFQY5JiNNK3qYn9rbu06Gjp5mHM30AofJZsHmMmtoteeaDJXmLBPiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZikt8GL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZikt8GL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19EE1F00898;
	Thu, 10 Sep 2026 21:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789075117;
	bh=oRKAEJeMUTZgnRIaqlaWGRCcvq2MUdFnEPPAmAVDGzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZikt8GLUWTRd9R4VotEq/HlfjF+rdtJboL8Z7ZNPR6t+B2W9m0cfY8BlEj7KkLHv
	 0kr2y//4T0YS6lYPZj/ufmCBcGBOTniB4BXPHEljg4i0KGk8om8fVBLnDOMmVB9CcL
	 vSMQW4/3D9vlujmqZhNHavvPXE0IKqV1GGl+7t5XnmC+TrtT8np9xg++vHG15b5kwn
	 CEmpT8vY5IGI5Pwi2wqo3jSXkewAvnLVzVLbqfIkPEnG1/yMIm2IXzk/EwlHd8yJdh
	 Zo/qI3fPwwQQy/5Fkm0aAsO1zDJH2EfrwLlHdROK+B4hyLl8NJbG0rfaHp3y3EslgE
	 d3ihL/fzjJNFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf python: Fix ilist TreeNode string type drift
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910211539.3157204-1-irogers@google.com>
References: <20260910174420.3002597-1-irogers@google.com>
 <20260910211539.3157204-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:18:36 +0000
Message-Id: <20260910211836.C19EE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Updates Tree type hints to correctly use TreeNode[TreeValue]
> across all assignments preventing mypy strictness mismatches.
>=20
> Address some other minor stylistic issues reported by mypy, pylint and
> Sashiko.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910211539.3157=
204-1-irogers@google.com?part=3D1

