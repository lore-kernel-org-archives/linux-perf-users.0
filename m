Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F0175A7D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905032; cv=none; b=oQzznAMekaSnlEJmxGvXLEggus2cy/9Ls+Du7JBI7yjKQQQJlYQvRnex+PvZ2xJaPwSsg13gBJDTnKbVqiunEzDWIrSTEJxPkErKyxggxzZdzKDZzO/Ni4Qn50vwjTxZ+Afs6iHUGxizDmCAfquCRC9G1htvmWNsZHbg9jztv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905032; c=relaxed/simple;
	bh=wi6MiB5zs3Xie6rKLV+t6mt9v5QvrSGcFZuoeGV3odA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FE98JdftlbReGcURerDfKkuyx3yfRVcha3ivk04ZkKg+IfWYVMYoBHPRmLP4BWqomu2Uut+lvkwdac47E2YGgoc69khStpKGlZlcFL9GKAGm817I4z8uuVjFuvpgZ5L5gnukE/5T5s2hLQVNU/mP1AgBLDmHj70xye7BrG9bZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0lUd2tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0lUd2tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECA1F000E9;
	Fri, 24 Jul 2026 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784905031;
	bh=k1G0kiSsiQjye8P9rZljJNfAa5HmaMBVBZ5ZZlhMvYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N0lUd2tnBfr6fhLMQIgJi60qJkbTyN3+gm55hFpP2dIqEnHNnxydBuwdK8GXH7aGS
	 XwRHhjOQux3y+VWI6aetRoJsuK252CZif1JBecpSkGhzItn+0KH6X+bRdSIwKeuqt/
	 29FmY0dCCCKrznQkzw5OVvwRuV5FEnH24bKtIjKMDu2ETDtMZamqprV28xzchBtA+x
	 lFVgVJd/LNYUSQIForU8m36TB8J+ESZStAoMD4crGP5nibxOo+6dqpyAF0cDApdJUJ
	 xQb70w6ubuNs/dG38NXRYP29SN/+KZVdBVubQ6ug3rjtf9j16CeRqB3w1a3JN29Ykx
	 bKHLqLq57eWSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] perf trace-event: Fix infinite loop in skip()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724141316.99507-6-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-6-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:57:10 +0000
Message-Id: <20260724145711.53ECA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a heap =
buffer overflow in `read_saved_cmdline()` due to an integer overflow when a=
llocating memory for a buffer based on an untrusted `size`.
--

--- Patch [5]: [PATCH v3 5/5] perf trace-event: Fix infinite loop in skip()=
 ---
commit 31b13f3b8b045b8ed6e1e9aaefa3637fac096e0b
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix infinite loop in skip()

This patch fixes an infinite loop in skip() where do_read()'s return value
was ignored. By checking the return value, the loop now breaks correctly on
failure or EOF.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index 147a3b95ce06b..529a56c3730fa 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -71,12 +71,16 @@ static ssize_t do_read(void *data, size_t size)
>  static void skip(size_t size)
>  {
>  	char buf[BUFSIZ];
> -	size_t r;
> +	ssize_t ret;
> =20
>  	while (size) {
> -		r =3D size > BUFSIZ ? BUFSIZ : size;
> -		do_read(buf, r);
> -		size -=3D r;
> +		size_t len =3D size > BUFSIZ ? BUFSIZ : size;
> +
> +		ret =3D do_read(buf, len);
> +		if (ret <=3D 0)
> +			break;
> +
> +		size -=3D ret;
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential heap buffer overflow in read_saved_cmdline() due to an
integer overflow when allocating memory:

tools/perf/util/trace-event-read.c:read_saved_cmdline() {
    ...
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

If size is large enough, does size + 1 overflow to 0?

Could malloc(0) succeed and return a small valid pointer, causing do_read()
to overflow the buffer with size bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141316.9950=
7-1-tshah@linux.ibm.com?part=3D5
