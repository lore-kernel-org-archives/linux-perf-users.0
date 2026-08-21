Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872C212564
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272063; cv=none; b=ljeMKJfgBLmYG+1YKV0431HAG+rmaE8cbvMv5s+BFpce8b8VEJHrOTkYvaEHaPhUU6Ol36RU2dMeu/sqfDGuFhz3QsLyQFoqmZAne2/eLphg51JQ3K6cshBJqV8OFjU3xmb/mf1txBkwWptjac1h0F/+Ww/Ab43FYVbaqWkLB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272063; c=relaxed/simple;
	bh=++70brCsGDpcWUSN9iDyol00VXp6Cn+MQxffyxJZ64I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oLQGHESGXSLZzqF0eGXzoYQ2HtR9KC7obohWCcS0GQgvpiBKfMS0htMjeVEA8LLXiHW3tpqAGBWZHjJ3dtmLKQx70uSTgetNhLjFwJnG13zsPn1TaeauvHdS3gdzWb1p1e/nYPOuD/eC3xZGpp2MZqHphX1Pe1mBwKo8KcoRBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVB9p+GJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVB9p+GJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7441F000E9;
	Fri, 21 Aug 2026 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272061;
	bh=++70brCsGDpcWUSN9iDyol00VXp6Cn+MQxffyxJZ64I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVB9p+GJTojI/DWZQprp8bh7onvuKBb0MlfPt7b+iYfRdOOSNRqnG6EG2T8dtJvB4
	 AMF/+pokYDdLK9k26blspCw7tFL8xUlpMzV4kLsjouXNp9pz92gRNgL4U9eXKTFOrC
	 mbiEs41OZbVmFzvqHMgMYRfkFn00do11S7lxNgdC7xmNbDQu7Vy00cWWrlOI0eVTQl
	 ng9VFrmpq+NAno7piNIz5v2M+hgA6DFucZhzIFAEuba5asD52Qry9hv5qMW8GmNv4h
	 UlfBjbNbwjWXtH1Se+2x5MC3f7byn6VIK/GhRLVpsSfDVV/OKMO/X/FwnMGTNFtXqI
	 BAKQ3iK3SP7cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821001819.162277-3-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
 <20260821001819.162277-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 00:27:40 +0000
Message-Id: <20260821002741.4B7441F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821001819.1622=
77-1-thomas.falcon@intel.com?part=3D2

