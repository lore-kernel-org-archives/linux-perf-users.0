Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63F1DFF7
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062450; cv=none; b=TsU5isq+8eUw+FeUzO30tQ94f5ALsQ9UFaTVSPT63yAHHglcaNC7FUgvEEv7G+VL6uZ5zOf2H1Zk5gLh32cUQN/bW1AInEgl/gDtJGIgJDNug0tBvVddWE2wVapFZUvWv7xJLtC2A84AegicNB3/M8aAic+gjp1O+o+FK+ogDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062450; c=relaxed/simple;
	bh=w33G0TSk8Yjtml3xW3AqXsod/9f8MDmMbGVd+ZqPHjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzG1st7MnZbxx8dyVe48Il8ygJd1l9LyRwqF+iFWHc/wl4Dm2kfJ8kbxnhJZOOaWXXKAF71dwemb5ZISNgQN+RPbioIIO9Ep/Hr4LfsHpnHDEVpD4HhTK+KZwlvLxdHwAxQgNz8C58g8gR0W1tpoLxL+vBZyVqfsfdsDMmGXs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=Gb3r6MYP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vjBJjeYP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="Gb3r6MYP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjBJjeYP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38DAF7A007C;
	Tue, 21 Oct 2025 12:00:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 12:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1761062446; x=1761148846; bh=hKzRMTuEvujD5gZ9BXNKNcxFsIEWCjGd
	cNJeYGkdv9Q=; b=Gb3r6MYP55oaE426+Vl00kRunxJbtO3Hn15+S+Hb7QJgF9+l
	zOv8Dwm4UfhebiQ/fqNT+KmdAP9mjysU+T+uAJmdR1O4pYSgpDLoU6mUd1/Gf+oL
	CS7L6QjfE1MqH0za6dW/px7tYqIyYGZ+VYPAwUPJZsM9RqXPTObF/p28i+ADiWyS
	swDoiIFqNPo7qGJbZPBA8YA/kjPPKAR/9ecxCut62APJvlp+b751KWEowV1zKo8Q
	12/+4UX2fCG2AiccjEp9BFEyjkn4olNpU4xE+cw8qNpFm04hjGNYgTno7xdsLwBv
	o82vmjKv/RrlwXW0EyNaxF4P+ogfcF3XZyxZ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761062446; x=
	1761148846; bh=hKzRMTuEvujD5gZ9BXNKNcxFsIEWCjGdcNJeYGkdv9Q=; b=v
	jBJjeYPbszrQ+KyaVBieu5sMBPfX40WD6xgoZZIkvYEzTT1ufEiulFozHeajAfF0
	PdFuo2kDGOn+KPuib3NboT8fkRbd2+15tZ6bDugWgs09WvzEhGZZGPGKXveVdsbA
	oip0uX+RnLsMj86upuG9+scBEpU0b2jYLuUYGjyXpq+Mic56roRgblsDzbNVVmWJ
	dVTWDyAiR9cwK2RKpxp9haiGUbG9xpBa1g6QE2d6iKWFM3w7CTD6LNDTyMOaz1oo
	2TZA9SuHpXidTy7QkcQ5n/Wj1XwT8fZkOfw8ro8Zy7Z2OF3VdhT8xI93vzfQ/vWS
	Cy8jGZbZwiZF35/GEodvw==
X-ME-Sender: <xms:La73aPDnNLLFUpa1VZsdIWmHyv_qcmgNdYLUyQsJf2GswLXW74N21g>
    <xme:La73aM9Y-gvgMMdXF0uar_iEvHfBDmVmna0kCLQylUsUt3IaKbLaefzFZLnlpHuWN
    8Lv0XmKh799Fa6so5huJOKNu5Mca7RYST-AsyygcQThx2hd0hMkWWo>
