Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187639A7FD
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179668; cv=none; b=qAYQCtpRJpDUVw2XPb/fMDNspQmYhSTxazcxstLBLfQpmnn5T6Em9dR38ptZK92SxjYtWsbhd/cCXdP2hNCd+GDB2I+1EYqe5HTkCadJevagCTSdvqAOekWAEOxjsSiwzp2UmU63h5zY+SOQyJu7TNAcRSe7aeD27MfTENJG9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179668; c=relaxed/simple;
	bh=x1YS8pS9jTz1MmWaE8SvkmEDpu8HU2e13paabuqTTvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T7vbFcwhudh0BRalXvqupuZ8b0znZ2y9/upWW75mj3Uu+vMIqtyo5eFUuKMtXVVlHFi7o6O0q6viBYzqW4i8ZxVgA7FD6kteZeBXzlmoE9aswa2HYA6q88+38JFNyFT5tIMLzSF4RXFXS+uNVH5mX7xtkvcpGxM0Lv/WPeUeGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6he4DYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6he4DYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE771F000FF;
	Wed, 23 Sep 2026 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179666;
	bh=FQDS96Qn9RuW7DmOS8dUDwQEClKEn6bypvu0FlTtphU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6he4DYliy654ds0Iwc1pBecY0b6mrvpzK7SkvPB9TackWU14U6GgA9Xi6dO2K43W
	 XzYzS2hFXKKUERICDC1ZxUFiyHSpCEAYL3Ty45NSzD6fGxQeV5DIyikKw95btejgkY
	 FM6AznfwfkDgKsZNlN9XXwBRdX1PIyqW4QgfevOOYGCMPtrB1xXAgfaWPWCBULRxoU
	 x+GQPODNn4KTZrA+VlHVmaEQR8XwgYyZ1pkKxzPi1qejxvmEc1aQ6P6vz/aT64fHB8
	 r4uZxH9G05g9Z+JOffVcFU0lXYUxaSFcptPvki7jM6Yzwf06YW6wQ/L5K+AIaub9f3
	 j1ns3z6RcUwuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923155703.34814-6-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
 <20260923155703.34814-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:07:45 +0000
Message-Id: <20260923160746.4BE771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Show the memory region in perf-script subcommand. Memory region is found
> in the mem_region field of the memory information data source. This
> field was included with the introduction of support for the Off-module
> Response facility (OMR) [1] in Intel's Diamond Rapids and Nova Lake
> Architectures.
>=20
> An example of perf-script output with the new memory region field is shown
> below:
>=20
>       thread 5/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No=
|BLK  N/A|Region Local-shared-cache              ffffffff9f002aba
>       thread 2/0 ...	|OP LOAD|LVL L3 hit|SNP None|TLB L1 or L2 hit|LCK No=
|BLK  N/A|Region Local-shared-cache              ffffffff9dc54c95
>       thread 8/0 ...	|OP LOAD|LVL L3 hit|SNP HitM|TLB L1 or L2 hit|LCK No=
|BLK  N/A|Region Other-non-shared-cache          ffffffff9dc54db3
>       thread 0/0 ...	|OP LOAD|LVL LFB/MAB hit|SNP None|TLB L1 or L2 hit|L=
CK No|BLK  Addr|Region N/A                       ffffffff9dc54db3
> [ ... ]
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923155703.3481=
4-1-thomas.falcon@intel.com?part=3D5

