Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793831264;
	b=nvG/2/UA2K40luBJXzceqVDoyvJAasrHcx3WtsTfGZsNvlSqAFS/MCsccS0ywEb6c7sf
	 H6i1YOvBkBdrmoxMl0cY1huxmFoun6VNRhlIySPf/NTaxpooXMjMzQqfVDFFR9m1drmmj
	 LKhBTrFI2bfqVXdwtzG/1NX9feiwHQEB5QIM1iYH7xtwBY4GpTp1GNuGIHVNKFk8d/7f/
	 gJ/U1GApxA5SZxd2Pj5qvGVSY331keDLi9LsCB6C8/AKpHjNH1IMU5rNzXxmo92AHSlwb
	 sYhvfXW8PC5RQtv/rhm5oDd9YMevtzjPeQcSuZ8FL5FQxyGHGyBwHXPmrxaRQmmQ9iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TQAK8qbp+bqwH/yA/y8zCNOc+K4W78NBGe/TJCEFsJE=;
	b=zgU/Bkhu1bdP7xSXynLt1PU/I3QmyexvaLkBiVCY9Ypp0KQydkfwNqzwDYm8Rf698VP2
	 I3R3/5vGyWKqtRng+jfzKzUzb6gORFQ+IodpkRD8rB+B2+lwtVmRcTIWliNekvAu53vwv
	 w/Zh5PhYipW9TNLbI+BTqBVlA/9Pcecc/4W3Q/QbBNTepmbe+iape1KVQPYpl4hlV/YGM
	 XXoY22uKvFFU14YTu89UhBb5mHhBgQWW6hy0mANrU71ltZPHOKD2yBUGtwRMxlDcO11/a
	 HNTZJY4OwBZ5EvRZ+BmA6+o/TK1WaHBCIfS1EybQ6Uln69x/bQyrn/PYS8ynos22f2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7jFY1dM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B8606B385
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 22:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986B8606B385
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7jFY1dM
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso1412511a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 14:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793831262; cv=none;
        d=google.com; s=arc-20260327;
        b=o95ZNiIbOz9dXpBaCXLmHnu/4IZUCe3rK3JdjUPrMTPWlDZvgOV+9G0QU7Ld7VlIez
         f5LdRyfqAAGAtmmtYbljOAJlgKURqFlqc0u6Qg14ARAVuNLEXP6S+oOQ7lO3UR6IxpeC
         hfnZsO/+hIs0T3tI71ztshDfsqWznSseHchqtxD/pgYlnFVjVgUgXgt5m7dw00iDqwHJ
         Pkd4C/Fxja/1jJeEaGd+exEcEHIIVuiSho5RNXf44fB9x9n8a6e+mjs+74qw30Tdu1jI
         Op69Iq+G9nNq6ErwfmZDeuLoZ7jfpyXFoiCR3npQjQupOjVUuSqa2W+etzjN30NY4fhy
         9puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQAK8qbp+bqwH/yA/y8zCNOc+K4W78NBGe/TJCEFsJE=;
        fh=MUPafJR9BauWLBH+zmh78wcrn+cPhjCf8JbZppa0zmA=;
        b=caQzMoIcesu0XS7nn2CkbQqDhH042cCLCNQiTM65b1ldsVGSFpV44kQBYhYx5kqPCI
         hQj+Y7IX5lgOChh7Ybe4Fz7wr4e5Wh2rccbUHWDBxMfQkRz2OfzeL/utLjbf9PGsulyz
         97bTGOX3EiLRuCIXCuZEdMaIbHQ87Mog9zDdOHenpreAJ2mIp1FH3RQQ4rIYvY69RBGY
         CmAK1POaamdLl7OeoUE6VbNeExUNOg+lZ16Tzv9J0LQ504NhMRMYk/uyiBFES5MvcF6e
         op/FqlaPGexL+U0sIG/dG6pt9iBJx042c+c2NGLbBoxnFzAG8D6+wE66+8R43thkPS6U
         kGxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793831262; x=1794436062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQAK8qbp+bqwH/yA/y8zCNOc+K4W78NBGe/TJCEFsJE=;
        b=Z7jFY1dMUytIuSnGvfmRQhJvNM+YMaogwQ3qYtcCFmxsGzexP46W2pqzZE7uPEM8Mq
         f2yofWN6gBnRqvw9og+QisEgILBgcr+h+Rx8up8quaU1CiBJTYAB7bCubjt5iQ9/D5M3
         LqZqVdwpePd/HBq180Brbd1S9DYAwX8YZOZ2JVcAFNgvnppKI27JnlOunzT5DjlbsFuP
         80h8edc1iknyFkl0RTrSIucGRJT/uYkUtkYmOJhqFPD+6CjyXdzDqIemHL8XOm507MZS
         OE5Odg1n9nWapZfLPaIqhbVjCy5za/cLsfFqtZXmxmkp6IHAMyEJElpR4xKbAMyCNxn5
         lo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831262; x=1794436062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQAK8qbp+bqwH/yA/y8zCNOc+K4W78NBGe/TJCEFsJE=;
        b=yWMS4ZWBGEh/gHj4HGrFDGrgPQa2v6/Yd0Px8Y+rmchg8pLp6I6fAoSL6HaOpQxyf6
         uh5dhTaCM3FgUHNNKHE0G42blcETaDQffrYgYxsW4WGaGYzj/PNGbl+i1YdmD6cZOs3p
         L5TKAUs0AaDKPSa9QUuzfDcm1nYKHhAmTSpY4EhbibUO9XCcmm4Rbk8vIy+G4vgbv5Im
         2tPLPaa6SrHuigCGe41OMYyFHrv3WUd2Aik59hpbNWX3zDIwKtigVBk8WKxgoMSp4Qbd
         orVfjW+ihXF9kNHb6+ziJ4FHvKaH3T2iT4shFtjDeZUSjdz5W1ES7rSezOLlWiUjgUuN
         Be3A==
