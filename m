Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331B369236;
	Tue, 19 May 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220445; cv=none; b=X4aIqRWqoS96IXsokw4gDsKoC7iL+jR0LFrG5WY4PjvKikQ65br5EoJJ9OkyaKqUvEjfa4V3mLJA0aX6xirxF+PsMx1WTZ8BhZAIHCI7POlzqw2ydT0YQDEtuejh/UpoAtKR5h3BhtOt0ikgLVuqUk65nRWJj5v+wqIx+7y+Dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220445; c=relaxed/simple;
	bh=RorHhA8ruz2tPyJmTFqBrTEog9o9Kru/OzYYgz+2lEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvnRxZGBe0EFcluqV22lqusmn7Saspe6cyjdCAe+EdKqAqX6DWyNdsnSdre1gLYHpz27K3T4pSO7YsDcTcVqoigfJsM7lV93wBMQKFvOkIhyliIkEC3n6oU2Vs3yzWOeTMLdZXA+wrGMyIC+cy808hnqa+/nvQgUBbGRT3HAWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P70jYKkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P70jYKkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40F01F000E9;
	Tue, 19 May 2026 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779220443;
	bh=vWOIKq0OOgXucHtCGo6sCgOWXH+Ief2d3lc+BJjtVOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P70jYKkDmyL1fyEVhNCaZNYpld6L2YjmfuqoqEUeIkGoPjb1k60cWkSSl1cOsyJG0
	 k0upor+0DL40j3CdqL9QBcJMFkdzxbzBcrhlRgmuDv7P3GL2bAjsi/k1rHSiONIhdf
	 qrnV/UPmsl2wnsryXcUqi6Hipk9548d2TACJzfl7J6A3els0Ozgfufla/LMdMnVCwQ
	 iKhoE+EbNDRpY//sPQ90YJ796HhtMjvyV0vj51Io1BFApAx4rGORy/9OD0YXFUngld
	 oE+dGZe89UBf0her+9LnLODoaNpfc6Jb3XweC3aSZ4lHFGF6loPCimOF9Q9fcEIRgh
	 UKZW6YY5GdH/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.1 3/3] perf build: Disable fewer bison warnings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260519185154.2987285-4-florian.fainelli@broadcom.com>
References: <20260519185154.2987285-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 19:54:03 +0000
Message-Id: <20260519195403.A40F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The updated `sed` regex for parsing the bison version strictly requ=
ires three numeric components, causing a shell syntax error for two-compone=
nt versions.
--

commit e696603d6c95e1ec405be3442c49513276f5ee86
Author: Ian Rogers <irogers@google.com>

perf build: Disable fewer bison warnings

This commit reduces the number of disabled bison C warnings for bison versi=
ons
3.8.2 and later. It also avoids implicit declarations of yylex by adding
declarations directly in the C files.

Link: https://lore.kernel.org/r/20230728064917.767761-6-irogers@google.com

> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e315ecaec3233..b65ce3563bedd 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -269,10 +269,14 @@ CFLAGS_parse-events-flex.o  +=3D $(flex_flags)
>  CFLAGS_pmu-flex.o           +=3D $(flex_flags)
>  CFLAGS_expr-flex.o          +=3D $(flex_flags)
> =20
> -bison_flags :=3D -DYYENABLE_NLS=3D0
> -BISON_GE_35 :=3D $(shell expr $(shell $(BISON) --version | grep bison | =
sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\=3D 35)
> -ifeq ($(BISON_GE_35),1)
> -  bison_flags +=3D -Wno-unused-parameter -Wno-nested-externs -Wno-implic=
it-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable -Wno-=
unknown-warning-option
> +# Some newer clang and gcc version complain about this
> +# util/parse-events-bison.c:1317:9: error: variable 'parse_events_nerrs'=
 set but not used [-Werror,-Wunused-but-set-variable]
> +#  int yynerrs =3D 0;
> +
> +bison_flags :=3D -DYYENABLE_NLS=3D0 -Wno-unused-but-set-variable
> +BISON_GE_382 :=3D $(shell expr $(shell $(BISON) --version | grep bison |=
 sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\=3D 382)

[Severity: Low]
Will this new regex cause shell syntax errors for two-component version
strings like "bison (GNU Bison) 3.8"?

If the sed pattern strictly requires three numeric components, it will
fail to match a two-component string and output the unmodified string
instead.

When make passes this raw string containing unescaped parentheses
to expr, it will cause the shell to abort with a syntax error like
'sh: Syntax error: "(" unexpected' and fail the version check.

> +ifeq ($(BISON_GE_382),1)
> +  bison_flags +=3D -Wno-switch-enum
>  else
>    bison_flags +=3D -w
>  endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519185154.2987=
285-1-florian.fainelli@broadcom.com?part=3D3
