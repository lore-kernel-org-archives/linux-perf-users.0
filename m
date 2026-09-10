Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFB414434
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069890; cv=none; b=PA1gjOeW4QoZDZXqmYwajpdMvVCsU7/nGwC6DTuh4Tzohzh9ZR8KGdWmvJmu12M04/55ONuDa5Nh9ooECsk/rjdeNn6VwZkIunzt/DYvs35UXza4HelnyCGktqANPSAiYVUHPGr4Q9T2i7ojyIGfTthgx/WjM9BJ/DdbED0shlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069890; c=relaxed/simple;
	bh=7jlaxMmRR/UWk03MFw9WMBTwzcCzgE+8+tfhIth1iKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVoNEiC8hPIWimNweCoRYdmry4eYgGxYiBy6pknAfJ3K8rW3pIXXtkvlDudp+wXYOrb6uTa3FLn5XfeTDnU2ZF3mtqBsDXQh+eXEaGUHf66R/NLslfmA2nKyuOdSzxaaDEh/WMd/QLz7rvpWQGd9JJakY7rarz+aJAtdzCZ9dX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ4zX15F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ4zX15F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E07B1F00899;
	Thu, 10 Sep 2026 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069884;
	bh=7jlaxMmRR/UWk03MFw9WMBTwzcCzgE+8+tfhIth1iKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQ4zX15FVMf9jkdmvEIC2U1QHH+5Vx1v9Mf5XbmMahr7jWLe/5+O+9YtBNHsZFXg2
	 LPJimljZpwboHYvNJgVlujQRUDpmZfI9G1v2rsR5SWfD876RGEScrZcdiavtifCU9/
	 K4AWBKvTqyZMM6WGXB3X8x0j8jclqiX9W9xofQtXs5SmCyLMHm3Nzj++SCod29/PxD
	 Gw6Q0KgacksO69+DyBV9DHX4K8Y79O921RW4cazwcmVuPAZoE/aidfrsVVv8uu17Vh
	 Q9rhdbrMSab/c5R1RNCAS/G1Mj/tFyJTfqHr1SEuJfom8vAtxYitvi5ymsmD8HKDTr
	 9FcekZ1y3YN3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910194324.98002-3-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:51:23 +0000
Message-Id: <20260910195124.4E07B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>=20
> The L0 cache is newly added a small piece of cache which is
> the closest, lowest-latency memory cache tied directly to the
> execution pipeline.
>=20
> The table "Table 9-4. Data Source Field Encodings for Panther
> Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
> "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
> Auxiliary Field Layout"[1] indicates the code "01H" means the
> "L0 Hit - Minimal latency core cache hit. This request was
> satisfied by the L0 data cache."
>=20
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel=
-architecture-instruction-set-extensions-programming-reference.html
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Codeveloped-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910194324.9800=
2-1-thomas.falcon@intel.com?part=3D2

