Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC124A3866
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916581; cv=none; b=A/irylKhjPzL6wQwTAKLxWl5x2gpEG9aH+aN4iV1j02C2zPn+YnACvxeparRyN2OZyf9+YLW/gU9j+CB7Ad99Y/L9vNWkyOu3IO4X+XILDStuoc8o2LqmZkZl7jtABSjIIFiUvB69eJ3w5M4z1YEO/o3vtsuGo+hUOjvYn/HkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916581; c=relaxed/simple;
	bh=34IxHmCikdfeQuljetJuvZGhU7tIxdNCr7R5/nsImH8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EpdCeH3EQs3JnI+mdM2XPv85SkOI88R5E6u8zpE2LDw7US2TdAMupQ7dhVp4uvJ84ndNADdKXkW8Z/tZyIlAEuBjcst/7bIImWC9llrDIutAP/lnZnrBZjs5Ymty9gyHC5badmOVys57sj5vy3MZXMwi0aaKXcW2euNW4VmHDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLAwSsWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLAwSsWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456581F00893;
	Tue, 13 Oct 2026 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916580;
	bh=34IxHmCikdfeQuljetJuvZGhU7tIxdNCr7R5/nsImH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLAwSsWDqpSmQc6cR6T9pXoWfpFstLnHSBATkweDElgSWzIp7o02NnSrfSF4LOk2U
	 eXTdG9wSZRswnSlDmSdLvBRc4yiQSSnKtR39GlKyDEG6f8ClqsKlx7CbKZw7N5RKX4
	 NV2xly/fwd3qNQX/9pAMiUo2UlK9m0dkWK2Anhkkr5HuxM+dHtoEfLLN0gFaq2BCzS
	 v0q5njT4MP0LT2+kxzjj3oAceESZzvyZtBnDTKS4dyQSkBTtbsPN94iSuFdyeJY8br
	 JF4uQsObYhS3A+WhzPHd+Svnq2CZXgNCY7jX+MQdsYA3g2AwKEmF4OiNdLeMHLc/xZ
	 Zv964Jjb/OrGQ==
Message-ID: <sashiko-outbox-170342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/10] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-5-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:36:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D4

