Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55728366542
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182460; cv=none; b=nz17X9UN8tBIVdb8WUWfgh3zVmoM2se8sFRqN6AB1BeWib63f+AYmHLrPA1tetaeGbdx46BeLu+3MzDdkMR4AHpp+KpFZPcVNqbg55At+b+hJpkjd2/uE01yoVj5Kwqw0ZRmZLh5XFotTE5glTvL2Uq+5gtK58dUEg57qffbE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182460; c=relaxed/simple;
	bh=eqdEkoAQwc1NswqvQHOcxgPUXr1nTFtGYy19mIktkuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nWc0FpbsvRJYK4ud0JJe+Gr5+ywtFWKc9kM7UeXE3/d/Rme/BQjchXQ8bb4roGgjPQenk6upHnBycGshea+OexJPyVFr6DozM0IrKjShVPBevTC4cSBbPiNr+8YauNKpaHl5g94rULyMkf6MWjMTn9tEuNEfGhaKM9HURety1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyOukrCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyOukrCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F01F00893;
	Mon,  5 Oct 2026 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182459;
	bh=eqdEkoAQwc1NswqvQHOcxgPUXr1nTFtGYy19mIktkuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fyOukrCF9EYh92DPCp6ov1OREZonw2PO45SJwODtk2MTGmzinL9cOHBmgxZFnitSi
	 u8ay61lEJwzw0zSCEi3mwzMr9Z0tmWoZVMN7TQz0WIPmMN/2n7P5Ba5Ub8/YChgaGy
	 C90RsFyDDQeqOMZ2bpGSIxLgJKFDzAuP/SRuK5D7XxweFCCALMbSjeC4r/WXb/EXj9
	 hzfWj3Vkk287vfqeKqroCyGTMyQenCGCZUixDkfFCKs5D3mQSKTmQvTU2p3ci+inTy
	 chI4ZvD069TjefbFqJcQQ/j0ObWdCtB5YT8a9VL/du4KxaRB5Pfr+Bzym6p/IJ3+1R
	 /LAjNkMCenbcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] perf symbol: Set binary/symtab type for split
 kallsyms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-5-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:40:58 +0000
Message-Id: <20261005064058.EF6F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When it creates new DSOs for split kallsyms, set the binary and symtab
> type to KALLSYMS properly.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D4

