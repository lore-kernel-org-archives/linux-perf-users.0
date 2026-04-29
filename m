Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED911CBA
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429467; cv=none; b=JqsvkfKkLGuW6RMIMP0F2EtqA/W376MHN5jruJz3jpkmMJDFbQVPc4r8JSzG1lTqUiZN6e7rbGxlWCnR9uiVXdYMW/zLdnhxD6gtq+ut0hITVx30xIap/TeAXtu1CVzXJaQdA3L6Bmd5FgOOVzHfM3iwBQe/UromubK0MkTvoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429467; c=relaxed/simple;
	bh=osGSHu57b1Iq1vyNJxOLvzUwFXEkmgwQn3eONf0LKeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPsPpf0ihE+pdOlby/udtcZVNu6JsweRbbVdk0fQeQ4wiUF0QglgobxhGzrXE+MuiMViDCaib2LO6GtVPzKn+SVlb304fXzJ7IRxQfRamI+pz97gMg6VvT1C1QFA6aEE8yo35238xgGhFfDfJiz5ibBAHVKkpqkeNyjvY0syYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jccUMUr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jccUMUr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4E6C2BCB7;
	Wed, 29 Apr 2026 02:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777429467;
	bh=osGSHu57b1Iq1vyNJxOLvzUwFXEkmgwQn3eONf0LKeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jccUMUr1lw4otdTZ39Onj4srHbqfWXNsY1voVt3HvoVFbsw9EBcBVZQEOqNVIUBkJ
	 M1chQd0QHaGN1yvGwoCiD/C22ZU6VS+cgjDYpkLvz4nD4s4tvfytDZolFayn6BbZpl
	 g7+YffmWgs2l+RypgrYszi6laoWpSGtNkVtS1v9iFmOIHV+tP8vlGxJbh0mET13uv4
	 Qtauu+Xlw3X0L/paRxUosKSXOMF89WaEDdEGeC7fCETaGpYemrjbfJgKvdDPPrEAuc
	 JSOqtV7oCUkJyoaYIV04QxMmVlytARhjjJprWrTgmcwdbKAGSNJIax5xnBjZc+eX2U
	 91NHDfG/NW+Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] arm64: perf: Skip device memory during user
 callchain unwinding
Reply-To: sashiko@lists.linux.dev
To: "Fredrik Markstrom" <fredrik.markstrom@est.tech>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260428-master-with-pfix-v3-v1-1-c384d3e53092@est.tech>
References: <20260428-master-with-pfix-v3-v1-1-c384d3e53092@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 02:24:26 +0000
Message-Id: <20260429022427.2B4E6C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The device memory check only validates the starting address of=
 the user frame, allowing a cross-page boundary bypass that still panics th=
e kernel.
--

commit e9c0174fdde1a5c6f32621d5e911c732eed46d59
Author: Fredrik Markstrom <fredrik.markstrom@est.tech>

arm64: perf: Skip device memory during user callchain unwinding

This commit adds a lockless page table walk to inspect the MAIR attribute
index before reading a user frame pointer. This aims to prevent reading
from device memory regions during stack unwinding, which can trigger bus
errors and panic the kernel.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c53fb0..6426a307b8f8 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
[ ... ]
> @@ -524,6 +616,9 @@ unwind_user_frame(struct frame_tail __user *tail, voi=
d *cookie,
>  	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
> =20
> +	if (addr_is_device_mem((unsigned long)tail))
> +		return NULL;
> +

Could this allow a read across a page boundary into device memory?

If tail is 8-byte aligned and resides 8 bytes before the end of a normal
memory page, addr_is_device_mem() will only check the first page and
return false.

Because struct frame_tail is 16 bytes, the subsequent copy will cross
the page boundary:

>  	pagefault_disable();
>  	err =3D __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));

If the adjacent page is mapped as device memory, wouldn't this still
trigger the Synchronous External Abort the patch is trying to fix?

[ ... ]
> @@ -572,6 +667,9 @@ unwind_compat_user_frame(struct compat_frame_tail __u=
ser *tail, void *cookie,
>  	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
> =20
> +	if (addr_is_device_mem((unsigned long)tail))
> +		return NULL;
> +

Does this have the same page boundary issue?

Since struct compat_frame_tail is 8 bytes, an address aligned to 4 bytes at
the end of the page could similarly result in reading 4 bytes from an
adjacent device memory page.

>  	pagefault_disable();
>  	err =3D __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-master-wit=
h-pfix-v3-v1-0-c384d3e53092@est.tech?part=3D1
