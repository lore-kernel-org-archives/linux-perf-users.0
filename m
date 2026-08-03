Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A171DFFB
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753800; cv=none; b=Io5ZT44NjEy1Gm87GEkWuvoEk1o8Oe22d0rQaE/DKWFJhvR3+U6iziGASYiVu+bWq9VunHeEKy7Q2NslYRvTDG2ms9pkzu2WxAI/xQv3CW2xmh76fuckSKAT8OqiXagdbYZ5AEZTkX08WSlL35MpqD6XYthq949oLu3f/D7qihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753800; c=relaxed/simple;
	bh=82l9XzKfNmOoLypV5qiuy1ASy0xwoRrzJCRXxcI0qjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n7Ljw/VsYeJltAYmGTaVcBXEgWnh5oDZ10dVl/w20Qv8oSYwDTLZhzZ3NK9UIFDnT99Ux+MMdaXr0cqRXB2wz9dJyu62bygR8spOLaoa78OpFI69EUCKXbMXOejUIJ0GRgohxinzmIsMb/4qBq/D2srgxkABDT3MJmU8n7CUz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxMSunVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxMSunVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C291F000E9;
	Mon,  3 Aug 2026 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753799;
	bh=Bn2E14HpnmuJK1IZZGP+5MS7KVqnl/qGJQv/lzUfvTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxMSunVBTlErCbDH1v3hnoRATpCXgjkoB/1BXQqCpqonwnwBy3PonwljRE24tyJmK
	 89IsZEpe7DN7PfQ+jAE7AcWblvPRQpJ/ALNZdwVUNfUbdWL+4MdzDy53FM8kRuEY4M
	 k7RgxbRpc31qeAQMl/LghAhskRKU+wPqI98G5ou0aIi8Yfx569FnPT7SrVgvDZ1fsp
	 De1hP8Bsyu7taN/Qi0c/+QZYV254BW5RYBtdL/f/FFkLtvjrVYQzErvnhVjdaGttub
	 BlhASh46d/4VAMEpix4xlrUE5t367XmDyThJdoBo+kcdtKvebr5SFT3KXnHl4gPuoe
	 6dL4AYivgyYXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf tools: Fix double free and memory leak in
 kvm_events_record()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michalis Niarchos" <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803-perf-kvm-fixes-v1-3-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
 <20260803-perf-kvm-fixes-v1-3-a5db849ac973@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:43:18 +0000
Message-Id: <20260803104319.52C291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch resolves a double-free and memory leak in `kvm_events_=
record()` but leaves identical vulnerabilities unpatched in `__cmd_record()=
`, `__cmd_report()`, `__cmd_buildid_list()`, and `__cmd_top()`.
--

--- Patch [3]: [PATCH 3/4] perf tools: Fix double free and memory leak in k=
vm_events_record() ---
commit 03f3f88662347e4848a16bffad56206678f9263b
Author: Michalis Niarchos <michael.niarchos@gmail.com>

perf tools: Fix double free and memory leak in kvm_events_record()

cmd_record() reorders the contents of the rec_argv pointer array, so
its entry order no longer matches the order in which the caller
originally allocated them. Freeing the contents of rec_argv by
iterating the reordered array results in some pointers being freed
twice and others never freed. This patch fixes it by referencing the
arguments directly instead of duplicating them.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 1a013698cae34..189ef3576e34e 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
[ ... ]
> @@ -1717,9 +1717,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int ar=
gc, const char **argv)
>  	record_usage =3D kvm_stat_record_usage;
>  	ret =3D cmd_record(i, rec_argv);
> =20
> -EXIT:
> -	for (i =3D 0; i < rec_argc; i++)
> -		free((void *)rec_argv[i]);
>  	free(rec_argv);
>  	return ret;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but since you are fixing the
double-free and memory leak here, should the same fix be applied to other
functions in this file that follow the exact same pattern?

Looking at tools/perf/builtin-kvm.c, the same iteration and free approach
is still used in __cmd_record(), __cmd_report(), __cmd_buildid_list(), and
__cmd_top(). For example, in __cmd_record():

	ret =3D cmd_record(i, rec_argv);

	for (i =3D 0; i < rec_argc; i++)
		free((void *)rec_argv[i]);

Because parse_options() shifts elements around in rec_argv during the
cmd_*() calls, wouldn't these other functions also suffer from the same
double-free and memory leak when the elements are freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-perf-kvm-f=
ixes-v1-0-a5db849ac973@gmail.com?part=3D3
