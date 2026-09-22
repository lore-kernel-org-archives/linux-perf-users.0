Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0D5437F1
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080648; cv=none; b=mgYnsL3fn8wk0Q7c2p4JYYzNlI7xpDAS4dSkk9vlXUhZ23fLMsoA0+rv4EOYHcSHptsSXBUICPiT8UhArjK8bdjTGwFuUVuC88sjNTlEFbfqK4qdHJTR0tG+P9i8Ze/sqRGAv0kIyZP+U0ZXWS9FZgwrYdg3pgXTiTZwq0C/oJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080648; c=relaxed/simple;
	bh=7X3g9ELTyPSiCB8AEAniYOX04CjOBuZPBUKhD3vI/gU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NpjtnRiUAomvdrn0UTSUhyPcDgq7eiSpFQ14q3vYEgTaHStY7UI3/pgQVriiZaOjfs8W/3pbBn5TiF9DU+K+6cKO1fPXiuenQYdKNXKwQ69ctNYzbucyfFDY9P6iV1qorFCz84xvF7cobOa1U1gAgAMpEPVH4BtFVR++j5+dGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO7aSKM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO7aSKM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C7A1F000FF;
	Tue, 22 Sep 2026 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080643;
	bh=7X3g9ELTyPSiCB8AEAniYOX04CjOBuZPBUKhD3vI/gU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YO7aSKM7lvfIc5FysMPIbg3qI4BS4CnQ/jRYLrj0Dlr/gYcLyxtDPjQWS1asiDvVb
	 Jbdhyy1tzBumH8VSh3TDFTFPD3gtwHWpwdsDuuCDJMtOtugesQ1+wpvKVq5x4IOmfn
	 Ydl3BUhntZYHOzvpkwUoWADMXThwYCX7zNSO1Hp8Y4y74iEvr2JaKXDRMC7SrCp5OL
	 AVlPd82QYmM3Vq/6CGnK1kzn5oWN/Qbi8wZ4qX6pPDU92o8aS1SAEx5BOYWWb8qM+w
	 pHPhgvbuu965I/TgZuPumOHjP9OT/Mek2d4bVyJfkB5k0j12L26diWOTzBtPjZ6k2X
	 ERsG6cmwTsvmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] perf dwarf-aux: Bound the type chases for broken
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-2-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:37:23 +0000
Message-Id: <20260922123723.93C7A1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D1

