Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901973A7F7E
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790492; cv=none; b=AEw4dKqM77f98eCb1rV6fFaX1Qv0TffatklPpbpcNCfyY7Zbm+T4yMYiTSciFiEQQGjt4evee775ifV6l+9AWbyTPGd81Ew0DWizogY1eIsfIt2V5MJlXqY3tF7GZdwGK1yQoqk49ygIcOuCPaXczFoxNRxvFPT62CmFJqOUPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790492; c=relaxed/simple;
	bh=83uTAIF2uRYBb0UWcAEksM7UDjQuHpgw4g/HbkiyB+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KxA8WqGANCVsr4P6nCLNz75UE3Sw6NhWpzKtczSKDjG4ZSfP36vOsiDdSICLX8fRiXtIiwG8+2+WwwttidN6w1gsihR+6OJUxtgzICEj46TkSG3sV9POloD8hMWq8NYhB0ajC91EDoESHlegMj2808OJ3PWX0r76n3O6kpitljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu7cC3C8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu7cC3C8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA231F000E9;
	Mon,  3 Aug 2026 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790491;
	bh=RiNvpVq8DhaTbOqcSq9w9aYKclI5b+Sm7U0KU+ySrwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cu7cC3C80lyp8hfcDHWVzEe+Tbzz2hMr+W9rU7DJMKk0bLARYIi6Bj57hLEowfIHt
	 BmJikU2+XpfUcIBRCRmDerzUZE9dIvCEZ/XlFTKHxybyEfYEJMUDy5tpHz5mnAouFu
	 IzfrvMjeTtXJSuvNcgnp4yC3wBheiwBQWA41ClRpeDbLzmXVy3v/HsH5AC2tL6Mnxa
	 ynXNSIYns8ZEJ2ljLFZfzYEBErAsZPiTHOhkrLk9KF/KO/LShUHXt0Ets7QhS9GoEV
	 dnlAgGluO/6E76u03Vx7y7ekaYKR6GZsXLf1ol+8WuVUazQ0qo4BmjhF1PmK0Nzh3p
	 o8vWyHegtu1Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803204540.100348-2-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
 <20260803204540.100348-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 20:54:50 +0000
Message-Id: <20260803205451.4CA231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Insufficient stack buffer size and unsafe string operations in=
 memory event formatting lead to severe integer underflows and stack buffer=
 overflows.
--

--- Patch [1]: [PATCH v3 1/6] perf mem: Fix size tracking for mem_lvl's in =
perf_script__meminfo_scnprintf() ---
commit ac4418d3c38063a8fbcd5e19348324171261d3d5
Author: Thomas Falcon <thomas.falcon@intel.com>

perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf=
()

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fcc..4e490f9cd3488 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D scnprintf(out, sz, "|OP ");
>  	i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -	i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);

[Severity: Critical]
This is a pre-existing issue, but by passing sz - i here, does it make it
more likely to hit buffer overflows and integer underflows in the helper
functions?

In tools/perf/builtin-script.c:data_src__fprintf(), a fixed 100-byte stack
buffer is used:

    char decode[100];
    ...
    perf_script__meminfo_scnprintf(decode, 100, mi);

As perf_script__meminfo_scnprintf() accumulates the printed length into i
without bounding it to sz, if the total length exceeds 100 bytes (e.g., with
multiple mem_lvl or snoop flags), i will exceed sz. This causes sz - i to
underflow to a massive size_t value, bypassing bounds checks in subsequent
helper calls.

Additionally, if the remaining size becomes exactly 0 or very small, helpers
like perf_mem__lvl_scnprintf() and perf_mem__snp_scnprintf() do:

    sz -=3D 1; /* -1 for null termination */
    ...
    strcat(out, "Remote ");
    l +=3D 7;

If passed a size of 0, sz -=3D 1 underflows to a massive unsigned value. Un=
checked
strcat() calls will then write out-of-bounds on the stack.

>  	i +=3D scnprintf(out + i, sz - i, "|SNP ");
>  	i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|TLB ");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803204540.1003=
48-1-thomas.falcon@intel.com?part=3D1
