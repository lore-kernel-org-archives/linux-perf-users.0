Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72B4503E2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156569; cv=none; b=CJodQlRmW12XW8a7QwftKho+7miogFrRFZ+CCkwKfd+cxcHbGa08+0FXZCtEuE5LsFrkVT3NelLhf3IzGanb5/LNqWq/IFHeCL9C5+6M4mwCRKwlRAVjs7exOcTmdtdXxXG7TC6WRpOBcjzLEGq6ll4VpsNr2E0pIF5dob7J5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156569; c=relaxed/simple;
	bh=h2mGUpsgv2+CWVzlz3iAaexQFZh4bfUl7EV6WSKYd0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2sx4rvkpXmI33jiquQ7dA3XznOMWs1APhDf6HX8GhrsnZR5WJnPa44SdyO4dvlihnwx9PTY66ixwiARDo2U8nCuRO1A3kQganjxRYtI20E2UT15KoYaiK04ZyrOhym8Ecq5f0/N4IVJqY98sZXaI0v/m23CaRGT5MOQhVfvKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=G1XxhlSb; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="G1XxhlSb"
Message-ID: <32d5f620550bab0cffdeac83147ca0a28c9834ed.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790156565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z83FZz+vsETiPuchGYy0s/NEaJc+ExUS/kAxHQlibCc=;
	b=G1XxhlSb3/feE+cXr4Z/If/pelSJSgn6PQ5HnbjX+Z669NNR5IKT0r6HH3j25UxKX8yWMQ
	3YyPxzhM1TjECQJHbqa0EkGqPEekT23hFhm9ShJRFjGGJI+LRZzrGE5NtH9ukGx0HG88+g
	exTyJXGnlxFCkPuWuAq1Keu5SQ+EIAQ=
Subject: Re: [RFC PATCH v3 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
From: Stian Halseth <stian@itx.no>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Date: Wed, 23 Sep 2026 11:42:43 +0200
In-Reply-To: <20260923091443.2C7971F000FF@smtp.kernel.org>
References: <20260923090429.2026529-1-stian@itx.no>
	 <20260923090429.2026529-4-stian@itx.no>
	 <20260923091443.2C7971F000FF@smtp.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-nhOq8YYmPHFMCO89yIRi"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-nhOq8YYmPHFMCO89yIRi
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-23 at 09:14 +0000, sashiko-bot@kernel.org wrote:
>=20
> > +	case PERF_REG_SPARC_Y:
> > +		return "y";
> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	return NULL;
>=20
> [Severity: Low]
> Does this rely on implicit header inclusion for NULL?
>=20
> The NULL macro is used here, but neither <stddef.h> nor <stdlib.h> is
> explicitly included in this file. It appears to rely on the implicit
> inclusion
> of <stdlib.h> via the ../../arch/sparc/include/perf_regs.h header.
>=20
> Should this explicitly include <stddef.h> or <stdlib.h>?

My take is: No.

perf_regs.h includes <stdlib.h>

It's done like this to maintain consistency with perf_regs_arm.c,
perf_regs_mips.c and perf_regs_loongarch.c.



> > +/*
> > + * The sampled window's %l and %i registers (DWARF 16-31) are not
> > in the
> > + * sample; the kernel flushed them to the register save area at
> > the start
> > + * of the dumped stack.
> > + */
> > +static void libdw_set_sparc_window_registers(struct unwind_info
> > *ui,
> > +					=A0=A0=A0=A0 struct regs_dump
> > *user_regs,
> > +					=A0=A0=A0=A0 Dwarf_Word
> > *dwarf_regs)
> > +{
> > +	struct stack_dump *stack =3D &ui->sample->user_stack;
> > +	u64 sp;
> > +
> > +	if (perf_reg_value(&sp, user_regs, perf_arch_reg_sp(ui-
> > >e_machine)))
> > +		return;
> > +	if (!(sp & 1) || 16 * sizeof(u64) > stack->size)
> > +		return;
> > +
> > +	memcpy(&dwarf_regs[16], stack->data, 16 * sizeof(u64));
>=20
> [Severity: Medium]
> When analyzing a SPARC perf.data file on a little-endian host, will
> this
> memcpy() write raw big-endian bytes into the little-endian host
> variables?
>=20
> The dwarf_regs array is composed of Dwarf_Word (uint64_t) elements
> and expects
> values in host endianness, while the stack dump (stack->data) retains
> the
> target's original memory layout and endianness (SPARC is strictly
> big-endian).
>=20
> This can cause the 64-bit integer values read by libdw to be byte-
> swapped,
> breaking cross-architecture DWARF unwinding for SPARC as the stack
> unwinder
> relies on %i6 and %i7 (DWARF registers 30 and 31) to find the
> caller's frame.
>=20
> Should this code perform conditional byte-swapping when copying from
> the stack
> dump?

No.

Checked by analyzing a sparc64 perf.data on x86 with this series.

unwinds leaf -> mid2 -> mid1 -> main -> __libc_start_main -> _start,
the same as on the SPARC T4.

The dump of a 64-bit sparc stack starts at %sp + 2047. It's 16-byte
aligned, so each saved register is one swap unit and is already in host
order.



--=-nhOq8YYmPHFMCO89yIRi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarOfEwAKCRDoeAEuJe36
VlZBAP49sB3o8Yi6j6hB2aH6+3qMxVnXI/CGhNE31L92CWiGpgD/cUDPoG5DvOyW
+/kG0NIiCB6fd6+NiCtCccaDqI2SAgg=
=OKd8
-----END PGP SIGNATURE-----

--=-nhOq8YYmPHFMCO89yIRi--
