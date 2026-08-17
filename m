Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446084483AC
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982715; cv=none; b=qXUZGdnXcc4c1Fq39un74ZD5nE2r7v767c1pqrx+L7Q2ZcOmMyoizbOIFP22D4E93bqaTPBKfDfRrsd1HSm+2I0oThWUFLdAak54DIDNZ9rxbmhgIR05kbl7lWhb71wvEdQ1ZEpme+HJFiy5U+2KmUhA7nEyZlxAlG+zZbthTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982715; c=relaxed/simple;
	bh=B3KYCRVX2GOgf9c8qG2etbcHQ+I/1Sfk9V4FJCqHklk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJpsx8niNUCe4fueTGg/ukKKHGPBPooNUysLk/AL0abAsYjSmzMKO9hKAKmDKQ/HslOZHj0SQGNWNv+7j9OZpStE03UdI/mdfH8whXgGSJ1TLU7Qyp+WcMVj2zL6V20abv1ctuqyZ24lBM8L7FhIvBW8mVYgP2h8CkYEvI9DYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpjIj3hJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpjIj3hJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74611F000E9;
	Mon, 17 Aug 2026 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786982713;
	bh=J54VxcZBxwsGj4ThnALmNjCshKbyb+SAgwaEfl2QDuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpjIj3hJZh5Fyp55lBj98hgz9oxXmRed/xaRoFWi5IQll7xQUe0RZAB03aVfFgdbP
	 n6TokTSVyjVYHe3ADqleOXjy+py5OhnYBssOh63V3+0IvpDiAKzBEhU7ruH0Ft6Hgk
	 9YHjjp11aF0oD/U8qEU+vj17/fmgqP4AseXcC1P98thPvgFKoOXJdaghlSuZLiDaXA
	 xV7Wz5e3bUH/12k4hATWGUgN7dIVESKypTKlVkBoE9rE/NVBaeutVIN8Ga1vFd+CkX
	 wYMDuME9ZYQkO4E6lAj7ufJ/23PfswNHy1Xo8nkRlJRtl3JJTEKBoEueaK6KdQ82a4
	 eYmxC2LpLWlrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf tests: mmap-basic: fix user rdpmc detection
 logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
References: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 16:05:13 +0000
Message-Id: <20260817160513.B74611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of `<unistd.h>` for POSIX libc functions.
--

--- Patch [1]: [PATCH v4] perf tests: mmap-basic: fix user rdpmc detection =
logic ---
commit 4b703a4e5dfd0ba3b4f770b8ec3924ee647f0a6c
Author: Qiao Zhao <qzhao@redhat.com>

perf tests: mmap-basic: fix user rdpmc detection logic

This patch introduces a fallback to /proc/sys/kernel/perf_user_access for=20
RISC-V and Arm to control userspace counter access in the mmap-basic test.=
=20
It also updates the test logic to support restoring arbitrary values and=20
adjusts expectations for Arm platforms.

> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 5cec7644952c7..4433a5df3d776 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
[ ... ]
> @@ -182,47 +183,77 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
>  }
> =20
>  enum user_read_state {
[ ... ]
> +static int set_user_read_fd(int fd, int enabled)
>  {
[ ... ]
> +	if (enabled =3D=3D old_user_read)
> +		return old_user_read;
> +
> +	len =3D scnprintf(buf, sizeof(buf), "%d\n", enabled);
> +	if (lseek(fd, 0, SEEK_SET) < 0) {

[Severity: Low]
Does this code build correctly with musl libc?

This patch introduces lseek() and SEEK_SET in set_user_read_fd(), but there
is no explicit include for <unistd.h>. While it currently compiles under
glibc due to implicit includes, relying on this can cause build failures
under musl libc where headers are strictly separated.

Could <unistd.h> be explicitly included alongside the other headers?

> +		pr_debug("%s seek failed\n", __func__);
> +		return old_user_read;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-rdpmc-dete=
ction-logic-v4-1-c22074578f6a@linaro.org?part=3D1
