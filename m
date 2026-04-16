Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BD39183C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337745; cv=none; b=XZVEI0CkWiQJMzYTrkBoN8DCEcBIwoBSKQnq2z98vX4AQjOVbiNLatHTEq+yjwUmTIH53PjxD1qnxCkaPLggeIoEgSJW1KyrHo2egQTu/fzr5NW9fE3bsgUZb7X5uVP58V4CnS2zbFbRj9FxmwkSCiiBCPvx8Bo7CBfMr2WOdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337745; c=relaxed/simple;
	bh=PR0bUy9126NRss29Myu0zsqezaEfzQ1Tb1pAbC6zZzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LwxLXKVZLDb8PUz/5vCm5o3aK3Oa69LA3AkzksM3lTHySp++kb0cWjjNB9GXk/YAGCMwJfXveDAlDh61OvQn9Xr4TcqC8rc9dzUpn4H8/DxH1+2Vibvi0xgGNDrVYpaI3f04pgc7HeO/4SL1MN4quOFdbch9yDD9YIUzfIo5Hxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK8fJ4Y9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK8fJ4Y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A68AC2BCAF;
	Thu, 16 Apr 2026 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776337745;
	bh=PR0bUy9126NRss29Myu0zsqezaEfzQ1Tb1pAbC6zZzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hK8fJ4Y9v3JDnRIQTGMnG3K8MkQcHpp/H/eUB4v6623T5GCNIa8Gqx2PtViAAlANn
	 qIbHWZ92O6XjfU/m2W6q5FjFjcOlq2SE9sDyuUtC1eYo37aDlWp+GfjjpW6S0YuNA9
	 I6kQBWJZUtQynN6sO2RedG9T0fIBUPIxMOucFI5Rp/Gg81Y+JrBpunmCMYPGKVCISW
	 OXqxh0KwK9FfOtNKSxj417VpSjzPmghTC8Y+Iw1Zkf08GCanGDQbECnUq6c9SKqwhH
	 4SG7osDQZooLbfb/jDFRQpSO0zJlUSWt+cbdKUUgFsjLre7nwzcH9GuQYvc9z/MOfh
	 GafbJ01CUz5Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf dso: Fix kallsyms DSO detection with fallback
 logic
Reply-To: sashiko@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416091657.578429-2-tshah@linux.ibm.com>
References: <20260416091657.578429-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 11:09:04 +0000
Message-Id: <20260416110905.3A68AC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Path Traversal and Information Disclosure due to `strncmp` matchin=
g any prefix.
- [Medium] Incomplete fix: Fallback logic is missing from `dso__is_kcore()`=
 and `dso__is_vmlinux()`.
--

commit 9ee80283f13c6a0a5235a2add7a94736c1dfcbba
Author: Tanushree Shah <tshah@linux.ibm.com>

perf dso: Fix kallsyms DSO detection with fallback logic

This commit fixes an issue where kallsyms DSOs are not correctly identified
during build-id injection because the dso_binary_type is not yet set. It
adds a fallback string matching check against the DSO's long_name.

> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index ede691e9a2495..515ab6e95b0e4 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h

[ ... ]

> @@ -915,6 +917,14 @@ static inline bool dso__is_kallsyms(const struct dso=
 *dso)
>  {
>  	enum dso_binary_type bt =3D dso__binary_type(dso);
> =20
> +	if (bt =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {

Since the fallback logic was added here because dso_binary_type(dso) is
DSO_BINARY_TYPE__NOT_FOUND during perf record and inject, do dso__is_kcore()
and dso__is_vmlinux() require a similar fallback?

Looking at dso__cache_build_id(), it relies on dso__is_kcore() to flag the
DSO for special caching logic. If dso__is_kcore() returns false during
build-id caching, kcore DSOs are treated as regular files, which causes
nsinfo__realpath() to fail and breaks perf archive for kcore sessions.

> +		return RC_CHK_ACCESS(dso)->kernel &&
> +			((strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_KALLSYMS,
> +				strlen(DSO__NAME_KALLSYMS)) =3D=3D 0) ||

Does using strncmp() here allow a path traversal if long_name is
intentionally crafted?

If a malicious perf.data file contains an MMAP event with a filename like
"[kernel.kallsyms]/../../../../tmp/leak", this prefix check evaluates
to true.

Could this allow build_id_cache__cachedir() to construct a cache directory
using this malicious path, causing build_id_cache__add() to unconditionally
copy the host's /proc/kallsyms into an attacker-controlled directory?

> +			(strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__PREFIX_GUEST_KALLSYMS,
> +				strlen(DSO__PREFIX_GUEST_KALLSYMS)) =3D=3D 0));
> +	}
> +
>  	return bt =3D=3D DSO_BINARY_TYPE__KALLSYMS || bt =3D=3D DSO_BINARY_TYPE=
__GUEST_KALLSYMS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416091657.5784=
29-2-tshah@linux.ibm.com?part=3D1
