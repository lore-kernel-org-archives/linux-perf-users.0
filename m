Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600255;
	b=OrcE4WxSxr2qz5znnsY6Pz+ZXUtoIVcSWwqlafLkSCUeRxLOnDJPlEnD8E6rDA6cbxpo
	 cg5pkDPv/cz3UDeRO0yOJkN65/BFlvOb/OnMjsnvlr1q8w/U2GIAdiZPFnhxS8JiGjvj3
	 +tZUTMmMgqZPfLmn6BwGmewnZZLwna13ETTt1CiXhdXBYyLq+xgJ5TJZPxl+0W3sNesQY
	 DlbWue8m7+a2HaQd965E8O4URM4O/0ZER3pvcfx9frrKnomuhG4w1oPCbm+WXY/IzSIqh
	 OCprEvIdjg+ajHL8lEc5mDQ60mULsJ4P24lZ9uE9E6YPZ7o0qrgM5W/GDonByqh+95w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P88JxzC+ivo2UIVAQfgdNeEXNiJEULb0q2srJxsS7/g=;
	b=gES8JtGQ2YnZ0H/eaAvQ6IlWWblr50dwsjDtwEe/mX1s57dKgces5GFwh85EDiLz9PqL
	 tuC9CnUSJ+I643JLbaZDSo5tlEzvb61B3Jpiwsp5SNIHLol9ja4KtelZMXcL2QboCFacx
	 0NyIF8RthioNI90WQ5Yj10kyu+HGdy78FkhRzawJzat4k1xl+nkC6nLTZ26plgHXtScIw
	 HbDD9bJ3Bx2s7XWNAWY3QMIi6bvBuAPfkg7sn4AT6wctAFIPiTVxuSdvUci0iism1tX1W
	 9UBSbOkW2WQOUvjrsM44ksD79O63RhmY9M5n01SG7C4Ek5pNb6CGFAfcGF/LL7m2P8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzwadFt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AE606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzwadFt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645C21F000C4;
	Fri, 13 Nov 2026 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600255;
	bh=P88JxzC+ivo2UIVAQfgdNeEXNiJEULb0q2srJxsS7/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NzwadFt4a3rTM7dM82Q2Ky5J0ubMJ6kTFIsRmC2ro4FklJBdJzkBDvCQ9Vu/InyBX
	 O6gAFbfMqMhyzHrzHUc76o00NCapACAl748W3gBACv2Q7k8n3ucVmgBnNs1sEuRX3v
	 qZaVWG8m/HsQt1sDgkxo5OyIA+LO1snK2wqMfYgX7UYKPFYCcQ2i/YVCqGTUB0Pk1K
	 73h+3Ik0vaRSsk/cLpgKyzrEiXgrLjFdXfFbLfdfITpNErbyLbDzpDHKMpnKEzpLrJ
	 GVuqENX9oZCYhJuruO7RiOrYjm38OnCkRGQiJre6i+Zcjrnn8FDlCNTYjxxn7ptcS5
	 agPJI31u47wjA==
Message-ID: <sashiko-outbox-213607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/30] perf pmus: Don't skip core PMUs as duplicates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-2-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:04:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_pmus__scan_skip_duplicates() skips a PMU whose name, without a
> numeric suffix, matches the previous PMU's. This is intended for uncore
> PMUs, such as uncore_cha_0 and uncore_cha_1, that have the same events.
> The check was also applied to core PMUs, but core PMUs of heterogeneous
> systems may differ only by such a suffix while having different events.
> For example, ARM ACPI systems with two kinds of core name their PMUs
> armv8_pmuv3_0 and armv8_pmuv3_1, and devicetree systems may name them
> armv8_cortex_a53 and armv8_cortex_a57 where "a53" and "a57" are hex
> suffixes. Only the first core PMU was listed by "perf list" and the
> events of the other core PMUs were missing.
>=20
> Before, on such a system, "perf list" and "perf list --unit=3D<pmu>" only
> showed the events of the first core PMU, the scan having skipped the
> others. After, the events of every core PMU are shown, as on Intel
> hybrid systems with cpu_core and cpu_atom PMUs. Uncore PMU deduplication
> is unchanged and pmu_deduped_name_len() already avoided removing the
> suffix of core PMU names when printing events. Similarly avoid removing
> the suffix of core PMU names in the raw event encodings that "perf list"
> shows for each PMU, so that each core PMU's encoding is shown with its
> own name.
>=20
> Fixes: cd4e1efbbc40 ("perf pmus: Skip duplicate PMUs and don't print list=
 suffix by default")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D1

