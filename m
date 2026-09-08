Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D5550DA9
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873407; cv=none; b=BVJN2Hrft1XsVZMksShxl2Bd6mbRaCum5xcyFkCIT2U5E7jRokBsYXnPdaNeVqpY1HcTTgY3Rcb4L97uWLdbsZmjpmVAiD3ObgVOMLuiMn6jGB7s4jJUQl0odc8vdc0H0e/RYUE8B9cLYnup98bBWgvvk5gVUJFdFbg7OSXH9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873407; c=relaxed/simple;
	bh=wvEedzIsuLFybhXZ4uqXVx+a/3t8M5OdhIhHjY3JReQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2A/bVBAlcGrN3/hAoXkpgyLBGaUB55PYt3DfTRkHEOQ75gmDW4J4mb14L60oq4jpU2TT3/h3PnsVp79PjwLvs/9DJ9HqxnIAK6BWU7gP85sTQRAfse7/PM3WFJdd1CxkM0fbdQcTTOvLoTKry0K3KWs/rjDvEZ+Yls8Nzhx5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZXXC8BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZXXC8BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5661F00A3A;
	Tue,  8 Sep 2026 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873403;
	bh=78gmdpjTRMqSihqgedWWA2UjP8b8E/N1DABW13KFfEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZXXC8BQPtG0EZAbK5iQFsqrjHiaFa+03326c89zncgWrWgfyddXGDaWZXi1deZdC
	 csp+LtbUBQ4bMX1Ll7uvPONQO9/iImSXTkrWQf92vuWKqshAca52FnVPqFmTWn8d4+
	 RHlDtGJoO+vC/hmSTM0XZZsUlEAkNcWbl1R1wMFT3jBD83o65t1APZ7paHRwgPxkhW
	 6t1MXkplokzZ0wgxQLpHPbWsKZoA4BAFsvtKVXhZgz9duGaJ25KcOqYg9J0RJhPJAy
	 cg83s/xKFSBhpaT/LlMq3BjSxygtoQrsQ/Lr5gjyfrazqFoJun0RS+3mCMrCxZuXtT
	 tcc6aevQUrPEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/26] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <aca3c51ca091bdf0c4b49b0721fbbf78a05abcf1.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <aca3c51ca091bdf0c4b49b0721fbbf78a05abcf1.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:16:43 +0000
Message-Id: <20260908131643.AB5661F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The operands of 'adrp' instructions parsed by libllvm are currently
> represented as raw immediates rather than the "address <symbol+offset>"
> format used by objdump. This inconsistency causes arm64_mov__parse()
> to fail when parsing these instructions during post-processing.
>=20
> Example of the mismatch:
>   Current: adrp  x18, 8014
>   Objdump: adrp  x18, ffff800081f5f000 <this_cpu_vector>
>=20
> Fix this by manually extracting the target address from the raw adrp
> instruction via symbol_lookup_callback(). The address is then converted
> to a specific symbol during symbol__disassemble_llvm() and formatted
> to match objdump's output, ensuring compatibility with existing
> parsers.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D2

