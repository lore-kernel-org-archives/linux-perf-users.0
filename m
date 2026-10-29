Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301249;
	b=Cb7rjUIFVB4ln+7gaHGQHgHwF11Sa7vPCa1XC3y0O2YWcuCJUKwigRwt6LtKSFnnh7l1
	 xlks5pq+e2kWuaacl3T4sFW1N5zEZqn3RgksSl5mrNB5n5Voba6MLU6kCHXC2PVddcJWG
	 K61cMOeRfX0R42/rxkQ/cPT0nQjOV6I2YWd+xJgOwPQk5VV33yi4Btxsn1w+hpiQs9E3C
	 YyQpWX4TF2SKrJcclFSZW5J6kamzZpQ8K7JrKRxJexCr5bif4zn7ot0rBblZuEvbC7yt+
	 Zfp90LCPW1kjgt9vFv3XWcoSVt83UEMnx8f7SCUhp9Bwe/DJvKYSeem/eOcfDc64Otw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YBdsKuP43U5hcm4y2uKmy7rZP244Qj/U+EIWrIQNKlo=;
	b=AqABU5kCPiVf/V9gjh4S/abTM5+U1scBgcFfKvRY0D3Qn9MD653i42ChLseEdF9vSQsH
	 fH8xXUta530mfpLlhDoO4sp49g4FI5aHS/bPjiVlAJ1AVHKrl1wcTDeTIzcSkHFVrV2th
	 8SIVqftDJdRNRcQSNFLSLWU8vRcPlRm7blv5ZuigvWw20syEPZQZtIFuZSMLfm9xSRApq
	 Iil/tBTWJhkyxGcLywi8bh+BLfxl6PMBMM2bmUjkx5GcZwJb1yxADjsX8JZD1LZ7tUaRe
	 3CJ/zQfFU2LlN033dTt9l04P5f65JWYa8On7e1EIbFR2G9PeDrxFxYPLvxo4iWdiLew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoxYAK2Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E48606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoxYAK2Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A471F01816;
	Thu, 29 Oct 2026 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301248;
	bh=YBdsKuP43U5hcm4y2uKmy7rZP244Qj/U+EIWrIQNKlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NoxYAK2Z/Pqv9gVua+3JtJUGhu9eLyv19taUN1X6unKDEw8LLUX9n/jGdGuU/AQGw
	 84m/9M0x1As2mX3nMikFNlZpC3SU3+n+mAb2TZODjrNFRGblQjWwuWE+JA8PC2noU8
	 KB2QJqsJP3ok6LpkxrRqGxeRbxbdIMWVNheHrM9Rha258rUoIq1Jo7NoTsPfbZfzOD
	 VHadx0HIShOQuj06eJG8hNooW4ymdFgM+MH+cMRU6U5Xhu+zGNruwWIlXHcyv7bRU8
	 t7gA01rxjgVd4p6ez5Ne4Jk1P6SoY5fmdK24wd0XfTDLvPWHcUFs+l1mscW/+QTxe0
	 jrcGNhnqZZbvA==
Message-ID: <sashiko-outbox-189859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf jevents: add iommu page table walk metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jacob Lefkowitz" <jlefkowi@akamai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029-perf-tools-next-v1-1-a75a2b64a15e@akamai.com>
References: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
 <20261029-perf-tools-next-v1-1-a75a2b64a15e@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:14:08 +0000
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
- [Medium] perf jevents: unnecessary global in AmdIommuptw() breaks pylint =
W0602 build
- [Medium] perf jevents: min() in AmdIommuptw() turns NaN into 100% on unco=
unted sockets
--

commit 421e4310ee31d5eae1bdf50f6ef3739f62cf56c1
Author: Jacob Lefkowitz <jlefkowi@akamai.com>

perf jevents: add iommu page table walk metrics

This commit adds an iommuptw metric group to tools/perf/pmu-events/amd_metr=
ics.py
for Zen 2 and newer AMD processors using amd_iommu PMU events.

> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events=
/amd_metrics.py
> index 42569b9153f45..dcffd6e268fad 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py

[ ... ]

> @@ -318,6 +318,52 @@ def AmdIotlb() -> Optional[MetricGroup]:
>      )
> =20
> =20
> +def AmdIommuptw() -> Optional[MetricGroup]:
> +    global _zen_model
> +
> +    if _zen_model < 2:
> +        return None

[Severity: Medium]
Does declaring global _zen_model in AmdIommuptw() break the perf build when
pylint (>=3D 2.16.0) is installed on the host?

