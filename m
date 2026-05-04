Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AD3D8108;
	Mon,  4 May 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901841; cv=none; b=Kzwi6Lftr6AfOaHrIKeP66Zbe92f3ES5uP1o8n2+hQ2RwuTmjWzB4JTB7Uzerfybj33BNHdQQvJN259UtgipvR7x78oINRhbXeaAmNfm/oSRYFyPuq+t0elG7VcpGL2YfzNwKlSamBJil3D1xwtafYvNSy+A2NwBDAWkXiHAEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901841; c=relaxed/simple;
	bh=i5bybMeYd644bNhISqsFHYSoVAaa0OFKcsHlISNaFEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEyajOE/Ht3+XEjIF3+gZEbQL4Qwe7EAUak0VofSVHjGxEirRWTRFVNfjziGfBeHMkWG6HBijIF0XWtBhu5oF/RaTppVBaRa9J9UpkvfYyPsZh9xDyvNfjk+F5eqQuUeKkF5hYtYAvYdTfPLvwHA5y/hRqYaOKdlABrkgfQ6bTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BbjnRiNg; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BbjnRiNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777901840; x=1809437840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mCE6JH9CRlAZCEsBvLqMNoyr3/ZelpavSG/0UEYXErs=;
  b=BbjnRiNgGg1b2FUoP3DiGhKVux7Hy7+azQGGVY09/ifH0ceMw9bKsR1x
   zl3FrTKkdoP8aYD/bnKJL4mBAFimdasuGzZNuT/wv32wW8behqvay65ly
   4fMMQN7GMQBe64XG8QqZVQKQuF2vkymn1EwkBjbbg9F4WdRIKIDE5AkyF
   jJhokVwcko+dZkBH7cWkUwMn7V2mjxpenzIlHTo/TMsG729mLZ70lZ6Oy
   pGQRmYpQwVVm/HZxbXz46v7zWU3+m4DCg6Lr+WfOpE4E/Ok9XIxw34lJy
   ehSoJDesldWwcsKcwOkBOZmLb5kAiCRD61x10ftr6lUj78VDBHznp3UjR
   Q==;
X-CSE-ConnectionGUID: j5BOBbQAQvGWv871vytCSw==
X-CSE-MsgGUID: Z3/mLQI3S7Kp38xE9hy0Jg==
X-IronPort-AV: E=Sophos;i="6.23,215,1770595200"; 
   d="scan'208";a="18775859"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 13:37:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:8570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.227:2525] with esmtp (Farcaster)
 id 382ad3c0-3a31-436a-aa72-fa9330aea906; Mon, 4 May 2026 13:37:16 +0000 (UTC)
X-Farcaster-Flow-ID: 382ad3c0-3a31-436a-aa72-fa9330aea906
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 4 May 2026 13:37:16 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 4 May 2026 13:37:15 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zeev@amazon.com>, <blakgeof@amazon.com>
Subject: Re: [PATCH] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Mon, 4 May 2026 16:37:10 +0300
Message-ID: <20260504133712.21085-1-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260503162039.E185EC2BCB4@smtp.kernel.org>
References: <20260503162039.E185EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

> Will this cross-wire the DTC domains?
> In arm_cmn_init_dtcs(), the cmn->dns array is sorted by logid, and the
> cmn->dtc array is populated sequentially based on this sorted order.
> During PMU event programming, the driver uses the domain ID (dn->dtc) as an
> index into the cmn->dtc array.
> If the physical layout of the DTC XPs causes their xp->logid values (typically
> y * mesh_x + x) to sort differently than their computed domain IDs, wouldn't
> the cmn->dtc array be misaligned?
> For example, a Domain 1 DTC at (5,0) has a smaller logid (5) than a Domain 0
> DTC at (0,6) (60), meaning Domain 1 would incorrectly occupy cmn->dtc[0]. This
> cross-wiring could cause PMU events to program the wrong physical DTC hardware
> and map IRQs to the wrong domains, resulting in incorrect performance
> statistics and unhandled interrupts.
> Would it be better to assign the computed domain ID to the logical ID here
> using dn->logid = xp->dtc?

Good catch on the cleanliness — I'll switch to dn->logid = xp->dtc.

That said, the two approaches are equivalent on this hardware. The four
DTCs discovered on Graviton5 are:

  pmu_base    xp->dtc  xp->logid
  c030d900    0        0
  e430d900    1        9
  c370d900    2        130
  e770d900    3        139

The xp->logid values (0, 9, 130, 139) sort in the same order as the
domain IDs (0, 1, 2, 3), so arm_cmn_node_cmp produces the same sorted
sequence either way, and dtc_idx++ assigns the same indices.

This follows from the topology: arm_cmn_graviton5_dtc_domain() computes
domain = (x/5) + (y/7)*2 over the 10x14 mesh, which increases
monotonically with the row-major XP position that logid encodes. So the
sort orders can't diverge for this mesh geometry.

Still, using xp->dtc is cleaner and more obviously correct — the logid
directly reflects the domain ID rather than relying on sort-order
equivalence. I'll update the patch.
