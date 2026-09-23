Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3C5349D0
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180011; cv=none; b=dV12VYmGct84zPspfltoVuuvyrMM0wQUSnS0MwI0YysE/yweFRCnoxB5XVtKiq6yit7qWSSffMa+WoL2lpZs6KLX32nknSl5VydyIsXvzyrnnvESxzR5zGGTojH+eDObiCY5FLSz+fvhfJHFtNHW0tZCSRKfbq/bLcjHlf1ZBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180011; c=relaxed/simple;
	bh=AwYhi8eGUPFGjrlKR2QghL9tF4eEQ5fBdLNB6CE4mbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+HYL7YiU9gM0yR/ESqWspHd+rq0iF/HNU0u/7spaIhsrgb3RcyRkSdD0K/P2s5pVaOxp2f8QvOl1Y9fem+uDWnKopZxiSu7vkh3Eq8+xCQ9b6KYNz0J79hCkjR9PYx2r8LTgq8yjmglXa0HvQlEpCdhUahUMl//1EeJ0hoo4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acYjYzK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acYjYzK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FFF1F000FF;
	Wed, 23 Sep 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790180010;
	bh=YwEp47GJ1pTrBLLfoRag/7ePtnBxvUISZ1ycewem6ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=acYjYzK0HvhD1aQEuDtXevv6krxiCPYN4jIeETGMNMEMb6GE5JbvReaqW4zJIcKHU
	 l2KszDoS01CWp7FW2NtVkcAaiKavRAqzjdKfGJr10F+9AsASY8TgLdPUK4TUmF/cBE
	 tFrN/VUxe99glB6xuKe2frVPN1llth5TLVmHgWjazyDaziP7RGHuaO4JqTYBtGWfLR
	 oqhL7Y3Eu0k6Im3AJWUwQzWdyQk2TYl6A66Q2RG62BSesnIqmLrBBFF0Vu/KLWMNAv
	 D5hy02DvKDN65Udcg0nF3d7W0QXoEZcpA054OgzEvhvi030N8o3vXYCzrHsYGmvSpy
	 RNQK1vpkWQw3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923155703.34814-3-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
 <20260923155703.34814-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:13:29 +0000
Message-Id: <20260923161330.21FFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: L0 cache hits are silently dropped in perf c2c statistics
--

commit f3eb05aaf438922225a25a217c33e99b8e7d269e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

    perf mem: Add support for printing PERF_MEM_LVLNUM_L0
   =20
    Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
   =20
    The L0 cache is newly added a small piece of cache which is
    the closest, lowest-latency memory cache tied directly to the
    execution pipeline.
   =20
    The table "Table 9-4. Data Source Field Encodings for Panther
    Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
    "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
    Auxiliary Field Layout"[1] indicates the code "01H" means the
    "L0 Hit - Minimal latency core cache hit. This request was
    satisfied by the L0 data cache."

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4e490f9cd3488..4fd48fd200552 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -391,6 +391,7 @@ static const char * const mem_lvlnum[] =3D {
>  	[PERF_MEM_LVLNUM_L4] =3D "L4",
>  	[PERF_MEM_LVLNUM_L2_MHB] =3D "L2 MHB",
>  	[PERF_MEM_LVLNUM_MSC] =3D "Memory-side Cache",
> +	[PERF_MEM_LVLNUM_L0] =3D "L0",

[Severity: Medium]
This is a pre-existing issue, but does sort__lvl_cmp() in tools/perf/util/s=
ort.c
incorrectly merge histogram entries for L0 cache hits with other unmatched =
cache
hierarchies?

Because sort__lvl_cmp() exclusively compares the deprecated mem_lvl bitmask
when determining the sort order:

	return (int64_t)(data_src_r.mem_lvl - data_src_l.mem_lvl);

Since PERF_MEM_LVLNUM_L0 and other new levels are only defined in mem_lvl_n=
um,
their mem_lvl evaluates to 0. This causes them to be incorrectly grouped
together with other unrecognized hierarchies like CXL or PMEM in perf repor=
t.

[Severity: Medium]
Will L0 cache hits be silently dropped in perf c2c statistics since they are
not accounted for in c2c_decode_stats() in tools/perf/util/mem-events.c?

c2c_decode_stats() populates c2c_stats by checking the deprecated mem_lvl
bitmask:

			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
			if (lvl & P(LVL, L2)) {

Since PERF_MEM_LVLNUM_L0 is encoded in the new mem_lvl_num field, L0 cache
hits will bypass these cache depth checks entirely. In addition, the c2c_st=
ats
structure lacks an ld_l0hit counter to track them.

>  	[PERF_MEM_LVLNUM_UNC] =3D "Uncached",
>  	[PERF_MEM_LVLNUM_CXL] =3D "CXL",
>  	[PERF_MEM_LVLNUM_IO] =3D "I/O",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923155703.3481=
4-1-thomas.falcon@intel.com?part=3D2
