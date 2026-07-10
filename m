Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883541ADFE4
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652363; cv=none; b=phUR6YLUS9oa6AWocL5+0hl2HSAHjZgGKFx9giv7NFexH0asjipIUZ+frUlwsoij8AxzwAkVhyfPpZq9RWr/z2Uliaj2rqTsJi7xHYvHQZEA1ay1c2+7DsbgSFIP/6LazRadKpR+48NLMVDVoRI1Nbo0qwXQMDzb1UEJ2oicneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652363; c=relaxed/simple;
	bh=dAcGCP1MqHgTW7ac7nGX8WudaxHuttvVUTQlhTGE7Hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h4fG0SLFoXCQIS/WGp/uNPxR7m3s26wQrNkKe78xTw+Jz8ogMheLn+9LAC6q/4Vqi9r1zSWJv4YnjFejBqjF1/Z7hbT2IFspLElghc/yHcKz26Bj8D8tWwCasrVzXRawhdYCH76fficffH2xi8x7xQ5vwQNHQ+Jys63m3VaDViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltA7EIYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltA7EIYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040B51F000E9;
	Fri, 10 Jul 2026 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783652362;
	bh=LoqJmLP7KoOoN6z8NiH1fhsp/S5hC53M8cTLiLqyLfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltA7EIYmUmlShyd/kwguP/fvlojKkJzU2QcpLldgI2tx4bqeEO8hdrFVhnyoqRs7B
	 p7ma8qzmMUkZCYhlwXS210aMn+gomSmZI/zGVwJA7kLS6Ik/PL1jiGzDv+n2Oqswod
	 BBM6iTWfC5KB9R4wc+rO+ChSVZ5UWEZeF468VfOoucgmEqg+n44F4Ki0H+Ol02cQ5l
	 7dLXVm/Y1rdC+wZR7WRCY6HsyC4xe9xHssAwFjrqT3wf/Wighw8zVOTNMdYoBESmNY
	 Mc6BywFMA8NcS3iPzudaOTNVIdcfkoRZxH/QQf7BbJuYDas10QYd7oEBWLoBD78280
	 FdFtb92q0M27A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] perf disasm: Fix potential NULL pointer
 dereference in arch__find()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-3-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:59:21 +0000
Message-Id: <20260710025922.040B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Fixing the NULL pointer dereference unmasks a reachable Use-After-=
Free in `arch__find()` when `arch_new_fn[]` fails, as the error path frees =
the `tmp` array but leaves the static `archs` pointer dangling.
--

--- Patch [3]: [PATCH v4 3/9] perf disasm: Fix potential NULL pointer deref=
erence in arch__find() ---
commit 709c36ab73e377d0cda7f8eb4df8b0ebdb9717c8
Author: Ian Rogers <irogers@google.com>

perf disasm: Fix potential NULL pointer dereference in arch__find()

This commit fixes a NULL pointer dereference in the error path of
arch__find(). It resolves a segmentation fault that occurs when
arch_new_fn[] returns NULL by printing the numeric e_machine value
instead of attempting to access result->name.

Closes: https://lore.kernel.org/linux-perf-users/20260709035721.9EE901F000E=
9@smtp.kernel.org/

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 0a1a7e9cf3efe..5b114f089d560 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -182,8 +182,8 @@ const struct arch *arch__find(uint16_t e_machine, uin=
t32_t e_flags, const char *
> =20
>  	result =3D arch_new_fn[e_machine](&key, cpuid);
>  	if (!result) {
> -		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
> -			__func__, result->name, e_machine);
> +		pr_err("%s: failed to initialize %u arch priv area\n",
> +			__func__, e_machine);
>  		free(tmp);

[Severity: High]
Will this error path leave the static global archs pointer dangling?

Earlier in arch__find(), tmp is allocated via:
tmp =3D reallocarray(archs, num_archs + 1, sizeof(*archs));

If reallocarray() moves the memory block, the old memory pointed to by archs
is freed. If arch_new_fn() then fails, this error path calls free(tmp).
Because archs is only updated on success later in the function, it will
remain pointing to freed memory.

Now that the NULL pointer dereference crash is fixed, execution can success=
fully
return from this error path. If num_archs > 0, wouldn't a subsequent call to
arch__find() pass the dangling archs pointer into bsearch(), causing a
use-after-free?

>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D3
