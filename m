Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049855;
	b=g9Veor62zf5tdkdAzenhWPuuSM27pZEt3ug4n+hGGDfLa1nFnZ2LVl2YMH7VzJP0tcsF
	 hBJ49sBXTQZZr641D3m9Z0ZH1LaTvE0RnTi4Ra/4rTNIGXfCcOIaZ3Vq+40t+9wTkXuOt
	 imAFKELtGNhPiemKJ8OwLUqH2Rs/9rBP7hq85LHWffLv4utP0bjYuoEIM/9tbXi00xJQu
	 5Rewnztgzws/6X7Hgd6dMhnz774LrVjQwKPTk3eL+HW6wBqqQsRo8SGVghZC2+bwlnRk8
	 E5StfiXnmUuXMiJTdvYS0IZtkr+duK4a+3lbj2R+VwGDyYw595REEebhAe0cAsKeFbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049855;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o7Gepuv8/10630mz1ZtWLjGNszx+xKG6LgJyBsloNDY=;
	b=rYI+8Ohl8rb9ZZM7Gh/VF3NwKeoIbM8f1VdwO8O7825RguO3d6aIeZoNB8m/JRINPjtZ
	 D6kj89pLUqrB77IAs2gmKuq8FC3eCg+gCyAhXDhDgbc0P4SxuU/BVtG7AKkAkuOwjcHvs
	 LForTjouQqZy4kC2OudfzInZJmWta5aeqUOsl7sF8nH+YAg+9C3z4WIhRbKfYk7Z8cx7Q
	 A57GK1mC0k7ibqPvG7+sjHw5lxkWazCySxZRimTdem5QSPh7a9gRbigfLIF4QJZuEiJBU
	 stYo7Jr4vlEtkAW1ZZfoY3AO82W1b/LNCt3TUVXHs0CXJByb7JJInRP8J67SgjzyoaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqA8KLEA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A870606A31A;
	Mon, 26 Oct 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqA8KLEA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9DB1F01825;
	Mon, 26 Oct 2026 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049854;
	bh=o7Gepuv8/10630mz1ZtWLjGNszx+xKG6LgJyBsloNDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UqA8KLEAZZ9HDFlNe2yEjNimHXIy+wB/4isZAgPXUFyUxa26RqCKOBVUyZTWg9A59
	 h8/p1F9uIzkxwv/AY5GbiqmzHM17UalngezMe7pSjYS7ZIw0cox6DZwNQ9VRQraZ6s
	 DtvrzHTdAUfGwJsowoC/JLW+fEF8nRH6WG3BXQZfzZB+2rqWlB7FIXrHm17lGzdGIn
	 fBlEGhJFIz5JdcKy8MjOgSdRjSi4V4y+qyHMtpFMA3m2uqeWwoTM8kfTRujYpl9zEW
	 iYDujB/TX4MK0R21wqMJ/iJrwDw1M1M4ipQL8kseuNDRUuVjwiXP3SvSjZDWJhSHPX
	 dzdyd3XdeLrow==
Message-ID: <sashiko-outbox-185750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf: Add Broadcom BCM5301X AXI Trace Module
 counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkFSTSBQTVUgUFJPRklMSU5HIEFORCBERUJVR0dJTkc=?= <linux-perf-users@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0Ug?=
 =?utf-8?b?VFJFRSBCSU5ESU5HUw==?= <devicetree@vger.kernel.org>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261026211151.3212237-3-florian.fainelli@broadcom.com>
References: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
 <20261026211151.3212237-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:24:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: bcm5301x_axi_event_init() calls for_each_sibling_event() wit=
h NULL ctx
- [Low] docs: perf: title underline too short in bcm5301x-axi-pmu.rst
--

commit 98ec05a97143b2d8c2fd04e15999d3fc2b116134
Author: Florian Fainelli <florian.fainelli@broadcom.com>

perf: Add Broadcom BCM5301X AXI Trace Module counters

