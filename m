Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D48283142
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969828; cv=none; b=I+b0urtj1EX0MYxY1KNrXkJLMV7aQxHwR32gx5YjbT/NVvuFaSwcGL+qWQN5RVZS4CdEfwWVwLXY+3PGjCpbvSrIxUfIbgkk1NFzUVqG/VStfY5zLtQ0GgD6fKLphbrhZfhnahy7TR2GITy9QR8wxQUFMco2h4k0lklsaQmbCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969828; c=relaxed/simple;
	bh=FGqfMY/zJpY3SUwimHdzy6XVHRryZi7GlVq0HGHmuM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PPks4YagKs9zUIcZXQkvGhrPuRu2FWjpL5/w2oyP2cOTpwUXywKrWDKQbXjV7x2WVzFbEEqc5a5pJwQLt3nORjuxiXAJEQPHWIVc+6NK5+H6o7cFrO4wmqQOlmKbERAeb6Fce+c8mQsnxdoWrs1r/mwYyyx9N+B0FYsNFhHZaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D20aOmvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D20aOmvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E1F1F000FF;
	Mon, 21 Sep 2026 05:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969827;
	bh=FGqfMY/zJpY3SUwimHdzy6XVHRryZi7GlVq0HGHmuM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D20aOmvdvUeJObyXAcz4XJxUqid9StIfDveYOadyge4oOfD3oTmR+IuhJ8zNrVQKt
	 cSnR7QgiCehsIriluLr7qx8bVxN02Qav7Uu8x+bT1itTJgamB5vyjAgHtzZIaT9PBQ
	 fnpDwdDUSgi9NxlRcPYM2AEzsCNJdlxDtuRKCqbxFFhvD3iB6LDJONodlUwTPq4jcz
	 AXp0hUQ9DEJ2+QbMu3IT90LUDZffONH5DuX5FJh1PmluXucciEKUPys3m4LpinrJYE
	 lvj3asqZ/69iTJNbxi6bl7/4fNitskuz29QNd1x+koUmAzsiFERYdeYj2Moi7+FDZc
	 4/AlPUGFQKlIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 47/49] perf Makefile: Update Python script
 installation path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0cc2018c2be53fba9156d8d1c54d54db205e0d13.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <0cc2018c2be53fba9156d8d1c54d54db205e0d13.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:50:26 +0000
Message-Id: <20260921055026.E0E1F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the libpython feature test with a python-module feature test
> checking for Python C extension build capability, and update feature
> test references accordingly.
>=20
> Remove references to the legacy scripts/python directory and install
> standalone Python scripts directly under the python directory in
> libexec. Update the TUI script browser (ui/browsers/scripts.c) to
> discover standalone scripts from the updated installation path.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D47

