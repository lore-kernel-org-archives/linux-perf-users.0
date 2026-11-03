Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664490;
	b=PZy0IOAaXmKYMGJe2cHaatLST0xSq3vkQE7PatMPkhLXOB2yqIfoUwZ6pS7kDSxnNENa
	 DKxmuAmd17EZ2qgoOYKlOXepsBlMQJPOA91oYk1YCZFAFwPuwUQJ/IL2ePfA86hHSzwnj
	 XoJA3lUlEj8l5+uhzxnjD2ilCYNjs60IT2XcfYHJ3+/YeeeNM1Igu8VcG5/K7XfW2jhr4
	 BNdRl/dQme8Ci4XKYxo0U5iS7ojau5XyGIysiK7fABQHK3vT2fxYyiW6cM+cs6SIWMWCX
	 XC3hqov0BNDssMsH+oNRmQw7FuxItDIHLv4mUAuRWluVNbmKKxXAT2QUQhb1V/yn3nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664490;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JwMFLLfKvXgE8eknGGRABoKdTh4BgliElDneW6vU7B0=;
	b=YT51DEOzERYBS5OXlbipSbvmdMpuIuSH3cczQ8rSJtq9HRBXFSWEpod52NMqFX7vWeu8
	 KiLP1xEtbvSuKu7CJdsJSKuu/2azUlzsYPr6kc0jEHFQRWf+u5sNBj9vFLQZ5rhC9EdbR
	 44zC+/0ZutGMGDN3NbFhxrE4ZMZpCkn6O1nuB5t0tOVEAVHjYZQsV07DU1DuYpEJ8zvjD
	 HPjkt19e+DtQkDXvm9mBH169j4rIfBCb9krnc8zDc5GgOSr07Cpi5bndOLauq24mltrvb
	 NQMls91dylsO7J8qZYEqnUsbLSnUFnZFn5GIQ2VO81VH8OHnCYjIg8Mu7zkVOmozsaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4DiEI30;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDC606A326;
	Tue,  3 Nov 2026 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4DiEI30
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4901F000C1;
	Tue,  3 Nov 2026 00:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664489;
	bh=JwMFLLfKvXgE8eknGGRABoKdTh4BgliElDneW6vU7B0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4DiEI308tq2NK3yFpWgMO1dRs3beITz1yKUFKQ17pkv1mfSb8h55gU60/kB2tM7Q
	 VbfZDM1NAfIwjZml8nk6Mt8W1hi3iohyVq7yuhEAxxxmyG5rZi2LCknXpGPu8dywDx
	 eCRqs7sMWKyQ+v9golC+bV3wN01LhXRGnPBsw8mgjZ1uv+eEoiTGkdQxVR71OalWJW
	 csibbvY4fhhx2C1ZOARaYG8WynPhhERHNTn6JWjpHB5NyVjwPe0zZITXpqAYe30MB6
	 cyr7iv0cpXcc9S/80UnpavJqdKRNu4f3MzjpV5xwiHGjCKhSvGLgDKuBERbnrAicP2
	 BlcncNhpMju8w==
Message-ID: <sashiko-outbox-194360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102234301.2242242-3-irogers@google.com>
References: <20261102234301.2242242-1-irogers@google.com>
 <20261102234301.2242242-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:08:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf: rpi_axi_pmu: NULL ctx deref in rpi_axi_pmu__validate_group()
- [Low] perf: rpi_axi_pmu: enforce RPI_AXI_MAX_EVENTS limit in group valida=
tion
- [Low] perf: rpi_axi_pmu: Kconfig depends on undefined symbol RPI_AXIPERF
--

commit 3a239421611725bee7d8e283cbdeacf0ec2bf701
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a perf PMU driver for the Raspberry Pi System and VideoCore
AXI performance monitors on Broadcom BCM2835 and BCM2711 platforms.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b99..c1d7d64caba28 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -325,4 +325,18 @@ config NVIDIA_TEGRA410_C2C_PMU
>  	  Enable perf support for counters in NVIDIA C2C interface of NVIDIA
>  	  Tegra410 SoC.
> =20
> +config RPI_AXI_PMU
> +	tristate "Raspberry Pi AXI Performance Monitor"
> +	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on !RPI_AXIPERF

[Severity: Low]
Should this dependency on !RPI_AXIPERF be removed from the patch before it =
is
applied?

RPI_AXIPERF is not defined in the mainline kernel tree, and although the no=
te
below the --- separator asks maintainers to delete this line when applying,
tools like git am and b4 strip the note and commit the undefined Kconfig
symbol directly, which triggers scripts/checkkconfigsymbols.py warnings.

