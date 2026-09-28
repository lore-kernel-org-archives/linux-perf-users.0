Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEC4BA1CD
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597062; cv=none; b=ktaRH9kHW740he7WysnbtbAir0N7PSYrlJ5mg/YBrhKsrb7iNwfeEUPqWh1mrfuTjWlIPL8z7GWGhSJ28IVEzjb4Jw1xV6g0X8eTe3zQbFJsaVNmYji2g+mSq9Ur1QrCrzkG1MI8mvMdWKYK0UxoHUHs9V1W3+g9XVFr40/+I9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597062; c=relaxed/simple;
	bh=g5H46M12bgTpD1Gq/7G5IJOyBQERgaEEp9jkVuiW60c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pEBz3op6jB2NjmqI+Qc74ZhcKxx6SnQLf2X1fLbZ1wFVLR+CxXbGdZYsU3kUWK2OO/WO7fYp3Fm6OXjMgFHcwcaR6eDq9ufY+HoOWBCNr4mphyDo/+sB36M8PIvqi9UCI3M4MnN1VAfDS8+2B8gZCMi39XtHHEZQ3/cVcwEIDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc8/rBv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc8/rBv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1031F00893;
	Mon, 28 Sep 2026 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597060;
	bh=pf0F7L68Z3KiAyckkG/gmiHplk5JMr3zez1zEpj7KTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mc8/rBv9A0DwzPDLaeg1dQaOvz9DghruGiEFFFbipYYXfVc3MF7oyFriGdkC6YpS+
	 NUCGzLBLr3LGnV/KslJ/ujOExGrynzSRajo0Zq9OdmZBOWzlOfIBrKRY0yska3G1/U
	 c+AT5Y3DZQKrEwEEoE/2D9At970XsEBaUa2hWdWAaLdsRZSIagA9+TwFSOc3go91U5
	 UYXKQteOmrEoFP2xkdbpRQ3wdskjTH7d+3ZSFnrAdXlxZ+SED1k9oC2qta1aca17ks
	 dF6ZcwuUMxlswT77C3gS8rPAmBm2S/v08/IHtnrZAnhkSGMU9innnQptdQr9JpW9UX
	 JgCZ24s3klWFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tools feature gettid: Undef _GNU_SOURCE before
 defining it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <arpXYeRUu3B-ouqB@x2>
References: <arpXYeRUu3B-ouqB@x2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:04:20 +0000
Message-Id: <20260928120420.7B1031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Since most of tools/build/feature/test-*.c feature tests are included in
> tools/build/feature/test-all.c, we can't just define _GNU_SOURCE as it
> may already been defined and this will break the build with:
>=20
>   acme@alta:~$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   In file included from test-all.c:26:
>   test-gettid.c:3:9: error: "_GNU_SOURCE" redefined [-Werror]
>       3 | #define _GNU_SOURCE
>         |         ^~~~~~~~~~~
>   In file included from /usr/include/python3.13/pyconfig.h:9,
>                    from /usr/include/python3.13/Python.h:14,
>                    from test-python-module.c:2,
>                    from test-all.c:14:
>   /usr/include/aarch64-linux-gnu/python3.13/pyconfig.h:1810:10: note: thi=
s is the location of the previous definition
>    1810 | # define _GNU_SOURCE 1
>         |          ^~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   acme@alta:~$
>=20
> I.e. pyconfig.h is included by the new test-python-module.c, that is at
> the start of test-all.c, defines _GNU_SOURCE, noticed on Debian 13
> (/usr/include/aarch64-linux-gnu/python3.13/pyconfig.h, libpython
> 3.13.5-2+deb13u5), and then test-all.c includes test-gettid.c that was
> defining it as well, undef it first as does several other tests.
>=20
> Fixes: 1b7e0280e247b93d ("perf Makefile: Update Python script installatio=
n path")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arpXYeRUu3B-ouqB@x2=
?part=3D1

