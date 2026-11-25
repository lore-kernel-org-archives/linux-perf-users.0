Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579538;
	b=q+auagftSh/Dlfg+KW3g7vyH5+fk7YQEb+Mt8dk8erapUjEI25fAJ2aDHoLGZRUdeqtu
	 Rt0QeWlwdNt2BobnJKAdgzAQXEN9UTwdRQ4iLOWcDK1bEWjOoaBDdbNM932tYeOmzN5HS
	 ktsXkzK+pPOcBwcHn0mU5FxWP1G6II2knKBP6ClQ9lWLJ3UyCI9Hs4Wm+nEj9+stzifoC
	 1ib6vbitlJXpUQy2bfI0tAosng1YH/mVgukd3msWWQ64/R+lsQ34TT6rEK6DjDDTApdjP
	 4J/c0Un6gXt73edrDFIPZYMIXRFl4R1xtNJhV4S5OocMAaXX2WOC12aelq8Pb+/jfww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6OQDCvgBLN5hQttteI6k+NbSiIL4tJ6YbUnXUKJTmnI=;
	b=pcfe1b2r++Zxv9TZZlsDpYX/PJ2jTin4Mp+iLQ+GtPo+ezVx9lwyGlFNyA7kxRhfNSOk
	 GYAx+YFRboGv+R6ymHQYjTkSXKFjE+O2DkeHrGtZdLBlmroronuEslvE3kJxa1OJImIXL
	 x3r/DQx+bS0C17LHuYvaUHCi5OmomPZ7Ad4e3HfOotb0rY3f8bVbIgJFmMuDF1uyAcklT
	 ICvXTPJMRFA8aM6ocowpO1N0w0ke5yCtj2jayVmw0BQv3/JVxCAyG57SIPVwLHMx4VB9J
	 uQZzw7MhSNPuMGeO6wT3JDdSToSLVuZNtVWymG3nUZt+Rhqv8DM50UBhoK6pDcgiN2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNRGUY54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF13606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNRGUY54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F681F000CF;
	Wed, 25 Nov 2026 04:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579538;
	bh=6OQDCvgBLN5hQttteI6k+NbSiIL4tJ6YbUnXUKJTmnI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XNRGUY54hU7RVuy/0+r6V+f88cn6dVZpE0/BwKLeUPdtLT2pRO5UhCOuqo47l7OXU
	 k+TZqpTZHbKGXwMWg5APj9U2wRuFSBR4ylKuCWdecqbanjm2KhdNeXAaNsl1p7IWuO
	 0mO4n80nybuAUFuLFvYnPwi/2OBeZZIQJ1u4X9kzvLfr17oIpEacUeMFmfLH7g58NF
	 eyP1chxqjEL92MqaBL8/V1+nmmhs1rhLJ2lDPk7xFhUP+EeCvr19lhpWkbFr7Ch2kC
	 9V8CAKe7JENERp5yycdD3uz/0x3qDmaTMZz0ZmkSr/ugaLK1569fcjy8R6rjEq4qD1
	 XD+kFNfQtKd2Q==
Message-ID: <sashiko-outbox-232551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 0/2] perf jevents: Reject unknown keys in the JSON
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261125040016.1675748-1-takano32@gmail.com>
References: <20261125040016.1675748-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:05:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125040016.1675=
748-1-takano32@gmail.com
