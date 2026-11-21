Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795279282;
	b=JxCPJRCX2f3CdiCWMtZlgDPsYdxxV6XnznXWKkf2B4fv9QLIUWtVtMohrkNsNARhS+LM
	 r/563Y9HzmpYGsMBWX7zvmxeDpfO7qTuqbybiBuHIqWu2wbyPzcSJCedH4JMS1s8TlQtO
	 JP/llzAe8LWebOGRrYI0RMrzTJSaSFmiu1mirw0LGSF4U2RTE/iwpPXSpCJKUh7kEPwGQ
	 PTMAFiO1oyKDkl3o3eLOitio76Q3DNP9mNXw0Ttz1Mf6RuO9NM9i6fsJEnw54AcA93/fG
	 PSgbIXDGthZlbyVcqt3nYU8JDezSicaP5OTqRcrKYfi7HMRfHqRw6Av8OhoEOOT02zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279282;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=5QGqpwAd2j04+ouNovEsuYr3y8kKvb4OP6cEVFGZvjQ=;
	b=RzXn1wmSgITy80ptWCQUd/S8/r7GC3T85ZChC5GpaqjiEDxCPE52b/0gW7OcmiPNjK43
	 NagV/nhv430slIgD1AtRc2RaGi2x7i2XcUly3URBYSkr6CEXTgEgmJpTGa8QUtik68qlV
	 FfJXntwU7IfGpagTKbKiPXJlEce4wDrNWr0+5xvJ2hqhYGDJdgKcj/KAotxorU0JCJICL
	 1p5+7x9Q2anDPxNL4Cl9YSzneGDaPe81cdQSzwdym1RIurpO8v5YkLaGW5bMmhm4QdfPO
	 TpPXuS4mz5nJ7EU9rjKiSVsoj3MNmjXtyP7A47tkOgNzopiLyPPPG374GnNQqmpHFaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQqvWjAr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C99606A32A;
	Sat, 21 Nov 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQqvWjAr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795279282;
	b=BHA7FzHQGs85EwQlRiqnx4yf4I9uT6Oc2ovbNa/oSkUZBJ5eh2S4MRphFGDbGkVkZyd9
	 TwBcSCHNjT1WKjgHVKwXgMjzc+8tI1bf1gKf6iVrO9+fwmyLDEj/w0/q1XvQE+xWDYRlD
	 pkNIryjs1Oc6vxlQF00P6jptkEzKO+YYkpCShkQXy7rPuMB61iE3dA22HTN4EJSfyHpAE
	 lM6A2uXSvHmqYKpHgcVd/MvDbTJSpedJCPdvUtRs7H1ScO/PGS1s2/kM2cfCqLMdz7d2K
	 xvtC0zIKXMQNTqXKgpv3qgGmV3QIv7tLi+Xwk0/j1EwWMQE2ewDcq3sn70XpjIfRtQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795279282;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=5QGqpwAd2j04+ouNovEsuYr3y8kKvb4OP6cEVFGZvjQ=;
	b=sVvVS82qZasT1nxBDwE934rA8BQG56fSbR67XLES92p5KCQh6cBQybUSBqTQ9U4tB6Uk
	 zc5nS56PfMwz3ao72XeDevvEXxjqc01CBAIuyXtAnZCRMjeyR/vrsu+xa9vhyuYn7wVYN
	 ZCv299o/G9fIFL2gssUdDXELZ7idJTb9yE21svI8ApNlrX+xBJYILOwZ9ff+QKnlGzoQw
	 KnDPhsfp2CTI5WfEpVlSM9kzaRV3Ww0BDH0J7brRVvpqZ1fbv5Q+/0E+YKV1e+ftMqidw
	 2xUoO2wr0/A3CcrWTC4HLRsy67VRdW2L+x7giA3MNxzuovn12iU7uY6sVdEDbFt7/tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7790F1F000C6;
	Sat, 21 Nov 2026 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795279282;
	bh=5QGqpwAd2j04+ouNovEsuYr3y8kKvb4OP6cEVFGZvjQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hQqvWjArPzdZFzh791XoFobzKCzySve09kibsI8IFeeoQlT0BytlEUVLN1CsuC+6I
	 h7D/2Y5h78ypT8tiTCSp9jEDJqyjbIv2xt+lhKFeTT1KjNZfxY3f/yp8PnDCVQXUHV
	 oxtEpJL0wbPwvqIVc2MKX1jLpV4VPM2aohkIJM9gnRqF10fquYSG4Muq3arG2SS4Ff
	 LsByjrCPvwHCYFMbMbC83KoQJ0OuA5TEjA4hwhBxS+KG/qRlmxixCmH1UzJ2lRn1Qf
	 0kiAXIxpFCfVFJdBxpO3o2Im7l4xEXXp+xUm96VZWSOkIEH03vUjnGLl29ajKhwcYY
	 SDR0lPjZIbZ9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C91114BD04;
	Sat, 21 Nov 2026 16:41:20 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Subject: [PATCH v8 0/7] perf script: Lazy symbol loading
