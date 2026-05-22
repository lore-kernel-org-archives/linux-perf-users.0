Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF42727F3
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431745; cv=none; b=C5novwF+YV/TeD9Glb2+yRfyFz9q43Ugt/CkcvL1/zOaDaQjBKDwyhtUoJJ4AZm3CPjuakjUaoBNXJLAKOazWn64pcAsrYJZ5k0XGgDaGzOnAKT02i7PSHzI6Q4wxmRmSiecXTA59Z/dwO1NYB7MXeBjm6WuJehmeioSfA9aoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431745; c=relaxed/simple;
	bh=oY+ecSYSgPgc7pCEUfW4cdaij9bLn1rZAQE6HCOPSTg=;
	h=Subject:Date:Mime-Version:In-Reply-To:To:Cc:References:
	 Content-Type:From:Message-Id; b=usHIvIJYgQ01tEQsXdeP0bZ5Et1SJ0/RnuE4JjnSZbyu+ncGFCHoI/RRR/Wql19riNv62qgbWPwkEau3g+6UkwK9ByWc0I/1Ukah3To7V8DPDBcCPFsZuEG82H5xSG7qXGLVQiIKN/ssWbkN5D2kFaweDpfMILvxeoju1BQa6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=p0ALeNKz; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="p0ALeNKz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779431732; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=C1vQRP1D3NY632F8UPmb0CyLB1qMSem5wwX2O1TVSL4=;
 b=p0ALeNKzcr2HZf6FBV510jawDfkMkJZYsnNLlMTCYMnPepbQkicBuPQG6qnjL8Sc7VXx9M
 04l506R5XoY78PESqOvlV3uNXyJcT9NorG6smSglMWaC82LPIK5f4fjdenFXu1MQHi0+uS
 y3okbDVkIsuT1hvVXMTSbqQR/GW4ruddA1LxbSTOTr04ZypzDQAvt4rs05RrDtAHXpuNNd
 +DK9AdpvFea2x+Pt05sQYIL3q0K36bKQ5GE7n2fThoDmldlz4S2K2PB0iQXhsEflsgdwCT
 vzMuzr5RohsUnz1ibhFJ/71PQ+jWFuYqO7aBCSV4RzrOxzHCzl7gaIxhrBYiaw==
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a0ff932+2ad164+vger.kernel.org+qirui.001@bytedance.com>
Subject: Re: [PATCH] perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
Date: Fri, 22 May 2026 14:35:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260521113810.A5BAB1F000E9@smtp.kernel.org>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <linux-perf-users@vger.kernel.org>
User-Agent: Mozilla Thunderbird
References: <20260521111429.4042238-1-qirui.001@bytedance.com> <20260521113810.A5BAB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <621ff628-e3a0-489b-8730-e07153d0c0e0@bytedance.com>

On 5/21/26 7:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Parser desynchronization causing valid symbols to be skipped w=
hen encountering symbols of exactly KSYM_NAME_LEN length.
> --
>=20
> commit 6a5c6924aa13657b35988b3648db68dd1a6e6f83
> Author: Rui Qi <qirui.001@bytedance.com>
>=20
> perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
>=20
> This commit changes the loop bound in kallsyms__parse() to prevent a stac=
k
> buffer overflow when reading long symbol names. It ensures the null
> terminator always fits within the symbol_name array bounds.
>=20
>> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
>> index e335ac2b9e197..f7100d43ecf49 100644
>> --- a/tools/lib/symbol/kallsyms.c
>> +++ b/tools/lib/symbol/kallsyms.c
>> @@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
>>  			read_to_eol(&io);
>>  			continue;
>>  		}
>> -		for (i =3D 0; i < sizeof(symbol_name); i++) {
>> +		for (i =3D 0; i < sizeof(symbol_name) - 1; i++) {
>=20
> [Severity: Medium]
> Will this change leave a trailing newline in the stream for symbols that
> are exactly KSYM_NAME_LEN characters long?
>=20
> If a symbol name is exactly 128 characters, the loop terminates without
> reading the newline character since the bound is now restricted to 128
> iterations.
>=20
> When the outer loop continues to the next symbol entry, io__get_hex()
> would encounter this leftover newline and fail. This triggers the error
> recovery path which calls read_to_eol(), skipping over the entire next
> valid symbol entry.
>=20
> Could this cause the parser to silently drop valid kernel symbols when
> it encounters symbols of exactly this length?
>=20
>>  			ch =3D io__get_char(&io);
>>  			if (ch < 0 || ch =3D=3D '\n')
>>  				break;
>=20

Good catch, thank you for the review.

You're right =E2=80=94 the change does leave unread characters in the strea=
m
when the symbol name is >=3D KSYM_NAME_LEN. As you described, the next
outer-loop iteration's io__get_hex() would fail on the leftovers, and
the resulting read_to_eol() would skip the subsequent valid entry.

I agree that explicitly draining the remaining line is the right fix.
I'll address this in v2 by adding read_to_eol() when the loop exits at
the length limit without seeing '\n' or EOF.


Note: in practice, the kernel's own kallsyms output is truncated to
KSYM_NAME_LEN - 1 (511) characters, so this path is unlikely to be hit
with current /proc/kallsyms input. But the defensive drain is necessary
for correctness, especially if the function is ever used with input that
doesn't come from the kernel's kallsyms.