X-ME-Received: <xmr:La73aH_Ss5qS184c4Y18-pB8X6_dKbt8lDeBeoDEu9Buw1sUxHvUMAqWh0Th2TNQRwfrt_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefoihgthhgv
    lhcunfhinhguuceomhhitghhvghlsehmihgthhgvlhdqshhlmhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpedvjeejfeduudevgfevudekheekgfekleeuudfglefhheeigeevgeff
    iefgtdehheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhkvgihohigihguvgdroh
    hrghdpfhgvughorhgrphhrohhjvggtthdrohhrghenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmihgthhgvlhesmhhitghhvghlqdhslhhmrd
    hnrghmvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpvghrfh
    dquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghs
    rdgtlhgrrhhksehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:La73aLc9jYUjvKfGEVanV7YOFmeUR-b3NPzBsRA52qMwSC-vtAkcQw>
    <xmx:La73aIEsq8Pd4ug4CGfHz-i9oH89t47rJ2Z-Pa9dnA7hvIo-VqaJ1w>
    <xmx:La73aBdaWwnzrZb_e3ZI1XZZvdv0P301Q3efieE-8FtlIOzShsIQOA>
    <xmx:La73aKEP3XutkZBFmSLzEqgpBpfl-wEkeEK8Zb4jA2LFM4653zveyg>
    <xmx:Lq73aKXnKjh2sApbbyCN0eQnObvV1MK4OTdxY0lw1_y-GOCRQuxbNpr7>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 12:00:45 -0400 (EDT)
Message-ID: <a573563e09f5eb0f96658bd08b328cad0a8d40d3.camel@michel-slm.name>
Subject: Re: perf-tools v6.15 tarball not uploaded?
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Date: Tue, 21 Oct 2025 17:00:44 +0100
In-Reply-To: <aENMPp9SZdABPkic@x1>
References: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
	 <aEHylyR4hGaqZ6C8@x1>
	 <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>
	 <aENMPp9SZdABPkic@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (3.58.0-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnaldo,

On Fri, 2025-06-06 at 17:14 -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 06, 2025 at 02:59:27PM -0500, Michel Lind wrote:
> > On Thu, 2025-06-05 at 16:40 -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Jun 05, 2025 at 11:24:50AM -0500, Michel Lind wrote:
> > > > I noticed the kernel.org mirrors don't have perf tarballs newer
> > > > than
> > > > 6.14.0 -
> > > > https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
>=20
> > > > Will they be uploaded soon? Presumably I can just generate the
> > > > tarball
> > > > myself for now from the Git tag.
>=20
> > > Its there now:
>=20
> > > https://www.kernel.org/pub/linux/kernel/tools/perf/v6.15.0/perf-6.15.=
0.tar.xz
>=20
> > Thanks! This works great on x86_64, on arm64 it's failing because
> > some
> > files that are needed to generate unistd_64.h per James' commits
> > starting Apr 29 are not there.
> =C2=A0
FYI - I just tried with the perf-6.16.0.tar.xz tarball and hit the same
or a similar issue.

/builddir/build/BUILD/perf-
6.16.0/tools/arch/arm64/include/uapi/asm/unistd.h:2:10: fatal error:
asm/unistd_64.h: No such file or directory
    2 | #include <asm/unistd_64.h>
      |          ^~~~~~~~~~~~~~~~~


> > (I tried copying the files that show up in the error log, but
> > eventually hit a wall - for the Hyperscale build I'm going to get
> > around it for now by just generating the file on CentOS Stream 9
> > and
> > Stream 10 VMs, but I'll try soldiering on a bit to get this fixed
> > properly next week)
>=20
> Yeah, reproduced:
>=20
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /tmp/build/perf-6.15.0/libapi/fd/=
array.o
> =C2=A0 MKDIR=C2=A0=C2=A0 /tmp/build/perf-6.15.0/libapi/fs/
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /tmp/build/perf-6.15.0/libapi/fs/=
fs.o
> make[4]: /tmp/perf-6.15.0/scripts/Makefile.asm-headers: No such file
> or directory
> make[4]: *** No rule to make target '/tmp/perf-
> 6.15.0/scripts/Makefile.asm-headers'.=C2=A0 Stop.
> make[3]: *** [Makefile:108: uapi-asm-generic] Error 2
> make[2]: *** [Makefile.perf:973: /tmp/build/perf-
> 6.15.0/libperf/libperf.a] Error 2
> make[2]: *** Waiting for unfinished jobs....
> =C2=A0 INSTALL /tmp/build/perf-6.15.0/libapi/include/api/cpu.h
>=20
>=20
> We shouldn't be ever using anything outside tools, but over time we
> ended up doing that :-(
>=20
I'm going to work around it by just using the kernel tarball for now.

Best regards,


--=20
=C2=A0_o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README