Date: Sat, 21 Nov 2026 08:41:00 -0800
Message-Id: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQTWrDMBAF4KsErasyGv04yqr3KF1Y0qhRqe0gJ
 aYh+O6VU2iNwenywcz3hrmxQjlRYYfdjWUaU0lDX8P+acf8se3fiadQM0NAA1ZofqIcebl2bvj
 kHXVDvvJCfeDU+Ohb0XoZLKvbp0wxfd3l17efXC7ug/x55uaJYyrnun6vHsU893/LKDhwEaQ0Q
 CgiNC8XR/nZDx2bS0ZcMnabwcooq90+ArSh8StGLhh8cI2sjCRFKJWXRroVo34ZAYDbjKoMtNq
 ic6ilpRWjl8yDa/T8G6ODJ4cOlF0xZsHgfpsxlWnIghI6ggCxYpo/Rgi5zTSVCdYieQo22uWLp
 2n6BuoTuuh5AgAA
X-Change-ID: 20260915-perf-symbol-memory-send-e7cfca1ac3d9
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7285; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=AufCquRWD0D/RZkkRTuT2qBw5SuChZRJC1BPgkrcluo=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrAcmtPftC0Ww2lWDJW4rmYl0tq3O4P9sGhiRlk
 ZrWDoL21nOJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawHJrRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjHDxAAj2VRzK98j0vpKsb0P3S2XqcIQ8AumY0
 OWdY8SnzNRDlg9Lmf5dX2Co7c+2uo6masUA5Sln2pYruX1jhCd6jMmpNaocfQDT9T2yZMgnwFrJ
 hRoNHBMO04mVRCGf9+osEy1NBlwfaERIfJBmb5+X0/kqFQmT9wjxtPcldI0WMfGy2grGVOBttzG
 GW3zOp5wT4gbF80VkFI4pfx41/e+7ksHa4yZ9SLIyqpqpdvR7Rv/ekXfK90e423xOfRQ7bXTcwl
 WFpC99dJ7WEH8Yg2+8nucTobg5cX8HGGfFN6VI6216xE4ZS3D5TFoPXO+Q0zkILX/bNC3gbNYOO
 1hxalM76bP6mLpUzJl5oE6YRxnewhd2jPmNEMam/4q96EkVNodFtnO5T+35vZLv+DIDLz/2vxqe
 7U4uTFueXaTro0UMN4QO3HFOOk3E2H+22vbUTmKtxOZR8FAgz4LpxKC5At5S7Wiifrw/DpFZwhU
 j9mqQAa2RaiG64QUnbj8192ispuSM7Qwb9IjzH7I/zi1LMiOzisI9wIY9qXhB7V+Q+3SIM5drX1
 MBHcs9WeAan5KBAbrZ+F00EBfKEppi6rsErFFxA+FwbDem5xAtYqdsXzQJZ9CJY/tEu+/GVIBsC
 /4+ZcZZZ928bOMte3BZ92CVW05qyh+4Td17/OXoGtbaBRwyIRwFA=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com

perf script loads the entire ELF symbol table of every DSO that appears
in a sample, and keeps each symbol, with its demangled name, until
process exit. Most of those symbols are never sampled. On a large
profile this turns symbol loading into the main memory cost of perf
script, and in a memory-constrained cgroup into an OOM kill.

With this series, perf script --lazy-load-symbols reads a symbol name
only when a sample needs it. On a perf script run over a 45,073-sample
callchain profile of a large C++ service (about 1M symbols), the output
is identical in all three cases (medians of eleven runs):

                                      time    max RSS
  perf-tools-next                     3.70 s  319 MiB
  v8                                  3.75 s  327 MiB
  v8 --lazy-load-symbols              3.56 s  174 MiB

Eager loading remains the default, and costs 8 more bytes per symbol for
the name pointer. Lazy loading covers userspace ELF .symtab and .dynsym.
The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
eagerly.

The patches:

  [1/7] Split the size, type and binding checks out of
        choose_best_symbol(), so that the loader can tell which aliases
        need their names. No functional change. Unchanged from v7,
        reviewed by Ian.

  [2/7] Make the symbol name a pointer instead of a flexible array, so
        that a name can be set after the symbol is in the rb-tree.
        Unchanged from v7, reviewed by Ian.

  [3/7] Add lazy symbol names to the symbol code: the DSO lookups read
        the name of the symbol they return. Nothing creates such
        symbols yet.

  [4/7] Check that the symbol table file is still the one perf loaded
        before reading names from it. Nothing records a file yet.

  [5/7] Add --lazy-load-symbols, which makes the ELF loader create
        symbols with lazy names and record the file for the check.

  [6/7] Unit tests for lazy names and for the file check.

  [7/7] Shell tests, including parity with eager loading.

