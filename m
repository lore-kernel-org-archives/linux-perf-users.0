Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755779;
	b=GKvGxWmV/KSvHlypsHiS7ylXInv8rCJMKqOoC+t1Trkyst9xFcsQBUzBlqXiea80vFlQ
	 fPbHbULkHM5Cw1XdRPeKBmtKZ1mLH3MLTUi70pHTQGQ9Go8fecgbJURGmTHzwXhgeWhC5
	 86s8g4Tu0c7wdH2njnJKdNUC7a2uUZ8jKlygEK1tiOKCG3ergKkFB3bO3Z4j5J7aCw7xF
	 VlMK8Cw6ieRzgB+lxKfwyEulQGm9lUtL8NyV+JMaF5kKV8tyhGcF6KBH3XaM8rcsL/F7D
	 UzJzC/J5qXMdv3S0TOuG4TDiUXTEddnjgqHUFve93LDui5yXZdjCnY8c8D00hRfdlLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ldZ8PCFlLZZkKJL96y+Yw4+DhZTFWMnWRQJQmc+WkI0=;
	b=zESdiT5gLj/cLenWbNAcvt2J1ANdUIAt+mww3Gj34qS61W4Uqot+w4rHXOwl0OgLXaeA
	 CIbSjiuMZzunKb5oT4oMQ/S4MKV5KleZmg1BNQtACAMHy4NJA9m61t733lvbNgstoCnxd
	 KMyPnoLfG47etkkdnm2phXtjJoiDR+4dQfa1m9LClWR6rRpjoFgsn3ubhwnJr23xqGeZL
	 hh0K6AON4gwsUOgYDxEeBRDtwIAaTYeoQB9TPw6+K1OI+yq7ybORCaPiLYk5nti6qAdQX
	 OS2fy/jURc/lqGi13pT0hIAvM6nFDr9MwP4eZjDhJRcfQrLsGJ+ewFyvM0obQvPHeFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w02l4sOv;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B9606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 501B9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w02l4sOv
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677bc4704cbso8956783d50.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755778; x=1796360578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ldZ8PCFlLZZkKJL96y+Yw4+DhZTFWMnWRQJQmc+WkI0=;
        b=w02l4sOv6l9Pylfx6A0Jef6M7ifhjoD7Kml0J3yWoQ6Bnq6K7Q2PFGDaM7u2ipRoql
         5YfqyxV/dSZV2HVbT/z6WFzuFHgHrJuis9f6XI5jJo4exHO9pMUVifMnaZcwwWn2vh7x
         9oED1NEtSnYTNpqEVFSWUEFDo0h1FbNbSL1qhSLDW606JDjw5WlcgwFtrBIci94PstNS
         0QkD83HWM+HZBuwzmtj76ZB0B+xEomDKt1cB0TkH0BnHmNhq6Vd9DDOxArKsPu+E7abM
         KGOp0y2rl8dzpoR2qvH7yp6RWJzCqjlLLZGjjmuEPUrXsBTuss8maH9bxZimU2irT6IC
         sxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755778; x=1796360578;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ldZ8PCFlLZZkKJL96y+Yw4+DhZTFWMnWRQJQmc+WkI0=;
        b=WnaIkdWIcOpdtOW/twoWFmGXGdcqb7E4WKGIpaaxjac/yWmDh15X4IS+bKYTdpRNy7
         Kd3fdNtyJ3uTas84LhHl4vcpRJlNI9HwWku16N7DdDg7KWaYOXF6ORsAoQtuJuBr66OS
         XvUTQkj9zp/3AG92KsTmL7uGl4N+1HlbqVVcFZW5Zlz7LizWu91EdRsWG5YWY4azpQY8
         R13gqyg9tubapVK92ncET+yeS9ZfJIWpbFV3p8EDFyJ0Stw0Zfgzsx2azWPbSrj3tTJf
         jG1jzjo3RYMPXbEChOhi0s4ETKULD3SgQK/P9rW9mC+Xth6lQi82TuCyHWrzRS0QZV4/
         rCxA==
