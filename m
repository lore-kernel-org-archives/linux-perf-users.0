Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343985;
	b=c3143zuhXRK85sbEvdTMYb9zkQaGOQowh7T0aGKV1JZ/QvJuEZGZqlLNHzrMX48zY6lA
	 7sQXWMv/NjOqGxO1siB0cNo9oQGf43j6DDYeHywYPCNkwgfO1v34a5xh8av8tNvSouS2d
	 2i14ATzIOdyIRgB7gQDUmQWECVuMenPzobyd/yhhPAYlfhxHKWIHvwD8vYTdiqdGM+W0g
	 cJDhYKhEzauvMcCaLmnMdtuMdJd/zQRFqcicc6So3f8gqeQB0n2snSFO9HhsLu4uM2WCZ
	 PgasgqbGOOSfb9U079M9XvMn4kL39ET2gwWkP8RF4uvcjfbTi6BRsJDNyAs5onhN5vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ria1H+vqk2wlhkuQtB7+ZKYRZmuRE1ojfEcCXZjoxoo=;
	b=08l0sNoRGgn7hXP1nR2SBPjRyk/ne9edJKGyT1Aw6MSXuD8jgTbnjGf6SEhRjqc3JYmE
	 YdaBC+ZN38QRaUW6Q/US4NMjvziZlRtqzNy24ElNNErTgIDCDDZFmK41c1S8xykRzJCzr
	 /C7J+PlavT7eZdIoh5oSi+9v4wp5iBIL1AwxVszRxwSHMegtnzGPZtmKxXZoXRDebsLsc
	 4h6JFkWqUCdU55NTr0hLueLI1QFarniK6G8kUI4iV7141dEPID6IUKMLiVMb8A8ob36Mh
	 3uxQ4ENeR76kyluwWYXWSoV9OqiuQ1z82Z/iuft2R4lgwZpUw1NjUSQ3xS59G7wpqSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dau8I/x+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD79606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dau8I/x+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE3F1F000C1;
	Fri, 30 Oct 2026 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793343985;
	bh=ria1H+vqk2wlhkuQtB7+ZKYRZmuRE1ojfEcCXZjoxoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dau8I/x+Hl3xTKaO/pll/Dd3J9J6TmE61qpuz/xI49euO5LsZM7dW12v6MtYn7Bmg
	 BXmA7iZye5u5qY253OdkBiyvp74o06M663/j/yNSN4/HOaYd9TSAFLtKVk7uzTFQVU
	 c4oGtCPFMcOb0PDoebdaL0ZIMSqWPpzRoPhNfeP7PPwogVIOCZ2K/c233eUSy7np+v
	 d7gUUipMY8uSgYiF8z5ZOqYtEsRBT72MZkf7ypWaMCPxdK1ZpHU8evsWfiVcbPAUBx
	 hZjShp/NPTrmUwuZxf6mZ5y1Rw1VwbONfQjuROed0BnJdCP5OexedzNycZb16Uhffi
	 xbWLRk0nFtcPQ==
Message-ID: <sashiko-outbox-190627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf record: Skip affinity for per-thread mmap buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: Paul <p@1g4.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030065857.2157899-1-p@1g4.org>
References: <20261030065857.2157899-1-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 07:06:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Paul Moses <p@1g4.org>
>=20
> Per-thread mmap buffers use CPU -1 to mean any CPU. Combining --per-thread
> with --affinity=3Dcpu passes this value to __set_bit() when constructing =
the
> reader affinity mask, causing an out-of-bounds bitmap access and SIGSEGV.
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000555555f3488e in mmap.mmap ()
> #0  0x0000555555f3488e in mmap.mmap ()
> #1  0x0000555555e2f7bf in mmap_per_evsel (evlist=3Devlist@entry=3D0x7fffe=
dcc1150, ops=3Dops@entry=3D0x7fffffffaf50, idx=3Didx@entry=3D0, mp=3Dmp@ent=
ry=3D0x7fffffffaf70, cpu_idx=3Dcpu_idx@entry=3D0, thread=3Dthread@entry=3D0=
, _output=3D0x7fffffffaf08, _output_overwrite=3D0x7fffffffaf04, nr_mmaps=3D=
0x7fffffffaf0c) at evlist.c:598
> #2  0x0000555555e2ef96 in mmap_per_thread (evlist=3D0x7fffedcc1150, ops=
=3D0x7fffffffaf50, mp=3D0x7fffffffaf70) at evlist.c:650
> #3  perf_evlist__mmap_ops (evlist=3D0x7fffedcc1150, ops=3D0x7fffffffaf50,=
 mp=3D0x7fffffffaf70) at evlist.c:748
> #4  0x0000555555f2150d in evlist.mmap_ex ()
> #5  0x0000555555db0b0a in record.open ()
> #6  0x0000555555dadea7 in __cmd_record ()
> [ ... ]
> nonnegative CPU. Skip the reader-side bitmap operations as well, since
> per-thread buffers no longer allocate an affinity mask.
>=20
> Fixes: 8384a2600c7d ("perf record: Adapt affinity to machines with #CPUs =
> 1K")
> Signed-off-by: Paul Moses <p@1g4.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030065857.2157=
899-1-p@1g4.org?part=3D1

