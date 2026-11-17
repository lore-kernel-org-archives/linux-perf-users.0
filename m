Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873835;
	b=BQRj2pLettsN64YFXCSruX5Hxaxf3+5wdCaUhdop0ZEsknZuaIaco+aLZTm6qTbM1zZB
	 y+yU4Zppi3ZOgpjLxEZOt4xZ7wyirMa18it4TR/6wB17HSylC9UL0vGq4S8ZPOy0kOOY+
	 o+hIbn2cWTlnqT5kuS4cudWTrlEWEPIF60+ioTPBFDvFuvsFJj3ktwOSrt4pD2SPgAb38
	 oM+rMfGZGVVr+Oq8z1jflN8RzVnuD71tg0BsMN1uMj+sC3Rm+xy/6QjK7p9+BsX654dPb
	 WNlpbrvERP+j3iIDEzSuHr7obFv0neIoyGJ75uvFmsTZaFIA+BJjvDEfNCzpZ+6H6+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WGZ8GA0J/zDFCNwg43i7cStKQvXj8elI2gFGDalsweQ=;
	b=X+eIBX9dU+g+CE+sZc7+bTTf9wwTP3mldb35sdbm5D+mVz793iuItg6pyv5asVTgXyEF
	 LP2nIPdt9kEkdNgrkh7hT3ci2DPxgHusopQP1cdJ8qaevOj0FTFV4llnLH6viZpQnodk3
	 lBA4BxjqXDav0Asn/dY2WWeTxGKCkNVvPAem4IXlMuDGG3wgKIFsDhnyQDG//yVvro17L
	 itoGeBJCSOBifwyMx+jp+V08pcbinbCfEDPsWkNgEUUaLn9g8m0Gt5DJ8ZOcGDf9XUT+f
	 z+v87T+UNcXdC/BNx/BHm1fiBQM3jVckr4f4Tdl2LOZIw9ptmMucV5ckwqjX0XSmGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4ljM4O9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD0606A332
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4ljM4O9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E5D1F000C4;
	Tue, 17 Nov 2026 00:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873835;
	bh=WGZ8GA0J/zDFCNwg43i7cStKQvXj8elI2gFGDalsweQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4ljM4O9STqTxBPow+EWOVoty/Vhoq9YWPFQndPtSyjCq8V6YlyQH6lqBFrXwuxQ5
	 YRZuaUVxrCm6B+kUk8xsOk23DZBqJkwduFSCdQfvqvFlz377OecND44fGOvA0cHs9i
	 828ghPH5rQq+jez2KJJ2t4dIr1T9rX1SsdEWsPsexBjN49SEwkEaDp2Znj0cFUhrWz
	 lG9uFpVpsDe8rPv0oHroG70bZ+lLrKC3FDPukQemegR7sV1gy+Dik9sZstdaDPCYuT
	 U9fvjgqLV+qpbilkZPpk0Bjj5lazoYeZ5L0PaRmlo5TOmklcQ7Nin75L6k8tMLUm3X
	 XaZwjmMe+0eBw==
Message-ID: <sashiko-outbox-217971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-3-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:03:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 32-bit x86 accesses globals with absolute addresses, like
> "movl %eax,0x8c73448", but the operand parser only recognized the
> offset(reg) forms, so the operand had no memory reference, the resolver
> saw a zero data address and resolved nothing.
>=20
> Parse a bare number as an absolute memory operand, leaving jumps and
> calls out, use the address in the resolver, and let the instruction
> tracking record the type of an absolute global load in the destination
> register.  The displacement is sign extended for 64-bit objects, as the
> CPU does, and zero extended for 32-bit ones; a zero address is skipped
> by both users, since it is what an unrelocated operand looks like.
>=20
> With bare numbers being memory operands, a frame base register of -1,
> "none", would also compare equal to the -1 "no register" of an absolute
> operand and take it for a stack access, so guard those comparisons.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D2

