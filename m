Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1423BED01;
	Tue,  9 Jun 2026 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985809; cv=none; b=QXOeWKn5UtwIOXxfFK44M2J0hJGMbax/LrTmoTu0n5ebRIQoZQvu7IN+siBvkQxZG7l/g14QZgMwAqXle16Ncq5oz79okmSh0Ac4zdSinbMQbuXTWMVST+FsTw0AaykqTh1o8hEX/YiGErku1bcgRCdJoNUDZHOouZncdghTark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985809; c=relaxed/simple;
	bh=6Whor5XkaZiXIX/wRKDsuGYZC/t4NxJfT3zbwVHXvcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9csfBdjR8PrCBNFg2X1awxKDNQiQQt6ZaECSZg/7sLLQbqdm3yK9mQfPM1aUK8Adwzvc2SHjuYjy6ACnKtCFMPvLXA9YJTqmgV0fCenM/iJMtQdJjdbSaXGrXx7I5SF2j4ToOYVfFQa414HYmPP/ktUxPeG1IUcjufKpNs6OW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8UaLx/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8UaLx/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF11F00893;
	Tue,  9 Jun 2026 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985808;
	bh=bAnQQJWmSkSti7JjToO/IoKflDTyMT8AWvqLBkx688k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8UaLx/FbwHh5w+XlzaGS1DlnzBVSCLFigVfGcz23EY/ihA6PfLEzek5TqxhbAsLo
	 hgnOXjyf+wXIVhVf4cBkK80ttJciBehqM8oexaC5DBnbZtVr+HLhpq7yk7X259zg2C
	 QC/+dhae27+pWfN8GRN5ZDNw9iNmZHgCV8khrbhSObzpYhGRe0F8hcg9EETBoLK9om
	 ab+F4kqwGUOJ7y2RCWvP/6Jph+6+LwiEZCpaUHnDHVb7igtrMqXhnxMT5InPbox6KA
	 7UlDBZ1rB5c3mNwfqcDNxZLZEebxApTjvPbgbLaqQneKQsBVc9JEcGf383dBZbl7ng
	 hFpODXCQxGiWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/21] RISC-V: perf: Add a mechanism to defined
 legacy event encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260608-counter_delegation-v6-12-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-12-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:16:47 +0000
Message-Id: <20260609061648.25DF11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] HW_OP_UNSUPPORTED is defined as 0xFFFF but assigned to a 64-bit =
event_id, risking collision with valid vendor event IDs.
- [Low] Public macros in shared header rely on an undeclared `C()` macro an=
d a private struct.
- [Low] Unconditional boot-time pr_info spam and incorrect logging conditio=
n for missing PMU events.
- [Low] Missing `__init` annotation on `rvpmu_vendor_register_events`.

Pre-existing issues:
- [High] Missing `perf_pmu_unregister()` on error paths in `rvpmu_device_pr=
obe` causes Use-After-Free.
--

commit 8f8945d4e47e7d93800a2f3a4d8c51c826b9b889
Author: Atish Patra <atishp@rivosinc.com>
RISC-V: perf: Add a mechanism to defined legacy event encoding

This patch introduces a framework to support vendor-specific PMU event
encodings and counter mappings for the RISC-V ISA. It adds vendor event
tables and registers them during PMU initialization.

> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
[ ... ]
> +#define HW_OP_UNSUPPORTED		0xFFFF
> +#define CACHE_OP_UNSUPPORTED		0xFFFF

[Severity: Medium]
Does using 0xFFFF as an unsupported marker risk colliding with valid
vendor event IDs?

Because RISC-V hardware event encodings can be up to 64 bits, a vendor
might legitimately define an event ID that evaluates to exactly 0xFFFF
when assigned to the 64-bit event_id field in struct riscv_pmu_event.

Could we use a standard unassigned sentinel such as U64_MAX instead, to
prevent falsely rejecting valid events?

> +
> +#define PERF_MAP_ALL_UNSUPPORTED					\
> +	[0 ... PERF_COUNT_HW_MAX - 1] =3D {HW_OP_UNSUPPORTED, 0x0}
> +
> +#define PERF_CACHE_MAP_ALL_UNSUPPORTED					\
> +[0 ... C(MAX) - 1] =3D {							\
> +	[0 ... C(OP_MAX) - 1] =3D {					\
> +		[0 ... C(RESULT_MAX) - 1] =3D {CACHE_OP_UNSUPPORTED, 0x0}	\
> +	},								\
> +}

[Severity: Low]
Is it safe to expose this macro in a public header?

This macro relies on the C() macro, which is not defined in this header,
potentially causing build failures if used by external modules.

Additionally, it appears to initialize an array structure meant for
struct riscv_pmu_event, which is defined privately in riscv_pmu_sbi.c.

Does this break encapsulation by requiring external users to have access
to that private struct?

> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> +static void rvpmu_vendor_register_events(void)

[Severity: Low]
Would it be beneficial to add the __init annotation to this function?

Since this function is exclusively called from rvpmu_devinit(), which is
an __init function itself, lacking the annotation means its instructions
will unnecessarily consume memory for the lifetime of the kernel instead
of being freed after boot.

> +{
> +	int cpu =3D raw_smp_processor_id();
> +	unsigned long vendor_id =3D riscv_cached_mvendorid(cpu);
[ ... ]
> +	if (!current_pmu_hw_event_map || !current_pmu_cache_event_map) {
> +		pr_info("No default PMU events found\n");
> +	}
> +}

[Severity: Low]
Can this condition cause unintentional log spam on boot?

Because of the logical OR operator, a platform that provides only one of
the maps will still trigger this log, incorrectly stating that no events
were found.

Furthermore, since the table currently only includes a QEMU entry, real
hardware with counter delegation extensions might unconditionally print
this on every boot.

Would it be better to use a logical AND here, and perhaps pr_debug?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the PMU
registration code, I noticed a potential memory lifecycle issue in the
existing probe error path.

Looking at rvpmu_device_probe(), the PMU is registered with
perf_pmu_register(). If a subsequent step fails, the code jumps to the
out_unregister label, which calls riscv_pmu_destroy() and then frees
the pmu struct.

However, riscv_pmu_destroy() handles hotplug state and CPU-PM, but
does not appear to call perf_pmu_unregister().

Could this leave dangling pointers in the perf core and sysfs to the
freed pmu structure, resulting in a use-after-free if those interfaces
are accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D12
