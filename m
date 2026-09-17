Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFD4E3239
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661014; cv=none; b=VYVhPztYoZM4ZUJc2fAVwG0DOBN0a+BoVK+lfa9ShIGtEVfhwUziAVDwTY/YOVn+qDiUPCCl5koB7LEbglJAgtLyZoAsJJ/vCWVxzWGrMznGp0x1IB7SseBlRJfDnAzV1GvueRYwdXu6tiWD54gpSPy1ppegslvAGWs5UJdoaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661014; c=relaxed/simple;
	bh=TrlLE0xtFxyhON5vldyEMQRY1Mo0y2inrxDCHfVK45s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iAe1MhlNBkd3hdajHlqr4BoP6/X6VmDa4vEleH6cxmVa18Hqcd/M5g8ds/Tjyx/BzopBOMPQ3tU/WTQ119rpoXxSNOJmlVHySWeKvd1vpo06OPuyKsXRCqYkmEeqa9+Y13qYlTI73cNlaBbBrBfKBCk60j9OQD5aMUiI4QH3MkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTqxtSY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTqxtSY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C031F00893;
	Thu, 17 Sep 2026 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661013;
	bh=TrlLE0xtFxyhON5vldyEMQRY1Mo0y2inrxDCHfVK45s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTqxtSY3Ew7R7r6hiFcrVn0xicN8jx6lARRx6CCOgBO+DvREOEMO3OFOkVMiD2TN8
	 dHwL/INmaIFOHjBqDS58sKgIiXpxCqd3VS16PJJoSquroZdQCNCANk7r4mBPL0Br2a
	 Ex1pgUYgS1bd/xlfWdLVNC7qMhtPshJED7zigRQ1mjVyb5AXjZdkrRsgG4ShcsPghv
	 fLrQh64wm4fg0K5oHJOB94Unz2hEZeerjGjqCKCtWQsqOsS7bDVPxZQ4r2xwHM/u3g
	 G+EpPDipjiOB/XCZBhAx8U+mnGc1g/HjcEbpU/E0lfai8MYnfC4gvDhRsU+iGLr72a
	 /FHe3OmrYMUZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] perf dwarf-aux: Bound the type chases for broken
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-11-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:03:32 +0000
Message-Id: <20260917160333.51C031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A DIE that is not what it looks like, e.g. one parsed at an offset that
> is not the start of a DIE, can have a DW_AT_type that refers back to
> itself, making the typedef/qualifier chases in die_get_real_type() and
> die_get_pointer_type() spin forever, and the same for the type name
> recursion in die_get_typename_from_type(); 'perf report -s type' did
> exactly that on the dwz compressed debug info of zlib-ng (libz.so.1).
>=20
> No sane chain of typedefs and qualifiers is 32 DIEs long, so give up on
> the type with a pr_debug instead of hanging.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D10