X-Forwarded-Encrypted: i=1; AL+hErE5ntAvk7fidCXfQ77gA4XK7fd2199n+TMVYM09VMGIfJbgsp9GhU/ImE3rPcuGq/8oblmDkBQjdEgs1uHLgzLt@vger.kernel.org
X-Gm-Message-State: APuU4Z/DF23QjAE0eJU+PKXnFo9a2KR+TxPR4Isni0qed0dZva7ZDtKA
	9zWPncp3ov00Dl5Ni+F5sXg8hTsptJkt06nkeWPgbq31bOhHypg5LqkF
X-Gm-Gg: AZFdTZdj0I1+zu9apq6usZ4TLkucbOUevtAuGlvTCOrorczH/8Uen9UweAqkg9tEuE+
	PCRmnqRhRQ5ZylshB+99VIamEhKVsuBAKK6IZ1F+MXmyiiLgu5hulbOAlhvMpDoah9H2VYbgInf
	3kGXOLXTxqbKffv5NRCPydsTtdev0HGOKb5Acr2UFJi/J0rQ+OJaq0k1GhMbbCMTLufYlcUdG8X
	Ax3IFZL+6DZ6XWfubfyEEYsCdVx3wjegZeVZmLDe6/CFxjb/ZcrC7FMNixN9pkY8mawycHLa+CR
	L9LvEzdXD0MR0+yRe8qD0psPgtO+dWDHJE7PgvbicXhEtWDcKTDkHWLBGILoXtMNQoRs64XeDLs
	y5nKhJw9q+M/hFoSJI6faiBGWPd5RcCGJBPfKxqHURQc6w0dFSRXdpVszGaetUpuDTS2GZxz7p3
	DnaJMvF0vziQpH1N0rklRix78P3UZOMLNfQc+B7dSJDGlntm0DpJ1A+pAnY25zXDhaa6KOPy39S
	JZXFRVViDWA8ecwI5JKwW5TgPiMt2YzeaKhQMOZYHK8Wx8o3e7FJ1rhZWzZLKZxf/3AmAkd4OxZ
	kimSVJIi+BwJHrtcz3MNo4KyZ17mbOU0adHqs9MmH5g9Ro2CsYDopweavdLEH4MHWScVGVAP7Ya
	XvbtFHyQUq1luoKHTPHR2Tj/Bbv0gExr8TZjmBV84VA==
X-Received: by 2002:a05:690e:479f:20b0:67d:b472:88bf with SMTP id 956f58d0204a3-67df44e6c52mr5839588d50.162.1795755778290;
        Thu, 26 Nov 2026 21:02:58 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df30e4407sm11064397d50.0.2026.11.26.21.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:02:56 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/7] parisc: perf: fix the RDR tables and add
 PA-8800/PA-8900 counters
Date: Fri, 27 Nov 2026 00:02:53 -0500
Message-Id: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBCF4auYWUsCxCDxKqYLwKGOCyQz1TQx3
 r203b1v8f4LBJlQYOouYDxJaC8Npu8graE8UdHSDFZbZ4x1qgYmSaoi57a911rpMbpohmEJPkI
 7VsZM7190fvwtR9wwvb4luO8PONXj3XYAAAA=
X-Change-ID: 20261126-parisc-perf-pa8800-07b6b144da8b
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4750; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=8XZcFb1qpQxx4pRvdS1id0E+PcjfcsQRHzh889C9bUM=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5+f5tWiivvuWGOe8Ji8Pz+vvDM7PFt0v1pXQ8X/K8a
 mOuygOnjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmKSvD//A90isWLc
 7n+m78a06/C/f9CPe8naudXJqOqN51nuq5QYrhn/K+SyW/DVY/uum1e8Xdden7e4LNw2R6RWY2L
 TML3dv/nBMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The first two patches fix the RDR width tables of the existing /dev/perf
driver: the PCX-U and PCX-W tables have been swapped since the driver
was added, and PCX-W2 needs widths of its own. Both are taken from the
RDR description tables in the PA-8500/PA-8600 and PA-8700 PDC firmware.
I have no PA-8x00 machine older than PA-8800 to test them on.

The rest adds support for the PA-8800 and PA-8900 (Mako) counters, which
/dev/perf claimed to support but could not program: they sit in RDR15
of a second RDR chain that is shared by the two cores of a processor.
The access sequences and the event image come from the C8000 PDC 2.13
firmware's PDC_INTRIGUE implementation.

