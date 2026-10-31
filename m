Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793468638;
	b=4n7q26dYxut05mCxofx9muCkF7zPxeNbTSLFuBrFBEnUSE8bNuVU+lyZF3bjrJe5PM+3
	 op/pMbuiDk9qbDwydI+l9LwpY+P74CYaKTRaIWbWQ8W9+LckvAc8srEom+ZBS5SY9lRo3
	 jF+ghjjkozBYUmfXU6sNAPIhHzYeB01AyY0TnOyzoKLJ8OHQZg5OTQrDAt7JQaAnARx9w
	 wRqqAeEy4TQUzhFW1eFdLpehahhQVO2RFB+viCH3uY+geSjuqUfjmOQxi9Uzri84fvYrS
	 /7QPVOwpiKunxvGjOjS6PKo2cjL6WK2FSElQbS6uERqmT+yZlK4NklvlhhKJwPlkCTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tpJVUHUX1SYqW8DDRmdRkjnrkQV4VZulE3lRBuXBmBU=;
	b=edw0wonVhVecLizgAE7c6dwFuBY/66qhixh3vRBbuY/S3ZJBlWW1Cmmv8RD6KAZYpCVS
	 Up9/isbeY/2aS6zeR1JrpX5vJBHOdngOLxmD/yE7nlmBd7NnX+cxJRrk9NVWAbTa7FiGG
	 /zISrxCUf5YrAfGDEdMzY+y99ZA4aE9pvMresGx/Npghc3PL46diU17N7Z4FKhb0k7PWI
	 pHhbnqfKRP449DmO3MJAWk2ouRQAp3hAFJ4CC0AqivoAX49IOikaUNiWrRahJJxLQ13k4
	 US9MMVbum3vJJcvhHt7DOewB3wGN2V3mYDPJ8FYTkP39Nq4Mw7lm9YOxgilcW2FnieA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zkObb6j7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080B606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 17:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5080B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zkObb6j7
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso179709766b.2
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 10:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793468637; cv=none;
        d=google.com; s=arc-20260327;
        b=dtPgu/xUctN2EsvigCzbTBup7G2Mh4ex9Jimta8QyrDp/V+nCntu5wRAkk/hDrLUS5
         XawBrwEkVKPjZCwn8s02oBIhOAC7hlHy6w1ggncr1uX9Zzokn5hEGUBm5i5omW7u36t7
         TVbDKpQj6G+SXn7CyIIA4/bunioOtAWjRXoml15Hr3sbX474kgQxIbzLS1aklHZ3vme5
         P3z6ka8I7KV+cY5kBcX4icvwYUs0mFwEDm2Qq6PF1joiLCJSxYC0QXyQGJxm+NwhSgVH
         ExmdztRKOUS6x4+hqswOVf7hUuJCxgLQpAmqsGtugMlgwmmo394WLRr4k6Ej69AFMH6a
         oAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpJVUHUX1SYqW8DDRmdRkjnrkQV4VZulE3lRBuXBmBU=;
        fh=Js/6RUqAl+YaeX4wqmoLEpRVgWaDj9nmjQ2mOTuZPL4=;
        b=rOvNHzG/cVXzOpLyULW69vb+GRbaCwlXrgY/Noh/WhD1DNu7eSUf5OxaVwRBLDMqe3
         XNYGsFpXj7zJGhpaoTcvT+xAF4UbiECovae7i5tjwOmuv6GBGIH3aqz4fZ1ZuAaZvKV+
         7RCwm0mAfXxbOuHp6HmkDffh8/6mLu4DKocuwnr8q2ECHVDKBMSKydLjJi8YIEUJ8xUE
         9gDRygaS4BJKzLUwadS7qGTpXy5iCOd6o3ez1dgQJAvU/4QgLk4bNiM+AGISeeZN9JOf
         sZtkvsGeDPU18hhl41TV41fEfNbXBUvfZBMLFaKgwRoiXI8hBWxFF5kzsSEtETKp3SZY
         6qGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793468637; x=1794073437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tpJVUHUX1SYqW8DDRmdRkjnrkQV4VZulE3lRBuXBmBU=;
        b=zkObb6j7GaY+zs4kYDsBylH03Lbm+TjWGxg5oHC8/wGzLFdeyY/4KaJkNow/kY9zgK
         +1Xfx/FP2H+HHF2KXtQvLut58F1lR8WNEwalHQNBqK+b0TE1PBoMlVzdhpxds/zE3iCu
         P/ZqxR6BSygto5QA27yF1DiXcD5fNHrlfqTQU5kLzzLx7HfGo5t7IuZ60iGvoshGkZya
         no5QtYpk6YxcoO7MaO6ljP0yNpedH3/miDfJIMPmBdDV9stCyHASNg3AbcN9jG1aDrCU
         3a9DmlsC6/MjCy/5UvUoijGX9r89PXYhsdVY/gJsHUw+Q2P0w+TPLul+KF/QgBQtlmuv
         o7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468637; x=1794073437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpJVUHUX1SYqW8DDRmdRkjnrkQV4VZulE3lRBuXBmBU=;
        b=v0pvAxFTiYWRzQEopDVPbHwnNKluWxKaZ9NE94plFnb//5DwTxW03saDrs5EI5d/8O
         vVrwvS3rHeKKp+X8yKGD/vaqWNYcVaeJVKu2Q1aYbueRuWbFX0V60upDBoWZSXNqnJ9d
         jrBXF1Ku/cYz6x4PyoDITzMv3F5iokMp+hrQ7u1E3OQ35feHMd2CdEDR8DrVu487q2rz
         gQZDTEoGq/OiknjIjC2BPHz7BK80Gj5w/e0dIykWF+u8UhqnG/bixg4dcGP3D44becGJ
         fXe5PrZosR3E4T+lEepHHPAkDVLPX0s6/y3aXBRxkntQX+w+sAh9qBRrqMrJ/1wCf2ws
         KXaw==
