Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9624248867
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007643; cv=none; b=RaeTWGFDroBV65bk+SN6UkeQyNJeCDrfj3DvRPK2BYXzMZfXo48zhT3pjR+5fCEpABJEmIW9Z35hPW5NkTLNyLP2pua1xROp5hR4pbh2pVs5eDsZBorlybukLayGpDkOys7mNPzIP543b485pFIA3ovzAj5tYy3ipUhJoms9jXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007643; c=relaxed/simple;
	bh=cy7x+J9c9ABxEe+Eg0/i+7lc06rc/CFChZOIhIY4HHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Haqi5a4rW14RL38ofpwnDwKaUM3CopALl/uGBry7dJm+3fL66VqS6U7JbcGLANBbTsMDUYKSX6gYnd1WF9tHVFc3D3BRU71GTlX6hd2KB+5xYN/PiWUheYda38csR7/uzBVDhP4qqwNinHMCwslYswJqlMHgfqm00NJ4LLLDhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWX/A0jj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWX/A0jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBCB1F000E9;
	Sat, 25 Jul 2026 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785007642;
	bh=sx6CBPqmaR+mtxzAYdvLkfFD7GR5gJdJjEs1AqiOY/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kWX/A0jjU0gCm3bSqjrvz7fGHKv9zprZVaxvWhbljK9taeQEx54rIFE55ichooA1Z
	 EQwDt/zPDcwGxbUY/FnXSLtIEFuuiDngPZi3droEc6LUjRzGNNp0OC6NyAO+Po/Akp
	 5XqQpaTLgIwsjGdM5X8IJyqm7wyErXuEKmzNfohrXSmPRoLnUzeL5agrebUnGGxycu
	 KmLPlzB3QdkiFN0TvZ1Qi6jWdceeQJfK6VQyWmk0AqW0Y3OX/GHuPMx1CbpcE2iuNz
	 Ag+D5VtU4HNst/mLb7xZPsIRq8yAuawaRUJBlbH8yfY6T+hq4aBNxzDu6PdenBuWOn
	 aSecKeFY475cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] perf trace-event: Fix heap overflows in
 read_ftrace_printk()/read_saved_cmdline()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725184953.234759-5-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
 <20260725184953.234759-5-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 19:27:21 +0000
Message-Id: <20260725192722.1FBCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete fix for a heap buffer overflow in read_saved_cmdlin=
e() on 32-bit architectures.
- [High] Data corruption and pipe failures in read_proc_kallsyms() due to t=
he use of lseek().
--

--- Patch [4]: [PATCH v4 4/5] perf trace-event: Fix heap overflows in read_=
ftrace_printk()/read_saved_cmdline() ---
commit 8469cf15f119b26dcccff6c290c31c101e46c1ab
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix heap overflows in read_ftrace_printk()/read_saved_cmd=
line()

This commit attempts to fix heap buffer overflows in read_ftrace_printk()
and read_saved_cmdline() by rejecting maximum integer sizes. This prevents
an integer overflow where size + 1 wraps to zero, avoiding a minimal memory
allocation before calling do_read().

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index 52ed496d92c3b..53f1920c3fcbe 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c

[ ... ]

> @@ -357,6 +363,11 @@ static int read_saved_cmdline(struct tep_handle *pev=
ent)
>  	if (!size)
>  		return 0;
> =20
> +	if (size =3D=3D ULLONG_MAX) {
> +		pr_debug("invalid saved cmdline size");
> +		return -1;
> +	}
> +
>  	buf =3D malloc(size + 1);

[Severity: Critical]
This isn't a bug introduced by this patch, but on 32-bit architectures,
does this check prevent size + 1 from wrapping to zero if size is
0xFFFFFFFF?

Since size is an unsigned long long and malloc takes a size_t, a 32-bit
SIZE_MAX value will bypass this ULLONG_MAX check. When passed to
malloc(size + 1), it would truncate to 32 bits and wrap to zero, causing
do_read() to overflow the allocation. Could we check against SIZE_MAX here
instead?

[Severity: High]
This is a pre-existing issue, but looking at read_proc_kallsyms() in the
same file:

read_proc_kallsyms() {
    ...
    lseek(input_fd, size, SEEK_CUR);
    trace_data_size +=3D size;
    return 0;
}

Does using lseek() instead of the skip() helper silently fail on pipes?

If input_fd is a pipe, lseek fails and returns -1, which is ignored. This
prevents the file pointer from advancing and can cause the next parsing
function to interpret the payload bytes as its own trace section.

Also, when repipe is enabled, the size header is repiped but the skipped
payload bytes are not, which corrupts the resulting perf.data file. Could
this be updated to use skip() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725184953.2347=
59-1-tshah@linux.ibm.com?part=3D4
