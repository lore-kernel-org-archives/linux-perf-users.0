Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449636A364
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642486; cv=none; b=Ura3ZGOVv1b5pNvOIH53iX+wdd0PjIyCiq14rmP7ujZg7K+NIKvQ7MAkGWjXgZZtQAp1qaRnvUR/sVegA/3hXUo28G7t6EXzFZdR6meFEV5KOfZNlxTYoEs/slyjhV/PBKzeMbRGDKW+RF/E0pVQJFkOHcZPpdv1JCc39Rq4hnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642486; c=relaxed/simple;
	bh=4Q2klOfmPg9WhjDD0lB37BvPsQHzZhaO9F6OJGp9aYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wbw0Zc9EaHtbnvXkwUu0k2J1cbxyG5YZ4c7cltPJlEIKD54YodecyGiZKrJLDUyCftm2KAjqSoq6eG9M3D3XOovEAQWR5EukTSsIIv946Tc+DMbYC7TMxA2SE3t11u25RgGO1JgbQPhyYUfIFnTm3GhpFK1HHDYFJOuUSYzWQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKK2mK0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKK2mK0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4313DC2BCB0;
	Wed, 13 May 2026 03:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778642486;
	bh=4Q2klOfmPg9WhjDD0lB37BvPsQHzZhaO9F6OJGp9aYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GKK2mK0hEvrJ7FY8wpZZ4xuCTygA2uAfW/TJlARq93yGdKwRCURDVxG+ZiiRuEqlU
	 wUYm4gZ0OgyCuJwf+hF9Xb2pXFMevu1guOkPieZUDUEb07sdch3L0jxUEhUOzp0c6x
	 iGoaT8axsNyMZCKHQ5qv0hk7uT+/hJ1IfCIP/RC2C2/cFjPyzD9s3I/9wFw8qCQ44S
	 TY70sx0S23VldyLj35y74mDpRr3BoEh4g/v0mzHt41tjFnOI+Q8wzRpHwlQE0uPMpP
	 S/qc4xZZT/zeEhdKCtKzA1uicIBrEuxQGqnYHmFQkz/x1R3Sd43gM9l7vN5d6X0oKi
	 KHp02n5XyZEgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/28] perf header: Propagate feature section processing
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-18-acme@kernel.org>
References: <20260510033424.255812-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:21:25 +0000
Message-Id: <20260513032126.4313DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Heap buffer overflow in `do_read_bitmap()` due to 64-bit to 32=
-bit integer truncation when allocating memory via `bitmap_zalloc()`.
--

commit e35bf21cac5ff925a1738af0ac2a6ea4e2e724b2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Propagate feature section processing errors

This commit ensures that perf_session__read_header() properly checks
feature section processor return values and fails the session on error.
It also changes the stubs for optional libraries like libtraceevent to
return 0 instead of -1, allowing files to be opened when these libraries
are missing, and skips feature processing for truncated files.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -2748,8 +2748,9 @@ static int process_tracing_data(struct feat_fd *ff =
__maybe_unused, void *data __
> =20
>  	return ret < 0 ? -1 : 0;
>  #else
> -	pr_err("ERROR: Trying to read tracing data without libtraceevent suppor=
t.\n");
> -	return -1;
> +	/* Not an error =E2=80=94 the feature is simply unsupported in this bui=
ld */
> +	pr_debug("Tracing data present but libtraceevent not available, skippin=
g.\n");
> +	return 0;
>  #endif
>  }

Does changing this return value from -1 to 0 expose a pre-existing
issue in do_read_bitmap() when parsing perf.data files on builds lacking
libtraceevent support?

Previously, returning -1 completely aborted feature parsing. By returning 0
here, the parser sequentially reaches HEADER_MEM_TOPOLOGY and exposes
do_read_bitmap() to untrusted input.

In do_read_bitmap(), a 64-bit size is read directly from the file and passed
to bitmap_zalloc(), which expects a 32-bit integer. A maliciously crafted
size like 0x100000004 will truncate to 4, allocating an 8-byte buffer. The
loop then uses the original 64-bit size to write values, which can cause a
heap buffer overflow.

I see this is fixed later in the series by the commit "perf header:
Validate bitmap size before allocating in do_read_bitmap()".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D17
