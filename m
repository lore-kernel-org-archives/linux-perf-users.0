Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A43B14D8;
	Wed, 29 Jul 2026 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353070; cv=none; b=knDCnP1ILf7I1VX48CwErKsOOUs/QRVF7+V/A/98vokNvmtICUhQ/7nUyT2Qpxj42SYegs527OOlMOe1/ccAR2a0WAwbTKhwQfxJVgm4tWfxykcncbEbXfbh7H1YWRYztH1QpIjqPTOMl0iNQisCCqoTjBnIqLsQJO7G5mzzY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353070; c=relaxed/simple;
	bh=dYCWcGmZfIrAvSQn+4gAg7900ltABw1k0gPqYi5q3G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l06ejp+2n9C3EOt0zqvo3eWQiNvwiy7zsOsIfRldCQb3/ChsFc8zIRDeeI+gJni3nimOS4wDjqE6lA8fTfza+uy2Z2ztQMk+LJCHeHtly5jT2Hfku2eN/0vVfL4Uor8Q8jRBHktS2lPp5aQiLD88oTLMaI29lky3h8oA+CfSgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWi2OxIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWi2OxIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714401F000E9;
	Wed, 29 Jul 2026 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353068;
	bh=6iZv9+X2jQ/Xdvl9pYW3L/P+s7eiaIDxAPObyi8rBJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KWi2OxIWV0Jh/nMj76bDjnQNlQqUJsWK6M2+6Ex59wGVkY7ZTj7oR/hyhAwq6hBNH
	 1ZQ7lAzT3ZWJnQs1Pv9BWyycKTJ/U72Uej5o+NLkrh+C+WxyXkdUViEuFGHSJYSbbe
	 5dSZ9z3Qhl3GBJom6snEhT5IIjD2/B56UICmbcRZh414sY1fqFsudD22ILseaPXf/A
	 6Mk6rWpDHSbUXyYlSRwCu1LtVHECrMHmlhloxH0Cx9DHWq8S/Vzik/QMhvq/bPnGs3
	 00HAaXdL3MmtxKRYJP9VzNHnUKI6Ablas6a1AndjHwfxEUdgeghu8gtkKIccWdsPHv
	 jDTOC0SmrfE/g==
Date: Wed, 29 Jul 2026 20:24:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
Message-ID: <20260729202426.5b2f70b3@jic23-huawei>
In-Reply-To: <20260729145555.3919550-7-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2026 07:55:52 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The counters are configured with Freeze on Overflow, so when any counter
> overflows the CPMU freezes every counter in the block (CXL r4.0
> =C2=A78.2.7.2.1). cxl_pmu_irq() reads the overflowed counters and clears =
the
> overflow status, but never writes the CPMU Freeze register to unfreeze,
> so all counters stay frozen until the next pmu_enable() and events in
> that window are silently lost.
>=20
> Unfreeze after clearing the overflow status so counting resumes.
>=20
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgol=
abs.net?part=3D1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Guess I had an emulation bug.  The disadvantage of developing against
emulation written by the same person writing the kernel driver.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/perf/cxl_pmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 8b89db8f4d68..52e78a6e0960 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -804,6 +804,15 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
> =20
>  	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
> =20
> +	/*
> +	 * Counters are configured to freeze on overflow (Freeze on Overflow),
> +	 * which freezes every counter in the CPMU. Once the overflowed counters
> +	 * have been read and their status cleared, unfreeze so counting resume=
s;
> +	 * otherwise all counters stay frozen until the next pmu_enable() and
> +	 * events are silently lost.
> +	 */
> +	writeq(0, base + CXL_PMU_FREEZE_REG);
> +
>  	return IRQ_HANDLED;
>  }
> =20

