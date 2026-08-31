Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EA221F20
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213670; cv=none; b=YFxNol7FvAHrLl+sDcvjfDZvsL5pLW4+iTl/OLsJNPm08YubZ+cf6w+1bfB76VCh38unie8b6uJ4uIqcJ32uhDwhhQ9+vMXYpaSmc/jqVi5hXIAjaf8kSV/gNJJCtQbSQOxX8H8lBUb+phF8j1jS6cLa/Ue3GENnfuIM/TcqDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213670; c=relaxed/simple;
	bh=/hGUVHLpIW59YpQewD7HP+TwdCI7LoemMveK0fXvSTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTRm2XSTIiI8FJw1PZScXmgbg+3p825LzIEiOJHoHNOsb2CADkVFnQPzxyWtgh9H6CB2YQ5f+b+koKhhA906/yK+0DqWfR0R5yiBiBaQ9RJ6WG5HrrYH2OJcdYj97jHZmB9x/cVq1gSko750o5U4mgExAkONT5TIA7XpC8rzsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Entwik+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Entwik+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99C81F000E9;
	Mon, 31 Aug 2026 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213668;
	bh=/hGUVHLpIW59YpQewD7HP+TwdCI7LoemMveK0fXvSTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Entwik+9KSjvxRtZZBt4ui8AT5IbAuDTYfwfiRqiNt1SOVVPkGj4xNM7OtLgaEKiF
	 zbKioK4C78OfmoD/8mnXW08jdCEaz4B9DCsfGyBUalcIul/ldDO+STWHwPvoFz7ytu
	 rfFZJQTEb34T5MIGK9CqgptzA9rfPWBMPAmvPqoyuMSq7wY1sYyKhtQBWIyP/aTkPX
	 fzADsx02Msy1Eu4p6cZRKQ/aO53IQVZqzxeFp0Mkp2gmiG2f2BM218GsBlfaGvfWrc
	 ZjBwi3gOXvK13njKv54WY0BVihZtWIuFmJiAg+3kuy7nOnEkkkEWG5H/SiNlf5h8oY
	 JeetIPoRU2vnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831204613.2793526-3-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
 <20260831204613.2793526-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:01:08 +0000
Message-Id: <20260831220108.A99C81F000E9@smtp.kernel.org>
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
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831204613.2793=
526-1-thomas.falcon@intel.com?part=3D2

