Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408C381E97
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114289; cv=none; b=o68vm+8O3WIKmXNWJ1Vx3Po1m9wZELDfVZHH9bS4g7yuNq0InQqzB/2H6BsEUSNgrF0Q905mv8T5/R9LieFDwLFupUDSNs+DNV2HQGaGv0LYYupqGiVRuOtkCRxe7iZvSubi02uOBvfO0WK0+Ukwq/fWZcylALkKgu+JV4xb0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114289; c=relaxed/simple;
	bh=L9GqZ3acUD40Isbxd/gO0HLXyUmkH9NPu0ktGz8t8Tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bfnPI1a6mRTtyBDSWHG+SOEl/39fsBUTiS2VtWx46QktK8IZTZCX3uT7O2ZZ5ftyhripX5Pin2A2yVWsXBFu7nFYp05slaxB0xbMcm93RaAY012nd5HQx94nQDA4YqcylCQSND6cmfj3GYFsfHR0e/FD1pTm40myQeXNn3+VTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPz+CfLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPz+CfLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FAC1F00A3D;
	Fri,  7 Aug 2026 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114286;
	bh=jCj8Vy7v4V3tb3RWVxFYIDRwWP331yikffPGKLlWtko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPz+CfLHbU14cCpw2IKFJ1Wi93L1RMTQ+LOiKoxi6R8jLaDis9XUIlroT5mAVzG1G
	 q4cJNvj44046ESHfNkMw0yTWZIIviwP6O2kvnqw3gf7vfBlrSqAAYAz+J5XK5bKNRY
	 g5rDc0qKcA8q3w0/U8flw09YysvDY545ydSjMDQuheMBj2aHjSUaFe9/Dld+sW4MgX
	 A/DeX+VISmEeqBzCPXVfTdj7NxLMahQWFlBfJziVr6VpME7darOnGBmZTGP3dmOjHW
	 /0X+5846ut5ge4Q+Ld2UyYE5AAEwJTn1qrewgFrn3iA+kAgCs74Bd6MJ71SZnO3Zba
	 IBMswf8TzMIHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 4/6] powerpc/perf: Capture the HTM memory
 configuration as part of perf data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807143734.1224-5-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
 <20260807143734.1224-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:51:25 +0000
Message-Id: <20260807145126.57FAC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The fallback logic for draining memory configuration records u=
ses an uninitialized stack variable `handle` when `perf_aux_output_begin()`=
 fails, leading to a wild pointer dereference and a kernel crash.
- [High] The `HTM_MEM_BUF_SIZE` calculation assumes a worst-case fixed over=
head of 92 bytes, failing to account for dynamic sample sizes when `PERF_SA=
MPLE_READ` is combined with `PERF_FORMAT_GROUP`. This allows the sample siz=
e to exceed 65535, overflowing `perf_event_header.size` and corrupting the =
ring buffer.
--

--- Patch [4]: [PATCH V5 4/6] powerpc/perf: Capture the HTM memory configur=
ation as part of perf data ---
commit 46bf60d42ede8a36ee43812e6bfd3aeda1d041a9
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Capture the HTM memory configuration as part of perf data

This commit captures the HTM system memory configuration during AUX trace
dumps and emits it as raw perf sample data. It adds a staging buffer for
the hypervisor call and handles drain iteration alongside the AUX data path.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index 90d26a721616b..7e8ae35269852 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c

[ ... ]

> @@ -203,6 +206,168 @@ static ssize_t htm_return_check(int rc)

[ ... ]

> + * 65440 =3D 32 + 2043 * 32 is the largest multiple of 32 satisfying all
> + * constraints:
> + *   - total record: 65440 + 92 =3D 65532 < 65535 (3-byte u16 margin)
> + *
> + * HTM_MEM_MAX_ENTRIES is derived from HTM_MEM_BUF_SIZE =E2=80=94 not th=
e other
> + * way around =E2=80=94 so the hcall is always given the true buffer siz=
e and
> + * the WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE) guard is a genuine
> + * impossibility check rather than a post-overflow assertion.
> + */
> +#define HTM_MEM_BUF_SIZE	65440U
> +#define HTM_MEM_MAX_ENTRIES	((HTM_MEM_BUF_SIZE - 32) / 32)	/* 2043 */

[Severity: High]
Does this buffer size properly account for dynamic sample sizes when=20
PERF_SAMPLE_READ is combined with PERF_FORMAT_GROUP?

If a large group of siblings is configured, the read format payload can
scale up significantly. When htm_collect_memory_config() emits a memory
configuration sample, could the computed size (65440 bytes plus the read
format overhead) exceed 65535?

If it exceeds 65535, wouldn't this overflow the u16 perf_event_header.size,
causing perf_output_begin() to reserve much less space than
perf_output_sample() actually writes, resulting in ring buffer corruption?

[ ... ]

> @@ -594,10 +759,25 @@ static ssize_t htm_dump_sample_data(struct perf_eve=
nt *event)
>  	 * NMI reentrancy from corrupting an outer transaction's handle.
>  	 */
>  	aux_buf =3D perf_aux_output_begin(&handle, event);
> -	if (!aux_buf)
> +	if (!aux_buf) {
> +		/*
> +		 * AUX ring buffer is full: perf_aux_output_begin() returned NULL.
> +		 * If the AUX trace dump is already complete but memory
> +		 * configuration collection is still in progress, we must not
> +		 * return 0 here =E2=80=94 that would signal EOF to htm_event_read() a=
nd
> +		 * permanently abandon the mem config drain.  Memory config
> +		 * records go to the main ring buffer via perf_event_overflow(),
> +		 * which is entirely independent of the AUX ring.  Retrieve the
> +		 * aux_buf from the ring's aux_private and call directly.
> +		 */
> +		struct htm_pmu_buf *fb =3D perf_get_aux(&handle);

[Severity: Critical]
If perf_aux_output_begin() returns NULL (for instance, if the user didn't
mmap an AUX buffer), does this leave the stack variable handle
uninitialized?

If handle is uninitialized, wouldn't perf_get_aux(&handle) dereference
uninitialized stack memory when it reads handle.event and
handle.rb->aux_priv?

> +
> +		if (fb && !fb->collect_htm_trace && fb->collect_htm_mem)
> +			return htm_collect_memory_config(event, fb);
>  		return 0;
> +	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807143734.1224=
-1-atrajeev@linux.ibm.com?part=3D4
