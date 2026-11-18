Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038089;
	b=j9g2qN+WUplDtQSbDvzODgr/H9P8ngKNjjc7xb+iQzubMnvuTS2ui2jJeaR084Gd+/Ge
	 X1WUO6Ih0L3AzC0Uwi2lvySRDl+YeReih1STAt97exbMric6v49Swtq3QdpERuln7hiJr
	 +HJAEUiIJ6Fxz/K4DQqtNTDU+FrqN2Uw9iAg5atqjWj/wpOSG+IuIHRJEBxlU1+qk1syV
	 SqvrSYW966P86uSJNBKf00qtB141Q46hYeJL7ZnZzBA7J4B4FOwmj18F07WH7LOHUEiYG
	 JMUqdbmNrhexHwJULtuF8AJ1e+49XMoRqftsEdqJq0OwuOJzoa4O6UWEf3n/Rk+zYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6bXGADX+oU+DtSrxIShnNre8lWZpobKP/IEcicIc4bc=;
	b=FvMX2yDXEqUPfYLr2ZIEaRXEd9w3s2hQIlx9PSUIkSpNEUIpHS+oqvWoxc7u6E/ydRs7
	 A63TOSlyQdFjndeZTcuWItIxXfLl4pR92gKdFZWg+z4j083FnQutfBktvdHhb1wVj0Ap6
	 eXtbe+wJ9QLBpr1YUom4zrZgFwYeTl1P0QlqzFTWdVckepChdUY/6nwJeImOq9+rILVQ7
	 P+1rNi3LJWH3RmT2SUuqJoBEDt8QKOKV43GllXhdXtNtdzM7rU2sDb0x9qABO3X1Zbl9j
	 zykR2s3lncLOvpjdL3sq7QY8bc5MYX+vaOO2Rpm4pnQFIAiY6aGaKaSqhZMKhCaQ0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZG6RkH7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C28606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZG6RkH7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9325B1F000C6;
	Wed, 18 Nov 2026 21:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795038088;
	bh=6bXGADX+oU+DtSrxIShnNre8lWZpobKP/IEcicIc4bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZG6RkH75eCWKbkSozqSgApiyKNNP6iM8hb9fiyPZpVRt8zu+LnJ+MiRpdiSPx+9a
	 DQd6IBWp43RxyZ2UHaE0K+zrWZ6YjjNC/jeKLwje3f2MGd+S5JbTg8Zj45RRlW5TEr
	 7+IcI0cr/FgIk10tvj6ES/Y5wS9a2W+40jRpkmYClt8VduTDRuDVeHxt6r0ex4HHJr
	 vcE7bSCnhq33ankuBmQBdvvVkoLaE3Y0t81i6QHXBbLdI5VhnZzhOqUiNr4hk9CMda
	 VSimxpN1ruv3+SeAt/Hbow/vpFgTIwdTXpKqRWTsS1lJ04eeFKPHY7d7UJ5u6PVpxR
	 rjEWMuTqlahUA==
Message-ID: <sashiko-outbox-222021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] perf vendor events intel: Add diamondrapids
 v1.00 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118212655.2262601-2-ctshao@google.com>
References: <20261118212655.2262601-1-ctshao@google.com>
 <20261118212655.2262601-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:41:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf vendor events intel: diamondrapids CBOX unit mismatches
  kernel cbo PMU
- [Medium] perf vendor events intel: diamondrapids CXLCM 12-bit UMask
  overflows 8-bit format
--

commit 3a4a08558cf9b749c6a1a772aa40a0eb0daa9bf9
Author: Chun-Tse Shao <ctshao@google.com>

perf vendor events intel: Add diamondrapids v1.00 events

This commit adds the v1.00 core and uncore PMU event JSON definitions and
mapfile entry for Intel Diamond Rapids.

> diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.js=
on b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json
> new file mode 100644
> index 0000000000000..c657163f21f71
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json
> @@ -0,0 +1,292 @@
> +[
> +    {
> +        "BriefDescription": "LLC Lookup request that access cache and hi=
t the LLC with the CRD opcode",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x34",
> +        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_CRD",
> +        "PerPkg": "1",
> +        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_CRD",
> +        "UMask": "0xc0a00f7",
> +        "Unit": "CBOX"
> +    },

[Severity: Medium]
Will the UNC_CBO_* events in uncore-cache.json (and the CBOX entry in
counter.json) match the kernel's Diamond Rapids CBO PMUs at runtime?

jevents.py converts Unit "CBOX" (and "CBO") into pmu_name "uncore_cbox",
whereas the kernel registers Diamond Rapids CBO PMUs as "uncore_cbo_<N>":

arch/x86/events/intel/uncore_snbep.c:
static struct intel_uncore_type dmr_uncore_cbo =3D {
	.name			=3D "cbo",

When perf matches "uncore_cbo_<N>" against "uncore_cbox" in
perf_pmu__match_wildcard_uncore() -> perf_pmu__match_wildcard(),
strncmp("cbo_0", "cbox", 4) fails, so none of the 29 UNC_CBO_* events are
available on Diamond Rapids.

> diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json=
 b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json
> new file mode 100644
> index 0000000000000..b692606bcd63d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json
> @@ -0,0 +1,22 @@
> +[
> +    {
> +        "BriefDescription": "Number of Allocation to Mem Data Packing bu=
ffer",
> +        "Counter": "4,5,6,7",
> +        "EventCode": "0x41",
> +        "EventName": "UNC_CXLCM_RX_PACK_BUF_INSERTS.MEM_DATA",
> +        "PerPkg": "1",
> +        "PublicDescription": "UNC_CXLCM_RX_PACK_BUF_INSERTS.MEM_DATA",
> +        "UMask": "0xf10",
> +        "Unit": "CXLCM"
> +    },
> +    {
> +        "BriefDescription": "Number of Allocation to Mem Data Packing bu=
ffer",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x02",
> +        "EventName": "UNC_CXLCM_TX_PACK_BUF_INSERTS.MEM_DATA",
> +        "PerPkg": "1",
> +        "PublicDescription": "UNC_CXLCM_TX_PACK_BUF_INSERTS.MEM_DATA",
> +        "UMask": "0xf10",
> +        "Unit": "CXLCM"
> +    }
> +]

[Severity: Medium]
Can uncore_cxlcm parse a 12-bit UMask of "0xf10"?

The kernel's Diamond Rapids CXLCM PMU defines format/umask via
format_attr_umask (config:8-15, max 255) and exposes bits 32-35 as a
separate format/port_en attribute:

arch/x86/events/intel/uncore_snbep.c:
static struct attribute *dmr_cxlcm_uncore_formats_attr[] =3D {
	&format_attr_event.attr,
	&format_attr_umask.attr,
	&format_attr_edge.attr,
	&format_attr_inv2.attr,
	&format_attr_thresh9_2.attr,
	&format_attr_port_en.attr,
	NULL,
};

Because jevents.py emits umask=3D0xf10 (3856), pmu_config_term() rejects bo=
th
UNC_CXLCM_* events with -EINVAL for exceeding the 8-bit umask maximum of
255.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212655.2262=
601-1-ctshao@google.com?part=3D1
