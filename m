Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784783148BF
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850909; cv=none; b=YjrTrrr8BG+sMo46jqtyFL16UOMHrl1YTGVb/0P23i/xHYVxpeRQVDW+2gq/7tr/03guBUHZ2uguVUtgdzr0lh2AvLjLvImrff0PZWaemdXM7BOKDprd3aZHy4gXOK2ZYcRzcu39gglqnaSi3IicpVZf554IH+wKnFJEfTrRe0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850909; c=relaxed/simple;
	bh=lawEfptOHt0IZW+B9AC4wqL4pYYJB19oGld+QU+0L5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QdhwxPXvhZ3arQuYz02jZnYgX4ejhF1sDKTz2MiODPpwIq4x+TBr6kvRN5vFaZVRSHMo9lSSP5R20ey9c7AMir6T4iCqVYFF5IkT7skv6qpvk48XVWhhJSRZVoT4I4Xd1WsJGKgBa4N0ZruOSwHcw7zR05TyedC2unX1Im3QYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkI0Bj+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkI0Bj+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2731F000FF;
	Sat, 19 Sep 2026 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850908;
	bh=lawEfptOHt0IZW+B9AC4wqL4pYYJB19oGld+QU+0L5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkI0Bj+P07szq8xNhiPJGqOGgCRmi/v0/dI9zK8bjrzrMwfI57cLGcKj4rxhJ1ZFH
	 SW8FFyf6OAXqBoaj2GK16jvXK9C9b1Ljbm4v2+mBl/eeVzQu4ZbiLjM/ifTdgRgenc
	 4y6FpSzjclErDgoKdXJeKEa6siXWS8S/ozS7BFaOaK5d3plgTXobcOHkd2FvA33ZhU
	 qt/VgVPyvV/Qqk1dobccRtmuv3qZddVJ1UN4HhRcZ/dv72H8hXyCtgWf72+ysAg5TH
	 zU4cwWfDuJe+x+8JDfxE+KJEFutb2x7yV705/KSnQWujbDbdGzGluqe4VTohhlWryE
	 6qAORAys8ItqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-4-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:48:27 +0000
Message-Id: <20260919204828.3E2731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 'perf report -s type' hangs, burning all of a CPU with no output, when
> resolving a hist entry on the dwz compressed debug info of libz.so.1
> (zlib-ng): die_collect_vars() saves the dwarf_dieoffset() of the type
> DIE, which is relative to the file it lives in - the dwz alt file for
> the types shared by more than one CU - and update_var_state() resolves
> that offset in the main debug file, where it parses whatever is at that
> offset, here a typedef whose DW_AT_type refers to itself, making the
> type chase spin forever.
>=20
> Record whether the type DIE came from the alt file and resolve the
> offset with die_get_type_die() in that file, with no fallback:
> resolving an alt file offset in the main file is exactly the misparse
> above.
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D3

