Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B924052AE;
	Wed, 29 Jul 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339264; cv=none; b=Ro+Pgpssy3C4QUJGmGelm2ToCCV5z6qub2O4m1tFxl5fh2VNlcvSQpZjD+CEyBNva7aJlhdlvG6ZZ8q4fqxoIif+KaKC798hTY9ZLrbeGJlk2vAYhxjMa1MY7LAOKktP5cXczPxl4hJT68EzET+1/HDTw5ffwbYOoXXJiQAFHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339264; c=relaxed/simple;
	bh=eM9XGcryDhEtPIl0PlnMEB1umS7ff8nSqvnjhR9xgak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PF2ujfF3+lvqY78VYdZv/W1RfZabvRIDkcLe/l9rnO6/EqCMSdYD7aw+Vn6KrPro/ZegbNBWMtpOOypXp7+V4CYGc8yomnrI7hgKYV9VT3z+GfwnwWGy4ec5lSxIhiy2XDuq4U7hSVNIP+Kf0IFmrPrnYkx55BBePAJF9psz/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnrtFuwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnrtFuwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E0D1F000E9;
	Wed, 29 Jul 2026 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785339260;
	bh=IopSN6z277y/pWQZ6XfMa76rI5If44HKl5RR1HbLqmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UnrtFuwhLis9kBi1SD5RIqQ6uCC3SCbRs1hsP91ARsZinVJLTVq6w6JOEuosY50Ci
	 hKs6tS1k6eEdYGzqvKKO71frlzyHSgI0lsdIsDJuW4NLRp4xz0ZuMZFTW+Id5kXEgO
	 yt2/4VPx0E18X/ncN3/3uJrFzFr6mU2rImUvW+au4AocKqXKHQw204cE/VBADZ/pdu
	 BBWtj11atFYZL5YGFnLuJsC6oukW6so7LVtih6qFTDoWlwEAv25rC/5cGADsyfVfcO
	 jtBmI5esTKiPIhw2zDmSPv/dBA3KLYg/JriNBl7pWp59ChC4S0qA9HLLOmJJ3/qRKK
	 8UEpHSByA6mHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplug
 callbacks after unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260729145555.3919550-9-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:34:18 +0000
Message-Id: <20260729153419.31E0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly fixes a UAF in logging statements during teard=
own but leaves a critical lifecycle race unaddressed. The IRQ is registered=
 via `devm_request_irq` before `cxl_pmu_perf_unregister` is registered. On =
device removal, `devm` unwinds LIFO, so `perf_pmu_unregister` runs while th=
e shared IRQ is still live. If the IRQ fires concurrently on another CPU (e=
.g., due to a co-function changing the shared MSI vector's affinity), `cxl_=
pmu_irq` can read a non-NULL `event` right before it is detached, leading t=
o a NULL pointer dereference in `__cxl_pmu_read` when it accesses `event->p=
mu`.
--

--- Patch [8]: [PATCH v2 8/9] perf/cxl: Don't use pmu.dev in IRQ and hotplu=
g callbacks after unregister ---
commit 34ab4c1ad03386965fbc73a1d534f56456842698
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Don't use pmu.dev in IRQ and hotplug callbacks after unregister

The patch replaces info->pmu.dev with info->pmu.parent in the IRQ and CPU
hotplug callbacks to fix a use-after-free during device removal.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 2e817a52ff1e1..f42238b2b6b0d 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -803,7 +803,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>  		struct perf_event *event =3D info->hw_events[i];
> =20
>  		if (!event) {
> -			dev_dbg(info->pmu.dev,
> +			dev_dbg(info->pmu.parent,
>  				"overflow but on non enabled counter %d\n", i);
>  			continue;
>  		}

[Severity: High]
This is a pre-existing issue, but since this patch addresses teardown races,
does it leave a critical lifecycle race unaddressed here?

Because the IRQ is registered via devm before cxl_pmu_perf_unregister() is
registered, the LIFO unwinding order means perf_pmu_unregister() runs while
the shared IRQ is still live.

If a shared MSI interrupt fires concurrently with cxl_pmu_perf_unregister(),
cxl_pmu_irq() can read a valid event right before it is detached:

cxl_pmu_irq() {
        ...
        struct perf_event *event =3D info->hw_events[i];
        ...
        __cxl_pmu_read(event, true);
}

Meanwhile on another CPU, the unregister thread detaches the events and
synchronously sets event->pmu =3D NULL. When the IRQ handler calls
__cxl_pmu_read(), it dereferences event->pmu:

__cxl_pmu_read() {
        struct cxl_pmu_info *info =3D pmu_to_cxl_pmu_info(event->pmu);
        ...
}

Could this lead to a null pointer dereference and a kernel panic when
info->base is subsequently accessed during device unbind or module removal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D8
