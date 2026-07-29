Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CB485CC8
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329385; cv=none; b=jzUS50dLJ01ggiXKD/7PXwlYTM9PmRqAzTnOuoYYEn9dL2KBFeM2KYSYG/+PygyYauEdMC64fATMD7kITI6xGMnneLzF16FHIbUXS9dWB0g1tta4NzVcgDE4kRblQo+qEx3exDhuPsfMzOVgwxNNFY7axgmcEzKxX8H+6modQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329385; c=relaxed/simple;
	bh=xy2y8zq7P+nKJp0Ra1QPGxT36GVDqZSXRhvDvE/hmrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A7cctbdqRGZohxhT1EN8Mcowux67RMIyTo3h3QKXE9QO02JilcA39txkC0DFW7+jUfAV8A5sR5tCvsffNRoukR7/PJ0eMoixKxnY1WHEVVWuTwypm46FXo5bmVayyYgt+u2O4lBxzqdACoPm+AjjrM3dWANe2RhuMrjXUlp6P7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caWwOKSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caWwOKSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2102B1F000E9;
	Wed, 29 Jul 2026 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329383;
	bh=PwnPBj3HaxiU/BgKZxJn3cRTsKcUB/zwFdgOkG85FQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=caWwOKSjxC2uARTEvX+Qt+trKRVjnbwfGjlEO8/bgjkY1xExebW9LneH3UhFYd2zT
	 Shgc7OY6cE25I7+++5hcLJ8kp3FohhqoOT3Ty4VJY+1XAlbYdGtzlItmWNgDrdvsWz
	 9OeIxlB2SxgyK3QRzAJa6btJaxbrX7nOlZPNHdsecBLI8YYVxYHvew/zJgAae6bTly
	 UCBZ1UMaH9h0YJLV6J2bcnBoFY6sQv94JXnyfeX/8BNJVOaJPXemCqDh5ICDlGNe1V
	 U9TecU7RUCOv6g8GRl1YQLYotNbxSZ7BEFmkt0M2dbz9vqhTutze6pYoyOSDeG9q7x
	 90PI0iU6sdb6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 1/6] powerpc/perf: Add HTM PMU driver to expose
 Hardware Trace Macro data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729123752.63010-2-atrajeev@linux.ibm.com>
References: <20260729123752.63010-1-atrajeev@linux.ibm.com>
 <20260729123752.63010-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:49:42 +0000
Message-Id: <20260729124943.2102B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbalanced H_HTM_OP_DECONFIGURE hcalls in htm_event_del can hijack=
 concurrent trace sessions and cause kernel log spam.
--

--- Patch [1]: [PATCH V4 1/6] powerpc/perf: Add HTM PMU driver to expose Ha=
rdware Trace Macro data ---
commit ac0e563af1a2f5f6278332191b43b79a4c0d0029
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data

This commit introduces a new "htm" Performance Monitoring Unit (PMU) driver
for POWER systems. It exposes HTM control via the standard perf interface,
allowing node/chip/core scoped trace configuration.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> new file mode 100644
> index 0000000000000..7ad592f26bb46
> --- /dev/null
> +++ b/arch/powerpc/perf/htm-perf.c

[ ... ]

> +static int htm_event_add(struct perf_event *event, int flags)
> +{

[ ... ]

> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> +				       cfg.coreindexonchip, cfg.htmtype,
> +				       H_HTM_OP_CONFIGURE, param1, param2, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
> +
> +	if (ret <=3D 0) {
> +		perf_event_disable_inatomic(event);
> +		return 0;
> +	}

[Severity: High]
If H_HTM_OP_CONFIGURE fails here (e.g. returning -EAGAIN on a long busy),
does returning 0 trick the perf core into considering the event successfully
added?

Since the perf core assumes the event is successfully added, it will
eventually call htm_event_del(), which unconditionally deconfigures the
resource.

[ ... ]

> +			retries =3D 0;
> +			do {
> +				rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex,
> +						       cfg.nodalchipindex, cfg.coreindexonchip,
> +						       cfg.htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
> +				ret =3D htm_return_check(rc);
> +			} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
> +			if (ret <=3D 0) {
> +				pr_err("DECONFIGURE failed in htm event add (ret=3D%d) node:%u chip:=
%u core:%u type:%u;\n",
> +						ret, cfg.nodeindex, cfg.nodalchipindex, cfg.coreindexonchip, cfg.h=
tmtype);
> +			}
> +			perf_event_disable_inatomic(event);
> +			return 0;

[Severity: High]
Similarly, if the start hcall fails, the driver explicitly issues a
DECONFIGURE here but still returns 0. Will this cause htm_event_del() to
incorrectly issue a second DECONFIGURE later?

[ ... ]

> +static void htm_event_del(struct perf_event *event, int flags)
> +{

[ ... ]

> +	htm_event_stop(event, 0);
> +
> +	/*
> +	 * Deconfigure the hardware resource.  Only H_BUSY is retried.
> +	 * If H_LONG_BUSY_* or any other error is returned, the resource
> +	 * cannot be reclaimed in this atomic context; log the failure so it
> +	 * is visible in the kernel log.
> +	 */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> +				       cfg.coreindexonchip, cfg.htmtype,
> +				       H_HTM_OP_DECONFIGURE, 0, 0, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
> +	if (ret <=3D 0) {
> +		pr_err("DECONFIGURE failed in htm event del (ret=3D%d) node:%u chip:%u=
 core:%u type:%u;\n",
> +				ret, cfg.nodeindex, cfg.nodalchipindex, cfg.coreindexonchip, cfg.htm=
type);
> +	}
> +	/* pmu_private freed by event->destroy =3D reset_htm_active */
> +}

[Severity: High]
Can this unconditional DECONFIGURE in htm_event_del() hijack or destroy a
concurrent trace session?

If htm_event_add() previously failed and returned 0, this path is still
reached. Because this patch permits concurrent opens for the same HTM targe=
t,
could this double deconfigure silently destroy a valid trace session establ=
ished
by another CPU, in addition to spamming the kernel log with pr_err() messag=
es?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729123752.6301=
0-1-atrajeev@linux.ibm.com?part=3D1
