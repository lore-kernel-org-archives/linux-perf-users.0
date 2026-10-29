Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249625;
	b=la/7hhWpFO2henJw53kOqo2ZTmuFGq6ivCbiH+WhTRJ4dq+/JQfrQvpnYI2zYAqQHBSl
	 cYE6KMCxX5VkpjdFIQEYAPlscGOf8ZQer/dYpu1NamIhtWsZ1QB2QCex6WSaM/p1Tq5Nm
	 IYCCd7FNF0jtyrVuYPipWG8mXYEDqRIX3CfbTlHopPA4luObx3QvWiCNjjg3WLSQ79oFr
	 JcE32c5F/8EzBYXnye0Laz3ypZ4XfJmBrSxIoEKgaIt76Q6WywvFvQZsNcucQpdlVO/K+
	 4Edu2ToTmCrWFM9HWG3H3CPxYE3IEUjTAL9Atq/ZYVMcOP1zUHwg2kior1DrOdr2cbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gCuUMu4cHjgVZPG9rAJrg+crPcx09IRAQso3Ddykkcc=;
	b=pTYzhK2CvZiSUDf+lxltOn+1jsN2HJmqWOlX2FN9Egv6xkSV6C9ZueYFNee2snZFJB6s
	 ho8MDguwgJwI9ygNdhG0jLXomUg2sad/TyEjXJ3S1ml+SCh2bXz8GLYn+rXXRrIYKZt2f
	 eTovmeolc0Y/ei8bYSVAGoUtgOoT3sWSHUXLIpRCb9l3lmy+G1y3YHKx5HAde4iWF2kq8
	 NA9pWrKiquRP6iFrIUXGrHyh65C0NFG/ATlpzEaQmCWo68YM5p7chiZPLxRlm5iVGPFxg
	 Xk0T5Mlcaj5hvKE05rqZBdaJGGt8aU9G0YzG5EgaOpM7LJdk+TStLBaJ1JB0RNXseqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtZ9Vx4o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB8606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtZ9Vx4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B2F1F01825;
	Thu, 29 Oct 2026 04:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249624;
	bh=gCuUMu4cHjgVZPG9rAJrg+crPcx09IRAQso3Ddykkcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtZ9Vx4oI8JZBj2TSHko6MRfj4J9vFaFaqiSmxoJ5ScDpGJ4u+rdUfZIoNgrwkitk
	 4nJPaumA3NAgUGAR3MPmwdVvAj2yF2jt0+CaC85lxhQ4ML7ftmIf9lG/7QIRYqnpZZ
	 +tYNSM/k9gLy3fcqVD+QTUFQsVvg9uq4mJkAJdRt3WEq8skLpztBmbTKXRYihulia6
	 JALidOajhjcsa/nxSJZjyf0wFbjvUxq02SDHwRYMZMAhLaUxNBkLyEK9qFuL3u6KWB
	 UDssjQAcarupvoYZS5vnMyqdWFy904C4i24AGf58YMp5/6RWaDa6IHlEpTmJ2D5Z1Z
	 ByYLM7SXel/Ow==
Message-ID: <sashiko-outbox-188714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 03/18] perf/x86/amd/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-4-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:53:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Sandipan Das <sandipan.das@amd.com>
>=20
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D3

