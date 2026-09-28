Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DE54706C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618260; cv=none; b=moeSukAZctbW67LIZORsKrMCPqnJnoz+N2HvTFhyejWMCEAT+TZMJI63qeZCjwHhYOl44OfZzDxr0EIErOnBdviHqprn0D3OTB9lxSAt8TorRsREGw90SmP+k9MfXEKONCKTIsp+XkZMFm2c1DgpQXVtdcN4tfaZ1w65ok2HODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618260; c=relaxed/simple;
	bh=CufiFEb5dSyD6zEMjzQrxnlzessENrQ8wgDLnfNBQ5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TqfP+V5kcTKnmyPFwqaaK6ggP9V4uMlqBVt3F7d9HCCrjoAnukoFoo88eZrmDLP6cMZ/bBP+7QVnTSDcJbjVD9cssOcdgOKw42iMb1kNoVxmBW3LvPiIQxKcqt1RO0/jV66pkU+AdhJKz22O8ykt4qRlfGgG4iPdr39eyiQVQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGxuFooa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGxuFooa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74681F000FF;
	Mon, 28 Sep 2026 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618259;
	bh=9YvqIizNMveqig8lf+UR2AMfPu7IPH/AGmseEhCjMas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGxuFooatB9rbzo0wnRPhpS2CbJq9woGwOAQVaq71Z0s/M9DcpnFXN/pwXtDY61A7
	 jcxnToPOJAwBn28j5fWOfFTJbvEGijmIjvcTnzuLsru5g5/2K/KU1B/AJSM3t+Hyeq
	 m7nynaCfdyPPoRJpv2WaGWOwhwGwrcStskfu2tvGrixWj5BTDjr1F+ntHtm6ur0UEj
	 dpDIuE9NX36xRw+bgBtPMSmO7UXhhBp1mE32c8f+z1ed+rgMga/CSW8iybBVL3QVAv
	 LwWRxKpJ5c+QQkZNkTSEvB/7f3E1OM6PzwzNjksyPYfLMO+2n0HWvV0taady1icAdT
	 MAeXGpebV2iyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf jevents: Add NVIDIA Tegra410 uncore PCIe
 metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928175127.1032535-3-ctshao@google.com>
References: <20260928175127.1032535-1-ctshao@google.com>
 <20260928175127.1032535-3-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:57:38 +0000
Message-Id: <20260928175738.D74681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add PCIe bandwidth metrics for the NVIDIA Tegra410 SoC. The formulas
> follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst:
>=20
>   AVG_RD_BANDWIDTH_IN_GBPS =3D RD_BYTES / ELAPSED_TIME_IN_NS
>   AVG_WR_BANDWIDTH_IN_GBPS =3D WR_BYTES / ELAPSED_TIME_IN_NS
>=20
> There is one PCIE PMU per socket and PCIe Root Complex (RC), named
> nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-id>, with RCs 0 to 5 in each
> socket. The metrics sum the rd_bytes/wr_bytes events of both sockets:
>=20
>   lpm_pcie_bw, lpm_pcie_rd_bw, lpm_pcie_wr_bw: all RCs.
>   lpm_pcie_bw_<rc>, lpm_pcie_rd_bw_<rc>, lpm_pcie_wr_bw_<rc>: one RC.
>   lpm_pcie_loc_rd_bw_<rc>, lpm_pcie_loc_wr_bw_<rc>: one RC to local
>     CMEM, GMEM, PCIe peer and CXL memory.
>   lpm_pcie_rem_rd_bw_<rc>, lpm_pcie_rem_wr_bw_<rc>: one RC to remote
>     memory.
>=20
> The per RC metrics are in the lpm_pcie_rc<rc>_bw metric groups.
>=20
> A socket's event counts as 0 if its PMU isn't present (has_event() is
> 0), e.g. on a single socket system, or if it isn't counted in the
> aggregation (source_count() is 0), e.g. the other socket's event with
> --per-socket. Otherwise the metric fails to parse or is nan.
>=20
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928175127.1032=
535-1-ctshao@google.com?part=3D2

