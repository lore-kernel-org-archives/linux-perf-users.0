Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B73F5BC5
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108931; cv=none; b=q9ga8blfFrWDT4/bVaD94xdnyFq5dXLAchjzI1eSwSUwPZqaemMcw/6eJXctfvqe1FlASiXlqlffeigcL4JcWTC4QjnqkzaoUdW3UMXmk+SfWtDmfRKXuLBwpZrbHZNFHelCGjVSINFI/Lz/DhMHPHYwI11IQNbYAqUJst1/VoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108931; c=relaxed/simple;
	bh=JOayaKeDLFGp7J7cfYQ/Gn0P3ws1qUDyQjKlBgGRfb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mzpX7zOnTe3VVmjXgyDZIhiqcGg+TU3uNdkffLk22/IbkLsuhbR1DecCZ7Qca5Tfi4HPmXWGbfEC3PnIG4yi1BjRf143o/z3v0LBfHQ7icZIZMzFoAG6tphiI8uelbIxMtDX682+QDklzU5Qy2jx8phaFg/LVnhPk4huChYjrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dExSg7j2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dExSg7j2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CFF1F000FF;
	Tue, 22 Sep 2026 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790108921;
	bh=JOayaKeDLFGp7J7cfYQ/Gn0P3ws1qUDyQjKlBgGRfb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dExSg7j2ClPuszuoxUsF/+yF9e/7vxaZqAPj4V3gyO3Pd/r6e/XR8/aa94WLEbjUN
	 WTn1v65K50/1bzpT6cmKhkk7vQXk11iCbkgNlIHFzWFWxWAjCdIMXIkZjf9GS7HIc8
	 Cht+61r2ZL/dC9su9PJ9JnzYIYGJ3b1CMpwlFSGc51I7+xjTNrpEFeY5/QDBwH2O8h
	 EeK+hsrV9S34O1JHFd7It1TVlEs667rxunhW34Aq8dTwruy03TeYhM597B0TNmf3fh
	 /4XmaiAWjnNlioZFgl9kJnPxUkOfss5HNyu5T20VG5UhDXS1zxRsPucTZCHsTKD1uz
	 Z7BTuKbLBf+oA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922201507.1719668-4-stian@itx.no>
References: <20260922201507.1719668-1-stian@itx.no>
 <20260922201507.1719668-4-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:28:40 +0000
Message-Id: <20260922202840.E3CFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the sparc perf_regs tables and the EM_SPARC/EM_SPARCV9 dispatch for
> register names, masks, ip/sp and the perf-to-DWARF register mapping,
> plus the uapi header copy.
>=20
> For libdw unwinding, seed DWARF registers 16-31 (%l0-%l7, %i0-%i7) from
> the register save area at the top of the stack dump: the kernel flushes
> the sampled window there, and the CFI after `save` needs %i6 and %i7 to
> find the first caller. The dump base on sparc is the biased %sp, so
> read words from the dump with memcpy rather than an aligned
> dereference.
>=20
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922201507.1719=
668-1-stian@itx.no?part=3D3

