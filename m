Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848370;
	b=PZqFILdR+qi+vT6vSv/toZIK44X/XmeW8iNWCX2zDPmabpvoeMWOOjTyE24lH1LiHMSM
	 StOi9BkgkfPLDmPvrSX3PQY8IvVZNNQn83lAV7DEghd4QL1tqYn/t0XkGzZYCI73ZD1mx
	 GAisdujFOo4omrbeJtDFqiuSQTFwoofpRv4/ZVHlNG2Kx06ryJT6A7WUSlhjbC4iHi+Uc
	 AHP/owD+kHYauU5F8rFv1fwxYQW92B3a85222DnTIq6kPmpnpcxpfPEaomk7/E4qDYFho
	 1E7nuv34a6zU80DyZbkRz5Tqxy4sh3Tb7N/PRdZCXxVM8OJVKV4X8DLKPHYDZycKGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D3KFfqEfFSHUEjSfNKRlFvLMrAcLyCngT+p2KDEd4AQ=;
	b=jZo2h0o9hfTg+1Pt8D5ROcticT7IfJzjyZ9osiWjHASJiqAkib0SQ0QzUliHdGUBir8t
	 Ye9MSPUSCa0Co+ZqWXqNtrip0tkylG5hY19iXwp/f8at4Qdq40TToHD1Hw8bUyE5mZWni
	 gV8hKJ9xDcs4PXEPH/tyBjmjZMe84trx2Iq4W6NTAu2J97X+EJTOaqI0BbkwdyjSsCPpT
	 XbV/PYxf4MbkZe+RCY5KOsm1PiWLjCc5EvSeH1thHAhHPlm8uuqRpefVg0uxGr5AEvgc1
	 Fl9tD1U6GGuMKE51Zyg4TQ1bh9Pa465Gozz55ixKv2PuNHaksSdXzgp1cDWktCenLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcWoJ+s2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D2606A880
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcWoJ+s2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2703B1F000C4;
	Mon, 16 Nov 2026 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848370;
	bh=D3KFfqEfFSHUEjSfNKRlFvLMrAcLyCngT+p2KDEd4AQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcWoJ+s2hzsjaGzBlfWsnaaLWWNQ4ItEPdQiFLKA3l6QV9SbE4JPdmC/1LSCawTk1
	 xXb23PEds1YtVRacDuG9MRGwAXMzpRSY6QjEBmYg9uROGGYj2QcccAXa62lxJ/WOAj
	 Pe6YqrzXMct0nl9XHoQ7tLUo1ixA3i3MYOLu7vypZt/AsN5uKmg1QFtqPbhC706i3N
	 Q9J58HTLK9bsfsRNWf6T9JTw32lMy5k0/R35VGIaGTiUMciDSsMO1squs28KzWp13C
	 /ueGf/gXaeXnTV3tT3KXLUrfApybkUwbRwRTsXzhOSQQIiJpTZ44o4qTErfPIXrRjH
	 x+laLSKPubzvg==
Message-ID: <sashiko-outbox-217401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] perf annotate: fix annotate crash for fused
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yao Zhao" <dragonlinux@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116165438.694835-1-dragonlinux@gmail.com>
References: <sashiko-outbox-214904@kernel.org>
 <20261116165438.694835-1-dragonlinux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 16:59:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Function is_fused tries to find the previous fused instruction with the
> current conditional jump instruction in the annotate_line list.
> disasm_line is the container of annotate_line.
> The annotate_line list uses list_head and the head is in annotated_source:
> notes->src which is not an annotate_line, so it couldn't walk without
> checking the list_head. If so it will read annoted_source neighbour memory
> mistakenly and most likely cause crash.
>=20
> Fix the case where current instruction is a conditional jump and it is
> the first instruction in the disassembled list, the original code will
> walk to the head and treats it as disasm_line which is not.
>=20
>     -------- backtrace --------
>     #0 0x564dd8d5d5cd in ui__signal_backtrace setup.c:0
>     #1 0x7f1737e3e6f0 libc.so.6[3e6f0]
> [ ... ]
>     #16 0x564dd8bd7095 in _start help.c:109
>=20
> Fixes: 7efbcc8c075c ("perf annotate: Fix fused instr logic for assembly f=
unctions")
>=20
> Signed-off-by: Yao Zhao <dragonlinux@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165438.6948=
35-1-dragonlinux@gmail.com?part=3D1

