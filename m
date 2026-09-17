Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E142D0602
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611052; cv=none; b=J/Fjmew6kwyusXa3vG46bz8Vw3Ztwhio5i6MZEbl3i9Ot1/erJIabVQ/GERvQc4F+VeYlgXmy0/+EiFqipT1L54zVF7vVUEqs90OdBZn6RJQTf+WDADte07OSn6yIMOO9wZw3paJTmd4Se8jyRZbLn4m4nVsE8OPpmML5RW+0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611052; c=relaxed/simple;
	bh=zO51tUZulM3jL3AgJpx2GV5bDev8p1oKzHSh/NvE8M0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qPTBLCDeBCNiXEPGMtT0rFxGBoa3ogMnuA9aMmdTCtM2rU3FkwphnkKqup7OF2V7trm5gcvMicW/KR1Mrwma8bQASb7+g9tBeVK94gbOhYoTxqDt3jB7jxLO7f24ixQP17xw/pD18Tst9sxQQpLGL0/KZpT7EVVV/AyPBjjhses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFdpXO7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFdpXO7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C0B1F000FF;
	Thu, 17 Sep 2026 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611050;
	bh=zO51tUZulM3jL3AgJpx2GV5bDev8p1oKzHSh/NvE8M0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFdpXO7NshSlCElrCnRZfCre/U9leVtsm1tiCp5BN/U0XBiLY1iVCPx8EWbKc6h4w
	 YPrIuWGTSn+GL+TmRKZ/0OAveVa4iFPgBrGhjYAaY/Wkdo7wKybk8RhnNA+Vyz8HvH
	 43/YeG4BsKchXrujtVKrxFgnvdNjXhRvxBmOYiOOTIzyOp0VvVihSz1FGehMCYFhnr
	 WlwRthAoH5Qfb10K3aKD53Zwv9NVagqjcxRaSlkwZOte3cgFnYSU/V63GikcS96hMy
	 5emGHznremKN2GWBrB23/VYXYhupKooOaHFUONtrhHN3R647pLfXbZ5cdL6rO8hGkK
	 +sWUeAKGpmhXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] perf/x86/intel: Remove incorrect PantherCove PEBS
 data-source constraints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-7-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:10:49 +0000
Message-Id: <20260917021050.35C0B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Same issue exists on Panther Cove, PEBS data source is valid only for
> the events:
> - MEM_TRANS_RETIRED.LOAD_LATENCY (0x1cd)
> - MEM_TRANS_RETIRED.STORE_SAMPLE (0x2cd)
>=20
> The perfmon database (https://github.com/intel/perfmon) previously
> tagged additional memory events such as MEM_INST_RETIRED.STLB_MISS_LOADS
> with L1_Hit_Indication, implying PEBS data-source support, which is
> incorrect. The database has since been fixed, but
> intel_pnc_pebs_event_constraints[] still follows the old definition and
> marks those events as data-source capable.
>=20
> As a result, get_data_src() may decode data-source information for
> events that do not provide valid PEBS data-source data and mislead
> users.
>=20
> Remove those non-data-source memory events from the Pather Cove PEBS
> constraint table so matching falls back to the regular non-PEBS
> constraints, which already provide the same counter constraints.
>=20
> Also update pnc_latency_data() to decode LOAD/STORE flags explicitly
> when setting memory operation direction, for consistency with other
> *_latency_data() helpers.
>=20
> Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D6

