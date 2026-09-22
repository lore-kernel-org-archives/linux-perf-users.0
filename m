Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0E541453
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080548; cv=none; b=e1yq3tBHKCMkURK0cmU3dl7Aru8lJDKOTCqyV/P76rjC6Yiolm8fJrB+UsC0kmRNW7DHFkrt3PPWIm6iutrx8J7ksZFTK81Jc2/IcfImLDxm3It1md2GKQd+LSxyZ9WDmexnoV7StSisQaZTgx03No1mRlG77RJLswPxdkdJ5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080548; c=relaxed/simple;
	bh=u7LAD1ITKRqwLJjEt33ICJwq7fBJ8eZWlav8ArFGFB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pBtcYCu3+UT0d0QW1iS6D26lmx0eGXq9z9bY0pciHWm1TtIekZuPrXRDmgEVzivrUE0WIrvo4j4RecJlqXO5NGu4un+3GLpbcDVU5Y2rNUUh7YR6rPH9tkcBG6hxRRUgTxTBExFoBRvudfRCGRXaODAqbWSdrTm4zX5SFiqtJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VroHYaqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VroHYaqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006731F00893;
	Tue, 22 Sep 2026 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080547;
	bh=XwA34wpdkTfNLOhRw3WbRz7aSd2iLy8wOe9Q5ZywEiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VroHYaqDD/O6BmfD+pZl5E9FJdPJqOprLPzSdvGQlosLRBRxAqx7Ey+rptk4Axuti
	 YpTHQAqg4ety42d8ykF+eVUlI7UpJK2AfUkAPsu0Oe+iT3fAKXQw0KB9+xqV1dpxPc
	 56bhwGDnMxhqYJusTwmpvTPgMX1X+DYmMzuzmqbPuNj2wltBSSqOuP0+Hmje7AXjI3
	 GIq8qrZ+JmKyC/o7mI8VJ5Dee1mv4Io+9LXSXymuu7CD9wSqUnrd5BWLwZH5eHa8gK
	 kGLu14HpxufUSP9vZtjPuq1hGY5341dNbBVsCxdN5SgY4r2KCjoP4mSLskB9I5G/fn
	 q4p3wNH7VBgAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] perf dwarf-aux: Add die_same_file() and
 die_get_type_die()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-3-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:35:46 +0000
Message-Id: <20260922123547.006731F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D2

