Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8930BF4F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050796; cv=none; b=jDo3eWf4mixonVnxM63hRRseNb5xIS4ry81ASl8PcTYMelP1uHmlB3wKYcP6Fr+CH27+sm6icbw7G3qhapCeN7NtM/JIJa4lLeYntE8JEAfUVD5J+2+tKlleE+0vfEFkQBZujmU5fW4tn0TutR9d1AIUB0EkJv6kzGluEha7B3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050796; c=relaxed/simple;
	bh=w6ngN0VH/fxYjtmLQ9t/vM3pAF3i/WbzUGbG/7ioT7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F+mLsXTs7QiQMzau/2l6/TclAICRbv1IyGItGa1Yqt0iBSEb6YabFwfU7lXZlfOMQlIT9RGO0C7dMQZ7vqbMRuutbew07v/yZPMGKENGw4b9afgzVHaKq2EWYDZbuyUEbCEOgNHcsDF0g9/uUbuIS4Iq30qKC3xuvpg8twynCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKWuel4x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKWuel4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97FBC19425;
	Fri, 24 Apr 2026 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050795;
	bh=w6ngN0VH/fxYjtmLQ9t/vM3pAF3i/WbzUGbG/7ioT7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UKWuel4xmHGQ9rQ8xrP42/V0WCTtHhyq08g4vmtZfR/30HjtiPRG2CJyy4dIq+k9r
	 tdijl+nC9cj6SViY7OR9EDlechl0VmvZYG3VV6guay8uEPxAg89ptqn1e8j1lx8ni2
	 M4zMZUZFfZ4kKITw/fBpnDP5+nxlLChfDTCsv9ghNu2k5W/DbE0FQr1fFZqfOVcKkG
	 ORmKa7TlrLiEYXFlv6QxG0PKJfyC4mL1jpbwi9xsPoNzEg+ynruOc3c66JuKISnIeT
	 lsuhAYZy0iXviNyy6xTcuBsY7TEmS5doQHKtTQE3XzPKv9lKW/4GOHtrgerACxg7bY
	 FSRY/u6U+rqIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 39/58] perf intel-pt-events: Port
 intel-pt-events/libxed to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-40-irogers@google.com>
References: <20260424164721.2229025-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:13:14 +0000
Message-Id: <20260424171315.A97FBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Invalid formatting specifiers in f-strings cause unconditional r=
untime crashes.
- [Medium] Missing buffer length validations before struct unpacking cause =
script crashes on truncated events.
- [Medium] Context switch reporting functionality is silently broken due to=
 missing API support.
--

commit 143d7221680f46960b8970a937b1e04169a639ed
Author: Ian Rogers <irogers@google.com>

perf intel-pt-events: Port intel-pt-events/libxed to use python module

This commit refactors intel-pt-events.py to use a class structure and the
perf python module. It eliminates global state, removes Python 2
compatibility checks, and updates libxed.py methods to comply with pylint.

> diff --git a/tools/perf/python/intel-pt-events.py b/tools/perf/python/int=
el-pt-events.py
> new file mode 100755
> index 00000000000000..682bf80becfeef
> --- /dev/null
> +++ b/tools/perf/python/intel-pt-events.py

[ ... ]

> +    def print_ptwrite(self, raw_buf: bytes) -> None:
> +        """Print PTWRITE data."""
> +        data =3D struct.unpack_from("<IQ", raw_buf)

Can raw_buf be too small or empty here?

The exception handler in do_process_event() defaults raw_buf to b""
if the sample lacks raw data. Calling struct.unpack_from() on an empty
buffer might raise a struct.error and immediately abort the trace session.

[ ... ]

> +    def print_pwre(self, raw_buf: bytes) -> None:
> +        """Print PWRE data."""
> +        data =3D struct.unpack_from("<IQ", raw_buf)

Are length checks needed here as well? Unlike print_cbr() which explicitly
checks if len(raw_buf) is sufficient, functions like print_pwre(),
print_exstop(), and print_evt() appear to unpack without validating the
length of raw_buf.

[ ... ]

> +    def common_start_str(self, comm: str, sample: perf.sample_event) -> =
str:
> +        """Return common start string for display."""
> +        ts =3D sample.sample_time
> +        cpu =3D sample.sample_cpu
> +        pid =3D sample.sample_pid
> +        tid =3D sample.tid
> +        machine_pid =3D getattr(sample, "machine_pid", 0)
> +        if machine_pid:
> +            vcpu =3D getattr(sample, "vcpu", -1)
> +            return (f"VM:{machine_pid:5d} VCPU:{vcpu:03d} {comm:>16s} {p=
id:5u}/{tid:<5u} "
> +                    f"[{cpu:03u}] {ts // 1000000000:9u}.{ts % 1000000000=
:09u}  ")
> +        return (f"{comm:>16s} {pid:5u}/{tid:<5u} [{cpu:03u}] "
> +                f"{ts // 1000000000:9u}.{ts % 1000000000:09u}  ")

Will this crash with a ValueError? Python f-strings do not support the 'u'
format specifier for integers. Because common_start_str() is called for
most events, this might crash unconditionally on the very first event
processed.

[ ... ]

> +    def print_common_ip(self, sample: perf.sample_event, symbol: str, ds=
o: str) -> None:

[ ... ]

> +        if self.insn and self.disassembler is not None:
> +            try:
> +                insn =3D sample.insn()
> +            except AttributeError:
> +                insn =3D None
> +            if insn:
> +                cnt, text =3D self.disassem(insn, ip)
> +                byte_str =3D (f"{ip:x}").rjust(16)
> +                for k in range(cnt):
> +                    byte_str +=3D f" {insn[k]:02x}"
> +                print(f"{byte_str:-40s}  {text:-30s}", end=3D' ')

Does Python allow the '-' sign modifier in string format specifiers? It
looks like this might raise a ValueError, and perhaps '<' should be used
for left alignment instead.

[ ... ]

> +    def do_process_event(self, sample: perf.sample_event) -> None:
> +        """Process event and print info."""
> +        comm =3D "Unknown"

[ ... ]

> +        cpu =3D sample.sample_cpu
> +        if cpu in self.switch_str:
> +            print(self.switch_str[cpu])
> +            del self.switch_str[cpu]

Is the --all-switch-events feature still functional after porting to the
standalone perf.session API?

It looks like self.switch_str is never populated because the new session
only registers a sample callback, losing the legacy context_switch callback
that previously recorded switch events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D39
