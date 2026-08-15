Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534239099E
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782620; cv=none; b=dG39YgGGnCQuLH6iM1xO/m7krifx2CW5j1I5U3nXskOMSBCT2ybWFHX29r9tkym9UvW1C6UEDmmYjId6iBL9KDEC0g0ulyLYVOVMrqL4m2HWfqr9KQilikWNkU9Fx6PYLngwWQmBPyjkZHEVbCVxVrGV5wBi/RMQ477fuxy1hW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782620; c=relaxed/simple;
	bh=9WP+5doPvQX7/lozyp0u0uhrkcAGhjwSBYEVnh26lpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aiaibcEmdWltoOeJC7C+fLBkn0RdXp0hGUPrXK+/VWao1sl1mTH9Uf8nKvBMv2Fyf424TfNOaBq+9Vi7UtvdJO4xiCFTR/xgqHgx0bmrCFrK7sJpdlQch2XgX8V91Q1eBOZjHmPlgpQb3sQOepM2Wvt0TCnU/xUUsngkhX7j76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFKnHRpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFKnHRpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2181F000E9;
	Sat, 15 Aug 2026 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786782617;
	bh=ag2g2F8qPIq6LPYyNeAOJW7Okr6q24b7smyqYypQLjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFKnHRpAb8H024I1Y6y6c7bpY58fOfuiGDOmhmWwA6b3EP5Gt359mA+ltwzZY+hPj
	 OAgg7NAFM55ThxnVOojTHQfSh/7e96OzWa25necLgwkUgsOdnkdKYos1H+XyLNhtik
	 nIub3aLkiI2V5IREg0xfaBtoZ/KJlQed/hEkjwPQ/9bs1iPNiztztSHvpgPjgL/IxK
	 Hr2dm1NJFiBGRTAhiIFNy+NEy5zHLBQ9c7JCAU5QFdwux+B+oaZkfz3+34jZikYTiF
	 ciYNtQ11Yow65OAtqcUIwQi8c4l0G6KJPdSiHT4t2nejjJEZRAZrVw7najdPfMipsb
	 Jfht+y0ZijfaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815082048.4043217-3-irogers@google.com>
References: <cover.1691900000.git.irogers@google.com>
 <20260815082048.4043217-1-irogers@google.com>
 <20260815082048.4043217-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:30:17 +0000
Message-Id: <20260815083017.8C2181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch includes out-of-tree `#if LINUX_VERSION_CODE` compatibili=
ty macros which violate upstream kernel contribution guidelines.
--

--- Patch [2]: [PATCH v12 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU drive=
r ---
commit 26b0420ae938eb90972f1d893f5dc06525dcd8ac
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a new performance monitoring driver for the Raspberry Pi
AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to
the Linux perf subsystem natively via the VideoCore mailbox interface.

> Note on out-of-tree macro compatibility:
> The inclusion of #if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> surrounding hrtimer_setup is intentionally maintained alongside
> this patch to guarantee seamless out-of-tree compilation fallback
> compatibility for Raspberry Pi Long Term Support (LTS) kernel variants.

[Severity: Low]
Is it acceptable to include out-of-tree compatibility notes and macros in a
mainline submission? The Linux kernel typically requires code submitted for
mainline inclusion to be written exclusively against the current kernel API.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..eda831d66056f
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> +static inline void rpi_hrtimer_setup(struct hrtimer *timer,
> +				     enum hrtimer_restart (*function)(struct hrtimer *),
> +				     clockid_t clock_id, enum hrtimer_mode mode)
> +{
> +	hrtimer_init(timer, clock_id, mode);
> +	timer->function =3D function;
> +}
> +#define hrtimer_setup rpi_hrtimer_setup
> +#endif

[Severity: Low]
While the commit message notes this is intentional, does this align with
upstream coding style guidelines? Leaving LINUX_VERSION_CODE fallback wrapp=
ers
like rpi_hrtimer_setup in the driver may lead to upstream rejection due to
mainline coding policy violations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815082048.4043=
217-1-irogers@google.com?part=3D2
