Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB556B873
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192180; cv=none; b=SQi/OaI3jVOZusFnxonDj4Sta+1hcGMY8U+KE2vPxoGNk6bwMx2Urfng6MzP7e5qgz1v9Pm+1onq1AmahRuAcHV8AQkpZScMMwpuatNq+NnvFdaY4y7rwtFNwK4WrL/vtRKYZtA5L9tF9zXg1WVNHtheBSsQdlRTCrzNN/AuB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192180; c=relaxed/simple;
	bh=cHrpNAISABJiUCH8EvUKAt4XudYbTcgKkug47K6boSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7xCroM2+zUcH526Nx1dkVB0gqkUr3akMJ0TOW19xKq9z5Gz3KJwQMdXEiJ8SgKm9Sd0cygKfix6YaAy3rsbwd7Xvdf9lCoZyqwdnR1yIDW7LZ295nCIeMfX5QizXTuRqLAt4RK6dF7CMcvr93716M+Ov9/p+n6isu7we1Ve154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=fahVbuhC; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="fahVbuhC"
Message-ID: <8ae003e9352750a5c8c197fb3ce68f99a999d76c.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790192175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHrpNAISABJiUCH8EvUKAt4XudYbTcgKkug47K6boSg=;
	b=fahVbuhC3+p4C+jBcelLbr37T5AbHB8U2j1D9wwhh06vMKwJ4ph1FoyVOlRinpjX+7Q4xu
	pwqQvC9TWQ7xAZPddh81ivkJYnQ2QIN7Q7uezMLBzc52uow8eZoPXCwMvYTWEGWh0tJbWZ
	h3shjP64AaIRtu2L4mTR99DgbKHW+7c=
Subject: Re: [RFC PATCH v3 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
From: Stian Halseth <stian@itx.no>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Date: Wed, 23 Sep 2026 21:36:14 +0200
In-Reply-To: <CAP-5=fUuRm3dWra4a-6eNF3F=tafcHvvDipqmDEXN5+ti-sW0A@mail.gmail.com>
References: <20260923090429.2026529-1-stian@itx.no>
	 <20260923090429.2026529-4-stian@itx.no>
	 <20260923091443.2C7971F000FF@smtp.kernel.org>
	 <32d5f620550bab0cffdeac83147ca0a28c9834ed.camel@itx.no>
	 <CAP-5=fUuRm3dWra4a-6eNF3F=tafcHvvDipqmDEXN5+ti-sW0A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7qxWQ+EbtXocVbEaPnYF"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-7qxWQ+EbtXocVbEaPnYF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, 2026-09-23 at 09:02 -0700, Ian Rogers wrote:
>=20
>=20
> This is a low priority item we're trying to keep cleaned up, so no
> action is necessary. The issue is that musl libc doesn't transitively
> include what glibc does and we frequently break the musl build. Let's
> try to catch it at review time. It is also nice not to have
> transitive
> dependencies. But yeah, there's nothing wrong with what you've done
> and following the surrounding convention is the right thing to do.

Thanks for the explanation, makes sense.

> >=20
> >=20
> > No.
> >=20
> > Checked by analyzing a sparc64 perf.data on x86 with this series.
> >=20
> > unwinds leaf -> mid2 -> mid1 -> main -> __libc_start_main ->
> > _start,
> > the same as on the SPARC T4.
> >=20
> > The dump of a 64-bit sparc stack starts at %sp + 2047. It's 16-byte
> > aligned, so each saved register is one swap unit and is already in
> > host
> > order.
>=20
> Thanks for testing! In session.c the functions like
> perf_session__process_event will swap all 64-bit values by calling
> event_swap, for a sample every 64-bit value is swapped by
> perf_event__all64_swap:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n1202
>=20
> In libdw__get_entries the registers and then stack will find the
> 64-bit values swapped. I'm wondering if the case of 32-bit needs some
> fix up like with PERF_SAMPLE_CPU in __evsel__parse_sample:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n3527
>=20
> The PERF_SAMPLE_REGS_USER always samples a 64-bit value, so I think
> they are okay with a 64-bit bswap. For the PERF_SAMPLE_STACK_USER
> accessed in memory_read in unwind-libdw.c, I wonder the byte swap 64
> done in perf_event__all64_swap means we're off by 4 bytes with the
> value being loaded from the stack. I wonder about the code:

Yes, this is a real finding, and I ran into a related issue while doing
some 32-bit testing in a chroot on sparc64 earlier, even without a byte
swap.

memory_read() gives libdw 8 bytes, libdw keeps the low 32 bits for an
ELFCLASS32 target, and on big-endian that is the word at addr + 4.=A0

The chain stops at the first frame restored from the stack (and on
sparc an 8-byte load from an address that is only 4-byte aligned
traps).

I had parked the fix for that when I decided to focus on sparc64 only,
as there were already quite a few bits and pieces I wasn't sure about,
and I wanted some feedback before adding more.

But since you bring this up, I now have a patch for memory_read() that
handles both the native case and the cross-endian one, with the un-swap
you describe, picking the half that holds addr.=A0

It's tested with 32-bit sparc programs, natively on sparc64 and cross-
endian on x86.=A0

I sent it as a separate patch, since it's a generic fix, and would
appreciate it if you have time for a look:
[PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit task
https://lore.kernel.org/all/20260923193432.2489729-1-stian@itx.no/

I did several tests on this series + the separate patch. Test details
in the patch.

No pending changes to v3 so far, everything in the separate patch.

Thanks for the review!

Best regards
Stian

--=-7qxWQ+EbtXocVbEaPnYF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarQqLgAKCRDoeAEuJe36
VpPOAQC+ouZ7W+/xGFkg5dOMQYwUHqvBNiZroJFqZ41FMIKXKQD/UpwypZD4mtVf
oJVxP2lhS/qY5SBqgdLXIPu4VLX0cw8=
=fb0m
-----END PGP SIGNATURE-----

--=-7qxWQ+EbtXocVbEaPnYF--
