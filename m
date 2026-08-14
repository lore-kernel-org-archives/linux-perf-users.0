Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CE4908BE
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730179; cv=none; b=Hu+gifso2vaXtkSzexJDnSVfdeUSbBb1qXbyWLTZ+O8sitpPDLjGBkezljT/N1tD77FMYXCj5aljqozFcvFlXaCu+IrqbzyesFc8uxuhvjw8t6N15ps0WFY40o09OCn9+LVM4ogTzP0rxOCcKKVfCgQH1Cnwqzkdj+OjRtdiam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730179; c=relaxed/simple;
	bh=jJGvalRkg33W1keXaps/TAm5TGOm0HJK6B4tbm8O3R0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AwLYB6P5MRbmUqlQbVGItsG/2oMmEnGFqk6F/17CV+H9e3+YHBW2/ekNfHuLqiP7kCxdfNxgXiECAtCGqRCXMBTtte4HrSX7Ruux/rqY5YGkQon89idmluJu3X3Y0pm5Isuk+V95b2F++ymGeSY7BZFdPxtzzfNnIKlIVG99v6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7rqlL6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7rqlL6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA68A1F000E9;
	Fri, 14 Aug 2026 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786730178;
	bh=jJGvalRkg33W1keXaps/TAm5TGOm0HJK6B4tbm8O3R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B7rqlL6RjGQ4b6NoGZSyc3BjFLAILA2fPjTkLtVF50wzL7bpiB3pPG5Doct4wNds2
	 Omzqh9ZFBt/mKxppg5Tw/Uiuw/YGtGF+WCZbA2t8Qd3gaYDGu66U5gpg+NlCsUkX/t
	 yKOVwh/06fn8hCVVnUPH6QwIGHQpNSzPgtwpCHhszL1zcH+4wlPf7FBTM6xEFnbsNF
	 rMzS5+UHi6m27UshzrCTVozYw4tcGv2ROgsdu1b7m1r8N05Xzi9vKtB+QCGZOgunzO
	 5EzVVMjhgmQGh++OB03YcjEd7x8EOiJZcyvllhmdmiaOJdMQkkLFeAf9kCGTLgldTF
	 hk6Hm3X3y8dwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf/x86/amd: Implement x86_pmu::print_debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <bbd6778b5494ac5e256479d4724823086a03c701.1786728929.git.sandipan.das@amd.com>
References: <cover.1786728929.git.sandipan.das@amd.com>
 <bbd6778b5494ac5e256479d4724823086a03c701.1786728929.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:56:17 +0000
Message-Id: <20260814175617.DA68A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Implement x86_pmu::print_debug for PerfMonV2 capable processors to dump
> MSR_AMD64_PERF_CNTR_GLOBAL_{CTL,STATUS}, plus MSR_AMD_DBG_EXTN_CFG if
> LBR Extension Version 2 is available. Chain into x86_pmu_print_debug()
> afterwards to dump the event selectors and counters.
>=20
> MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_{CLR,SET} are left out since they are
> write-only.
>=20
> Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
> Reported-by: Petr Tesarik <ptesarik@suse.com>
> Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@sus=
e.com/
> Tested-by: Petr Tesarik <ptesarik@suse.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786728929.gi=
t.sandipan.das@amd.com?part=3D3

