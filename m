Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58AE380FD8
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411896; cv=none; b=ESj0y8qrk+0xIe6YALmH6KA5DlqX9WiL18OJfIb1S3Ey8ZexdtSGktIUPJbAxEc+pgI+Th+RGwSHvBDvX20TqR4Z2K5XEkFLrF0Swq8VXSdLr2oFsLFZTzNr/SxQ7x8UeuFssig+FCeuqZJVQoZFDdN/xtpMRG3kA8SN4RK2ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411896; c=relaxed/simple;
	bh=ABYIpQg0SHsMiCiY27wOrPUUoPOzRiVBc0au4TWOLvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRVaVDkHCie6cmw4H7lQ2W7wvJkSGw/770RiweI73DKj9jt3x5tAOqlJLIwky2EJseoYdwNuMjRMKTXzebG8JY2akSLZwLMGa6cyE/SWwwhjpZxmr7cV7LPHIBxZ2ShRfAC7SjqH6oKDC9ADmv3lUznOpTartGRSaAXHdGhgct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0OGuruF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0OGuruF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF8C1F000E9;
	Thu,  3 Sep 2026 05:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788411895;
	bh=ABYIpQg0SHsMiCiY27wOrPUUoPOzRiVBc0au4TWOLvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0OGuruFJseCgyktHUG0yRO+0JDY2ZVk330k6Pl8oOYoS3/lOWLyX53czxyxbxP2L
	 ZeGdOxmAgSoyt6Nk/97Q0cxNtd+qLVTRAfUpu2HjetV/MpIgdvv3fI/Tmr8YJldngH
	 hOyINKPX7aknr2V1M2TysmzbOlVjVe0yEGFYH2AnNkh7EJX74YK3CURWKhq9zwXDP2
	 GLOJLpYVueEfXnnpX2QmXML8MygUt7rJldlpOfnW4x7mZTRkNL80Jvmvsq6YmVTYPU
	 CWENVcefGkeaFM0v7jDTeshIBNm7B7lDkLgHh1wJCKqLKV7K6LFsbjzmGLDfHFvfPD
	 y27JmxBySmaqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf tests: Improvements to build-test performance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903045603.3611902-1-irogers@google.com>
References: <20260902153135.2067365-1-irogers@google.com>
 <20260903045603.3611902-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:04:54 +0000
Message-Id: <20260903050455.1FF8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace hardcoded 'make' calls with '$(MAKE)' within tests/make to
> ensure GNU Make jobserver file descriptors are properly inherited by
> nested builds.
>=20
> Additionally, remove the 'unexport MAKEFLAGS' from
> tools/perf/Makefile. This hack was originally added to prevent the
> wrapper's internal '-j$(JOBS)' override from crashing when parent
> jobserver tokens were present. Instead, use proper GNU Make
> conditionals to check for '-j' or 'jobserver' strings within
> MAKEFLAGS. If a jobserver is already orchestrating the build,
> gracefully back off and let GNU Make manage parallelism natively.
>=20
> Finally, optimize the 'out' target (which processes 'run_O'
> out-of-tree builds) by stripping sequential bottlenecks like $(call
> clean) from isolated tmp directories, and wrapping the target list in
> a parallel sub-make call.
>=20
> These combined changes enable 'build-test' out-of-tree targets to
> build completely concurrently without severing jobserver tokens.
>=20
> Unscientifically measured the change lowered the build-test from
> around 15 minutes to 10 minutes on a 28 threaded Alderlake CPU. Fixing
> the jobserver issues meant the machine remained somewhat usable while
> running the test.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903045603.3611=
902-1-irogers@google.com?part=3D1

