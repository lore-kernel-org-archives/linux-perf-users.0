Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969F3002A0
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113395; cv=none; b=OxEvcJ64+FLn6gljhkmWD4zwKLtzuHly5b4htOBWAsxjfhO3CVzwA2bPXfyA+L0tyYiHZkHd4sHKLYNfRKjo2m1QXphIEEd3jv1krVpOhBM61K95BxSx2gh1RIhAdatRkJSwGckpBnr1J3cWe9g/XBlHDMCmJpY/yLTgTipayw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113395; c=relaxed/simple;
	bh=SVJnzqrfqe6tpnNeAHW2A9HHOf1H8gin59l3ndisO2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpjtQS7i70h8Y1mKZuYp9a6sKkn1xGJCSOVD+Up0JdOGBN2SuaKwr6lJpFToshryYdvReI7wtI06YxDOuQxfQseBv19FHqSx99Tl52Ry0oM4v+BZQ1hbiHbcGHXThO+cqtAQlEoaGzVa7buOyjFeNDauIgGucvGiXDVu+l88A5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=W0JaZZB0; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="W0JaZZB0"
Message-ID: <60dfd32837f9d1752fb96a35d8ce1d08c89e5d5d.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790113369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVJnzqrfqe6tpnNeAHW2A9HHOf1H8gin59l3ndisO2s=;
	b=W0JaZZB0LWLOIZl2xXLxxh4Vxs8ESsJsyYz57wYj1jkXMj0I1CENqxV6xFY+s6Bh5e35G1
	k9WjTXve3z08zaLWuUBGjNru2Kn7Ne7WVFUWQ7MQo94IQ0xakcGdXOb/ZnYzvNccpUovqj
	khQTfMv2hpuYcXjwVO6Gm1DWUBCDtpo=
Subject: Re: [RFC PATCH v2 2/3] sparc64: Support PERF_SAMPLE_REGS_USER and
 PERF_SAMPLE_STACK_USER
From: Stian Halseth <stian@itx.no>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Date: Tue, 22 Sep 2026 23:42:48 +0200
In-Reply-To: <20260922203330.F2EEF1F000FF@smtp.kernel.org>
References: <20260922201507.1719668-1-stian@itx.no>
	 <20260922201507.1719668-3-stian@itx.no>
	 <20260922203330.F2EEF1F000FF@smtp.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-h1G8m4YK3/m3z6uxca5o"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-h1G8m4YK3/m3z6uxca5o
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


On Tue, 2026-09-22 at 20:33 +0000, sashiko-bot@kernel.org wrote:
>=20
> [Severity: High]
> Since %g0 is hardwired to zero on the SPARC architecture, the trap
> entry
> code does not save it into the PT_V9_G0 slot (u_regs[0]) of the
> pt_regs
> structure on the kernel stack.
>=20
> When an unprivileged user configures a perf event to sample
> PERF_SAMPLE_REGS_USER or PERF_SAMPLE_REGS_INTR and requests the %g0
> register (where idx=3D0), does returning regs->u_regs[0] here expose
> uninitialized kernel stack memory to userspace per sample?
>=20

Yeah, that is probably valid for trap taken in the kernel...

I checked the implementation for mips and longaarch, and I will drop
%g0 from the ABI, and put PC in its slot instead.=20

Putting that into a v3 later.


> [Severity: Medium]
> For PERF_REG_SPARC_O6 (%sp), returning the raw register means the
> stack
> pointer remains biased by 2047 bytes on SPARC64.
>=20
> While the commit message notes this biased address is expected by
> consumers, when perf_output_sample_ustack() attempts to copy the
> stack, it
> will start 2047 bytes below the actual mapped stack frame.
>=20
> Could this high probability (~25% for 8KB pages) of starting in an
> unmapped
> page cause __copy_from_user_inatomic() to immediately fault and abort
> the
> copy? Would this result in a 0-byte dynamic stack dump even for
> perfectly
> valid stack frames, breaking userspace DWARF unwinding and profiling
> tools?

I was thinking about setting up some real world tests to see if this is
valid/producable, but I think I will instead go back on my first
statement in v1, and start the dump at the stack's actual address: %o0
+ 2047 for a 64-bit stack.=A0

Unless I'm missing something, that should clear this concern.

Then the tools and elfutils patches take their dump base from there.
There aren't really any other consumers anyway, so changing this now,
rather than later, is probably a good idea.

I will wait for some more feedback, and starting preparing a v3
tomorrow.

--=20
Best regards
Stian Halseth

--=-h1G8m4YK3/m3z6uxca5o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarL2WAAKCRDoeAEuJe36
VjN5AQCYQ/qkS+NpHKO+6WEEoZYqir3tfnwFJjV0LuL1/CegnQD9Fq5hYK+wPv+6
xPb9yH7nX6Hh0JrUD/IV2rm1vncb3gE=
=jfrk
-----END PGP SIGNATURE-----

--=-h1G8m4YK3/m3z6uxca5o--
