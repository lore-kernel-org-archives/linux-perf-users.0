Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7201DED57;
	Wed,  7 Jan 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773298; cv=none; b=JZTZ/uIVf9ruSZcz11UirTV52yhistyVHdwKPfYx37ae6GZtep2SNiIf7tgE6B1mLJ0bG6Dixevrk5fLnBZ3bO0u1c8uL9O7I2gpo10/TxYdoTYQ7B1OTTPXX+rxsFiFUJ/5lC0iZc97d5RbUcba5SpHDrhlhXu72Xxw5myfqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773298; c=relaxed/simple;
	bh=5Gv9sTBQHNIcQ36RKg5wjy/ubB3ucZcxiQ4WZwryQEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdEBInNu86Fp6mewPLORI2AHSizUramyioZtKRPoYk/10dtLCk/h/1i5e5+EyfdhcG6U8OUbTo5iK8r3jtzmM/riEgpx5QaVodq5I4f6gYHU8SihP9M/obuac7bxwQveWDHO73zkrFU+QGvqwruQ7KWEr5+dPZ/XRiZ99Wav15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <nschier-oss@avm.de>)
	id 695e145d-bfa0-7f0000032729-7f0000018440-1
	for <multiple-recipients>; Wed, 07 Jan 2026 09:07:57 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  7 Jan 2026 09:07:57 +0100 (CET)
Date: Wed, 7 Jan 2026 09:07:56 +0100
From: Nicolas Schier <nschier-oss@avm.de>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Philipp Hahn <p.hahn@avm.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH] perf build: Raise minimum shellcheck version to 0.7.2
Message-ID: <20260107-transparent-ocelot-of-elevation-e7d336@l-nschier-aarch64>
References: <20260106-perf-raise-minimum-shellcheck-version-v1-1-b46739a78888@avm.de>
 <aV4NG14zGnZw1PTq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3L/GXjG8W+MnDvsB"
Content-Disposition: inline
In-Reply-To: <aV4NG14zGnZw1PTq@google.com>
Organization: AVM GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1767773277-6BE562AE-5888426F/0/0
X-purgate-type: clean
X-purgate-size: 2192
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--3L/GXjG8W+MnDvsB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 11:36:59PM -0800, Namhyung Kim wrote:
> On Tue, Jan 06, 2026 at 02:19:28PM +0100, Nicolas Schier wrote:
> > Raise the minimum shellcheck version for perf builds to 0.7.2, so that
> > systems with shellcheck versions below 0.7.2 will automatically skip the
> > shell script checking, even if NO_SHELLCHECK is unset.
> >=20
> > Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
> > paths"), shellcheck versions before 0.7.2 break the perf build with
> > several SC1090 [2] warnings due to its too strict dynamic source
> > handling [1].
>=20
> It'd be nice if you could copy the error message here.

Sure.  I'll send v2 with one of the messages included here.

> >=20
> > Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
> > Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
> > Link: https://www.shellcheck.net/wiki/SC1090
> > Signed-off-by: Nicolas Schier <n.schier@avm.de>
>=20
> Other than that,
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks.

Kind regards,
Nicolas

--3L/GXjG8W+MnDvsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmleFFEACgkQiMa8nIia
bbgiLA//aK6OXGOYuUihaA84GDJzvwtG/x5Aasnd/Syejs90duapI1CfYbBXgXtE
3HQTzZQfNLU+TGMQGcK/H/x1+I8bHL2QkrROpme7wS4h+hFe0nRMsytD/qmWaDSe
+/xVIJBaoKZY28eEftjTfa1ADxCsFUYo3wqfyWFUKdC583QX60vqhA4THDRA3+Co
4qFxWJAuhOwtOHVK3WVYYiNWSCM3qVylfRGm0lYlgm6ufivBBbMDdVOH8+oQZsm3
HN78uwu3kDKia46dXgGb/ied8nv2B/h9asV1YkOEW6C64igwZmAFWv0/vBbceqdH
JawATTbTTwwlCC0gETR1NMdL1xm+qbURpMZnsT6ZhlB3fJZB92z99arzn1A3RB+D
GBbhsvEINzPmpMfRkKfCtOM5lRf3IxHDGPGH1RMO7kbyKKakaepjCYhJHJ3Wpgg0
dxnzpA/fhhmV/lXr7wsg2H7E6KO421Gr3yIUyya++fe/IMxLQSTxtMC39VmP81EM
Cs+2BONJOzxV/ZXqKyUQGO0R2ooefUovQ2BtYbjLU2D0/wDZNM9wSkzUgg5SjfEf
nEvP3SLZetmEXn7x5GvaBcAblptlvKNAgHVM5gXTadl1hrBPFzCwbmSyDKPZiZVL
LZ60XSOPmmpmlRnX5h5YktT6CSVWf2k3RZl7AJUJsJHufmcf2hE=
=Wfx9
-----END PGP SIGNATURE-----

--3L/GXjG8W+MnDvsB--
