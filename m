Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF8347BC4
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295122; cv=none; b=HdvmLvxgAd+z4oZCIe2atn5z/7OpP3stuoMXDaGTH0LaJvnkON7rSeQAo+BEo6yA/giocX9qWIhYw8RoHkvBSLitG0nIw9knvmcn1yJ3AnzIQGLUQA9FR7vbRZcWahMvCDu8CQA5v01IUMMPRBZOOpapDSAyyd3MMJoUAXuO8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295122; c=relaxed/simple;
	bh=qBtSTDlGXVudhQUScdKCXuwZiBRoM2vj5BybkF1xUvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgkKvHWzoK/jmTPUNSJmqpN5Em7VJ1fftzyAkRx/fe7Lsh20fP15RsBcSnHKHZNLSuA/w9L0WWkN9P67lCA7HN+QD5EYz5Ef3xhtnGCROLjiWXTTBqrz5GbcpPwqvYLtjEF+DmzRzQUWNZtZNEbhhu6s2TyGJ1gtlvs8fqLZpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtDfPm4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtDfPm4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30771F00893;
	Mon,  1 Jun 2026 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295121;
	bh=iPeulQKK2pHirhBvhNVPhaEx7Xd4G0EMdytRG0sGInw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jtDfPm4f7n070GPTgb2tfFKfuO+IeIu6Vo/D0WGr14FOBN3F8VCUFD/qOMqudX1dA
	 6JScqnqJV2V+DQ2qDiYx6OYERrLnaFON//BtDApeclbi9i8502kwh1H/Bh7E9p8ARd
	 tTUbZxX0MnSOmQ1BHNelsC7N+rf0W5y3m3UDJxkJ56ZyJqzS8x2qWUbuQEDUuWh6Wg
	 rI3gQAGeU9k5mZ//BITHVO44wwf2W7fgRG+Y9/WAyQYRcjSh2jl/16HoQEMDtuJPB5
	 TK/riTdDxy1v+J/12n0tsmwA7YXYW2rAjpTG7pC0dHiNTx7y3DPAsEogU8DJx1WX12
	 TcmJzmgcVppwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] perf jevents.py: Make generated C code more
 kernel style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-2-irogers@google.com>
References: <20260601061401.1541457-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:25:20 +0000
Message-Id: <20260601062520.F30771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unmatched `/* clang-format on */` in the generated C file and fa=
ilure to bypass formatting for large tables when `output_string_file` is us=
ed.
--

commit f1ba6b889b8b196461d3bfaa989b79ca18161739
Author: Ian Rogers <irogers@google.com>

perf jevents.py: Make generated C code more kernel style

Make jevents.py generate C code that complies with formatting tools.
This adds clang-format off and on pragmas to bypass large generated tables,
making the rest of the code easier to check.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1466,6 +1463,7 @@ struct pmu_table_entry {
> =20
>    _bcs.compute()
>    if not _args.output_string_file:
> +    _args.output_file.write('/* clang-format off */\n')

[Severity: Medium]
Will this cause the opening clang-format off pragma to be omitted during a
standard perf build? When jevents.py is invoked with the output_string_file
argument, this pragma is skipped, leaving the massive tables unprotected
from formatting tools.

>      _args.output_file.write('static const char *const big_c_string =3D\n=
')
>      for s in _bcs.big_string:
>        _args.output_file.write(s)
[ ... ]
> @@ -1487,6 +1485,7 @@ struct pmu_table_entry {
> =20
>    print_mapping_table(archs)
>    print_system_mapping_table()
> +  _args.output_file.write('/* clang-format on */\n')

[Severity: Medium]
Does this result in an unmatched clang-format on pragma when
output_string_file is specified? Since this closing pragma is written
unconditionally, it seems it will produce unbalanced formatting directives
when the opening pragma is skipped above, ultimately defeating the purpose
of bypassing the large tables.

>    print_metricgroups()
>    _args.output_file.close()
>    if _args.output_string_file:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D1
