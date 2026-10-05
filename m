Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936C36F8F1
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182778; cv=none; b=d+oYSemVpdI9nFg/4CGsF3+cORRoAzOZwdd/odY59U7WmUoBX9UZQLRyRuYQFpxD+R4ezGLI5cFFxgIcjxNeNqwg/f7fxXKlYCSQYfFJIjTzV+IwzSKmf/6togmfMAySZpYl9HEnKy8CtQiMphFtaAWKI0UEtzCigdNK0wJ1g2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182778; c=relaxed/simple;
	bh=IriK1cpaj7T4euNf8m8WBdSTCawycZ6FMErrVcd3HlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dkyou6RUP7WnS7pphgUCcA7rtcuKwaL44bsDTw4gxScdULU4pmctsq0r5cYmC8I4UZ4O2zJ94pOlC+aGhA10ENFsaV1jaKDrT1XktE8pgKy7n/kINCTQmedpmcojq90aqmTB++FxVsY2Q1jLw225PsbvUUUys71pAjBr5Y84mXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPRv/wCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPRv/wCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07241F00893;
	Mon,  5 Oct 2026 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182777;
	bh=kPLA8AiBM3q+5J2IM5vg1gG8ifyW4tjKh13UpsSd1Y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPRv/wCaiH8lU3BZN3RP3MPxOATDLNhxaROqhV2yXC4UisHoqf/8RiwzbrZACA4Qu
	 KECjwQeh8Zb2Vu9OelyAlFeZ+eB8K2BV4NFraMpih2xu1+xtn1i/afeD4dvrDXXsfg
	 MrG9GiSJPyBq+QcKoI2H0zkn3zp9XodgOTWUvNvjKgtUXqJgfSlePtfM9qSXSRGH0p
	 i2oW8u498rrESEjzo98ST+BSyPRf3+pJkRFHjTBDbooxcZXJppFv/5VzN5X7ZBVz+i
	 WjrloZcJ1XN/AY68+dikiFIFS38G6HHocxT96mSoPiJhifwdZs6fHrucAOrWcNxa05
	 pIeFzfKF2nhAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] perf symbol: Set binary type for JIT map DSOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-7-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:46:16 +0000
Message-Id: <20261005064616.F07241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: annotate regression on JIT map files due to unhandled bina=
ry type
--

commit 79781ef5615895fe2ec492b108f82094b6a0246b
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Set binary type for JIT map DSOs

This commit explicitly sets the binary type of JIT map DSOs to JAVA_JIT. Th=
is
ensures they are identified correctly and bypass attempts to load dso_data,=
=20
as they only contain symbol names and lack binary instructions.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1859,6 +1859,7 @@ int dso__load(struct dso *dso, struct map *map)
> =20
>  	if (perfmap) {
>  		ret =3D dso__load_perf_map(map_path, dso);
> +		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);

[Severity: Medium]
Does setting the binary type to DSO_BINARY_TYPE__JAVA_JIT here bypass the
historical early exit guard in symbol__disassemble()?

Looking at symbol__disassemble() in tools/perf/util/disasm.c, it guards
against unsupported files with:

    if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
        return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
    }

With the type now explicitly set to DSO_BINARY_TYPE__JAVA_JIT, this check
fails and allows perf annotate to incorrectly attempt disassembling the text
map file.=20

The fallback binary disassemblers inevitably fail to parse the text file as
ELF and return -1. This propagates back to symbol__strerror_disassemble(),
which handles the -1 return by printing an unhelpful message to the user
instead of gracefully exiting:

    default:
        scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", e=
rrnum);
        break;

Should symbol__disassemble() be updated to check for DSO_BINARY_TYPE__JAVA_=
JIT
so that it can exit gracefully when users try to annotate a JIT symbol prof=
ile?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D6
