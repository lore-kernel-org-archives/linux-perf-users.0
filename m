Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81A39185E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159556; cv=none; b=PvhWOjBcZQ2czg9OOeWo3wHO1/JQKrmm7PzBR0IG0atsNRO3g4ZF9I+v5d0AP5WD94ogmkIBH5laoWnFTRZW7xNiKBGtsv2WsYWPTP0styTD3ACLU2S36WY79bQxMfiIeIiNL4slX38aii/fGE9Wq6tMYM+gB54MXsyoxO2cOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159556; c=relaxed/simple;
	bh=kMjzHe6r0VacKNhrVG/4TeRFZwYBHFhLQWMde16MV+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sru9D63B6uM+Rscpk8ztIgcDRxUfJpYy+T81KwhzlULrsHZEhXf+zS5KbmxFyAmXPDJ2LmgvpnYZOcq8Z+97E0Am5eSRfGVw+m3gz9/RmCG0F14qTSR6/6mH0saFXuoBbfmTgOHrqhvGqwQ95DUSb7UOSeLG44DVBlli4dC/XCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8VYBtR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8VYBtR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92529C2BCB0;
	Sat, 25 Apr 2026 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159555;
	bh=kMjzHe6r0VacKNhrVG/4TeRFZwYBHFhLQWMde16MV+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W8VYBtR03QGtnwXe3s8wXVraTxHg4EoTGDiwmDfLhkVrwAYnIPa6nzTRYFppgF23B
	 ynx132bM+ZP5a1ETpxPRQxcGBRhSBBm0us2jE9gyJSEwpnISeeKiCljsDqoQRdGjXy
	 uQRshOXUkhGT+a1BY6hJSkiK91AR5G+1WcsVzJMhyW0NJvN3dGVWZbtXgctNnXlC9N
	 nhdK40i6UOQnbsZYj6oivsSw9b2cY22PDw9fuwNG4x43k//tx96n2FK0PCq7akY0kh
	 qCLQikrXTRa1QMth3bB1KuIgSzaUvL0Hk8AFPLJZRC5InWaQ1GgEOkBIm2QmuiUAvt
	 HayAzBRmUOSFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 32/59] perf arm-cs-trace-disasm: Port
 arm-cs-trace-disasm to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-33-irogers@google.com>
References: <20260425224951.174663-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:25:55 +0000
Message-Id: <20260425232555.92529C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Event filtering logic drops all samples due to incorrect stringifi=
cation of evsel.
- [High] Relative 'vmlinux' path fallback allows arbitrary code execution f=
rom untrusted directories.
--

commit bfb5fa4502593496d0bc26784e43f473bbcc607c
Author: Ian Rogers <irogers@google.com>

perf arm-cs-trace-disasm: Port arm-cs-trace-disasm to use python module

This commit ports the arm-cs-trace-disasm script to use the perf python
module directly. This avoids creating intermediate dictionaries for all
event fields, improving performance. The testing script is also updated
to use the ported script.

> diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python=
/arm-cs-trace-disasm.py
> new file mode 100755
> index 000000000000..92c97cca6f66
> --- /dev/null
> +++ b/tools/perf/python/arm-cs-trace-disasm.py
> @@ -0,0 +1,338 @@
[ ... ]
> +KVER =3D platform.release()
> +VMLINUX_PATHS =3D [
> +    f"/usr/lib/debug/boot/vmlinux-{KVER}.debug",
> +    f"/usr/lib/debug/lib/modules/{KVER}/vmlinux",
> +    f"/lib/modules/{KVER}/build/vmlinux",
> +    f"/usr/lib/debug/boot/vmlinux-{KVER}",
> +    f"/boot/vmlinux-{KVER}",
> +    "/boot/vmlinux",
> +    "vmlinux"
> +]

Is there a risk that checking for "vmlinux" as a relative path could load an
untrusted binary?

If this script is executed from a world-writable directory like /tmp, it
might find and use an attacker-controlled vmlinux file placed there.

Because this binary is subsequently passed to objdump via
subprocess.check_output(), parsing a maliciously crafted binary could
trigger vulnerabilities and lead to arbitrary code execution.

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
[ ... ]
> +        ev_name =3D str(sample.evsel)
> +        if self.options.verbose:
> +            print(f"Event type: {ev_name}")
> +            print_sample(sample)
> +
> +        dso =3D sample.dso or '[unknown]'
> +        symbol =3D sample.symbol or '[unknown]'
> +        dso_bid =3D sample.dso_bid or '[unknown]'
> +        dso_start =3D sample.map_start
> +        dso_end =3D sample.map_end
> +        map_pgoff =3D sample.map_pgoff or 0
> +
> +        comm =3D "[unknown]"
> +        try:
> +            if self.session:
> +                thread_info =3D self.session.find_thread(sample.sample_t=
id)
> +                if thread_info:
> +                    comm =3D thread_info.comm()
> +        except (TypeError, AttributeError):
> +            pass
> +
> +        cpu =3D sample.sample_cpu
> +        addr =3D sample.sample_addr
> +
> +        if CPU_DATA.get(str(cpu) + 'addr') is None:
> +            CPU_DATA[str(cpu) + 'addr'] =3D addr
> +            return
> +
> +        if dso =3D=3D '[unknown]':
> +            return
> +
> +        if dso_start is None or dso_end is None:
> +            print(f"Failed to find valid dso map for dso {dso}")
> +            return
> +
> +        if ev_name.startswith("instructions"):

Could this startswith check unconditionally fail?

The __str__ method for perf.evsel objects returns a formatted string like
"evsel(instructions)", not the raw event name "instructions".

Because of this formatting, the filters ev_name.startswith("instructions")
and ev_name.startswith("branches") will evaluate to false for all events,
causing them to be silently dropped without processing.

> +            print_srccode(comm, sample, symbol, dso)
> +            return
> +
> +        if not ev_name.startswith("branches"):
> +            return
> +
> +        self._process_branch(sample, comm, symbol, dso, dso_bid, dso_sta=
rt, dso_end, map_pgoff)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D32