X-Forwarded-Encrypted: i=1; AKwUvBzd+y57e34MznMx0nOvdmgIARsRAB/BZBEdiEH1vk6Bs3fWG7dzZqQoOip7WR75VV3IuNuh/H+8MgiraUMVnddu@vger.kernel.org
X-Gm-Message-State: AFq9FYJydx7cV1rhTq7oUXq9kabPbMVRioBc/KBARfdlWUmwBfFLBZgD
	5n3TR+pPuACUMJs5oe2H89sPwjY3jU6CUfR3cxaFgTMM2SBbRgVWuTv65NiAvVBQVDA2Kf9y/xX
	7nUooxn+EKwPqaVE8+9KWWiVxmIuDcH4=
X-Gm-Gg: AYBFou1yp2yObseIXSIMHxzqvfDW5UziwjB9inObdraaGIgZIaVWl5EzzaMope2rJpW
	BjYnwD/3jTTwdjvEMnC5B4Pcv3u1qqTgVqXXjrTylOcCZ8HgvpVmIq0dYbGaMuAmdfnBzJCem2D
	hm6HrBsbZuQTdfSIXeE8cYyc247S4Pws/8L6ld7XHukwtDtFTME+FL9XMGhiJgCTuazIScDj+jj
	WfakgbZKuuFZc1W6oFtRDWPdrd+SgXF4O1qbeiXA/VwCXgVJdNO8sbA/asvcbGpCgW/JHq2FXCX
	TJnXsrkPvuNQzBFBld+9+ojXpTlnWKn6BzSghGmdB2bAJJPxu7LlSty/A8thmNYVMsu8dclfxsq
	FWwOC+PS8T7Pz6K6YzpVMZ5CTb8cWqHycBIBJJ03EgggvwWYtYxXnGJi0A75I0PSKhPk+IWAqRc
	I/QEAU5mOLBwxKywny7ikhhd4=
X-Received: by 2002:a17:907:1b29:b0:c41:26b8:c49d with SMTP id
 a640c23a62f3a-c4ca7ab18d6mr482885966b.38.1793468636616; Sat, 31 Oct 2026
 10:43:56 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com> <20261030-perf-alpha-profileme-v2-2-9ce2f0b0e622@gmail.com>
