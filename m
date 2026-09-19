Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3C1A6835
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800324; cv=none; b=pO3I1zQoWXwhkmtV6YkIHJU4HzT9VjvtUep9kg7GfXfNSKXx3FZH40/9BUyTWSr1evvz/veKXfpstjBcMFAxdZNwOqVHieSQ8mUULGpHnivU1Rv7O8kftK6IFJKCpN8ekhtETC1y7MPSEDpinA3yb7zqwAi7jMk84tvmNei+Bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800324; c=relaxed/simple;
	bh=qylvvpkf6jhRb1UIU6r+YBRiUhl0RjB4okxZvK4PjVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGb7/o001CffD5CeGvBrIYsKKgl0N4/eltYuskz6elf2PkKRAWysiOO8PvoywDUySkt1k980yUvC9zXy37aOVZWXxriQr1bFywhPCCvqEN/7Rir9BZurMB09glyMmklgpP22bk1GfmxVpFRRrkd65d6bmW8thcp3wFpjn55T5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFXYiLVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFXYiLVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092941F000FF;
	Sat, 19 Sep 2026 06:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789800322;
	bh=O6uveWxW20zV0ZI1bDNjzfw8eNXNn0ph4YM5bbIJbjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iFXYiLVE0eAdCeX2Rf2bqAVyos/J0EVhitd7QG1BxDcNh8Wxsp4GhqKRkVb/HsGOl
	 0xENpp9G/ADo2Rfo0cEvbdaZjzTIQ8GP2b/7nJWT9e6o345LBJtpYK5w4z7WC6rQlI
	 SpnhjqTOL+K8lPWfBNJLvjGKNVQKZJy7GeASilwxGdD4gXnGPTDtoAyPxIdqJnLlek
	 xTxv4/AZJwxVM6qpR5hrKUZwpcsPMhp8dT/NImEBmtOs1bJ3i4n9gRuHGzZm6qirgD
	 ihK4px4FXmBKE8qzuHsg22sUZE9gB4aahnVu8oc4Z3f2JBWM9SD9qjQ+iTqeSMXOSq
	 v06kW4ukdqp7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] perf annotate-data: Allow out-of-size access for
 flex-array types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919063745.48444-4-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
 <20260919063745.48444-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 06:45:21 +0000
Message-Id: <20260919064522.092941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Structs that have a flex array will have accesses beyond its original
> size as the array was declared as 0 sized.  For now, it just allow any
> offset bigger than the size.  It could be refined later.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919063745.4844=
4-1-namhyung@kernel.org?part=3D3

