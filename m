Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB82FFDEB;
	Wed,  7 Jan 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786795; cv=none; b=m8d9dwTAycV6bw+lTy084SOd5wf71/DTWtHMyJA3QF78lkaDs1T7Pn6IFbXdutV/sbxw9UgpWOStUa3MA9iFwWahDlfpfUV9dUrJE4rXsOZ9mCRQyYPbt6DU2Zd5j8xsL7HnQY85DPtVLrwwOQ3KAfxL0spsVMFIzSy6C+nDXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786795; c=relaxed/simple;
	bh=cW4R8Lec7YSE6ljelTwneJAz/DEslXdm4KWL2FguodQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVrKsxoH5AdtIAPNjez403TFboIyFTXg9ncj1W3iXda4LRJPYTcy7+Bt3m/e75fBo+76yUWAV3ETOuYVtbUkOfx2WDRE5jWZWmUlNArkbuOaR6PgGPf2sNgeBILYcxRLTO3MoBmCntWTpMR3oZSuBsuzdAsNGMRHIE0pY5ywOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=S/xZuj16; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="S/xZuj16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1767786788; bh=cW4R8Lec7YSE6ljelTwneJAz/DEslXdm4KWL2FguodQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/xZuj16xVAIo0rYhqgRpdaKXvYeU//1EC0WChxUq4HLd35mQG71AgvtUu1Nxzeb8
	 5Vt+ZJmJYOvWWqUi29rTWzcu18VDKrgmH41P0+J3Lo1gAOoYYBbNZuzyX1tGHo8bK7
	 5KC3odJhDx3uviLSBRGYlVBtZBoU396pJ9TTyNMU=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <nschier-oss@avm.de>)
	id 695e4924-3a9b-7f0000032729-7f000001bac0-1
	for <multiple-recipients>; Wed, 07 Jan 2026 12:53:08 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  7 Jan 2026 12:53:08 +0100 (CET)
Date: Wed, 7 Jan 2026 12:53:07 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v2] perf build: Raise minimum shellcheck version to 0.7.2
Message-ID: <20260107-pristine-flamingo-of-painting-0f3051@l-nschier-aarch64>
References: <20260107-perf-raise-minimum-shellcheck-version-v2-1-019ef32d7711@avm.de>
 <413A6A45-CA6B-46F8-BE19-5AD2D1559DD6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SFB3yqYclW5TkIFR"
Content-Disposition: inline
In-Reply-To: <413A6A45-CA6B-46F8-BE19-5AD2D1559DD6@gmail.com>
Organization: AVM GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1767786788-15F7A7BC-9BC5B6C2/0/0
X-purgate-type: clean
X-purgate-size: 3092
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--SFB3yqYclW5TkIFR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026 at 08:05:21AM -0300, Arnaldo Melo wrote:
> On January 7, 2026 5:13:26 AM GMT-03:00, Nicolas Schier <n.schier@avm.de>=
 wrote:
> >Raise the minimum shellcheck version for perf builds to 0.7.2, so that
> >systems with shellcheck versions below 0.7.2 will automatically skip the
> >shell script checking, even if NO_SHELLCHECK is unset.
> >
> >Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
> >paths"), shellcheck versions before 0.7.2 break the perf build with
> >several SC1090 [2] warnings due to its too strict dynamic source
> >handling [1], e.g.:
> >
> >  In tests/shell/base_probe/test_line_semantics.sh line 20:
> >  . "$DIR_PATH/../common/init.sh"
> >    ^---------------------------^ SC1090: Can't follow non-constant sour=
ce. Use a directive to specify location.
> >
> >Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
> >Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
> >Link: https://www.shellcheck.net/wiki/SC1090
> >Acked-by: Namhyung Kim <namhyung@kernel.org>
> >Signed-off-by: Nicolas Schier <n.schier@avm.de>
> >---
> >Changes in v2:
> >  * Add one of the shellcheck messages to commit message (Namhyung Kim)
> >  * Link to v1: https://lore.kernel.org/r/20260106-perf-raise-minimum-sh=
ellcheck-version-v1-1-b46739a78888@avm.de
> >---
> > tools/perf/Makefile.perf | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> >index b3f481a626afa314632876449a11eb79b2978824..e2d668fb7f439befd6d1d9cb=
f66765f8b815e3c6 100644
> >--- a/tools/perf/Makefile.perf
> >+++ b/tools/perf/Makefile.perf
> >@@ -255,7 +255,7 @@ endif
> > # minimal shellcheck version as v0.6.0.
>=20
> I'm looking just add this patch, from the smartphone, but shouldn't the a=
bove comment need to be updated as well?

ups.  Yes, sure; thanks for spotting.  I'll send a v3 tomorrow.

Kind regards,
Nicolas

--SFB3yqYclW5TkIFR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmleSRoACgkQiMa8nIia
bbiwkw/+Oceh+KImuErjJDsZPnmqYO2xWu6BWslXRxFwBEZGpYADlNcpXceTyFYp
UnCrZDhkDWWLOXcRswp7zQqoGr0OXE2ekRh9X/VvlPkr0AHOCWtsFK5d45vZVGZP
fWx3D8kfD3BUMUHudsqW2/qz5AnKL7weddGUW4djqBsbFjh9X4I6//1fXRGlznuS
LbEj2AcRkOZEgpjP+rUtqil5mFmysKV/46ETmINFMe/Uubsco2fN4aILj0+g0Ndo
YVi+7bT4L96uKjqkEi+55Q6Os/SJ/S3dqCmP6Ps/z4nW0vgvcSbyYvUo5Ots4lqE
gdGV/yNu/7Nl1sWmCIX7GPftKaxAb+7R1xX0PtkEh4yNTevAd+eexlPmg4PABWdv
KO2UXt9ZgjNutrNFRHbNA/CHWKv4btlQ8BG+IhHk6x/T7GBrZfXuHIEBV6Z38Lwa
dTWhTZdHpSx6LdmIp+TeJhNshjdreZFGRyosSVI4vsTFChH9ZMNRneDKp4vFVUWN
DZ3hnxsvtSC+6ciFMf5M2CNKpGGKyABpLVgR8cJ9Z1Rq0nK1mQyWD9sX81UcoChN
8vPSxdic9ciBrRrQCNocyRxi6vPP+H7/21rFRukvUCnePRdDWN4+7PoYNOCHm2QC
gDOmKVrjh+kgQuThqeT/Fmo426PSoDdWxO2mRf+5PeZ7GtIW5os=
=UjIs
-----END PGP SIGNATURE-----

--SFB3yqYclW5TkIFR--
