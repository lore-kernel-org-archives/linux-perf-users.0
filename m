Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973718859B
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968493; cv=none; b=ZRlS7raYI47+0fLfmYClpug+2S833Ejbb/R2amuBRla+8ZMpKGbT/ab0QChFK1L8ylW1SwoXcJl8TH0nqAXi6G8XygrApGneJNv9GMDbiPgukcWhUetEosItdP/+/az03UZJA8fRWBHALkQp/qFtAR1GRFAu0clI6Wv0oWc0UX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968493; c=relaxed/simple;
	bh=pUZ+KCmSKi7Z/HRAUiP2/AGGV5dbVCgPC3qWXeO5Rwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eW9V6K6tH46p4M57Nqxub4RrFL6uhUpHRVmW2QLln+AjxnbtMvh5j9XG9KWdouYLdiQNaAYDGIUtYw2/byz2uhX9HCO8Fgxhw0tQSft1OtB+VxvvmW9tU7O/Tmkyqc09sj0aRCTqao5il2e1tLlypWobE0FXyeAWiT9+1fqrNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yia8hrnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yia8hrnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E988C1F000FF;
	Mon, 21 Sep 2026 05:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968492;
	bh=pUZ+KCmSKi7Z/HRAUiP2/AGGV5dbVCgPC3qWXeO5Rwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yia8hrnWsoUkGLMlLzdedz+Fi9wI7DVhxaM7+BU5GRHfzm4+lX75QpPCejjA0LmZH
	 c0JM4Qe6RN9PxsedsWMa9VH8ALS3MlUXr0oSMs0YAoYgLftRUC5LQNqLyssR0u4hYQ
	 dGBmZsIeK5ESkso9FcfvazB2aH8VYVJ5YI8UykK0FVa/cEuEE8hKlADHiZh5CSnkv0
	 xBeXM5Qm0RUJ02a7I/0RzWGuwuckOi2cRibTWjfn2zz0JO3YxUZ2eLnEer5cXfm9cu
	 xNiMtenRSdmiL/wFmoL30vrJzvkqQqmvPaOO7LnCzFex5GQzoBanci1UasoZPp3TRP
	 e9Cyke6jNFkaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/49] perf Makefile: Install standalone Python
 scripts during transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <bc2109d93d728f8cb71a9a1f6079920870b29130.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <bc2109d93d728f8cb71a9a1f6079920870b29130.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:28:11 +0000
Message-Id: <20260921052811.E988C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Install the newly ported standalone Python scripts from
> tools/perf/python/ alongside the legacy scripts during the transition
> phase so that newly ported scripts are available in the installation
> directory before legacy support is removed.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D15

