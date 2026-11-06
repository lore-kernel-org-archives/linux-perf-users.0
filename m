Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931884;
	b=1wIUYqKH9Kff6eluPJbNGTj45uKC62F0RfsQvCEMx06zBA4KYK5GJrKndXn5Y0NPy056
	 TtbJy+I07THfI2snjGUzW6Zud3QrTRAi0Bls5Nq9ebWGWr9ko1rxxL1PhgE30vG9CJLbi
	 shjvSGtkDB3cMZ1mNzJTvN2N89fFZOoy8qL+8uNAYRwVDpuxTifb3e0HwkUIGu2JftOdr
	 dddGJGO3eR5NxKbsWWAb2M031UjJPtUOAPE3iJrbQqPiPBM3Dglc8wQ/hvR0wFUM/yVUR
	 QM4vz8XaSrTU+by6lfylqLctDm5QWdHSLuvnFoiJCIS4Ni8zeTPC5eoEh6+BusFHeIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+OtrpvjnDNgvH2defLdCQjh/tJrX8Y5edlbiseWT79c=;
	b=E06jqhnZBTOcGo+VFxSbVIakj8frlcaBjNzgXnPI/q3pfB3iywZHuhfsVeVlojwNzt02
	 GP22ndK2jeAtRUhAgTI2uvzkBLL4fE2bMLZS0wG76Kconr2mZhdGRrF7BK1QF1c6IIZNi
	 +c2DAkiXhE4ttovEfh+OiVS91FFzJYYAIPybJOprSreZ9GpqL82TjqHWS3yCjwZpvEFZz
	 EggWLDcLIDrX0WGRlg2w5XtbgM/wvXHOiZemTXtWgKKNvluU1tjSTONlm115NIcPGSjWq
	 PB5xrhiByLYok1hOqhD4MtFChR6himxfZlkAdXyJ/cTXeMPqs1rmA+CcR6+GkF2sjHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gch7uPEf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18C606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gch7uPEf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29BA1F0089F;
	Fri,  6 Nov 2026 02:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931884;
	bh=+OtrpvjnDNgvH2defLdCQjh/tJrX8Y5edlbiseWT79c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Gch7uPEf/Npe0tcFbU7vNkaZrtknr71isetS6K+rWRchD6THteLoYrUfi+TV1Rlko
	 rV8DVAHhWizrZg78Osr8A+NsZLrgCau/SgyQdCcp0fNX3fQgWalwVr/AQRTXuiEX3M
	 rTt9tajD+jHIRjxWceKvOTsDSkrkHBKHj7FtCym4jEkTQqII99ApMSb402ybCg4lAw
	 zotktoQTY3rO3txb+bavj3j9W/xbWRC9l89SEBgeD5qjYG3Q3v51mMUuF4/RbdOadq
	 LifAfdgm+caMPXQQBpBfO/GpHQTk1Wr19mbz/ASTz2yTg1fAobFq744m5RRnDgalPy
	 M/2POwcM9ndww==
Message-ID: <sashiko-outbox-200590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf iostat: Preserve the port count when growing the
 list fails
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261106021913.2341-1-lirongqing@baidu.com>
References: <20261106021913.2341-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:24:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> The root port insertion helper increments nr_entries before reallocating
> its pointer array. If realloc() fails, both the scan and filter error
> paths free the list using the increased count, reading one pointer past
> the allocation. Failure of the first insertion instead dereferences a
> NULL array.
>=20
> Grow the array before changing the entry count or the port index so a
> failed insertion leaves the list valid for cleanup.
>=20
> Fixes: 19776d3cede7 ("perf stat: Helper functions for PCIe root ports lis=
t in iostat mode")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106021913.2341=
-1-lirongqing@baidu.com?part=3D1

