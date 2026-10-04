Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C43B47D5
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116861; cv=none; b=I/Hm4OJJC8jRmnYG6Vr+iiyI8bkEzOEbjObedBn1/GWqY4p5zXM7YlGUqEy2LzSL/jU3XJhNIOmDRaL+MEbMm1ndc11CYu9dm4NSzjysp65pBUvKkZqVet0eQwHXKnRQV8KuhjMbec5kzscNCGsXuiL9M4QFeSpyAXwuFxuwDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116861; c=relaxed/simple;
	bh=Qjxsj6ufYeuWee2wjxwTNxB2pizPNrqn39DRkDUDkBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4ZHrr4IxGeHlrx6iRCLq5W8ygA+L6EOKKHHe9oGruecNB1P6hjkb5QrX31XTYF4YE5QjmBhbhFkHlEkRQiaMUjjiEcfZr5KoSVZF5h2X2uekdLnf2/ENz4zoqjegvYMIIJpCh7eUlD12hB/ec213fDoFemT8Qj4fmgO5MSlf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHKBTqFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHKBTqFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED361F000FF;
	Sun,  4 Oct 2026 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116860;
	bh=Qjxsj6ufYeuWee2wjxwTNxB2pizPNrqn39DRkDUDkBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHKBTqFj3Wd2xZ3pXXteB5pSYT3zlLnlo2c/KKhgh+SRdtMMsywNwr3PX+ZcEeha/
	 0T3sgplYxt25ZdoHQ3o029SHOU1yrxoJfHWTD/6LPIEV9D6PkTaE+yW2KrLzfQaxp8
	 d3h4X4YNyo+f8eJBquXCjmjq+sEDSaOb1xSFeI5Hea9O3sjynjTdtsobcm0u85Je5E
	 xXBvf/arwE/RpAv2N6iFBIk7B2Eha+L/NebZsjOjO3j7iRULF6x2/4thao1kYsYvD5
	 Cebhzf2nX6/wtHNpG6EJwK8FL2RP93v8vKMZcHmMXvTlN+o0gaVOZGS5smdX4Mbu+n
	 qCt8A6HlmjEhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf trace: Support --bitmask-list with
 --libtraceevent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004121531.380660-1-atomlin@atomlin.com>
References: <20261004121531.380660-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:27:39 +0000
Message-Id: <20261004122739.EED361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit ab74d1fbe061 ("perf trace: Add --bitmask-list command-line option")
> introduced the --bitmask-list option to display cpumasks and bitmasks as
> condensed, human-readable range lists (e.g. "0,2-5,7") instead of the
> default hexadecimal format.
>=20
> However, that implementation only augmented trace__fprintf_tp_fields().
> When --libtraceevent is specified, event formatting is delegated to
> event_format__fprintf(), which bypasses trace__fprintf_tp_fields() and
> relies directly on libtraceevent.
>=20
> In libtraceevent, tracepoint bitmask fields defined using __get_bitmask()
> are parsed into TEP_PRINT_BITMASK AST nodes and unconditionally formatted
> as raw 32-bit hex chunks (e.g. "00000000,00000005"), ignoring the
> --bitmask-list command-line option.
>=20
> [ ... ]
> recording replay (trace__replay()), leaving trace__event_handler()
> untouched. As with existing tracepoint replay in perf trace, this expects
> the evlist to be populated from the session header.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004121531.3806=
60-1-atomlin@atomlin.com?part=3D1

