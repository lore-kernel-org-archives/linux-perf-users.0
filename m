Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7913FBEB1
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550137; cv=none; b=Qzt5d3KJ4Ne3QDvver237Qsf+Rl6y3crcgSGR3pul0pwqumMMBvacEvmLQ8zRjjhKKZC73kAvt8T69zFSxR37sVjW/49A1eLWY91EcL0g8YHopJYWC63TccBayX3OlThl1wetK09zqfhroxjdMwPRJM8bpuR+ovqElty3Pt4RuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550137; c=relaxed/simple;
	bh=I9TQS4XNBshsRkHXkfB/pIgsxdT4FZJf4Cz5n2lf9II=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=skbDlIcZWzrEytlxjYCzVfPv/gJ39/PEIpXqNeWImy0T5t7HLVtWqfzMFgXNbs20LPfsM94mvgV8igiXw8uHjxzYJqPeITwQ+xS0cmTPRBkY0b5qnvg0Z4/T7JsDuHyOpGdQo9VgknxVebEeCFgEVroXD9WWVniMWHKd3Ix8l6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNHARitD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNHARitD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1189DC2BCC4;
	Thu, 30 Apr 2026 11:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550136;
	bh=I9TQS4XNBshsRkHXkfB/pIgsxdT4FZJf4Cz5n2lf9II=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CNHARitDlF5R9aE69HDNq74LBdkWS6+qc+QS63MR6IN5CYx8AxJL0vYu/ViaBZRVV
	 NQh0CWeUZiCUYv0fO5UOpgPvy4OnwWWW1Ii3EanQ7bmvlne56HjgeDfAijw7NfkUuL
	 JtRInBbwlz8Yr4RFxocOnLAvFdHDrdSKBs6NsSYSwhFd7xt61RpbYWKRrNgVrN/Uul
	 mg7YiDtgj+g9DX0FfmYlbuwMh+n9bzmSSrixwEHLaZqqTBtCRYhhg80UQBP6fwAD5Z
	 YslZ0bvd9eFZ4/U+Ss2eBkVtUXghN7VzmjTE8YR4aiWkPvV1oNnNkiYAs0wfQGKrfH
	 DvdYsjyYrf34g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] DO NOT MERGE: arm64: perf: Add skip_vmio
 parameter to control device memory callchain guard
Reply-To: sashiko@lists.linux.dev
To: "Fredrik Markstrom" <fredrik.markstrom@est.tech>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260430-master-with-pfix-v3-v2-2-bd526ec04a75@est.tech>
References: <20260430-master-with-pfix-v3-v2-2-bd526ec04a75@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 11:55:35 +0000
Message-Id: <20260430115536.1189DC2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The commit is explicitly marked 'DO NOT MERGE' and introduces a mo=
dule parameter to bypass a safety guard, intentionally triggering a kernel =
panic.
--

commit 955a332efd3c97ad086c64a2f8f7a0cd30dbaea7
Author: Fredrik Markstrom <fredrik.markstrom@est.tech>

DO NOT MERGE: arm64: perf: Add skip_vmio parameter to control device memory=
 callchain guard

This commit introduces a module parameter to dynamically disable the device
memory guard during user callchain unwinding. Disabling this guard allows
perf to follow frame pointers into device memory, intentionally triggering a
synchronous external abort and kernel panic on arm64 for testing purposes.

> DO NOT MERGE: arm64: perf: Add skip_vmio parameter to control device memo=
ry callchain guard

Should this patch be dropped from the queue, given the subject is explicitly
marked "DO NOT MERGE"?

[ ... ]

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 4a28df9bbe763..19b5251f214f2 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -123,6 +124,10 @@ static bool range_is_device_mem(unsigned long start,=
 unsigned long size)
>  	return false;
>  }
> =20
> +static bool skip_vmio =3D true;
> +module_param_unsafe(skip_vmio, bool, 0600);
> +MODULE_PARM_DESC(skip_vmio, "Skip device memory during user callchain un=
winding");
> +

Is it intended to merge this debug module parameter into the mainline kerne=
l?

The commit message notes that disabling this guard intentionally triggers a
synchronous external abort and kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-master-wit=
h-pfix-v3-v2-0-bd526ec04a75@est.tech?part=3D2
