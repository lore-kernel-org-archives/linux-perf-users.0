Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2D3D1CB4;
	Tue,  9 Jun 2026 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985899; cv=none; b=bsEa/PutcLNwExF7g+4Xo5NhQGEcuPF1YSWd1o8AXwtM1P1QCdTXyY+0BeSEHbpMz9VXGAt8ofuodTlrvwHWwSM/zXJMuzTI4qt+/Eb7Lqj96EI2Lhe9QKK9D49D6JdFyHpxrJz5OOXgaehHBlcQgiZQDP4UDC3uU07l+EqDKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985899; c=relaxed/simple;
	bh=MB8fUksptvZBCrRSniuPXOg4FmanV8h719JwRqDHlRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gbxSdjwfdsoeKR7kFvfAFTvEzJ8SFj82LOZkP1nJIYXzHiyQqiYeRbzVXnRIuSvtOvF7F0/qo5rXF0PWbPP7xwkhpceFKDuQrcry3umrX8YCgEPuWMZsweIQj4CM7mgXjf+W95sUSiv6E8+CFqmmFdeO+SRtlbvAcJ0jrQn265k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HByjxFnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HByjxFnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE371F00893;
	Tue,  9 Jun 2026 06:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985897;
	bh=msNXDs93oyBVdrzSowEDVg9WOgrxvPbrX3SRzMIWqQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HByjxFnB+a2EAYT2zeONyUVo3GmLHp3ZMvWAySLeSnZuqvoz3NcnLpazQY5G6mrZx
	 K+e1tB5Y05CQQWv/40O4P5E5mq/LWS97O2fwtTem/u2PYXORS26gqSkta0OggIDSXY
	 49uOwsLCkeblyeZIpdjC518ZBt1xRjv2Uz/dtewpZuJrRryGf19k373rCn6v0lae9p
	 cYfs3Yma5O/FnmFbVI+9BDXNjaIkvTFdpR0ISl/oe0zhMuubvzvZEiHJEgvaQnhdH4
	 urulTOqYPGyAVFTtD8AtOaa4IU2nsqhPvWh813Cb6rD44AapjeUzjc+kOZudsfw15m
	 EXgoNOxAd7bTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/21] tools/perf: Support event code for arch
 standard events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-18-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-18-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:18:17 +0000
Message-Id: <20260609061817.7FE371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `if not eventcode:` check incorrectly evaluates to True for =
explicit encodings where the event code is `0` or when alternative encoding=
s (like `ConfigCode`) are used, causing them to be overwritten.
--

commit c082fe77b89457807536772c21ae88a13885568d
Author: Atish Patra <atishp@rivosinc.com>

tools/perf: Support event code for arch standard events

This commit updates the perf tool to support custom event encodings for
architecture standard events. It modifies jevents.py to avoid overwriting
the event encoding with the architecture standard event if an event code is
already present in the JSON file.

[ ... ]

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 3a1bcdcdc685f..457fce7a59820 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -413,7 +413,11 @@ class JsonEvent:
>          self.long_desc =3D None
>      if arch_std:
>        if arch_std.lower() in _arch_std_events:
> -        event =3D _arch_std_events[arch_std.lower()].event
> +        # If the JSON event already specified an event code, the encodin=
g has
> +        # been set above; don't overwrite it with the arch standard even=
t or
> +        # the event encoding would be lost.
> +        if not eventcode:
[Severity: Medium]
Does this condition incorrectly evaluate to True for valid 0 encodings?

If a JSON event explicitly specifies an event code of 0 (e.g.,
"EventCode": "0x0"), the parsed eventcode will be 0. Because Python evaluat=
es
0 as false, the not eventcode condition evaluates to True.

This incorrectly overwrites the explicit encoding and discards previously
parsed event fields.

Can the same regression occur if alternative encodings like ConfigCode or
EventidCode are used, leaving the eventcode variable at 0?

Would it be safer to explicitly check if the eventcode is None to distingui=
sh
between an absent event code and a literal zero?

> +          event =3D _arch_std_events[arch_std.lower()].event
>          # Copy from the architecture standard event to self for undefine=
d fields.
>          for attr, value in _arch_std_events[arch_std.lower()].__dict__.i=
tems():
>            if hasattr(self, attr) and not getattr(self, attr):

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D18
