Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC6345ED9
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882572; cv=none; b=sx3F+O0JXGEdP+IpPB28GDONzxtAfP4G7iPEi+yGkLWAtERLgGn+ZNnWMkjlFSJKzDYmwrrXCEt5uRf7ZCCvIjvUgkiwa9axFE4smI7nsynl/Pr88xGL1Px7tEo6yk8xxgElAs+k1Udf2nVLdED2frwPg6jBhXPDB9TPkMeMG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882572; c=relaxed/simple;
	bh=WjXQPWv21ntv6ByCCIBPaYVqdjMhCaVeSxea6kpfc6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJUqiJU2dDt92KCuG9WCn7pR55GaX8k5VafVeX84EbXpCbF/bNKLr+xeT1CA11UjYz5cu8XQAwtBNcDovJ8hKJHC+mTNKJqFTx7qS2mbifzQirArHM2FantFj91LQnzlX0bwNXiJtH0JMuhrVFH7IqiL2cUwYw2uJ0WOKVtZhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRszuFXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRszuFXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099FA1F000FF;
	Sun, 20 Sep 2026 05:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882571;
	bh=p2Y8gTGHmcw2urAJCEC5l2PzWHEv8cygc2clPgdPlM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRszuFXp6iPDeL4OtaZOtHDvhPYjoAosc9lZ76JVq/6MXwE0VQEUMYRsKjBJLLse9
	 a5ynyRnyLVmGRTU8KeG6aSKcRS6wpD2wUvTAlicLb3Pt+8NTt7pXv2hVaBpbdOcnAJ
	 5G+4dobiht25sbzprvJM5mYOZfOqerby2bT8dp04mq0/zKQ+23NkvSDlEiLzjgdGd5
	 dfa9mV2VtIGOx7mRlDlYKutiNO6GydXv23eJS1OFxxiTw+lLbopg7eC86m3ez7hCGW
	 ojqve/LukZb2GJ01a5kX3kHethMkIpZNEQluq4xuf0lYSiqevicnoUiQz3zS/hObiM
	 QWRspQ8MVlmlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 28/49] perf python: Port rw-by-pid from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <87dc74b960e57651635d1120d465cd37b8d7ac9f.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <87dc74b960e57651635d1120d465cd37b8d7ac9f.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:36:10 +0000
Message-Id: <20260920053611.099FA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-pid.pl with a standalone Python
> script in tools/perf/python/rw-by-pid.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Convert unsigned 32-bit and 64-bit error return values
>   (0xfffff000..0xffffffff and >=3D 0x8000000000000000) to negative errnos
>   so failed read/write syscalls are recorded in the error table rather
>   than inflating bytes_read / bytes_written.
> - Add argparse CLI support (-i/--input) and full type annotations.
>=20
> Add a shell test
> (test_rw_by_pid_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D28

