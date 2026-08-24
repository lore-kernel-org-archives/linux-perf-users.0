Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99393EC6A8
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561695; cv=none; b=oKNqmhG8PEArCjaqCorvZkaEEoJfbNxE07esSwkK7OLosjRwhpknM89dljonncKTOdfJTfNeM++ywVqTY9Cvef0NDBHSb7caS1DXixGrCEyH+T/rwiWnBkk1b6uUP/TXsTSCwCqujCEe5sKCiDAtAhpoIGgO2fnkrMbI1YbnhnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561695; c=relaxed/simple;
	bh=qmTH3eNyvtBBVOL1u44jkhrzEikpkAtiZ1b5AFzhRtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ArmpHuh8ePyA7J1Iy7eBeKiFamqtllMdRE/gYOxrjAy45yoS2fjMEPO+CCvW7kHN1XTZLlNjnZTp016loJ5hMus8A2bB0LLQdOauNCvAbM+rrkbQzvlFHLZ0CtlbS9MC7JMkghpLb5rAWgEiZI+CXwekdM4S+zziGr6gtUHQDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI0iOAa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI0iOAa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A65E1F000E9;
	Mon, 24 Aug 2026 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561694;
	bh=98oLn9PmuCfYTlLcUJElpQArhRFd/xLC8lADfpaw7CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MI0iOAa6lRA0ftbCqCOHrEQ1QfjzhMLLWy8PK5KvyX2ixJVzhvr0Jf5/hpKbtOsj0
	 rMyrYftNWDWe1vz/5kNDeAVHxGTBTCyzM7CjhkiWBR6+0tRr2BrhfkC0QqJZwVRpTT
	 VJ3dEWTZBPPWlRTV9QcCzTbNnzt7CmMZSSBw81EjGZTKjAILCehdao1UxYXj1vUhvQ
	 h90UX8CBkTMRH0BVYzdw+RjRPz263F30Tx3iEz1NnLAxnelnkNYgAzR+ZKZJiNHRgp
	 UBgTNAKejGqtLNC9ECxtQ2WjEDH0IWSVUItMJYFsYigocDoFkQ6H60MHduoxA7qAiy
	 Wrr3eCAsCZx4w==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 12/23] perf: Add sampling support for SIMD
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-13-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:54:54 +0000
Message-Id: <20260824085454.7A65E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded or improperly ordered SIMD register sample size calculat=
ion causes a `u16` size overflow in `perf_event_header.size`, leading to ri=
ng buffer memory corruption.
--

--- Patch [12]: [RESEND Patch v10 12/23] perf: Add sampling support for SIM=
D registers ---
commit e9a1c0bea3274c1464a1ceda195d11e8cdb5abe5
Author: Kan Liang <kan.liang@linux.intel.com>
perf: Add sampling support for SIMD registers

This patch introduces new attribute fields in struct perf_event_attr to
specify and retrieve SIMD registers during profiling. It also adds the
PERF_SAMPLE_REGS_ABI_SIMD flag and a new output format to indicate the
configuration and contents of these wider registers when sampled.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 801cf34cf519b..6cc655e7694d4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -8775,6 +8866,10 @@ void perf_prepare_sample(struct perf_sample_data *=
data,
>  			u64 mask =3D event->attr.sample_regs_intr;
> =20
>  			size +=3D hweight64(mask) * sizeof(u64);
> +			if (event_has_simd_regs(event)) {
> +				size +=3D perf_update_xregs_size(event, true);
> +				data->regs_intr.abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
> +			}
>  		}
> =20
>  		data->dyn_size +=3D size;

[Severity: High]
This is a pre-existing issue, but does adding potentially large SIMD
registers here guarantee an overflow of the 16-bit event size?

Looking at perf_prepare_sample() in kernel/events/core.c,
PERF_SAMPLE_STACK_USER is processed before this and maximizes the stack
dump size to fit within U16_MAX. By appending the size of SIMD registers
(which could be up to 32KB) after the stack truncation step, the total
dyn_size can easily exceed 65535 bytes if a user configures a perf event
with both PERF_SAMPLE_STACK_USER (requesting near 64KB) and
PERF_SAMPLE_REGS_INTR with SIMD registers enabled.

When perf_prepare_header() later writes the total size to header->size,
the value will be silently truncated because header->size is a u16. Can
this lead to the kernel writing more data than it reserved, causing ring
buffer memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D12