X-Forwarded-Encrypted: i=1; AKwUvByBZza8nujHaYDbHewpsxcUg6O7eYcc9X+T2qUv8x4cYtP5jYslLrTrIImcAjky/uEa7BPxipi8rLUfDu+bsGh1@vger.kernel.org
X-Gm-Message-State: APuU4Z+Dm40SVVwibdatwa2WuvSZXJlhEHfBAt6BZp+1RD3uzs0OHHvK
	LfPkCl9UN5OJ0tWmK2ej6gLtYoJpqXIGHFG9yt2Whot53GYTMbf/AYYpYfro67nMNBNYfXczw37
	d80NFHEsNew5nR9cYdw2e53rYs27+xSw=
X-Gm-Gg: AYBFou0nEd1wzMqXjTjljOvuUXVgoEm5GSJcpZ1uDuhYFd6rSuDnlh1Fb2DDVX0enPr
	UPJLYnUgCWXTHdreIXA/Ijm8GfmHMCE7JO8LYNFI/vCgwMvemaMftKd6yIQwPwcW1RKXT6wlbm8
	YYLcQjH+Wayv4ZW/LikUT+WjUeJzldklQ8WpuDOYWfx4sMlPqvogltrFSpH7kdJplNm6mQKuL2v
	vKjaMd2ghcF+fkjXTXQaN8E2p1P9rEoemsRIFgkXh9E6ng0+gh6W7CEVSZfe9n1jsZU5sICwdIg
	WAYy6ivs9YVnzJ/fOT7d7hbz3jkjKe9s7nUTaUsKl6j55+9RKfUkLheERzsQZ+I5cDqbkw7HcqP
	qp2rxagNDRel/fHHjRJ2+oTMbTFD0QWnpcMbAbqIhgQS8kh/LxeWTjdfohQq6k5b/QPb8ljNNOE
	dI3HJaLiTztZiR2M66W4hUYeY=
X-Received: by 2002:a05:6402:3787:b0:6b5:74dd:37f3 with SMTP id
 4fb4d7f45d1cf-6b574dd39aamr1147352a12.38.1793831261972; Wed, 04 Nov 2026
 14:27:41 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com> <20261104-perf-alpha-profileme-v4-2-1771ea02950e@gmail.com>
