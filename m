Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39842CAEF;
	Mon, 10 Aug 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380994; cv=none; b=i26CvXUrNknw4llZAzMqO95j2oAJukG7Xkwc8bHRYd09NhIBJZTDFgR+WHFi0sPPNxz5OewGBmsNkD1SYosT8rY+4AQAg/n1EojaNnKF4Q7M4xDoLP82GLFTkstvk5enZ33eMX0l8s4tF/zvCgK0McbOTxnXN9Wt75M4WYZJnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380994; c=relaxed/simple;
	bh=P4plBPhNTorj9RfVvO/yv1t8DXIcUFz1/WdCiHovbZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D5tl0pQ8NIqTDVW5iMSXdrdNSNS6upLmQ5PHmxcVc7q40SFFn9S+fyeh2kp3OdniTlGi4FKb9yJ3lnZlsDhNh++LG2PjR+bpmn/WWxC+vX0ZQGYDmE6ejA+VlK62ZWvh2pKROp8K5o5We2BLJ6d0P4B9iIsRRCOgtYLsoo2iWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTeyjm5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTeyjm5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE96A1F000E9;
	Mon, 10 Aug 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786380992;
	bh=Wo6nzazVGPIFcDs5c34oGuXZxGiBOjw8dD5RD0smpIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RTeyjm5NuoyRc6W9LdgYnVJLMzikwyudcSTRSzWfdCXjWyK1yywfoLjTZBMysZXCS
	 iT7CJTuyn1N5c5mgXa+B3wg9evz5zyU8XlWXoO90DrJXV5pk5hxT5FovEv9XREXt5Z
	 IYIRbfnRMuwcCbBR6jRIs7VbubhzDG9YA1bBEsTRvr75eer5m5la+J9iJt9ddsehez
	 9dAtjNYGoKQa+LIjNyUE29nDaECpiIwep8072xDwVHwoZA7QB8FmL98dJAkAl7nVOr
	 bq5kijndqzZNdx+TbPW8q7UqBpYZUfEa/BcPKxt1ouEhE0RZkUbIzLrwzCjcCh2Cyt
	 XH80LTCZqtzWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260810164622.1829843-3-puranjay@kernel.org>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <20260810164622.1829843-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:56:31 +0000
Message-Id: <20260810165631.DE96A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `isb()` context synchronization barrier after writing to=
 the `PMCR_EL0` system register in `brbe_snapshot_branch_stack`.
--

--- Patch [2]: [PATCH v6 2/3] perf/arm64: Add BRBE support for bpf_get_bran=
ch_snapshot() ---
commit a7708fa08fe97675c17bb6e7a2098acd91d49bfb
Author: Puranjay Mohan <puranjay@kernel.org>

perf/arm64: Add BRBE support for bpf_get_branch_snapshot()

This commit implements the perf_snapshot_branch_stack static call for BRBE,
allowing bpf_get_branch_snapshot() to capture hardware branch records. It
manages BRBE state by pausing it during the snapshot, freezing the counters,
and handling buffer invalidation to avoid data corruption.

> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c4..9e7e69c43b17d 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c

[ ... ]

> +int brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsign=
ed int cnt)
> +{

[ ... ]

> +	if (paused_here) {
> +		/* Branches were missed, so discard rather than leave a hole. */
> +		brbe_invalidate();
> +
> +		/* Unpause first; a paused BRBE cannot freeze on overflow. */
> +		write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +		isb();
> +		write_pmcr(pmcr);

[Severity: Medium]
Is a context synchronization barrier missing after this write to PMCR_EL0?

Architecture invariants for ARM64 usually require writes to control-plane
system registers to be immediately followed by an isb() to ensure the CPU
pipeline observes the new configuration.

Could the lack of an isb() here allow the CPU to continue operating under a
stale PMU configuration for several cycles, potentially missing performance
counter and BRBE branch events immediately following the unpause?

> +	}
> +
> +	local_daif_restore(flags);
> +
> +	return nr_copied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810164622.1829=
843-1-puranjay@kernel.org?part=3D2
