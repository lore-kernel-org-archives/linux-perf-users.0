Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A83ECBED
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561577; cv=none; b=aRnh89FKzjHd9jqJQ/v6DDI0g3n4rM/ODzeSlnmQx6D5VzJX3xXDPgeCJa0Ld6BP2dlO0d5YQMHyAGAKvssb768bQRLwZkIR50B9HIuMBwH4iO+OaSMajSV/f4SckcsU5iyh4gmdImpOFG1R9BT6fXVeOqWy5FIL0cY5c9RTNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561577; c=relaxed/simple;
	bh=ypCyohvJBnEpPQ0fwX1q3LNYoH/5kMqiwLD9ChHs0JY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LzmXiXCW8eA8lKyzFaUrz5zMFE+N0m0ALFv2u/3wUDQFE62xAoJeGtK+Y/NYKlMQ8zJlVPi8Ntd2ey692h4ZkcAu8wnf67XB2YRi5M0FpX0Z6E3nuSeUAxFm1cb7oKm38KAuaE+7zgbnuR9/R8T59bqVkAq0dNXxLHOgm6kMAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO1/GikE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO1/GikE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C341F000E9;
	Mon, 24 Aug 2026 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561576;
	bh=ypCyohvJBnEpPQ0fwX1q3LNYoH/5kMqiwLD9ChHs0JY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mO1/GikE3tAEDTL8F0i2cNheatHiQVtqwNP2SbKnmZ2QYr1zb+fEhmWSYR4DJv/YC
	 hbkxmbw721HLTNOdbmtLOTFqwygPqJKc+0Fd8pM6UyQ/2CTXOUi7KLMw8S24zv4JBn
	 hbnEORClM7tVodzo7UEM+xtHTllzX/L/UtqtNMbkdlzGTaoywAo6bnNWFFpKlZSqO9
	 4RrxVpXR/e2MSR/9VoRVQ4cPT0xw8jZOmsGiLm9uQJyu0ejoE9g+x0iawKTVk1E53+
	 5C9Dv5u29+lH/DvZa7qoKacf/pDPEI/FWHhzStUAJfiKzKAzYoxWmKwObbWSA9181a
	 wZYz94mo0D4jg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 02/23] perf/x86/intel: Enable large PEBS
 sampling for XMMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-3-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:52:55 +0000
Message-Id: <20260824085256.36C341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Modern PEBS hardware supports directly sampling XMM registers, then
> large PEBS can be enabled for XMM registers just like other GPRs.
>=20
> Reported-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D2

