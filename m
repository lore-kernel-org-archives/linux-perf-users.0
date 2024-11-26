Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF142481DD
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732591605; cv=none; b=D6sJ9F9R4TmYxdIv9ss7DDL7VhLWuVYO9xFkVHJPb0TJ6ijGG67F1B4+2+rOHJG0tUKzRVPoUn57XnLzRAv6Agqkz9Kjy7S+eqmd6EwU0RFWmYo5WMj3VVjSofcpOwDwnzqSM0Vq0TNr2GVAabjJzxog/4LUVkGMdtYroQzFKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732591605; c=relaxed/simple;
	bh=dVMUXn76ohfBBbhjqD9ByYbaeA+5c+S+6qfcCPBCdk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tez/mr0elbQPXWk+sf/p/6qVvwxEDLL6QiOA1bfdEiRCEBGrPI0RMFfHdyhj2Ur8ITqdX67BwWEMdbMoyn/HtifO7bd0+wKpL9qrJYmEHS48smq4CJTtSC6MDu+CTC6V1yUzN01WfQ/SHQq15/fpM2moBMcUvwFoFTtV4hBhAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=AzOdN1UR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="AzOdN1UR"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Xy7KB4K6Pz9stw;
	Tue, 26 Nov 2024 04:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732591598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSkQekKwGT64+nYpv3/E6flOvU29B9jxT+OItYb9lrQ=;
	b=AzOdN1UROmPDxMeTjXpqxdqmMZLkm/fSsuWADPVCdrstv3TFud90g9YnJUpQmc77UkGoHG
	HhpYw8n/Oh364Bz5e+lqLVEvZXNxkLaWt0+6VT5f7af6sc0evvz6Zc66kjJeNLELyrd+ah
	YTnm7Vc7xXr3epamOEuONXw2NZUf5B3IdefOMV5d9KZeZ8Cn/qdhHjPF0mcvYXT+aw+URF
	bEBPyf8Ukl1aNqdVNR1FLIIoGVZDEYW9m/LcZD+4V3R8cnHc5kQTdiHtJ+qkVwoaoFKumb
	i2egOQnzU/vfuR+6peDyVwEHCGu6gSttJTPi2WGb5WqtXNuLmKp35dQBIrIZ2g==
Date: Mon, 25 Nov 2024 21:26:34 -0600
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Recent tarballs missing some files
Message-ID: <Z0U/6hbVcLv8mdV4@hyperscale.parallels>
References: <Z0S9HCQ0Z2d/I+Uh@hyperscale.parallels>
 <Z0UNRCRYKunbDYxP@hyperscale.parallels>
 <CA+JHD91LPXRadmVckNMSf-zMNuJsEO1_pk0JC57XdVQczadwgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ne5HjvDLCsfnLJT7"
Content-Disposition: inline
In-Reply-To: <CA+JHD91LPXRadmVckNMSf-zMNuJsEO1_pk0JC57XdVQczadwgA@mail.gmail.com>


--ne5HjvDLCsfnLJT7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Mon, Nov 25, 2024 at 10:50:49PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Nov 25, 2024, 8:50=E2=80=AFPM Michel Lind <michel@michel-slm.name=
> wrote:
>=20
> > On Mon, Nov 25, 2024 at 12:08:28PM -0600, Michel Lind wrote:
> > > Hello all,
> > >
> > > Per discussions with acme back at LPC, I'm working on packaging a
> > > standalone perf RPM, initially for the CentOS Hyperscale SIG and
> > > potentially for Fedora later on.
> > >
> > > I noticed that, while perf 6.9.0 builds fine from the source tarball,
> > > more recent versions (at least 6.11 and 6.12) fails due to a missing
> > > header:
> > >
> > > ```
> > > In file included from
> > /builddir/build/BUILD/perf-6.12.0/tools/include/uapi/linux/bpf_perf_eve=
nt.h:11,
> > >                  from libbpf.c:36:
> > >
> > /builddir/build/BUILD/perf-6.12.0/tools/include/uapi/asm/bpf_perf_event=
=2Eh:2:10:
> > fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such
> > file or directory
> > >     2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
> > >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > ```
> > >
> > > I can submit a patch to fix this (and any other missing files), if
> > > someone could point me to where the script is that generates the perf
> > > tarballs.
> > >
> > Update - on digging in this only happens on aarch64 (probably why this
> > was not caught earlier). And it also affects 6.9.0. In all cases the
> > alternatives are either copying in that one header *or* passing
> > NO_LIBBPF=3D1
> >
>=20
> Maybe the case of adding the missing file to:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/to=
ols/perf/MANIFEST
>=20
> Look at the other csets for explanation.
>=20
> You could also try building with the system 's libbpf, look at:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/Makefile.perf#n120
>

Thank you!

Building with the system libbpf might not be an option when building for
older Enterprise Linux releases, but I'll add that as an option in the
spec for new enough releases.

Best regards,

--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2

--ne5HjvDLCsfnLJT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ0U/5QAKCRCLIp0vfMwE
8r/cAQCHL/CI3tdh/tc4YPzKj7lBClYJyHI6gWIQDByh3I6aewEAkru+6tySlov1
ZunRT+/9dxkcXhGv/aHZYMs0MQ3cKQs=
=aa0D
-----END PGP SIGNATURE-----

--ne5HjvDLCsfnLJT7--
