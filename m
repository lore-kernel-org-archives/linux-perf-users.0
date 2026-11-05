Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903378;
	b=ZwyvrhtIeji0JhktetKP4iI9Xv9ffBy/gHfGE6lh9fzL+Mb+fJnAunOiYhF0bsmkgDkN
	 6lBZnirN1Z6uSkUKDvMC+STrNh/pZSkhupa0FNjBwmMf8e+XrPnRfwyhRWhAxfuToFecH
	 FpFHMP/lqYUWTTkIXCbQMtAvZQK9h2NXYHEVT7ZsbXg7tILcAazUtLmbxPAlrFNYm8pRj
	 1goagWG20cnwdFvYvhPTOT4chEW0YfukcTznGg1DYkrEX4Rv9yLAQaNsFeRtht5Io9fwa
	 GnVx++vHELXt8Bw3TXymarYKmHUQoa/6Aje2egYtfQgfsJGC68qQl6gTmd5ZDdHuVEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903378;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MjOFkYKHObseWphGutQez7ZtlrSwgFCK+YaHdhDjJV0=;
	b=N5pzMOuinGBteiermrhJkHH/1zjn0Ofgb6Zun7Dd5Ads1d6iCpBoHAq02k7ROQrmz7Q3
	 vmihMA4i5NjxiWEpozFe8Q71SJ9LvKMaSMXLVY+4gqzKO1Bns6LkOWZxhSYJ0uRTDnoBm
	 RZAIkCvkKekii2aOh37wjMOkuFd/5DdIN8LZGoTnPBuWznVLX7wYW7IHMyNgYHVJ++4TQ
	 7p7vQCp8/B+Gm+rRzCB90bl4kuDSrBDhor6mjMabZGUcNcGDfo9QgDEL0TvNzXHbCKh0Y
	 rpI2HP+Menbf2f24IXcuXsgj7TieliPgkmAaWBv2Nw7Mw0XJxcqn23IJtS0s/ftWbzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BspHo61d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE64606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BspHo61d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087BB1F000C1;
	Thu,  5 Nov 2026 18:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903378;
	bh=MjOFkYKHObseWphGutQez7ZtlrSwgFCK+YaHdhDjJV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BspHo61dV6lNXE3xwWcIaVe4jp86c13Z112ziS4Fvi4VzAHRnswUghtYJPOuUp5ru
	 ra7bQyPqlTQRMdIOUvWB9zdNQuC3wNU2nZOqcj7FbOmomBUoPNJOYf8t2Tdmt6tTpN
	 W5CwMexGN97wfsutDOpQFiDpq1nORs4HGC8XR6D/gD0craKOuWxmDvNnS30oSCYFMT
	 SWSddhPR0mpjEnXWgTBefdDea9YjhUTDEjlRTpVYJj6c00Q7qYMLjknbnzfWkjqODA
	 f2UiPfdHH6ud6tc0H4RDDiPidcU+FyEtYgPkPzVu4x+J0E3EnbsdSjC9rLvC9KMmdC
	 SjdhnsroGlQHQ==
Message-ID: <sashiko-outbox-199768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/47] cpu: Move CPUHP_AP_PERF_XTENSA_STARTING post
 stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105163045.38862-17-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-17-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:29:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> This state doesn't have a teardown callback.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105163045.3886=
2-1-frederic@kernel.org?part=3D16

