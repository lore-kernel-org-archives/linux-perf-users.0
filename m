Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE24FE2F4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661343; cv=none; b=r1nncsiie/gh8ZIkXPofoMCI8gzuK8lspXYj0caOCheiPht/N+bbfRlRcSQwnseTINkhFiZ3dsnzges/FLrai7DtzuyECIS1oVcvcNqA7xpVuwvqaXawgJIADuXNTSNYHA6jWGxaeJ9/a5pzwEmg2djKSVPcjZoMq4ibtrIpg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661343; c=relaxed/simple;
	bh=6k6pUBjUbtRPPHhLFIkq7pyvf5SDSAP2JkX27mx2Pmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nyxuqysBC5DbQEmj4BcKQprFzHKh8bg95wulGkupOV3memO2YpwYBNw6hsYhFF0TJlIttv9ul1MmJ4vaIU9A2aInfFOZtF3Tr6niqW6cwHT5dtnFCRf5e8tCeUj91VINkx9ftb6/wWBx+0taSRdaPWQuW4xHNnyMKRghNFg6zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdBAxqok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdBAxqok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021151F00898;
	Thu, 17 Sep 2026 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661342;
	bh=LPvedsh6z+cMkYxvrHWV0OcZXATuHbS+FfVlDo315Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NdBAxqok/3uv3N5PfEAz/1HFVdOOeZ8SyoIB63HLTITZXEC78LVPwbiZ3d+Z3OCEH
	 K6o5nUNCJt+2evaairws27mTtgnuwsN5pqxCH7gI9IYp4QMzo1tktKNMnFGSrZ9U7Y
	 ibWIHSIJ818/Jk2WF4nIuIGYnttB9AXnE8F/QM9qfzih3Is1DDlcZZVUVg96W94XTN
	 rzRxdrQR3Ko5vvUl1F9mOikk4i0XxW/tt8Q8rKWFETil8CflQ6D3vd7ZIHbgWkAm+z
	 TOftNtrzvCSLZZyqdHrJyLlpbdvH5/YjY24Z0gO/bHI7ibDOZT8TYwDgHAtnqDDiKd
	 ftL+Q7sJjSctQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] perf dwarf-aux: Add die_same_file() and
 die_get_type_die()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-12-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:09:01 +0000
Message-Id: <20260917160902.021151F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dwarf_dieoffset() is relative to the file the DIE is in, so an offset
> saved by die_collect_vars()/die_collect_global_vars() is only
> meaningful in that file: add die_same_file(), comparing the Dwarf each
> DIE's CU belongs to, to record which file that is, and
> die_get_type_die() to resolve the offset in it, with the saved tag as a
> sanity check.  Resolving the offset in the main file instead parses
> whatever is at it when it came from the dwz common file.
>=20
> dwarf_cu_getdwarf() is new in elfutils 0.160, so the libdw feature test
> probes for it and Makefile.config says 0.160.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D11

