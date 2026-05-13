Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA761991D4
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646349; cv=none; b=seJXoRtFg5WAEttcAb3HLeZ6QDT627RAmkcDeCHuNfYpDEXxPy6XgjEBE716Dp3l4/E1GGIQYsnPAgHLzDgRE9rUmjKx7rFzWr7RJv5GPvKAetwU1G1QT0KZuW9sSqCE+mdfxFXUXhjpoHXHgVct8YchekCs7+gg8PDYhmbxcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646349; c=relaxed/simple;
	bh=JKNroDttSKcaDL/iTi9eWJChiD0PsFlOMpolNyrQsqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrjXtOlcpU0qk8LHWRp0Cz6wJgil7GDFsLsG2ESPwextmxbxMSvgA1RsSgbKNTO5DG8/5qdF392wi8v0msWmhTK4hXyooOz5jYdakb1wmeCEB2rHISukk/mMqrNGPXDKXN4eEBUnF5VAH9thfK8ooE3TGFKQhfQB3UJwvX3ZwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHjJoYN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHjJoYN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A4C2BCB7;
	Wed, 13 May 2026 04:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778646349;
	bh=JKNroDttSKcaDL/iTi9eWJChiD0PsFlOMpolNyrQsqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tHjJoYN+i7zqAodNQSYP2hlICrXJpZr/qewCREHR356Ww0LGerPyd5+zYaX2eVGJ5
	 iPFyKZ4ym0/HHirLhKl4YwzAyGagYR9CwUOH22jiX/Ewbadbn2O5VhU5OvTIUq24j2
	 me9Vm0Tsx0rDZLe/M4R2Ph3UVibemTzqooywOow8jRbM4unYgMzyKaQk5dyo/xbVqH
	 1FZVXQgrjJMklZNioOU8nCTo72GU2TH0RSNWpG3tNcnqEbLBNdJau7VOVcAbv9semH
	 zkEQqDQa7cEsTISfem2YCNnnloGKoyz332LU1Zp9hpPztFRoBXj6P5DDUypevE7RRX
	 MV5uw0HRqy1Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260511230527.26096-7-zide.chen@intel.com>
References: <20260511230527.26096-7-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:25:48 +0000
Message-Id: <20260513042548.E22A4C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The return value of `wrmsrq_on_cpu()` is ignored in `uncore_msr_=
global_init()`, masking hardware initialization failures caused by a CPU ho=
tplug TOCTOU race.
--

commit d795e124f297e8f2c0cfee9efd29cdf4ec1993ce
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Implement global init callback for GNR uncore

This commit adds a generic uncore_msr_global_init() callback for GNR, GRR,
SRF, and CWF. It writes 0 to the global control register during boot to
ensure the UBOX PMON units are properly initialized.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 19056514b0812..a7780c5cd419a 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -1731,6 +1731,17 @@ static int uncore_mmio_global_init(u64 ctl)
>  	return 0;
>  }
> =20
> +static int uncore_msr_global_init(int die, u64 msr)
> +{
> +	int cpu =3D uncore_die_to_cpu(die);
> +
> +	if (cpu =3D=3D -1)
> +		return -ENODEV;
> +
> +	wrmsrq_on_cpu(cpu, msr, 0);
> +	return 0;
> +}

uncore_die_to_cpu() acquires and releases cpus_read_lock() to find an
online CPU, meaning the selected CPU could be hot-unplugged concurrently
before wrmsrq_on_cpu() executes.

If the CPU goes offline, the underlying smp_call_function_single() will
fail and wrmsrq_on_cpu() will return an error.

Because this function unconditionally returns 0, the caller will assume
success and proceed to register the PMON units. As noted in the commit
message, the units will not work unless the MSR is written, which could
lead to a silent functional failure.

Does this code need to check and propagate the return value of
wrmsrq_on_cpu() to prevent this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511230527.2609=
6-1-zide.chen@intel.com?part=3D6
