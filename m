Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AEB324716
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904878; cv=none; b=U2Q3HQ6/DKUn0+7RFQe2s2wgJ9ZVs69L+iKH6QJjfuJ7uDF1YkVCCYo5tEvk/XQQXs1C6ic5EIjTG/Eft1JWNoeWVV6asVd07nRNk1RZlLp/OL9dBhK4lPz4noXvg62V5UAJ9DGLo4as/tLExoMpe4/CEoxPxzsw0b2fZrIyJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904878; c=relaxed/simple;
	bh=Fs2OmUak6Sxx9BmOUGBgUK52nd7U+ErP8J1xS6BgV/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1Hoo6QZlHfFzWVToNFZmdD/BreZjsfIS9fRu2qMBbsItjpSbaSjurRXGskdRB5LCULOokBcXUgaO7E6ZaiKM1qQHfUe8FSfkceeMEGnWqDYEzj1aN+7o0RQx4gQ77qUFCXWf8PMSNlDFpj3yL34UwtsQfXLUlFfbClJHbaEYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrHDOHPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrHDOHPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944741F00A3A;
	Fri, 24 Jul 2026 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904873;
	bh=iMudD46VPVyL6OCjzvohdNuUsuVuq+KR76PpKRgAFFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OrHDOHPW7YVk3YNWtTYS5HDogpR2lLchcLGNCVP7zRWD0P9xx+eowQvIGvTSux2O0
	 W7OmW8p141lD0wZm/ZHbTJ6Rtq2yujgUE5yyFPAsX5Tbzu18kSdbvVUZU60eQEwgbA
	 anpsKX/U1EJroyjG7BeBOy9jinycjDaqnuf+ScppyWtmai0AuKeJOfubOQBpU60vKX
	 8TXibNfg7QMyXCp2pt5++BT9BE/ezBgQXEDfsqBLIS7415QR+wua75fCtIEqsM9UfL
	 wcLJiMPlXMmVIKV2NN6jjFyZElc/L7XV577Mt4eQvIG1RUyj/yyqF745q8C5vrdDYO
	 b+GN/V2Ln9sZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] perf trace-event: Fix heap buffer overflow in
 read_ftrace_printk()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724141316.99507-5-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-5-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:54:33 +0000
Message-Id: <20260724145433.944741F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch uses `UINT_MAX` without explicitly including `<limits.h>`=
, violating musl compatibility guidelines.

Pre-existing issues:
- [Critical] The commit patches a heap buffer overflow in `read_ftrace_prin=
tk()` by preventing `malloc(size + 1)` from wrapping to 0, but misses an id=
entical vulnerability in `read_saved_cmdline()`.
--

--- Patch [4]: [PATCH v3 4/5] perf trace-event: Fix heap buffer overflow in=
 read_ftrace_printk() ---
commit e35d114b06414be20beac51dfd3a3e158eba2833
Author: Tanushree Shah <tshah@linux.ibm.com>
Subject: perf trace-event: Fix heap buffer overflow in read_ftrace_printk()

Fixes a heap buffer overflow in read_ftrace_printk() by preventing
malloc(size + 1) from wrapping to 0 when size is UINT_MAX.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index 52ed496d92c3b..147a3b95ce06b 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c

[ ... ]

> @@ -180,6 +180,11 @@ static int read_ftrace_printk(struct tep_handle *pev=
ent)
>  	if (!size)
>  		return 0;
> =20
> +	if (size =3D=3D UINT_MAX) {
> +		pr_debug("invalid ftrace printk size\n");
> +		return -1;
> +	}
> +

[Severity: Low]
Does this code need to include <limits.h>?

The perf tools guidelines for musl compatibility state that we shouldn't re=
ly
on implicit header inclusions.

Compiling against musl could fail since UINT_MAX is used without explicitly
including <limits.h>.

>  	buf =3D malloc(size + 1);
>  	if (buf =3D=3D NULL)
>  		return -1;

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but doesn't the exact same wrapping
issue exist in read_saved_cmdline() in the same file?

tools/perf/util/trace-event-read.c:read_saved_cmdline() {
	unsigned long long size;
	char *buf;
	ssize_t ret;

	/* it can have 0 size */
	size =3D read8(pevent);
	if (!size)
		return 0;

	buf =3D malloc(size + 1);
	if (buf =3D=3D NULL) {
		pr_debug("memory allocation failure\n");
		return -1;
	}

	ret =3D do_read(buf, size);
	...
}

If size is ULLONG_MAX, size + 1 wraps to 0.

This causes malloc(0) to return a minimal allocation while the original
ULLONG_MAX size is passed to do_read(), leading to a heap buffer overflow.

Should a similar size check be added here to prevent malicious perf.data fi=
les
from triggering this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141316.9950=
7-1-tshah@linux.ibm.com?part=3D4