In tools/perf/Makefile.perf, pylint is enabled by default when present:

    override PYLINT :=3D PYTHONPATH=3D$(srctree)/tools/perf/python:$(srctre=
e)/tools/perf/pmu-events \
      $(PYLINT) --disable=3Dall --enable=3DE,W --disable=3DW0123,W0311,W051=
1,W0603,W0622,W0718 \
      --ignored-modules=3Dperf,textual,setproctitle

And tools/perf/pmu-events/Build fails the build if pylint returns non-zero:

    $(OUTPUT)%.pylint_log: %
    	$(call rule_mkdir)
    	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && fa=
lse)

Because AmdIommuptw() only reads _zen_model and never assigns to it, pylint
emits W0602 (global-variable-not-assigned), which is not in the disabled li=
st.
Other functions in tools/perf/pmu-events/amd_metrics.py such as AmdDtlb(),
AmdIotlb(), and AmdItlb() had global _zen_model removed in commit db5a60750=
133
("perf pmu-events: Clean up mypy and pylint issues") to avoid this warning.
Should global _zen_model be omitted here as well?

> +
> +    walks =3D Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
> +        "amd_iommu/mem_iommu_tlb_pde_mis/"
> +    )
> +    pt_rd =3D Event("amd_iommu/page_tbl_read_tot/")
> +    pt_rd_nst =3D Event("amd_iommu/page_tbl_read_nst/")
> +    pt_rd_gst =3D Event("amd_iommu/page_tbl_read_gst/")
> +    trans =3D Event("amd_iommu/mem_trans_total/")
> +
> +    return MetricGroup(
> +        "iommuptw",
> +        [
> +            Metric(
> +                "lpm_iommu_ptw_reads_per_tlb_miss",
> +                "Average IOMMU page table reads per IOTLB miss",
> +                d_ratio(pt_rd, walks),
> +                "reads/tlb_miss"
> +            ),
> +            Metric(
> +                "lpm_iommu_ptw_nested_read_ratio",
> +                "Share of IOMMU page table reads from nested (host) tabl=
es", # 0 without nested translation
> +                min(d_ratio(pt_rd_nst, pt_rd), 1),
> +                "100%"
> +            ),
> +            Metric(
> +                "lpm_iommu_ptw_guest_read_ratio",
> +                "Share of IOMMU page table reads from guest tables", # 0=
 without nested translation
> +                min(d_ratio(pt_rd_gst, pt_rd), 1),
> +                "100%"
> +            ),

[Severity: Medium]
Why do lpm_iommu_ptw_nested_read_ratio and lpm_iommu_ptw_guest_read_ratio b=
oth
evaluate to 100.0% on Socket S1 in the commit message example where 0 count=
ers
ran?

The amd_iommu PMU driver registers its cpumask on CPU 0 only, so under
--per-socket aggregation, sockets without CPU 0 have aggr->counts.run =3D=
=3D 0.
In tools/perf/util/stat-shadow.c:prepare_metric(), uncounted events are
assigned NAN:

    if (aggr->counts.run =3D=3D 0) {
    	val =3D NAN;
    	source_count =3D 0;
    	aggr_nr =3D 0;
    }

While d_ratio(pt_rd_nst, pt_rd) and d_ratio(pt_rd_gst, pt_rd) evaluate to N=
AN,
wrapping them in min(..., 1) hits the MIN rule in tools/perf/util/expr.y:

    | MIN '(' expr ',' expr ')'
    {
    	if (!compute_ids) {
    		$$.val =3D $3.val < $5.val ? $3.val : $5.val;
    		$$.ids =3D NULL;
    	} else {
    		$$ =3D union_expr($3, $5);
    	}
    }

Because NAN < 1.0 is false in IEEE 754 floating-point arithmetic, min(NAN, =
1)
returns 1.0 (100.0%) instead of propagating NAN ("none") like the other two
metrics in AmdIommuptw() do. Could min(..., 1) be dropped or replaced with a
construct that preserves NAN when the events were not counted?

Also, on lpm_iommu_ptw_nested_read_ratio, is the comment "# 0 without nested
translation" inverted? Without nested (guest) translation, all IOMMU page
table reads come from the host page tables (page_tbl_read_nst), which match=
es
the 100.0% value shown on Socket S0 in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-perf-tools=
-next-v1-0-a75a2b64a15e@akamai.com?part=3D1
