Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5F35E55D
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969362; cv=none; b=NVtFiBzkxWogslDQYD8Ks1Z/vI4sVFKTDMFW8DMvaf6ozSX6fWclnQ4maQkbQcIrRxR3EHFOUcpW0wyNwES8QK12dcDgnXe0gpuYL5YWPOyA/lFLeDmJbYXChLrL7VU4EGs+xUi9KmN0bdBbTRjDwsq1CzrR7vhSwl8FS5tSFU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969362; c=relaxed/simple;
	bh=Dia/9drumcDMqJXAdj6wKO61YDTD5vCt1xFflI2R7IA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZsOfgz6/HrdzQz7/1Y4lEGoWq/6coCST1UcK3ode/oH50cgClkz4+FIf4yWXIha88FuR3MuvcTvRHGP1AeRmVi8P8S3HG1h7SvDP3VzC2DZ5g415ys+ok514DpisjA/ariA6lKBlJzh0DmZVeQyGGqhXO/IOHUSN9A5Twt4/7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTiMEcF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTiMEcF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED6C1F00899;
	Mon, 21 Sep 2026 05:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969360;
	bh=KGYfMic3JMRpnpAMiDMajfEHr9nvfWOzrKjbOkOCloc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTiMEcF6P72QsrcXkHY+VJ7lbZFyUeJgdA1x9V0UUoIA1hWroBI8LdQaMZFy5W4dx
	 lSdzKL9xmAg6/4ZA4q32ldgM5QvtVSHj0FI7MlMUH+aK+oD7aE2UCj+h2/mHs2+gl+
	 3OG2Wk3xE54ziSpTAzgdPH4BzuQAacBA5QgjSuN4Ruoyl3pg8+sfzi/msvp96RYBNh
	 QLkvAgvm8rY9zIq58Ddk5MySLzanhe9EVzcqgsF/vG1swKIo22otnjG9/HqHGgujd7
	 +NfVeUk+ALBDcYbQCSwhW8M9wm1hR6vdGkP1mWwuMy+cDJ+cNrsIkT028ONRxYuHgf
	 oCVBxbQ08d+ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/49] perf python: Port task-analyzer to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c3b631c7f0185ae355c4687e6d0b094ff6b71b70.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <c3b631c7f0185ae355c4687e6d0b094ff6b71b70.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:42:39 +0000
Message-Id: <20260921054240.5ED6C1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf python: CSV injection mitigation bypass via quoted strings =
in task-analyzer
- [Low] perf python: misaligned task-analyzer summary table columns due to =
width truncation
--

commit 062cfbddd4574d86bc24087ab0abc8cd8fc7623b
Author: Ian Rogers <irogers@google.com>

perf python: Port task-analyzer to perf module

This commit ports the task-analyzer.py script to a standalone Python script
in tools/perf/python/ using a class-based architecture. It adds support for
offline file analysis and live trace capture, automatically disables ANSI
terminal colors for CSV output, and sanitizes task comm strings.

> diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-=
analyzer.py
> new file mode 100755
> index 0000000000000..a39bdfe32fc15
> --- /dev/null
> +++ b/tools/perf/python/task-analyzer.py

[ ... ]

> +        fmt +=3D "{}{{:>{}}}".format(
> +            separator, self.db["runtime_info"]["median"] * fix_csv_align
> +        )
> +        fmt +=3D "{}{{:>{}}}".format(
> +            separator, max(0, self.db["runtime_info"]["min"] - decimal_p=
recision) * fix_csv_align
> +        )

[Severity: Low]
Is this column header width calculation correct? The column header width is
set to the truncated integer length, but Python's format function will
expand it to fit the value and its decimal places. Can this cause the
summary table columns to become misaligned when printed?

[ ... ]

> +        len_acc =3D self.db["runtime_info"]["acc"] * fix_csv_align
> +        len_mean =3D self.db["runtime_info"]["mean"] * fix_csv_align
> +        len_median =3D self.db["runtime_info"]["median"] * fix_csv_align
> +        len_min =3D max(0, self.db["runtime_info"]["min"] - decimal_prec=
ision) * fix_csv_align
> +        len_max =3D max(0, self.db["runtime_info"]["max"] - decimal_prec=
ision) * fix_csv_align

[Severity: Low]
Does this field width calculation break alignment? The row formatting field
width is set to the truncated length, but it does not appear to account for
the decimal points if the raw value string length is shorter than the
required formatted length.

[ ... ]

> +    def _filter_non_printable(self, unfiltered: Union[str, bytearray]) -=
> str:
> +        if isinstance(unfiltered, (bytearray, bytes)):
> +            unfiltered =3D unfiltered.decode('utf-8', 'ignore')
> +        filtered =3D ""
> +        for char in unfiltered:
> +            if char in string.printable and char not in "\r\n\t\x0b\x0c;=
":
> +                filtered +=3D char
> +        stripped =3D filtered.lstrip()
> +        if stripped and stripped[0] in "=3D+-@":
> +            filtered =3D "_" + stripped[1:]
> +        return filtered

[Severity: Medium]
Is this CSV formula injection mitigation sufficient? The check only looks at
the first character of the string. Can an attacker bypass this sanitization
by wrapping the malicious payload in quotes, such as '"=3Dcmd"'?

This would result in ;"=3Dcmd"; in the CSV output, which a spreadsheet prog=
ram
might parse as a quoted string, unquote to =3Dcmd, and evaluate as a formul=
a.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D31
