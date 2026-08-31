Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265339446B
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210658; cv=none; b=Ab23pJQbTOCSDLFRJSp+Mv6cQwBk4i//9CLt2LhYyc0Xl2UXN+EIPIbF6BmuRQSFKCb4YCcLhmzztAg4cNDOghCIao/OOJNfMqfx9h6EofSpY1Pr/XmuFy4uGIG9cY2oEIOXy/Uo21P5XN0y5lLUNA4FIl38ru0XO0KwOAtwTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210658; c=relaxed/simple;
	bh=LOhD8UvV9XrZ4k9AirG7A8j3UbX6AFElP+l/zCdsODg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4d+3K19+LuCjVjxZfAa6G44evH056PQYO8hbuMZzfNdGjooU6CGIWVodTGN3HQ334Gy648anV1G0KDX+bn+01yybQW58G0wcqLDMq+js35DhioeINFdpFIiNEAJrTzznVoq7Td2rlzq3mSq4Z5FTCZril7PzgzwtERvLHdFxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKmVOIj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKmVOIj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65A51F000E9;
	Mon, 31 Aug 2026 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210657;
	bh=3/YnZUXdl/Re/80g0hsUNCBv8eZiuTmTa99h5cRujNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKmVOIj4bC/awdDIt7F/iM8w9PCKqhvHtHOTdrZqYgr3d12Jw70VUqi9h1YpWeovf
	 7fHWIqnCyRa5G45HHvXLmPuNWlPkxydw5B8tXlgv6KSbFbnGEy6VM0IGgSOowiZcfW
	 JWJUc2MxRm4q9IyGHkKJSIHclxypiUqu2tZD4CAcy8Y2dB6J+v1w/TKW9tPsRNbrxp
	 hoURVRbWZdK61ul/IyGzVdPTGsfimDsil9RsdK01Rj5U1P7YqE+xdoukLFERTg2rXa
	 iIOxBRezbDrHwyU2/u8vIpbvc+GzVpoW4nYB0Zxs7saA0QdSGfSVTcZBM4uZxySdqD
	 6YJ0LVoRyB4fA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 15/19] ptwrite uprobes: Add a tutorial and overview
 documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-16-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-16-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:10:56 +0000
Message-Id: <20260831211056.E65A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Missing blank line before a bullet list in reStructuredText.
- [Low] Typos in the 'Options in this case' list.
- [Low] Formatting inconsistency with double backticks in indented block.
--

commit e96dac3fdefb27a2867c9e268822b99d3e4c7aa7
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add a tutorial and overview documentation

This patch adds a new documentation file explaining how to use ptwrite
uprobes for hardware tracing. It covers performance benefits, requirements,
and provides examples for configuring probes via tracefs and perf probe.

> diff --git a/Documentation/trace/ptwrite-uprobes.rst b/Documentation/trac=
e/ptwrite-uprobes.rst
> new file mode 100644
> index 0000000000000..79ab35824b93c
> --- /dev/null
> +++ b/Documentation/trace/ptwrite-uprobes.rst

[ ... ]

> +Punning is a probabilistic method that depends on the existing
> +instruction bytes and the placement of the executable in memory.
> +It has a high chance of success on PIE/PIC binaries, but tends
> +to work poorly on non PIE main executables.
> +
> +When punning is not possible the probe is rejected at install
> +time. Options in this case:
> +- Move the probe site to a different instruction which may work.

[Severity: Low]
Does this list render correctly in Sphinx without a blank line before it?
In reStructuredText, bullet lists generally must be preceded by a blank
line, otherwise the list items may get merged into the preceding paragraph
or trigger build warnings.

> +- Rebuild with -fPIE if it's a main problem not using PIE.
> +- Enable or disable /proc/sys/kernel/randomize_va_space. If the
> +  randomization is enabled it may also just work on a rerun of
> +  the program.
> +- Fall back to a classic uprobes

[Severity: Low]
There are a couple of minor typos in this section. Could "main problem"=20
be corrected to "main program", and "a classic uprobes" be changed to=20
"a classic uprobe" or "classic uprobes"?

[ ... ]

> +If the program itself also executes own ``PTWRITE``, those values mix wi=
th the
> +uprobe output in the stream. The decoder uses the header magic to identi=
fy
> +uprobe records. Other values are printed as ``manual ptwrite:`` lines (w=
ith
> +their IP when ``fup_on_ptw`` is set) and counted in the summary's ``stra=
y``
> +field.
> +
> +To also print the decoded branch stream alongside the records, add
> +``b`` to the itrace options and drop the ``q``
> +
> +    # ``perf script --itrace=3Dweb -s uprobe-ptwrite-decode.py -i perf.d=
ata``

[Severity: Low]
Are the double backticks intended here? Because this line is already indent=
ed
as a literal block, the double backticks will likely be rendered verbatim in
the output instead of being parsed as inline literal formatting.

> +
> +Each decoded branch prints as a ``branch:`` line (from =3D> to, with
> +symbols where resolvable), interleaved with the probe records and any

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D15
