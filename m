Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C912F8E8E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021487; cv=none; b=DR9e7YaXQWf17aP0ahOwvNo1aJWewpp2vBnZVnbI3PL7zTQRIJNYAP1Jx9alB+xneGgmodoC8rZTPrA5xh66mBFBDytRi7iiAkYbyUn4HJukuy5c8ojAi0LN5CJix5fFLShBcQ5ODvMeiW8Cyj+feTaH5kEJoK/vxYLSSjVLzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021487; c=relaxed/simple;
	bh=9ovzHHh0l0jNAMWOKLUXRY5D4d5G54JaOIrr2mEu7kw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I0Wh5OS4a3o2XTAySXyS3f/E0ju8kVzr8jvV6VjQd84LPXvelkhy5PhNZ8VVIck20aLcwtz4PSH5x0XKdz5rg9lmXDM9WFLl8c5SuwyFc+aqE+cYqj5FACxe4wnfPpMu+AL+7JoO4RNEgVulu6OZf6FqcdC6ij3P/lMLsDQNiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SINUvovw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SINUvovw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7C81F000E9;
	Thu,  6 Aug 2026 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021486;
	bh=z9ccjAoNiYzSCc02I2uz5QScqPAcFusmSxmMV4vgaaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SINUvovwFCX1nYzLuSsNh5CjYdxOZGgDxjFS/P05EGG1RfqRnzJEkBpzTVNl96s8F
	 iiotWlIUrJ5WjaCyaBvvBaI3KgVSiMXlJHa6Vd4q9zZ8q9UL3jqPX8EL17+0elx1BU
	 k20ESh6QzFfVyyyk/O8XCpImkcJ2XqDrEsxQXOQeWnk7C0JRrCjf1nhEs5+qIFtvV6
	 nFK12HbmznjsI1Ui5iyRFL4sQW9Fm4aTrls/iVGWQezqqY7e9UgBnDPFbmknZc32BV
	 28X8sJOXUOmUtytmCpIJXVA7Q8TkoBlTAXzk3W2fuXrQUY4tX8aU49a1kq+bIvw8Gn
	 G3ObaXxJ27uQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] perf jitdump: Fix extended header read that
 always fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-2-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:04:45 +0000
Message-Id: <20260806130446.1B7C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checks for JIT records allow out-of-bounds memory a=
ccesses.
- [High] The error path for a failed malloc() calls funlockfile() on an un-=
locked FILE pointer.
--

--- Patch [1]: [PATCH 01/12] perf jitdump: Fix extended header read that al=
ways fails ---
commit dc8d1e17077d95aa9e9434ca752e0c0e9bb0e0de
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Fix extended header read that always fails

This commit fixes an issue in jit_open() where extended header bytes were
not being properly read. It separates the buffer reallocation from the
stream read, ensuring the extended header bytes are correctly consumed.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 83005b30b9bf3..4b7c7ba7cd95d 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential missing bounds check
in this file while reviewing.

In jit_repipe_code_load(), csize and sym are extracted without bounds checks
against total_size:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    csize =3D jr->load.code_size;
    ...
    sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
    code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
    ...
}

Could this allow code to point out-of-bounds if total_size is not validated
against the record size?

There seems to be a similar issue in jit_repipe_unwinding_info():

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
    unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwinding);
    unwinding_data =3D malloc(unwinding_data_size);
    ...
    memcpy(unwinding_data, &jr->unwinding.unwinding_data,
           unwinding_data_size);
    ...
}

If total_size is smaller than sizeof(jr->unwinding), could this underflow
unwinding_data_size and lead to a large allocation and an out-of-bounds
memcpy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D1