This commit adds a PMU driver and documentation for the Broadcom BCM5301X
AXI Trace Module counters, exposing 16 unfiltered fixed counters through
system-wide perf events with hrtimer-based 32-bit delta accounting.

> diff --git a/Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst b/Docume=
ntation/admin-guide/perf/bcm5301x-axi-pmu.rst
> new file mode 100644
> index 0000000000000..720f042dfbd0b
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
> @@ -0,0 +1,92 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Broadcom BCM5301X AXI Trace Module PMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
In Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst, the title underline=
 is
36 characters while the title is 38 characters. Should the underline be
extended by two characters so make htmldocs does not emit a title underline
too short warning?

[ ... ]

> diff --git a/drivers/perf/bcm5301x_axi_pmu.c b/drivers/perf/bcm5301x_axi_=
pmu.c
> new file mode 100644
> index 0000000000000..15da137a40859
> --- /dev/null
> +++ b/drivers/perf/bcm5301x_axi_pmu.c

[ ... ]

> +static int bcm5301x_axi_event_init(struct perf_event *event)
> +{
> +	struct bcm5301x_axi_pmu *axi =3D to_axi_pmu(event->pmu);
> +	struct perf_event *sibling, *leader =3D event->group_leader;
> +	unsigned long used =3D 0;
> +
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK =
||
> +	    event->cpu < 0)
> +		return -EOPNOTSUPP;
> +	if (event->attr.config >=3D ATM_NR_COUNTERS || event->attr.config1 ||
> +	    event->attr.config2)
> +		return -EINVAL;
> +
> +	/* A group cannot allocate the same fixed counter twice. */
> +	if (!is_software_event(leader)) {
> +		if (leader->pmu !=3D event->pmu)
> +			return -EINVAL;
> +		__set_bit(leader->attr.config, &used);
> +	}
> +	for_each_sibling_event(sibling, leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +		if (sibling->pmu !=3D event->pmu ||
> +		    test_and_set_bit(sibling->attr.config, &used))
> +			return -EINVAL;
> +	}
> +	if (event !=3D leader && test_bit(event->attr.config, &used))
> +		return -EINVAL;

[Severity: High]
When userspace opens a standalone event or a group leader (where
event =3D=3D leader), can calling for_each_sibling_event(sibling, leader) in
bcm5301x_axi_event_init() in drivers/perf/bcm5301x_axi_pmu.c trigger a
lockdep warning or dereference a near-NULL pointer?

In the perf_event_alloc() -> perf_init_event() -> perf_try_init_event() path
in kernel/events/core.c, leader->ctx->mutex is only locked when
event->group_leader !=3D event:

	if (event->group_leader !=3D event && pmu->task_ctx_nr !=3D perf_sw_contex=
t) {
		ctx =3D perf_event_ctx_lock_nested(event->group_leader,
						 SINGLE_DEPTH_NESTING);
		BUG_ON(!ctx);
	}

	event->pmu =3D pmu;
	ret =3D pmu->event_init(event);

When event =3D=3D leader, leader->ctx is still NULL (it is only assigned la=
ter in
perf_install_in_context()). Calling for_each_sibling_event(sibling, leader)=
 in
include/linux/perf_event.h expands to lockdep_assert_event_ctx(leader):

#define lockdep_assert_event_ctx(event)			\
	WARN_ON_ONCE(__lockdep_enabled &&			\
		     (this_cpu_read(hardirqs_enabled) &&	\
		      lockdep_is_held(&(event)->ctx->mutex) !=3D LOCK_STATE_HELD))

With CONFIG_PROVE_LOCKING enabled, this passes &(leader)->ctx->mutex (an
offset from NULL) to lockdep_is_held(), which triggers the WARN_ON_ONCE
assertion and can fault in match_held_lock() if any held lock in
current->held_locks has hlock->references !=3D 0.

Should the group validation block in bcm5301x_axi_event_init() be guarded by
if (event !=3D leader)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026211151.3212=
237-1-florian.fainelli@broadcom.com?part=3D2