In-Reply-To: <20261104-perf-alpha-profileme-v4-2-1771ea02950e@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 4 Nov 2026 23:27:30 +0100
X-Gm-Features: AclHuK-E3YidK4R7qpjEd0-aTfWoNyIvFLSGqk_JEj3O4YMcEfJ5h8s_oOS4dx0
Message-ID: <CA+=Fv5TbocBsz9Esu-ZcEmNkRGBxkQ+enjLUZeqy485JM4Om+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf python: Add alpha-profileme.py
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Wed, Nov 4, 2026 at 7:54=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> perf report shows where Alpha ProfileMe samples land but cannot
> aggregate the raw status attached to them.
>
> Add a standalone script, using the perf Python module, that summarizes
> it by symbol or, with --pc, by instruction, in the style of DCPI: the
> fraction of samples killed on a wrong path, not retired, mispredicted,
> taken or stalled, the mean PCTR1 window count, and trap counts by type.
> Mispredict and trap types are only counted when I_STAT[TRP] is set
> and the instruction was not killed before it was mapped, since they are
> stale otherwise. Redirect traps are counted by their
> PALcode entry offset in PMPC.
>
> Raw data is only read from cpu PMU events, as a tracepoint's payload can
> pass for ProfileMe status. Rows are kept apart by PCTR_CTL[SL1], as a
> mean over two things PCTR1 can count means nothing.
>
> On an EV7, sampling a loop whose branch tests random data reports that
> branch mispredicted in 21% of its samples, and 0% with sorted data.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  tools/perf/python/alpha-profileme.py | 178 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 178 insertions(+)
>
> diff --git a/tools/perf/python/alpha-profileme.py b/tools/perf/python/alp=
ha-profileme.py
> new file mode 100755
> index 000000000000..da374d206187
> --- /dev/null
> +++ b/tools/perf/python/alpha-profileme.py
> @@ -0,0 +1,178 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""Summarize Alpha ProfileMe samples.
> +
> +Aggregates the ProfileMe status that the Alpha cpu PMU attaches to each
> +sample as PERF_SAMPLE_RAW data, by symbol or, with --pc, by instruction.
> +
> +Record with raw data, e.g.:
> +  perf record -R -e cpu/instructions,profileme/ -- ./workload
> +A precise event such as instructions:p samples only retired instructions=
,
> +so its killed% and invalid% columns read 0.
> +  alpha-profileme.py [-i perf.data] [--pc] [--top N]
> +
> +Columns:
> +  samples   ProfileMe samples attributed to the row
> +  killed%   profiled instruction killed before it was mapped (PM_KILLED_=
BM)
> +  invalid%  instruction did not trap and did not retire valid (VAL clear=
)
> +  mispr%    conditional branch mispredicted (TRP and MIS)
> +  taken%    TAK set; only meaningful for rows that are conditional branc=
hes
> +  stall%    instruction stalled between fetch and map (PM_STALLED)
> +  pctr1     mean PCTR1 count during the window; what it counts depends o=
n
> +            the event: inum retire delay for cycles:p, window cycles for
> +            instructions:p, Bcache misses for bcache-misses:p and Mbox
> +            replay traps for cpu/mbox-replay/p
> +  traps     trap counts by type, only for samples with TRP set
> +
> +TRP, and MIS and the trap type with it, are stale for a killed instructi=
on,
> +so mispr%, invalid% and traps ignore them there.
> +
> +Samples from events that set PCTR1 to count different things are printed
> +in separate tables, as their means cannot be compared.
> +"""
> +from __future__ import annotations
> +
> +import argparse
> +from collections import defaultdict
> +import struct
> +import sys
> +from typing import Optional
> +import perf
> +
> +TRAP_TYPES =3D {
> +    0: "replay", 2: "dtb2-3l", 3: "dtb2-4l", 4: "fen", 5: "unalign",
> +    6: "dtb1", 7: "dfault", 8: "opcdec", 10: "mchk", 12: "arith",
> +    14: "mt_fpcr", 15: "reset",
> +}
> +REDIRECTS =3D {0x481: "iacv", 0x581: "itbmiss", 0x681: "intr"}
> +PCTR1_NAMES =3D ("cycles", "retire delay", "bcache misses", "mbox replay=
s")
> +SAMPLE =3D struct.Struct("<IQQQ")
> +
> +
> +class Row:
> +    """ProfileMe status totals for one symbol or instruction."""
> +    def __init__(self) -> None:
> +        self.samples =3D 0
> +        self.killed =3D 0
> +        self.invalid =3D 0
> +        self.mispredict =3D 0
> +        self.taken =3D 0
> +        self.stalled =3D 0
> +        self.pctr1 =3D 0
> +        self.traps: dict[str, int] =3D defaultdict(int)
> +
> +
> +def pct(n: int, d: int) -> float:
> +    """Return n as a percentage of d."""
> +    return 100.0 * n / d if d else 0.0
> +
> +
> +class ProfileMe:
> +    """Aggregates ProfileMe raw sample data."""
> +    def __init__(self, by_pc: bool, top: int) -> None:
> +        self.by_pc =3D by_pc
> +        self.top =3D top
> +        # Keyed by PCTR_CTL[SL1], which sets what PCTR1 counts.
> +        self.tables: dict[int, dict[str, Row]] =3D defaultdict(lambda: d=
efaultdict(Row))
> +        self.skipped =3D 0
> +        self.session: Optional[perf.session] =3D None
> +
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Add one sample's ProfileMe status to its row."""
> +        raw =3D sample.raw_buf
> +        # Raw data from another PMU or a tracepoint is not ProfileMe sta=
tus.
> +        if (sample.evsel.type not in (perf.TYPE_HARDWARE, perf.TYPE_RAW)=
 or
> +                not raw or len(raw) < SAMPLE.size):
> +            self.skipped +=3D 1
> +            return
> +        version, pmpc, i_stat, ctl =3D SAMPLE.unpack_from(raw)
> +        if version < 1:
> +            self.skipped +=3D 1
> +            return
> +
> +        symbol =3D sample.symbol or "[unknown]"
> +        if self.by_pc:
> +            if pmpc & 1:
> +                key =3D f"PAL+{pmpc & 0x7fff:#x}"
> +            else:
> +                key =3D f"{pmpc & ~3:#018x} {symbol}"
> +        else:
> +            key =3D f"{sample.dso or '[unknown]'} {symbol}"
> +
> +        r =3D self.tables[(ctl >> 2) & 3][key]
> +        r.samples +=3D 1
> +        killed =3D (ctl >> 26) & 1
> +        trp =3D (i_stat >> 39) & 1 and not killed
> +        if killed:
> +            r.killed +=3D 1
> +        if not trp and not (ctl >> 1) & 1:
> +            r.invalid +=3D 1
> +        if ctl & 1:
> +            r.taken +=3D 1
> +        if (ctl >> 27) & 1:
> +            r.stalled +=3D 1
> +        r.pctr1 +=3D (ctl >> 6) & 0xfffff
> +
> +        redirect =3D REDIRECTS.get(pmpc & 0x7fff) if pmpc & 1 else None
> +        if redirect:
> +            r.traps[redirect] +=3D 1
> +        elif trp:
> +            if (i_stat >> 40) & 1:
> +                r.mispredict +=3D 1
> +            else:
> +                tt =3D (i_stat >> 34) & 0xf
> +                r.traps[TRAP_TYPES.get(tt, "other")] +=3D 1
> +
> +    def print_totals(self) -> None:
> +        """Print the busiest rows of each table."""
> +        total =3D sum(r.samples for rows in self.tables.values() for r i=
n rows.values())
> +        print(f"{total} ProfileMe samples, {self.skipped} without Profil=
eMe data")
> +        for sl1, rows in sorted(self.tables.items()):
> +            print(f"\npctr1 counts {PCTR1_NAMES[sl1]}:")
> +            self.print_table(rows)
> +
> +    def print_table(self, rows: dict[str, Row]) -> None:
> +        """Print the busiest rows of one table."""
> +        print(f"{'samples':>8} {'killed%':>7} {'invalid%':>8} {'mispr%':=
>6} "
> +              f"{'taken%':>7} {'stall%':>6} {'pctr1':>7}  {'location':<4=
0} traps")
> +        ordered =3D sorted(rows.items(), key=3Dlambda kv: kv[1].samples,=
 reverse=3DTrue)
