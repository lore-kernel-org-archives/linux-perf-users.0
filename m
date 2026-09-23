Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DC3815FA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187724; cv=none; b=LlZLPGb+ogb3ua3HXIDdnlOT2r/gw1H4vFs6ZVuhEsm7S56vU5tpUm5i5BqrG4YydSUz0ShXK6kYw91UMDu7izPrJBJasQIYPuo56OcRObqZ9IVbOEuiY3veL9AQ4Yf6t0eUrORcuGdmgGW/kjUjw0Np0I9pwDoe9tSF53QOO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187724; c=relaxed/simple;
	bh=Bd3SKWmKf3unmjimXjpwzKpzRwR5l6Cx4OcgarCHIWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZIrxVGncJvzVNmbGt4512RGJ2m3LNi2ADt0yFISK+wszYZFzDbws+cYVnu1XMVGiF3CLJIxnov/FKc/tq6a1PgTuwi7xgC8S2GycNwlrjHJRrA48SDGu/LwwoD5BxIQGci5/OFuEEJ2HiqVOsA5i1cJRG8Yp3RoJ77WfBi7LsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2pjo51e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2pjo51e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2311F000FF;
	Wed, 23 Sep 2026 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187722;
	bh=Bd3SKWmKf3unmjimXjpwzKpzRwR5l6Cx4OcgarCHIWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2pjo51eOmEh7YyLNxU5nsPTLHRvewfe7yKvfwqi7n2Wf4yCuWRFiCvJlK0f0roU9
	 njp+16kEW8bHoPV3ZxVIGnPLrD7YYv4qWrVJSj/P3e1fRpltS8eEsYuVi6/OsQ27oY
	 vVHLgInpT9x/0X24Ar1I/iRzb9Q9dSVZlA3kRxlJFYr5ZjtX5LS07QvKpW55Tc2/lC
	 FiI1L6S38K+t1a1BjBLg1SvRsg4qYra9Bot69157RqrDSv313uo7oUaxhYSXijJxav
	 mJIkuxoJGQfTpat+H086iCXlISrnMytmMVUnrhTEgZC/RYSQlnY72kRw8uuGigCGUJ
	 fXQDNp3S1pdsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/49] perf python: Allow KeyboardInterrupt to
 propagate in LiveSession
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-11-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:22:01 +0000
Message-Id: <20260923182202.4C2311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> LiveSession.run() synchronously blocks while polling evlist for events.
> When running interactive tools or scripts from the terminal,
> KeyboardInterrupt exceptions raised via Ctrl-C must propagate so the
> caller can break out of the polling loop.
>=20
> Previously, LiveSession caught KeyboardInterrupt with an empty pass
> statement, swallowing the exception and preventing calling scripts from
> detecting the interrupt cleanly. Remove the empty handler so calling
> scripts receive KeyboardInterrupt and can perform clean teardown.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D10

