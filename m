Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03985189B94
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664580; cv=none; b=WtXvfzdtlvAinNXO0t7blCnmPMztwtYbQGHU4XDBeR/hfECyj8BENj1tp7SWi/U3ki1nhNhyNubMxpsfK25ZgRQBtBVS8MIsWZvIyOTa40nGCoicpnPzj55ZKp0l9cenW2edJVoZhc4iyct/ZrdUIA22vGRxBXDSaAuTmRdxySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664580; c=relaxed/simple;
	bh=gX5dz9ZBK+KQNYqJzszi+HN7WWipt0WV9bMM4bdefQI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4LomL5lZHU4LQL1LScHH6CkrHrHHtiGhCI9CtOG00jaEFnQa/ae5zvD03qjvfeh2MyRO89Q8Pc5eIQ0eqhAwvETO8mOevR6lJF/38KLvbzG1ixdRABNHR7OuYsJzhUZaGUp6wazDqvG4wsoVNmqB1FWmI4oAHAhLj/mND3LtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=iCVN4Uox; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="iCVN4Uox"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XyfJZ0WMQz9spj
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 00:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732664574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX5dz9ZBK+KQNYqJzszi+HN7WWipt0WV9bMM4bdefQI=;
	b=iCVN4Uoxyx+DN4jRNumpQTDZcNHPBbRx15wXtSMGoxITlCpbe+RlE7sb23UwsLLJtk4rE1
	rYH3lPbVhwJVZNQail4SQErUXUbB6uX5INWU9kAy6/i38sLZpfVuRUE7o+IRIH+2Czj3fj
	XgoNFSJnt2dkQ2Q4OYBOke3yU8BLxlxPD/v8bh//kPRr2zwZAsKjqUo9HwwyPF5l0bmp5s
	DgDlN0Qh2EJA5RuYLYvTB5gIvcYKq9J+byNCczK+kz7HEmeRKZHOqe5crVYVKqqmcjGiRl
	6BADHeaq0yTkEPBYHvU4GpEDUQQqZ6Lx3PzI4MIxE37zC4dSlxbucKIRkbvVgw==
Date: Tue, 26 Nov 2024 17:42:51 -0600
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users@vger.kernel.org
Subject: Apologies for the misformatted patch email Re:
Message-ID: <Z0Zc+9SGQ9rbqRRT@hyperscale.parallels>
References: <Z0ZcG2Zn/1/iGTFA@hyperscale.parallels>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UxnTkjWw7aKIPsa0"
Content-Disposition: inline
In-Reply-To: <Z0ZcG2Zn/1/iGTFA@hyperscale.parallels>
X-Rspamd-Queue-Id: 4XyfJZ0WMQz9spj


--UxnTkjWw7aKIPsa0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 05:39:07PM -0600, Michel Lind wrote:
> From ab2bdf2e20a99b8d0298435328055daa59d2b640 Mon Sep 17 00:00:00 2001
> From: Michel Lind <salimma@fedoraproject.org>
> Date: Tue, 26 Nov 2024 17:37:44 -0600
> Subject: [PATCH] perf MANIFEST: add license files
>=20
> The standalone tarballs should include the license files - both the
> COPYING declaration as well as the text of GPLv2.
>=20
I've resent it with a proper subject line

Best regards,

--=20
 _o) Michel Lind
_( ) identities: https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc0=
4f2

--UxnTkjWw7aKIPsa0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCZ0Zc+wAKCRCLIp0vfMwE
8r0mAQD9pDDAQixBewtUBsunDf+3cE4D780oCJG8kENd/h/PsgEAiiwFqd08uljM
VvzJc7HxLtdOHf9FIQz9nVhpzU7KBQM=
=GHy6
-----END PGP SIGNATURE-----

--UxnTkjWw7aKIPsa0--
