Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A583304BCB
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629534; cv=none; b=W3GvAICWiprBp+sl00Wy3iJrD1YURY4GmCLo+bsWjF1PLhuu7eWvBLTZj+IASIZZGEHBkKTNMFVIGp4DC4dHMBfB7j+dsu+kYAcd6HUsobWUcORamqG0IJCizBH1VicLnoytWSCB6QGFXb4UGzO8VzJibPJqe+CnoMi5gKjRhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629534; c=relaxed/simple;
	bh=IMszFj0Fca56lBdw8T3uhR/+DPBevZTiiok6nK2QxaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OcAxY4ogq7RAnxD2YwQb/CrEWN9U8HG2hFI3Z2+nPXThSYy9y2rLOa2c1E9JdBFC87JsMn3Ctmsh7O28WWJrwtBcoq4XwTff3KKtsCJ0ezfAFHaDqwjKm4gzruChlIBTk4RJyyaWLqMGFyvg9yY4wgvilHpOUnLxP9sZFZ/7xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzQGwA7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzQGwA7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777AC2BCB0;
	Tue, 12 May 2026 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778629533;
	bh=IMszFj0Fca56lBdw8T3uhR/+DPBevZTiiok6nK2QxaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kzQGwA7dNMn15llzxum//yx/d3cjVAYFKbHggO0TPo0WRzwYgEWGFbOdV4EHcXHjb
	 264hdXcxGJZBM208sxAvH7sO8aGh58iJJA5rIeA7yCW8szx7GbdBeDkitiRYRAR3aa
	 LM2oURHkuupFzJRRkY+dmjXi+n6TELreptq1dbMWK9aHZgMagLGrTK47rsEVYakCEW
	 xr05qaRBkSl2onPl4pqXlluYh5EE1bJiy79sOfBIlrHYYnfhQ9H+zvLpOUXqySFWt0
	 uU1324yHLPPFBrtLoUAEPKRMG7sbyyks1vY1FgTDy791bOZA4+jBj8pTUZ3spXEHnb
	 ZbVthi/XSRozQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/28] perf header: Validate null-termination in
 PERF_RECORD_EVENT_UPDATE string fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-16-acme@kernel.org>
References: <20260510033424.255812-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:45:33 +0000
Message-Id: <20260512234533.A777AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing payload bounds validation for the PERF_CPU_MAP__MASK varia=
nt in perf_event__fprintf_event_update() allows out-of-bounds reads during =
dump_trace.
--

commit ae463885b1ae6653d958a99e1d8f5f34ac03cf41
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate null-termination in PERF_RECORD_EVENT_UPDATE string f=
ields

This commit validates null-termination for PERF_RECORD_EVENT_UPDATE string
fields. It also hardens the event_update handlers by adding size validation
for SCALE and CPUS events and swapping CPUS variant fields so the
processing path sees native byte order.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f2198ab0defd5..d253063b581f2 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -5117,24 +5117,65 @@ size_t perf_event__fprintf_event_update(union per=
f_event *event, FILE *fp)

[ ... ]

> -	case PERF_EVENT_UPDATE__CPUS:
> +	case PERF_EVENT_UPDATE__CPUS: {
> +		size_t cpus_off =3D offsetof(struct perf_record_event_update, cpus);
> +		u32 cpus_payload;
> +
> +		if (event->header.size < cpus_off + sizeof(__u16) +
> +					 sizeof(struct perf_record_range_cpu_map)) {
> +			ret +=3D fprintf(fp, "... cpus: (truncated)\n");
> +			break;
> +		}
> +
> +		/*
> +		 * Validate nr against payload =E2=80=94 this function may be
> +		 * called from the stub handler (dump_trace path) which
> +		 * bypasses perf_event__process_event_update() validation.
> +		 */
> +		cpus_payload =3D event->header.size - cpus_off;
> +		if (ev->cpus.cpus.type =3D=3D PERF_CPU_MAP__CPUS &&
> +		    ev->cpus.cpus.cpus_data.nr >
> +		    (cpus_payload - offsetof(struct perf_record_cpu_map_data, cpus_dat=
a.cpu)) /
> +		    sizeof(ev->cpus.cpus.cpus_data.cpu[0])) {
> +			ret +=3D fprintf(fp, "... cpus: nr %u exceeds payload\n",
> +				       ev->cpus.cpus.cpus_data.nr);
> +			break;
> +		}
> +
>  		ret +=3D fprintf(fp, "... ");
> =20
>  		map =3D cpu_map__new_data(&ev->cpus.cpus);

Could this missing validation for PERF_CPU_MAP__MASK variants introduce an
out-of-bounds read regression when tracing?

If the event type is PERF_CPU_MAP__MASK, the validation block added here on=
ly
checks for PERF_CPU_MAP__CPUS. The mask variant would skip the payload chec=
ks
and proceed directly to cpu_map__new_data() with unvalidated event data.

Since the comment notes that this dump_trace path bypasses the deeper checks
found in perf_event__process_event_update(), would it be safer to also
include the mask variant checks here to ensure the nr field doesn't exceed
the payload size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D15
