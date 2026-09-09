Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8513C3C0C;
	Wed,  9 Sep 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986703; cv=none; b=g6kLQj5yuhLDv4oGthawdzIdzaDCgVRLeXQr4plKgpSTwNoDfPcAe8ESWr7HumEqxzrBIb7AdulD/q2vF1QyHrAzCjJqPPahpVfL9LOsKxmf7TpHQ8G8tW/0i4AvMMua0gCBciz1NjihZtblhdV5w6M1abo3pTeojHPRaysLjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986703; c=relaxed/simple;
	bh=mg574GI5oTWonlZR/5TynmnjJyxQdnuaT1M/RVNSJBY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NWbE9C8SHG4s30rqicfItjRVZmhndgolPZ6qEcoSmkcGVKPYijEh0zcsJy4TVTOESWlK/Mg26hkuPtJrNZMB+nVL5cpmiLJcm1f4InbxqcrIntjF326Ish7W0dL6qGKc8belhrJpUsrfPrCHGHBgOj/58nBkLuOdFNWxyyJYYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoDc64Nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoDc64Nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29651F00893;
	Wed,  9 Sep 2026 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986693;
	bh=mg574GI5oTWonlZR/5TynmnjJyxQdnuaT1M/RVNSJBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RoDc64NzauZpSjxTZeYAV3KexjBguI3f50BytPGQn/X7eCE8TAv5lkdL18pLVbQ7f
	 6E3duuZ7PkIcaKkrMA2h/CuvMz6f7krVY9YLEDtcqBGRRDHZXuCvclrl0rpV79Uwon
	 Nq7hIWRYhYyPHKrxuFNOGRWffKDsuT09gArpGc/JMX89pPITx0x/iV7nLlMAx9RV/y
	 QTCQ8dPoe9QbXsCUDk8NBNCIe8NPXm7rB0f2MX5MWgQPCw0cQBRIn44zdvPFBpB1Ha
	 tp5w/KbRSMBigSg2AEmDoyVeNAjs02RGVvR8WoslxwFW3ViwHHGGuiRUGA31yiPwrb
	 Jhab8z5hbhHQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260909204122.1993010-4-irogers@google.com>
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 20:44:52 +0000
Message-Id: <20260909204452.F29651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Distributions like Fedora currently ship a statically compiled binutils
> libbfd that natively depends on zstd to decompress sections (e.g.
> undefined reference to 'ZSTD_decompress').
>=20
> Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
> bpftool's Makefile so it can natively build against static binutils
> distributions.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909204122.1993=
010-1-irogers@google.com?part=3D3

