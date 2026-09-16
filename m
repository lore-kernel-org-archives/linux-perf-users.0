Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688743DA5C7
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559973; cv=none; b=XSDNeLtHQLRioMQo+cuV+jFXXaVoHX3lvJ94GP1YrHqYsS0/xPj5t5NkBOdo3UyaQKPZDFAcXeUnLdtbd5hILrjOCP+q7KnUrcVkdmMFyGW3/JIw7ehnXzaQ3Z6hi7eGpt2d4Kg1QARWhJSKJiqw+Tmj7Hgsv6zWFXYstWdmqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559973; c=relaxed/simple;
	bh=M6lacqDYRP8LBzhb/6D2W5gQC3IwrEY/mQ2VnFHWes4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N11/L9bHlxHHgDOlI2XBqjku+I5fct/7tvZjPXNE3i7JlEMHNTCU/51CYE9lczNhLI6aH33oizfQxd+cScbQ939cxmdGXDH43VxqKHCUvhaJmaJ3cighdCrsQ0erHCkBesZD6vfNE0NV+BlZAGoaniMGis18HCUmng/1nkt1Kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCkUGItc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCkUGItc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D15E1F000FF;
	Wed, 16 Sep 2026 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559964;
	bh=pqeFiYyAv5VapOxt/aEN6kA6xv6SFYP4/eJINYcdsaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VCkUGItcdFOHNOGT/wF+lOQlS1/+L+zzRMKyI+FLfhtdxlGsFzzPmDihSgYERTwms
	 gkEY00bkSdWy/fW16JDRe79imK8nkhQH93GgoqU70gLnZzvAO8mg2sWAmzvnhOZa0n
	 evO3S6NShbOZEXkT6tWq0Ofoia3yQvFxWhinYX7LcqiiMNdprhm7xcX+t2kLq9W2Zd
	 eoA1D4upJ+YlQKD5npmh1ds2l0GsBf269wqlxfFsGbvBXWpXh1Rg2GV7esr7zGmuDb
	 Osl0C6zY6RxTsuZs/gjQnisT0cgNJzkpVKX1BX39jiDYvZ0Fdh6Ty+GnBPTCPq+/n1
	 EPmuQ6UF2HOLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf debuginfo: Let the user skip and disable
 debuginfod fetches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-5-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:59:24 +0000
Message-Id: <20260916115924.8D15E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: Thread-unsafe setenv() during concurrent execution risks c=
rashes
--

commit f05833c6d0f3f46ab299b21fc5d5d3a85ee8249e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Let the user skip and disable debuginfod fetches

This commit introduces interactivity during debuginfod fetches, allowing the
user to press 's' to skip the current fetch or 'd' to cancel it and disable
debuginfod for the rest of the session. The terminal is placed in raw mode
to intercept these keys.

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index be5882d9c2204..e2066fce2450c 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
[ ... ]
> +static void debuginfod__cancel_key(int key)
> +{
> +	if (key =3D=3D 's' || key =3D=3D 'S') {
> +		debuginfod_fetch_cancelled =3D true;
> +		debuginfod__skipped("Skipping this debuginfod fetch, this build ID wil=
l not be fetched again in this session, press 'd' to also disable it for th=
e other ones");
> +	} else if (key =3D=3D 'd' || key =3D=3D 'D') {
> +		debuginfod_fetch_cancelled =3D true;
> +		symbol_conf.debuginfod =3D false;
> +		/*
> +		 * libdwfl's own debuginfod client reads DEBUGINFOD_URLS
> +		 * in every query, so clear it to stop it as well.
> +		 */
> +		setenv("DEBUGINFOD_URLS", "", 1);

[Severity: Medium]
Is it safe to call setenv() here? Modifying the global environment can
reallocate the environ array or free existing environment strings.

If another thread in a multithreaded tool like perf top concurrently calls
getenv() (either explicitly, or implicitly via libc functions like localtime
or gettext), could it read from a freed pointer, resulting in a use-after-f=
ree
or crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D4
