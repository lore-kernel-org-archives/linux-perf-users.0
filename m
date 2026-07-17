Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614D3FD140
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294466; cv=none; b=i0mpBnrecjaBLNbHB/wlQEuT4Gfmajh2jZGoiB+2OQ2WruqulOoLWNqouvR3vV7blMuyXtjQyQZH+yrZsiEBxYesIYcPj3NyobH+oJwN7DvqKZfJFTWt6aHeSwyhF+lBiJXEd3NzxWbSjDedAQFdaXubHexL0++SDvoM/LDqQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294466; c=relaxed/simple;
	bh=5qtXC9koHnXM1URAB/UsrE/z1c99f6YkhXVoTbs+L40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXCuPYtFzHDsGQ/yeld1IPzDgYb7795WWjDVDsqE8MUHosSSiK86ArNrV6FGAg7iwsPmcPccnE7GeybnCLIg8DVaXf2/xnRHA1m81h4NJTX9HH4IKv4YH2RugouPa2gMKOrWIPwHIEiUi5Tzen1sMVJNgXCcUDr/5KUlsVKZUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4K0orpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4K0orpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBB91F000E9;
	Fri, 17 Jul 2026 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294465;
	bh=wTKlib+2MPRwLjsHR6o6MbtCk6D4h3EMcJNDAVhJwxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4K0orpNr7q4fn8s9iv93FSpZCFOB9yWTrUJR3iIjK6GvKJl+QbqSd8RKCGl9v4/2
	 zJREf2Oz6ePZy++VRQZDb7/3osFI9SbYX5Li7ZxR6rLe8ltrcj865uL8NFvgVdrJOu
	 rdpDpMA0SA8NYubBf6DYDSii7tSQJDUcxIH9qnGoRCGAUBNuy64j27Cjb5c/2K2hRx
	 XpZvwZyeU2AHEtneeMsRE5nfYthPzwssQSuEqxaenyHLP31wglJ8dDVykbN7XJVNo2
	 +LxMtBx+h8BW8DXLJz4mws2FbHQ2IJS7OT820jSYGNqXLHyQzKrWE1OCgNVqINnT46
	 TfRwuK/uLObdg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/13] HWBP: Add
 modify_wide_hw_breakpoint_local() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130340.1902076-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130340.1902076-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:21:04 +0000
Message-Id: <20260717132104.DDBB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Non-atomic updates to active hardware breakpoint state can cause t=
orn reads in NMI/#DB handlers.
- [High] The function alters the event's internal software state before ver=
ifying if the hardware update succeeds, leaving the state permanently corru=
pted if the hardware update fails.
--

--- Patch [4]: [RFC PATCH v2 04/13] HWBP: Add modify_wide_hw_breakpoint_loc=
al() API ---
commit 326c7d6d8fc03bc42d6719968b050227e4e25f31
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

HWBP: Add modify_wide_hw_breakpoint_local() API

This commit adds modify_wide_hw_breakpoint_local(), an arch-wide interface
allowing hardware breakpoint users to update watch addresses on-line for the
local CPU. It updates the configuration by reusing the current hardware slot
without releasing and reserving it.

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..f4709c892d674 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c

[ ... ]

> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{
> +	struct arch_hw_breakpoint info;
> +	int ret;
> +
> +	if (find_slot_idx(bp->attr.bp_type) !=3D find_slot_idx(attr->bp_type))
> +		return -EINVAL;
> +
> +	ret =3D hw_breakpoint_arch_parse(bp, attr, &info);
> +	if (ret)
> +		return ret;
> +
> +	*counter_arch_bp(bp) =3D info;
> +	bp->attr.bp_addr =3D attr->bp_addr;
> +	bp->attr.bp_type =3D attr->bp_type;
> +	bp->attr.bp_len =3D attr->bp_len;

[Severity: High]
Can this cause a torn read if an NMI/#DB exception occurs while we are
non-atomically updating the breakpoint state?

If an NMI triggers a #DB exception before arch_reinstall_hw_breakpoint()
completes, the hw_breakpoint_handler might read the partially updated
bp->hw.info and bp->attr while the hardware DR7 register is still armed with
the old configuration.

On architectures like x86, reading a torn bp->hw.info.type might cause the
handler to misidentify the breakpoint type and fail to set the RF flag,
leading to an infinite #DB loop.

> +
> +	return arch_reinstall_hw_breakpoint(bp);

[Severity: High]
Does this leave the software state permanently corrupted if the hardware
update fails?

If the PMU rotates the event out just before this function is called,
arch_reinstall_hw_breakpoint() might fail and return an error like -EINVAL.
This error is propagated to the caller, so the caller assumes the
modification failed.

However, the software state (bp->attr and bp->hw.info) was already
overwritten above and is not rolled back. When the PMU later rotates the
breakpoint back in, will it silently use this uncommitted new configuration?

> +}
> +#else
> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +EXPORT_SYMBOL_GPL(modify_wide_hw_breakpoint_local);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D4