> +        for key, r in ordered[:self.top]:
> +            traps =3D " ".join(f"{k}=3D{v}" for k, v in
> +                             sorted(r.traps.items(), key=3Dlambda kv: -k=
v[1]))
> +            print(f"{r.samples:8d} {pct(r.killed, r.samples):7.1f} "
> +                  f"{pct(r.invalid, r.samples):8.1f} "
> +                  f"{pct(r.mispredict, r.samples):6.1f} "
> +                  f"{pct(r.taken, r.samples):7.1f} "
> +                  f"{pct(r.stalled, r.samples):6.1f} "
> +                  f"{r.pctr1 / r.samples:7.1f}  {key:<40} {traps}")
> +
> +    def run(self, input_file: str) -> None:
> +        """Run the session."""
> +        self.session =3D perf.session(perf.data(input_file), sample=3Dse=
lf.process_event)
> +        try:
> +            self.session.process_events()
> +        finally:
> +            # Break the reference cycle between perf.session and self.pr=
ocess_event
> +            # because perf.session lacks cyclic GC support (tp_traverse)=
.
> +            self.session =3D None
> +        self.print_totals()
> +
> +
> +def main() -> None:
> +    """Main function."""
> +    parser =3D argparse.ArgumentParser(description=3D"Summarize Alpha Pr=
ofileMe samples")
> +    parser.add_argument("-i", "--input", default=3D"perf.data", help=3D"=
Input file")
> +    parser.add_argument("--pc", action=3D"store_true", help=3D"aggregate=
 by instruction")
> +    parser.add_argument("--top", type=3Dint, default=3D30, help=3D"rows =
to print")
> +    args =3D parser.parse_args()
> +
> +    analyzer =3D ProfileMe(args.pc, args.top)
> +    try:
> +        analyzer.run(args.input)
> +    except IOError as e:
> +        print(e, file=3Dsys.stderr)
> +        sys.exit(1)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
>
> --
> 2.55.0
>

I checked alpha-profileme.py against the raw fields in recordings from
my ES40. In the v6 recordings, 644 samples had both PM_KILLED_BM and
TRP set, including 10 with MIS set. The script correctly ignored those
stale bits when counting traps and mispredictions.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
