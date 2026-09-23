Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0BB5172C2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188433; cv=none; b=CsFC7L7vPZg9bngbMXb8NESzpTnshtXQL/y6aukAvwyBIxGbUN1ViWuhH1e2cLBFiurBOwr7OFhkZEAmitKJk7s85+Je/1xmTL7NLT65gWQYI0OLTVANjE2WoiuRdtv0B00OZKy0PGuvMpo2nsb6JJeLzreJhGlGbb63w3SnVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188433; c=relaxed/simple;
	bh=O2JB7Aq9mqOXsH8aX3Wyraj7sIm1wKlFFmcAhly7zMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wz38EMJARCkMdzHoWwKqAUqLRNk6SXxnV2Y5s9xBozvstDNxc5h1oDUCYp3V1FBhqm308ycejuYLkA1o6cFvAwdzqHiBJJzlXJyYfQJ/M+jgjwsUkU1i5oqvTrver6vQrNVcQzLHHkoClnGbLQiqkj3XxgX8/js1sI+l2Xmz5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1INkxqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1INkxqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBEF1F000FF;
	Wed, 23 Sep 2026 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188430;
	bh=9SMN1ogq2rQnrNWYXQW0Z+b9nuF+/fJLtRLx/uMo3jY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1INkxqzJ7NTZAL3E2UMspWmvn2n1ksfRiRJhkhSKfDdXgYq8bNtBRTuX/7DuR+/g
	 tJxmyiOqgA5LDPfOHTsng14ukX+rDTr5UG369z3sBI+L8KYOSb1YPZqOl+9EDBwICR
	 UbnCIOJOJkAuUets/IEYM0F9I4XwpCnNsc+XB9vvkD9LN/p9S8UAPUQzKT1J/86FBw
	 IxGkYxzixpPfsejuAy8u+NTuJ3/fhxivkFb1o1g6j4wOzhVVpMwdx8cFv0geS9Bydy
	 9MlMPPezWOb3to+l6QGDJu/ColMuiC0plhxbnRsl7e9f5NWqcUT1T4f2QGKiX5HGV6
	 vOKiZ1RnLJw7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/49] perf python: Port failed-syscalls from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-26-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:33:50 +0000
Message-Id: <20260923183350.ABBEF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script failed-syscalls.pl with a standalone
> Python script in tools/perf/python/failed-syscalls.py using the perf
> Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both syscalls:sys_exit_* and raw_syscalls:sys_exit events (the
>   legacy script only handled raw_syscalls::sys_exit).
> - Use session.is_64_bit to distinguish 32-bit vs 64-bit unsigned error
>   return ranges (0xfffff000..0xffffffff vs >=3D 0xfffffffffffff000) so
>   valid 64-bit syscalls returning ~4GB values are not misclassified as
>   32-bit negative errors.
> - Add argparse CLI support (-i/--input and optional comm filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_failed_syscalls_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D25

