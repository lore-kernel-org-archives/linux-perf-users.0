Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60349DBAE
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442451; cv=none; b=IATRq43Xwqj7ylY11mI3z8xsvLhdhLM6bynszD230j6/52ZPEE9OUeCrJ28itqSThCfgsi94JrtpLE/3zxEFSSV1qefBkdgrFY7AsheH8tkpV+PCLYo9WtLzmGJ7k58ORZASOu2XRa9oV9IyKGodoW/yUigoPIvAK9bKFGbEq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442451; c=relaxed/simple;
	bh=Beq3mXfEpTpdki4aZlFYgU5M4Kim+fCy+pBZ1m5CCVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOLpvo+y6+ERziCzcMb5n1PA4AhL97r7jKDYNV9E5gDAcixWRX/ao1UVMzN3ivcVbLsBKnO3OPx4b04g5RfapMVM8x5HHW4j6nH4b+F+IjfqsKver+q95xsaLe55xa278STiQ7G+dO/NpQV//BhaPKBPIIGAOSy7sD9VA5Wo+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsiJtJxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsiJtJxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F03B1F00A3F;
	Thu,  3 Sep 2026 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442437;
	bh=aoLK3NzQQLefUwLTPCXb9TS3ofa86PsiFckKBjKuI68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dsiJtJxhnmbqCQ6/PUECVyeK2dzIjES3xI4m2FERzIHLHO4Z8kCNkJsGBFk7pMUgg
	 jZ5kPuPDCYUAOANhEwA5Qua9grCcowgspAq/O7HBbDySH21LEMk0+MM67TI81FK5qs
	 4uj4D5Xh9YWWXQxu/fUzOJRBYrmNkgFl8lYxIbmcGDzX0W3fgCyJrWV/UnHqMK1Bin
	 eHf/LVKjc26kyT+u+j9hMrCf0eV4EL1TOAZAYa6juzxdnIC/4GfpRVnGd69IDUV0it
	 PYSgb+HRMiIVCmUSyvmgA8GJq5r+0ci79/sOo4mH+VTUILvPe3DBs9enRzwtr8a6JC
	 +bDUrYJJhl2pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf jitdump: Byte-swap debug entries via
 unaligned-safe accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903132251.237029-2-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
 <20260903132251.237029-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:33:56 +0000
Message-Id: <20260903133357.4F03B1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> debug_entry records are packed with a variable-length name[] field, so
> entries after the first may start at addresses that are not naturally
> aligned for their u64 addr and int lineno/discrim fields.  On strict
> alignment architectures the byte-swap loop in jit_get_next_entry()
> performed misaligned 64-bit loads and stores through struct member
> access, which is undefined behavior.
>=20
> Use get_unaligned()/put_unaligned() for the byte-swap of each field.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903132251.2370=
29-1-acme@kernel.org?part=3D1

