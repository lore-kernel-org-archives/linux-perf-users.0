Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41059563FDC
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195353; cv=none; b=qFSl2JcWMSj09dVVtnZ+Fi5Z15ECfLi7A4ghJyMT/d36JkM4AOUW8P9Ww4b7cz5NiQ8bCnAG78VajhFkREw8sOp7+KoeSAbiTwbQcqSmI6o3Im9HPY2B6mcDfqNBtIazoFf9WDVxEqyZ/7UVgD+ivDcC4k2X4TBLn6UK8hBAbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195353; c=relaxed/simple;
	bh=LeHU+QcLkX58wYi7uUJFTAA3SeAQ6azfIAfxbZiIxN8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFn63BKekfDx3IbQjAZEALh3O4RukxfApLMZ+4UUmA+v5ChYPCeVVz0pEP2GxnCRuvewINHeehhYm4LSxRIm9lDLiJNWEl75XvrjMgV5T1ZqgvhB1ch7GMvAW4vICEl9ZYdha5yE+ByD8OWGASR08inSHMlqM8PS5jSjMHg6oC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=JS6vFPO6; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="JS6vFPO6"
Message-ID: <7d5c0a2bef048b885e389f53baecd3c083df9b26.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790195344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjebXxHkHwUddxe5/kny3lYVYUu8/+gFMil7Jt0h2Xw=;
	b=JS6vFPO6FG6hMK7v1rb6HL1N6OUlLBhFDydZ8WdwijW3/DIE5eT6NNsVLIqsydpKXPKMdd
	KRJh8gcBPqc2jMl0cbjTZOxV7d/u4r5iC0brfhbepmytZdFynqZxYrXu0Y1Tdk1ob+3mKi
	v4Gq1erix07gr4GJN68GKJLkTh2dFH0=
Subject: Re: [PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit
 task
From: Stian Halseth <stian@itx.no>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Date: Wed, 23 Sep 2026 22:29:03 +0200
In-Reply-To: <20260923194534.C89B71F000FF@smtp.kernel.org>
References: <20260923193432.2489729-1-stian@itx.no>
	 <20260923194534.C89B71F000FF@smtp.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EU8IBZY/+Dctp7TuhtJq"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EU8IBZY/+Dctp7TuhtJq
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-23 at 19:45 +0000, sashiko-bot@kernel.org wrote:
>=20
> [Severity: Low]
> Does this bitwise logic truncate the offset to a 4-byte boundary?

Yes, it does, but only for an address that isn't 4-byte aligned, and I
don't think that can happen here.

libdw only uses memory_read() to restore registers, and the save slots
are always word-aligned on a 32-bit ABI.

In theory, a malformed CFI could ask for one, though. But if that were
the case, the read would stay inside the stack dump, and the unwind
would be wrong either way. On a strict-alignment machine like sparc,
the native reads would trap on such an address as well.

I'd rather avoid adding handling for a case that shouldn't occur, butif pre=
ferred, I can make the swapped case refuse an unaligned read=A0
instead of returning the aligned word.
>=20
> If a DWARF CFI expression requests a stack read at an unaligned
> address
> during cross-endian unwinding, the calculation discards the unaligned
> bits.
>=20
> While register unwinding typically targets 4-byte aligned addresses
> on
> 32-bit architectures, could a malformed or custom ELF with non-
> standard
> CFI trigger an unaligned read? If so, would this extract the wrong
> bytes
> instead of the requested data, potentially corrupting the unwind
> results?
>=20
> > +	return bswap_32(u.val32[(offset & 4) / 4]);
> > +}
>=20

--=-EU8IBZY/+Dctp7TuhtJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarQ2jwAKCRDoeAEuJe36
VjONAQDbNO2KBcnr9v/TzSBBVGexZpRF/Jmu89yCI8+w5qOKyQEAqpmb8MQUpeOR
7Ivb72CuITYUsjfjB8oSyvuPDdpc6gA=
=q1FC
-----END PGP SIGNATURE-----

--=-EU8IBZY/+Dctp7TuhtJq--
