Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026F357739
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688383; cv=none; b=b8z2uC+XXvcso8HPunVkjVm9DzlGJ2KEMCgSEAw1vK+HLHIuG4Bz1ZSCVf4sN0/whz6m7W3aOoOhbC9eYJ6YmiVO9R9LqrgMxQgjqJtRW+vfLAVPcDZDbZ02MXKDJLfP9LfZFMQfGpvLAJBllAjCFJEyUtQwy4rSzdQfa5GIj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688383; c=relaxed/simple;
	bh=FNa4lIdvMXl2RmAf7RwEQyevEH0no/6N7srajdKvr6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEiI5IKoYMO+jUTqHawajYXMFg+PYirahLAllDFL1dyWlzTjFufcxKUyXSDqImFLY9OMTBc2fbplNchQKNPRlF9K5aPOrpuz34ygfQrPJMyRcCLqFhVTfHL9jtVwzh3FahHMEp2ibEHwKfnImicFJ0G6UKhKc7iy2VmBiVvLV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv3fvbcB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv3fvbcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E501F00893;
	Fri,  5 Jun 2026 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688382;
	bh=O2g7jwK7BeYSSyEuUl4DdPmdYi6Su8FapsYGlG/75Wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fv3fvbcBe2PjCzAMen+uLkCQt6qsZ2kX9XA5KNWS0Fy9w/6RoNJ2iaD3pG3IDdDH6
	 LeNZShaTAmtMd+TevhgqeWhctPlBjnmfbD1+veDkVJS0TZZDzZvNwvv2ehShhNHjrd
	 Aidccq2MyjWwFwoJXzhiKWhxtolNOgE18cfcRxvWo6B7SvMbYY1QexwMQkTfyMi5xv
	 bpgH2w2Ms0CPW/WlaUB8ZQuS2BVqNjYy3WTJt3iwR7hCwnfPi/0hrDzzTlhd+DhExt
	 V+uqBQQEJ+ywyXLmX9QrzV9jS7KT5VeFTyJp4OJ+XYeexIgPMCmX+TSZ4z/P0/2iW9
	 D2gEUp4HXx5OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 18/19] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-19-irogers@google.com>
References: <20260605191500.2477026-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:39:42 +0000
Message-Id: <20260605193942.90E501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mismatch between `perf.pyi` stub attributes and actual C extension =
members for `mmap_event` and `read_event`.
--

commit 8baa7cf3368534ca613444f14212469e87a4ae23
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE suppo=
rt
and static analysis. It includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..9b00ab5f71d98
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
[ ... ]
> +class mmap_event:
> +    """Represents a mmap event from perf."""
> +    type: int
> +    pid: int
> +    tid: int
> +    addr: int

[Severity: Low]
Does the C extension actually export an `addr` attribute for mmap_event?

It looks like the underlying C object exports `start` instead of `addr`.

> +    len: int
> +    pgoff: int
> +    filename: str

[ ... ]

> +class read_event:
> +    """Represents a READ record."""
> +    type: int
> +    pid: int
> +    tid: int
> +    value: int

[Severity: Low]
Is this `value` attribute present in the C extension for read_event?

It appears to be entirely missing from `pyrf_read_event__members` in the C
code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D18