In-Reply-To: <20261030-perf-alpha-profileme-v2-2-9ce2f0b0e622@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 31 Oct 2026 18:43:45 +0100
X-Gm-Features: AclHuK9-36YoAe-AfeSjFGej2qPPk6oLiKJcu13eVoK7K6LnJ7aqvhCmb6_DCyg
Message-ID: <CA+=Fv5Qa4HnADkCey1XA_JbV5vsABzZCZ+kS-OJHjFDH2mQv_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf python: Add alpha-profileme.py
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

The script decoded single-event recordings from all four ProfileMe
modes on my ES40. I found two issues with mixed input.

On Fri, Oct 30, 2026 at 5:09=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> perf report shows where Alpha ProfileMe samples land but cannot
> aggregate the raw status attached to them.
>
> Add a standalone script, using the perf Python module, that summarizes
> it by symbol or, with --pc, by instruction, in the style of DCPI: the
> fraction of samples killed on a wrong path, not retired, mispredicted,
> taken or stalled, the mean PCTR1 window count, and trap counts by type.
> Mispredict and trap types are only counted when I_STAT[TRP] is set,
> since they are stale otherwise. Redirect traps are counted by their
> PALcode entry offset in PMPC.
>
> On an EV7, sampling a loop whose branch tests random data reports that
> branch mispredicted in 21% of its samples, and 0% with sorted data.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  tools/perf/python/alpha-profileme.py | 162 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 162 insertions(+)
>
> diff --git a/tools/perf/python/alpha-profileme.py b/tools/perf/python/alp=
ha-profileme.py
> new file mode 100755
> index 000000000000..19572431aeac
> --- /dev/null
> +++ b/tools/perf/python/alpha-profileme.py
> @@ -0,0 +1,162 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""Summarize Alpha ProfileMe samples.
> +
> +Aggregates the ProfileMe status that the Alpha cpu PMU attaches to each
> +sample as PERF_SAMPLE_RAW data, by symbol or, with --pc, by instruction.
> +
> +Record with raw data, e.g.:
> +  perf record -R -e instructions:p -- ./workload
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
> +        self.rows: dict[str, Row] =3D defaultdict(Row)
> +        self.skipped =3D 0
> +        self.session: Optional[perf.session] =3D None
> +
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Add one sample's ProfileMe status to its row."""
> +        raw =3D sample.raw_buf
> +        if not raw or len(raw) < SAMPLE.size:
> +            self.skipped +=3D 1
> +            return
> +        version, pmpc, i_stat, ctl =3D SAMPLE.unpack_from(raw)
> +        if version < 1:

An unrelated tracepoint payload can pass the length and version
checks and show up in the ProfileMe totals. Could we check the
originating event before decoding its raw data?

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
> +        r =3D self.rows[key]
> +        r.samples +=3D 1
> +        trp =3D (i_stat >> 39) & 1
> +        if (ctl >> 26) & 1:
> +            r.killed +=3D 1
> +        if not trp and not (ctl >> 1) & 1:
> +            r.invalid +=3D 1
> +        if ctl & 1:
> +            r.taken +=3D 1
> +        if (ctl >> 27) & 1:
> +            r.stalled +=3D 1
> +        r.pctr1 +=3D (ctl >> 6) & 0xfffff
> +

With two samples at the same location, one with SL1=3D0 and a count
of 10 and another with SL1=3D1 and a count of 100, the script reports
a mean of 55. PCTR1 measures different things in those modes. Could
we group by event or selector and label what PCTR1 counts?

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
> +        """Print the busiest rows."""
> +        total =3D sum(r.samples for r in self.rows.values())
> +        print(f"{total} ProfileMe samples, {self.skipped} without Profil=
eMe data")
> +        if not total:
> +            return
> +        print(f"{'samples':>8} {'killed%':>7} {'invalid%':>8} {'mispr%':=
>6} "
> +              f"{'taken%':>7} {'stall%':>6} {'pctr1':>7}  {'location':<4=
0} traps")
> +        ordered =3D sorted(self.rows.items(), key=3Dlambda kv: kv[1].sam=
ples,
> +                         reverse=3DTrue)
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
>

Thanks

Magnus
