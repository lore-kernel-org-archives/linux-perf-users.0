Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703F3D3D00
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882566; cv=none; b=OmtOnhoYns+GbJiasTjmgx6zSlu7+HxkkWb1QtT0T3Kpr2nP7b94LJbkMSVBabcRdIkcwsO7Q04PzcYDv04C9pduT7pQ0CQnBK7sNh/nsPc7yGVVDpgwgaM1kMvOQ2elJm87OXtwRPfZ0feXahpE3UPg1siQe/abtItn/TYokcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882566; c=relaxed/simple;
	bh=x40kPO6GV5FXp4bNuRBYHPwk+IbAGYOFPS2BcZRlR0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ohg6+msi3MVsxxAl4/m3sHo2OOqpGxXNjSY0TWml/tr6xHMEF7jhwz3UC+Q6JHrA8HTpsZ53giMuvvEf/2O7o2IVilUIyVpralrM4el/HC19cLOth8G0JLWkPJ9sMFFzrWcC6TqEsQMiWQoeNCHHYqOkO9NhWlgln653/NfB69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcgotfMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcgotfMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC0C1F00893;
	Sun, 20 Sep 2026 05:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882565;
	bh=HcphUhPzBj3Bn+k+VciTzY9ayWXtK92ce6v/2MuycxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gcgotfMsbd4T0odrmzQVpZkBlSBYelEwaa+9AWb8PFimso1QjOa0WY0RpZwCm/zCd
	 5758mKVWUVVoIpUUTnTSXaD0xPIZUPAeXr4Pdv5LIBp9Ykiq2282258MTrihaMUiY3
	 GUaSy3LcFfZCd8UNp2+yofPG+G4jqTTS+BUOyyS/sOwPbje8aIAmfpZJ8IqTjSvoKx
	 +PAjAbm0gbaYypqlDmVjjP1YJzjXpP32v9hNwIpEylGcj/u9+BhO+UxWemDSPrm3WU
	 sn97oCM3cvBZ/pdG1q+Hgn+UE6vuDb/hRE9YLADJuQk4DTdIf3dHI603s92sTSpuU2
	 mlvHkX9kGyezQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 27/49] perf python: Port rw-by-file from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a0b402bbda769485060a543060e543906bec06fd.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <a0b402bbda769485060a543060e543906bec06fd.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:36:04 +0000
Message-Id: <20260920053605.5BC0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-file.pl with a standalone Python
> script in tools/perf/python/rw-by-file.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Encapsulate per-file-descriptor read/write byte and call count
>   aggregation in an RwByFile class using perf.session and resolve thread
>   command names via session.find_thread(pid, sample_tid).
> - Add argparse CLI support (-i/--input and target program filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_rw_by_file_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D27

