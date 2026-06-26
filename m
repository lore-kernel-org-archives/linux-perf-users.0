Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DB3B47CB
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782498865; cv=none; b=BPmZNMkexLlXhTg8PUzhb5rGO2o6BaZMCtTwlJns+dlMS2wItSmKwHKIqcFWND9I8rSWMYpLd0GvFA9R4RpvFH7hBqfs1jifyCqao0n7PTRY2ytqJKPmwk9tJT/AeHecS+5Tog97tQ00ce3jIE0MeNHk8/tCYMTGz6qiVzKLZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782498865; c=relaxed/simple;
	bh=OJFo4FWk2U+TxX829KD+ekGTqSzdwJFHUXEGXm0xPVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJe6GXgcB17kwQ45SZiJxZXomO/7mjX47whPual9MZQleUcaC7BYHU52jD906RaMh/U/FmbnoaEs4i39oa+vmCEDfwBGUwCN4ecjFKnBcUr2D6R2OrG0GbFGimgmq4o7OB13AEg/3L3kaCfY+A2KP7MECBEF4hx9edfPQJgZA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY3Go4Z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY3Go4Z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD211F000E9;
	Fri, 26 Jun 2026 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782498863;
	bh=kyTtUEqaZZ2raduN2htjEhDhUgYnpd7uDUPLnNIAnn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OY3Go4Z6mh8cErGmxPF4Oz0Lvk0M4rhoTU7D84elMseZmAbDhxWuJlqu6DkMhbhav
	 8njyVPfKvSrtDxSLZ1unrFlrqSxfnq4vhm+f63R3VPDi4mXwj/oGjedThySQvK1Oju
	 8Fs+x0vheiUTTvha+fa8GeeM0cVpFQKXPLboDD6zTFCK3JLqXQU4u0N3Q48yRLlbpR
	 OZjN1mZeILRVCyV5Ded0GATCemQqh8E1tSAgEcmOMGAhzaDyNIexw5s+ivIVmu1b6x
	 Gx9KDll+ddRtlloPr6FAXqW2zq6Bax7sMSW2IlPBx6WWwixxWp4nXGKnfzb9fjuxnF
	 clEgq8MNo4vCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Add LDFLAGS to dlfilters .so link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Trevor Allison" <tallison@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626182739.53294-1-tallison@redhat.com>
References: <20260626182739.53294-1-tallison@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:34:23 +0000
Message-Id: <20260626183423.ADD211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding `$(LDFLAGS)` to the unconditionally built `dlfilters` shared=
 library link rule breaks statically linked `perf` builds.
--

commit 18f2c24db710920618ef1d894a2b24abff4dbeb9
Author: Trevor Allison <tallison@redhat.com>

perf build: Add LDFLAGS to dlfilters .so link
   =20
Build-time linker flags were not applied when linking dlfilters.
Pass LDFLAGS for consistency with the other link rules.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 476b8dcaef58c..f2294a6d89604 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -677,7 +677,7 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/pe=
rf_dlfilter.h
>  .SECONDARY: $(DLFILTERS:.so=3D.o)
> =20
>  $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
> -	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
> +	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -o $@ $<

[Severity: Low]
Does this break static builds of perf?

If a user builds perf statically by setting LDFLAGS=3D"-static", this rule
will pass both "-static" and "-shared" to the linker. Since these flags are
mutually exclusive, this results in a fatal linker error.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626182739.5329=
4-1-tallison@redhat.com?part=3D1
