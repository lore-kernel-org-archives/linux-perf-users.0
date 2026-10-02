Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231438332A;
	Fri,  2 Oct 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944409; cv=none; b=roH1f8DVihAr1INeSKvHlOBFZtW2Unv+P0itYjgAyuCrzsAoeaItOa2IhGgW7JQNsFi0NkIX8ht9OL8CIaht6Sv+II8aAJT3cCoksSvebT6FnLBkZVHiqB88BfGZM2q9B19kNJg79IF7f++b+qhcuKotdZNCTWk9uQdS/2GsgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944409; c=relaxed/simple;
	bh=NDgEPa0XeDvsUmZpfYIS+OBNFMqFM1UOXxuPhnqM03g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgESlp0Zl6AEO9oFlT2ZRDloF6nIzvVA9NWiNdA7TT++g/Nw6muXsHVConw8fWkpetdS0sWZwOMjx2tQps35xqwz4i3RwLzwli58BGcA7TwnA1IYl/MSlfeZPNYZyS5SyqK8/rOEJ1gcmVcnnfZZV6gtdIZtFlkAJKSiqNQFZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GqNF4z36; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GqNF4z36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790944407; x=1822480407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NDgEPa0XeDvsUmZpfYIS+OBNFMqFM1UOXxuPhnqM03g=;
  b=GqNF4z367Grc6WPc4FFqsgJLlSABT8GH1UK80aE/4DlWUYLZwtphrfn/
   mok53HWngeIytVnRP7EKi79UFLPC6ap6wv8889N5f/0HeSYjkwDH/zB7o
   qKP6YWOSM3W3oinwFSmYVs4H/kQX4cGlR5Z8NzwwST1r2kx08HShenwmG
   ceiL/vYJtTgtHI+ANV6/09vWLHUSmWuqQrGX91gcgtCefhhKTzSVpY8Rr
   0MfDjinHbuxtuZkO688SrVkpKYSMTUPDv5aGn6IJxHr/BaAXRsQkOCZ6f
   EghjNM9j5uVgqpeXkAkSeTNzKbg7jJeZlqpdaISL+XroJx6ZR9VH1tRcA
   Q==;
X-CSE-ConnectionGUID: YsK1ByWlSzaT8IyPnfeHRg==
X-CSE-MsgGUID: LEe5eKNsT6m+ajl436z7BQ==
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="asc'?scan'208";a="63552307"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2026 05:33:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 2 Oct 2026 05:33:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 2 Oct 2026 05:33:20 -0700
Date: Fri, 2 Oct 2026 13:31:59 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Himanshu
 Chauhan <himanshu.chauhan@oss.qualcomm.com>, Conor Dooley <conor@kernel.org>,
	Anup Patel <anup@brainfault.org>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra
	<atish.patra@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
	<rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Yuanzhu <yuanzhu@bytedance.com>, Yicong Yang
	<yang.yicong@picoheart.com>, Susheng Yang <yang.susheng@zte.com.cn>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 RESEND 7/9] perf: RISC-V: add support for SSE event
Message-ID: <20261002-reach-cloning-f1594729dbe3@wendy>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <4f7828b3e30407de9df205264bb94edc767d318c.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1CpoeXeJ7HJ+y6fs"
Content-Disposition: inline
In-Reply-To: <4f7828b3e30407de9df205264bb94edc767d318c.1789974241.git.zhangzhanpeng.jasper@bytedance.com>

--1CpoeXeJ7HJ+y6fs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 07:15:04PM +0800, Zhanpeng Zhang wrote:
> From: Cl=E9ment L=E9ger <cleger@rivosinc.com>
>=20
> Register a handler for the local PMU overflow SSE event so that RISC-V
> perf can receive overflows even when normal S-mode interrupts are masked.
> Reuse the existing overflow handler and pass it the interrupted pt_regs
> rebuilt by the architecture SSE entry path.
>=20
> Select the delivery mechanism once during PMU probe. Prefer SSE when its
> event can be registered and enabled. If the extension or PMU event is
> explicitly unsupported, use the ordinary PMU interrupt. Do not enable the
> interrupt after any other SSE setup failure or when a crash kernel may
> have inherited firmware state. Install the PMU enable and disable
> callbacks only after SSE delivery becomes active.
>=20
> Keep the local PMU SSE event disabled across CPU power management. On
> entry, the generic SSE notifier masks the hart before the lower-priority
> PMU notifier disables the event and stops the counters. On exit, the SSE
> notifier first unmasks the hart while the event remains disabled. The PMU
> notifier then restores counters and event userpage state before enabling
> the event. An unmask failure stops the notifier chain and leaves the
> counters stopped. Ordinary PMU interrupts retain their existing notifier
> ordering.
>=20
> An SSE overflow can arrive as soon as the event is enabled during probe.
> Publish the counter mask before SSE setup, so an early handler can stop
> the counter source even before perf starts admitting normal samples.
> After a real overflow, restart only counters whose perf state is still
> running. Honor a non-zero return from perf_event_overflow() and leave
> throttled events stopped.
>=20
> Guest attribution is not part of this version. Detect an interrupted guest
> from hstatus.SPV and skip its sample while still updating the period and
> counter state, rather than exposing guest state as a host sample.
>=20
> The perf PMU callbacks cannot return errors. If an SSE transition or
> interrupted-context read fails, latch the failure per CPU and stop its
> mapped events through the normal perf state transitions. Do not reset the
> firmware counter mapping behind perf, restart a failed event, or attempt a
> runtime switch to IRQ delivery.
>=20
> During cleanup, close callback admission and synchronously drain each CPU
> before disabling and unregistering the SSE event. If firmware refuses the
> cleanup, stop the counter source and transfer the event to the SSE core so
> later CPU hotplug or shutdown processing can retry without using freed PMU
> callback state.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  Documentation/arch/riscv/index.rst     |   1 +
>  Documentation/arch/riscv/pmu-sse.rst   |  55 +++
>  MAINTAINERS                            |   1 +
>  drivers/firmware/riscv/riscv_sbi_sse.c |   9 +
>  drivers/perf/Kconfig                   |  11 +
>  drivers/perf/riscv_pmu.c               |  14 +-
>  drivers/perf/riscv_pmu_sbi.c           | 540 ++++++++++++++++++++-----
>  include/linux/perf/riscv_pmu.h         |  20 +-
>  include/linux/riscv_sbi_sse.h          |   6 +
>  9 files changed, 564 insertions(+), 93 deletions(-)
>  create mode 100644 Documentation/arch/riscv/pmu-sse.rst

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1CpoeXeJ7HJ+y6fs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar+kPwAKCRB4tDGHoIJi
0nZkAQC+nQDWcheoZ/uoVpx3J1ReYYcarCsWNy5EGzoBtyzH5QEA1ZEVCP+p6hA3
bTJLWk5wESdHUitdwSiuB/6AYgPHXwE=
=1K1t
-----END PGP SIGNATURE-----

--1CpoeXeJ7HJ+y6fs--
