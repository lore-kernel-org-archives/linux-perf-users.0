Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FB311C11
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777191451; cv=none; b=illNh+SW4jOLICBzMx9CCqGSByf4K2HXOfUHi2uF9249L2M4UXlD2heqrsDXJO2XmUD6gsbObAuXdr+xKeIbPEKm/rVjFqNtdQLQx0O9IM/05TGOWNQ61aPB4BOylWXPukInJr+Xg1aZJvnWfVi7f4kerehpnjQxs8L8G9I3IlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777191451; c=relaxed/simple;
	bh=GI1Nf+TS5gbPbzNOlJB5bH7dnD+w3QhdN/NJpVefci8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UHdDrLzfS0krQbBo4ICOJR7eyPXWxtMT9l05domkf97FLy9Z5RfcsKHfxZFmXqLx2X5a2Sd2heYhA39XtJTZSr33xtJh6L1qryFOe/EmUt1tNbDnjCojn/cJZE7ubSYNU+9B5xQpTmz8yfDpqo64p2Y6xVWD62I3D4ImGchCVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL+T99ZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL+T99ZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2D5C2BCB4;
	Sun, 26 Apr 2026 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777191450;
	bh=GI1Nf+TS5gbPbzNOlJB5bH7dnD+w3QhdN/NJpVefci8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NL+T99ZCARL38BbUtpyQaLftmRNKNpoMPeaipxws3tGBzZpDXavReVa+SegM/tOtS
	 vZfLtxyEfqyGkHsve6I/R7jKVaAvHMmZXWl/4MOgSL475avpz1knzkEgVd7/Tftm/u
	 i4hB5Du++/eGuHdepNhKtfszwdj7GBlmEiVowU/5XUGq/7F4enSQ+G8kjpwK6hZHaX
	 KDfhd/yO3BKEGs7zIh0d5Tb3CmgW0d4OLEworaPhfP+hO6DaQmZqhgcgCezyWJiJ3X
	 1t0tFPRZzWanO0ZbMyYWT5nVN6UhWBPAzJ/VwkUhr7zVNSL3jvpgEuNpF4Vxzx4s2M
	 cMtZU9WJvzhXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] tools/perf: Fix the check for parameterized field in
 event term
Reply-To: sashiko@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260426080056.16558-1-atrajeev@linux.ibm.com>
References: <20260426080056.16558-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 08:17:30 +0000
Message-Id: <20260426081730.CA2D5C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unconditional increment of `buf_used` causes unsigned integer unde=
rflow leading to a stack buffer overflow.
--

commit 105f365626ee620dbee6f08aafbe58eaca32755c
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Fix the check for parameterized field in event term

This commit fixes the event term checking by changing strstr(alias->terms, =
"=3D?");
to !strstr(alias->terms, "=3D?"). It also replaces some snprintf calls with
scnprintf in buffer offset calculations to prevent out-of-bounds counting.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..ca0ceb0623ca 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c

[ ... ]

> @@ -2237,13 +2241,13 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu=
, bool skip_duplicate_pmus,
>  		info.scale_unit =3D NULL;
>  		if (strlen(event->unit) || event->scale !=3D 1.0) {
>  			info.scale_unit =3D buf + buf_used;
> -			buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
> +			buf_used +=3D scnprintf(buf + buf_used, sizeof(buf) - buf_used,
>  					"%G%s", event->scale, event->unit) + 1;
>  		}

Can this unconditional + 1 addition to buf_used cause a regression by
triggering a stack buffer overflow in the subsequent scnprintf call?

buf is a local 1024-byte stack array, and buf_used tracks the offset as an
unsigned size_t. If format_alias() fills buf to its limit, strlen(buf) will
be 1023, causing buf_used to be initialized to 1024.

If the event has a scale or unit, the size parameter to scnprintf becomes
sizeof(buf) - buf_used, which evaluates to 1024 - 1024 =3D 0. scnprintf saf=
ely
writes nothing and returns 0.

However, buf_used +=3D 0 + 1 unconditionally increments buf_used to 1025.

>  		info.desc =3D event->desc;
>  		info.long_desc =3D event->long_desc;
>  		info.encoding_desc =3D buf + buf_used;
> -		buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
> +		buf_used +=3D scnprintf(buf + buf_used, sizeof(buf) - buf_used,
>  				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;

Does the size calculation sizeof(buf) - buf_used underflow here?

Since buf_used is now 1025, 1024 - 1025 underflows the size_t type to
SIZE_MAX. scnprintf would then be invoked with an effectively unbounded size
and an out-of-bounds pointer (buf + 1025), which could overwrite adjacent
memory on the stack.

Would it be better to bound the remaining space calculation and only increm=
ent
the offset if space actually existed, perhaps using sub_non_neg() like the
patch does earlier in format_alias()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426080056.1655=
8-1-atrajeev@linux.ibm.com?part=3D1