The firmware's image counts only TLB misses and cycles, on the first
core, and nothing documents the other event selections, so I found them
on a C8000. I flipped every bit of the RDRs the image writes, one at a
time, in sweeps of several thousand settings each, and compared the
counts against about 30 small assembly loops with known numbers of
loads, stores, branches, cache and TLB misses and nullified
instructions. Many settings take an HPMC or hang the machine and need a
reset through the BMC. The bits that select events turned out to be
spread over three RDRs on both chains. This found cycles, stall and
non-stall cycles, instructions with and without nullified ones, TLB
misses of either kind, TLB handler cycles, loads and stores, D-cache
misses, branches, taken branches and an instruction match filter.

I expected to find at least what the PA-8500 to PA-8700 images in
perf_images.h count, but mispredicted branches, I-cache misses, return
stack predictions, branch abort stalls and D-cache misses inside the TLB
handler are still missing. I also could not find any HP-UX tool that
used the counters on PA-8800 or later. The last release of CXperf was in
2001, two years before the PA-8800 came out, and its HP-UX 11.11 kernel
module does not program the PA-8x00 counters at all. Caliper was to be
ported to PA-RISC but only ever shipped for Itanium. The PA-RISC kernel
of HP-UX 11.31 has a cpu_is_a_MAKO flag, but nothing reads it.

On a Mako, PA_PERF_ON currently runs pmenb on counters that have never
been configured, and that takes an HPMC on both cores of the processor.
Patch 4 loads the firmware's image first. Getting a report out of that
HPMC, and out of the ones the RDR bit sweep caused, took the HPMC
handler fixes sent as "parisc: fix the TOC and HPMC handlers on 64-bit
SMP":

https://lore.kernel.org/r/20261126-parisc-hpmc-fixes-v1-0-80fb55336ac6@gmail.com

The two series do not depend on each other.

Patch 5 exposes the counters as a perf events "cpu" PMU, so that perf
stat works, and patches 6 and 7 add the stall, TLB handler, filtered,
memory and branch events. The counters cannot interrupt and do not
distinguish privilege levels, so there is no sampling and no exclude_*
support. /dev/perf only loads the firmware's image and gains no new ABI.

Tested on a C8000 (2x PA-8900, 4 CPUs, 1.1 GHz) together with the cr16
and HPMC series: on every CPU, alone and with all four counting at once,
a pinned loop of known instructions counts 1.0011-1.0014 of them, also
over 18 * 10^9 instructions and eight counter wraps, and the cycle count
read through /dev/perf runs at 1100.6-1101.5 MHz. The memory, branch and
filter events count the expected number per iteration of small loops of
loads, stores, branches and adds. Events that would disturb the other
core of a processor wait while it has events, and /dev/perf and perf
events refuse each other with EBUSY.

---
Matt Turner (7):
      parisc: perf: swap the PCX-U and PCX-W RDR tables
      parisc: perf: add an RDR table for PCX-W2 (PA-8700)
      parisc: perf: add PA-8800/PA-8900 RDR and DR2 access
      parisc: perf: program the PA-8800/PA-8900 counters
      parisc: perf: add a perf events PMU for PA-8800/PA-8900
      parisc: perf: add PA-8800/PA-8900 event sets and an instruction filter
      parisc: perf: add PA-8800/PA-8900 memory and branch events

 arch/parisc/kernel/Makefile          |   5 +-
 arch/parisc/kernel/perf.c            |  88 +++++-
 arch/parisc/kernel/perf_asm.S        | 163 ++++++++++
 arch/parisc/kernel/perf_event_mako.c | 586 +++++++++++++++++++++++++++++++++++
 arch/parisc/kernel/perf_mako.c       | 565 +++++++++++++++++++++++++++++++++
 arch/parisc/kernel/perf_mako.h       |  88 ++++++
 arch/parisc/kernel/perf_mako_image.h | 208 +++++++++++++
 7 files changed, 1685 insertions(+), 18 deletions(-)
---
base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
change-id: 20261126-parisc-perf-pa8800-07b6b144da8b

Best regards,
--  
Matt Turner <mattst88@gmail.com>