[ ... ]

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..f194b8633e434
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> +static bool rpi_axi_pmu__validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader =3D event->group_leader;
> +	struct rpi_axi_hw_events fake_hw_events[MON_MAX];
> +
> +	rpi_axi_hw_events__init(&fake_hw_events[MON_SYSTEM]);
> +	rpi_axi_hw_events__init(&fake_hw_events[MON_VPU]);
> +	if (!rpi_axi_pmu__validate_event(event->pmu, fake_hw_events, leader))
> +		return false;
> +	for_each_sibling_event(sibling, leader) {
> +		if (!rpi_axi_pmu__validate_event(event->pmu, fake_hw_events, sibling))
> +			return false;
> +	}
> +	return rpi_axi_pmu__validate_event(event->pmu, fake_hw_events, event);
> +}

[Severity: High]
Can calling for_each_sibling_event(sibling, leader) when leader =3D=3D event
cause a NULL pointer dereference under CONFIG_PROVE_LOCKING=3Dy, and also
validate the group leader twice?

When userspace opens a standalone event or group leader via perf_event_open=
()
with group_fd =3D=3D -1, perf_event_alloc() sets event->group_leader =3D ev=
ent and
calls perf_init_event() -> perf_try_init_event() while event->ctx is still
NULL:

kernel/events/core.c:perf_try_init_event() {
	if (event->group_leader !=3D event && pmu->task_ctx_nr !=3D perf_sw_contex=
t) {
		ctx =3D perf_event_ctx_lock_nested(event->group_leader,
						 SINGLE_DEPTH_NESTING);
		BUG_ON(!ctx);
	}

	event->pmu =3D pmu;
	ret =3D pmu->event_init(event);
}

Because rpi_axi_pmu_event_init() -> rpi_axi_pmu__validate_group() does not
return early when leader =3D=3D event, it proceeds to for_each_sibling_even=
t():

include/linux/perf_event.h:
#define for_each_sibling_event(sibling, event)			\
	lockdep_assert_event_ctx(event);			\
	if ((event)->group_leader =3D=3D (event))			\
		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)

With CONFIG_PROVE_LOCKING=3Dy, lockdep_assert_event_ctx(leader) evaluates
lockdep_is_held(&leader->ctx->mutex) while leader->ctx is NULL, dereferenci=
ng
a near-NULL address inside lockdep. In addition, when leader =3D=3D event, =
the
final rpi_axi_pmu__validate_event(event->pmu, fake_hw_events, event) call
validates the leader a second time.

Should rpi_axi_pmu__validate_group() return true immediately after validati=
ng
leader when leader =3D=3D event (or skip calling rpi_axi_pmu__validate_grou=
p() in
rpi_axi_pmu_event_init() when event->group_leader =3D=3D event)?

[ ... ]

> +static int rpi_axi_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
> +	enum monitor mon =3D config_to_monitor(event->attr.config);
> +	struct rpi_axi_hw_events *hw_events =3D &pmu->monitor[mon].hw_events;
> +	unsigned long spinflags;
> +	int idx, slot =3D -1;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, spinflags);
> +	idx =3D rpi_axi_hw_events__get_alloc_event_idx(hw_events, event);
> +	if (idx < 0) {
> +		raw_spin_unlock_irqrestore(&pmu->lock, spinflags);
> +		return -EAGAIN;
> +	}
> +
> +	for (int i =3D 0; i < RPI_AXI_MAX_EVENTS; i++) {
> +		if (!pmu->events[i]) {
> +			slot =3D i;
> +			pmu->events[i] =3D event;
> +			break;
> +		}
> +	}
> +
> +	if (slot < 0) {

[Severity: Low]
What happens if userspace creates an event group with more than
RPI_AXI_MAX_EVENTS (66) hardware events targeting this PMU that share at mo=
st
3 (bus, filter) pairs per monitor?

In rpi_axi_pmu_event_init() -> rpi_axi_pmu__validate_group() ->
rpi_axi_pmu__validate_event() -> rpi_axi_hw_events__get_alloc_event_idx(),
events targeting the same (monitor, bus, filter) increment
fake_hw_events[mon].refcount[i] without checking the total number of PMU
events against RPI_AXI_MAX_EVENTS, so rpi_axi_pmu_event_init() succeeds.

However, when group_sched_in() attempts to schedule the group via
rpi_axi_pmu_add(), the 67th event will find no free slot in
pmu->events[RPI_AXI_MAX_EVENTS] and fail with -ENOSPC, causing
group_sched_in() to roll back all 66 previously added events on every
multiplexing rotation tick.

Should rpi_axi_pmu__validate_group() also reject groups whose total number =
of
events on this PMU exceeds RPI_AXI_MAX_EVENTS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102234301.2242=
242-1-irogers@google.com?part=3D2
