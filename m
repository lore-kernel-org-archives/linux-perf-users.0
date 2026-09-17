Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225E35B62F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611093; cv=none; b=isAD/qkPueDnH+JmvUlIjqgGEE4okdYmqGgsrA7MNrXZDTahYaXwQLelpOvYdtZYSSNc9tu0VA9m9ItalaqbB2Jqy2FStgp54ENBzCuBCLxTU2NxLXW5sawo+dDLsqfN2U3uDRRgmawRs7B0utIdZvytVjgU8djGVFrc3eWTkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611093; c=relaxed/simple;
	bh=di1PaEFXOPwXK2meNObxRYu/6+kSwa/EZo/MFsp+kFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KkpIwX5HvpDClM0qS1fwwT5dMA5oFZlKquhwCu99RAfxWRGzxisvpGRKMcimLbic8lY+XXTK77a2MFkmmBkG0uMsqvDLvppTlHApBBvRZyHPud0j5Yk8HZKTVZkCevUydhHe2OqU5fnut+B0FP9IVfVGjl0rLlZuGlZiNEyWHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysg5EqQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysg5EqQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A331F000FF;
	Thu, 17 Sep 2026 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611091;
	bh=di1PaEFXOPwXK2meNObxRYu/6+kSwa/EZo/MFsp+kFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ysg5EqQCtLcpFQwz3VybyeLSnggOb2B1vWzPGxQAVGf9MTmFMwB6Ytag8HcANfinu
	 M67Jgk4YuImzBjn4UndX79bF/KzJlIADRFlsMFp1bDNK4cc9V0qtQGTrKgq9YAPeFt
	 2PcQ2OjWPtakemfnu8KTWffYlboCj+Eq+7mSA7829cxZRbrszRq79FTLUtdKPPnA25
	 4mIzjAsnLG9wyS9IrehNWe78+XdcdbAVVy727e8lnpzOl6Dvwu36kmg9LcGKLT+7a3
	 cdKEvs3Es5NLlOnFGignrMhuCXPayYpuTknUvvgu5iYUf/oAXLm9tYJ8gSduISymEx
	 qU4FpwBbcMEqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] perf/x86/intel: Rename DMR offcore_rsp attribute
 to offmodule_rsp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-12-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:11:31 +0000
Message-Id: <20260917021131.87A331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> DMR introduces Offmodule Response events in place of the legacy
> Offcore Response events, but it still exposes the inherited
> offcore_rsp PMU attribute for programming the corresponding MSR data.
>=20
> Rename the DMR PMU attribute to offmodule_rsp so the sysfs interface
> matches the underlying event name and avoids user confusion.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D11

