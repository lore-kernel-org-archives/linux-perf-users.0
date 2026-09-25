Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FB4BD34B
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349119; cv=none; b=pUioyljPT1ZzcU9pmMusaXNAhbwDDtwsyLy02Za3wegsxGUCLobuZSguePNyhiqNxi3+eCbvgzAg4PeVquVOEPWLhOIHsAQSXKTCQjsZ1ZjV6Z/DXvcwthyIBMjSTg/3myinS/nye4zKV2Ga2qiQ/BjD4aMxCHA8Ph0iAY0vCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349119; c=relaxed/simple;
	bh=gWVBky2VSNhj5twBKyl5AcM46dVP7A7h8IvZ6Uky2L8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZD0D2PbQFM7IDV8rv8kT9zIn3+p9QFhT4lpJ5ZRYopoBIyITX+nV7hEQEGIqb5MxbQ6IAydnCEfXXWCS0Fcw1D0BF6VU5/VcUG9OXhBHZQBcB80ccV03i1WxvLd3kfjaHCijLm2+TVm1SWtkn38VJb2HEh1TE6ZcpKBGIpkjvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVavG9ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVavG9ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D40B1F000FF;
	Fri, 25 Sep 2026 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349105;
	bh=gWVBky2VSNhj5twBKyl5AcM46dVP7A7h8IvZ6Uky2L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVavG9ja5f04NiWfxqgOz0XlPnJyuoPTMweB54/rS1cF116rGrOnQGVbXpqIHw5I1
	 apQDIxvjCTJQKXprX0fsEFQKsKhAqnfBxeypNgKXYnkU0bmZcTiRWLSFpyxpRAF4Il
	 6zn2FdaqsOP6wzVgSrUOJy5MujJBbRy+fiWGBznsgpOBcnlN8g5PRq9AyHq8Y+Oqiu
	 UY6RFZ223WV0em3fl7+WLKZuqKX8X8KryD7XYg3QTTSuh46mn91HBOtoRUNe6saviA
	 7zEtGfZX0EuLdwzEIu+lLr27vnTToDVnSIf80QC+2BQtRoNXpM/dacxh+hPSYlLu3S
	 ErCrancQIsFKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925150657.1826942-4-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:11:44 +0000
Message-Id: <20260925151145.0D40B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 'perf report -s type' hangs burning CPU on the dwz compressed debug
> info of libz.so.1 (zlib-ng): die_collect_vars() saves the
> dwarf_dieoffset() of the type DIE, which is relative to the file it
> lives in - the dwz alt file for the types shared by more than one CU -
> and update_var_state() resolves that offset in the main debug file,
> parsing whatever is at it, here a typedef whose DW_AT_type refers to
> itself.
>=20
> Record whether the type DIE came from the alt file and resolve the
> offset with die_get_type_die() in that file, with no fallback.
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925150657.1826=
942-1-acme@kernel.org?part=3D3