perf-tools-next now has the first three patches of Ian's series [1].
Its later patches replace the symbol rb-tree with an array, which would
shrink each symbol further. They conflict with this series, since the
name loading in 3/7 and the alias name loading in 5/7 walk that
rb-tree. This series does not depend on them, and I'll rebase on them
if they land first.

[1] https://lore.kernel.org/all/20261117185305.108003-1-irogers@google.com/

Changes in v8:

- Rebase onto current perf-tools-next, which has Ian's annotation and
  ELF loader changes.
- Split v7 3/4 for review (Namhyung): 3/7 adds lazy names to the symbol
  code, 4/7 adds the check of the symbol table file, and 5/7 adds the
  option and makes the ELF loader create lazy names. The tests are in
  6/7 (unit) and 7/7 (shell).
- 4/7: Also accept a file whose device, inode, size, mtime or ctime
  changed if it has the build ID of the DSO and its .strtab and .dynstr
  did not move, such as a copy of the same build (Namhyung). The
  identity is still checked first, since reading the build ID at each
  reopen more than doubles the time of the worst case.
- 4/7: Compare the ctime too, so a file copied over in place with its
  size and mtime kept (cp -p) is not taken for the same file. Treat a
  string table section that no longer exists or is compressed as
  another file.
- 4/7: Warn once when the file cannot be opened or checked, rather than
  only in debug output, and try again for later names, since the
  failure can be temporary.
- 5/7: Do not skip the .dynsym copies of lazy .symtab symbols. Skipping
  them changed the shape of the rb-tree, which broke lookups past a
  nested entry point and the PLT name of an exported IFUNC. This
  replaces the v7 fix for a zero-size symbol before a copy (Sashiko).
  Duplicate selection now reads the names of each copy, so on the
  profile above, where one binary exports most of its symbols, lazy
  loading keeps its memory saving but loses most of the run time it
  saved in v7. Most of that time goes to reading each name with its own
  pread(). As discussed with Namhyung, a later series will let the DSO
  data cache read the symbol table file, and names will be read through
  it. A prototype with a small read cache gets back about two thirds of
  the v7 speedup for about 1.5 MiB more RSS.
- 6/7: Add tests for a file overwritten in place, for a copy with the
  same build, with moved or missing string tables, and of another build,
  for a failed open, and for a copy whose build ID cannot be read.
- 7/7: Add parity cases for a zero-size symbol before a copy, nested
  entry points, and an exported IFUNC with aliases.

Previous versions:

v7: https://lore.kernel.org/all/20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com/
v6: https://lore.kernel.org/all/20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com/
v5: https://lore.kernel.org/all/20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com/
v4: https://lore.kernel.org/all/20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com/
v3: https://lore.kernel.org/all/20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com/
v2: https://lore.kernel.org/all/20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com/
v1: https://lore.kernel.org/all/20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com/

---
Alireza Haghdoost (7):
      perf symbols: Split out name-independent duplicate symbol selection
      perf symbols: Point to the symbol name instead of embedding it
      perf symbols: Add lazy symbol names
      perf symbols: Check the file before reading lazy symbol names
      perf script: Add --lazy-load-symbols to load symbol names lazily
      perf test: Add lazy symbol loading unit tests
      perf test: Add lazy symbol loading shell tests

 tools/perf/Documentation/perf-script.txt           |  11 +
 tools/perf/builtin-script.c                        |   2 +
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/lazy_load_symbols_parity.sh | 447 ++++++++++
 tools/perf/tests/shell/lib/lazy_names.sh           |  20 +
 tools/perf/tests/shell/script_lazy_load_symbols.sh | 190 ++++
 tools/perf/tests/symbol-lazy.c                     | 963 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/stdio/hist.c                         |   1 +
 tools/perf/util/dso.c                              |   2 +-
 tools/perf/util/dso.h                              |  36 +-
 tools/perf/util/symbol-elf.c                       | 355 +++++++-
 tools/perf/util/symbol-minimal.c                   |   6 +
 tools/perf/util/symbol.c                           | 141 ++-
 tools/perf/util/symbol.h                           |  31 +-
 tools/perf/util/symbol_conf.h                      |   1 +
 18 files changed, 2183 insertions(+), 28 deletions(-)
---
base-commit: bb27ddbaee56536fb8df0a24f07b526766dfe131
change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9

Best regards,
--  
Alireza Haghdoost <haghdoost@uber.com>


