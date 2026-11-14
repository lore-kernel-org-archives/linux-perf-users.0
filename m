Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794633000;
	b=BZ3JyTLK+T08RRkqJlEFkRo8EKqFX07m+LrlerJW8m6poC58pVmA01IP91DumO6tAVQo
	 TffnWc5rrX4pKb1//uWBbEPo/2PVyR1I6HwDl/N8Yp71lw4p0Zl76nc67YPCsnigIJdCV
	 UDo9RhLUg19AUBWY7MXrOzhI682x6D1YV4SS9p6IhlgAr3B6mA+jwycuHzexx42jwrWp0
	 N3SqbKgkn7qtLHQ9/AJpDXTXZfR89jRtaFilVyZEKfRLgCYj+C+BfSX6Z0kEvrc36XzoW
	 AWkqqaBW+RVhxIq5xq/bMWFvKNkEe0tQ53HU4Izdm7SgNMrVcSoWZ8efF+oBqxgu7Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633000;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vmWSlG3T6Gjv/qXwty2XuH3eZy9oFt/Pmz6ZT32ZI4E=;
	b=ol1y/wY5bJYCA7zTsrSI62rA0m/KnRqwkmobItFEXiWsZSIuQTwqsittyN/fBMyO2wxd
	 cCr/P65CiFZLMSKWz/S4alro7qbHdHtUxhtb8daNONhf1FVOTP2b/4fDkawNGYn4Ievcq
	 aNr2z9fM0InwQGP4FT7uWk8VSsNN8S+RSUbcvD933TFnx/88AKEzNrvQDxd0ZcWgstykf
	 kCuD0zxM7DLiuW5qy5vnorJH8LqFtGci+kH2hj3BMkQzI55t1lpKfpVxyKJOUUZPz94Z9
	 2V04CtINx5LgPBNOgNBAPQL4qDxj/weYntnMLcT/cd9rXg/KoD/LIbEk1kiN4QV1GxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TapAidR1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947D606A8BE;
	Sat, 14 Nov 2026 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TapAidR1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794633000;
	b=pD887HNKto93oupWlQ88Ok50q00ANMGaguaIn+9nGemZLwfPaC16GEkztXKdfvcqjVmb
	 X1mZ+hItpT0uIIwSGnmXdipuPqrlGQ+TLq/zeHHCJelTqxoFspLvYl4bGayOA1171HZEF
	 MZ7FIus0fDWJE+3Hydghj9xZ13PUOMZrEO6ptPwg0QSwbyrpKaZkrBzxwcbI7WSyo+x9s
	 LlW2kziCyCcjyo+Ek2ydHeOqAXFOLvnahuATiV4U9uRTrIMRrYwbwXPnN4Fm2dKsMkYCn
	 aBifhWjyVuP7N11EAp/4ZySGMi48CuVy+S7yh9XrTcGV6dMjsIUSkF4+AAnWty0lWzg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794633000;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vmWSlG3T6Gjv/qXwty2XuH3eZy9oFt/Pmz6ZT32ZI4E=;
	b=LtnqRAmL4ct65wHt5UAF/cZELEIGxbo3Mdlvi0G4nJdD9X4j2w1EbIlDHPlYNajDZ2ks
	 Du7NX4JHgxeUyLi2pmXYmoaeg2dqWtyDOS9xTrkZ2ADCfgL6i+5Zc9NGpWOw+NBsmaum1
	 rhwGTBaEbmp/HrGuccnI+R09XydQ+l9L0Q/5FUsBEpClkcvYEmpNd/Jj56nt9R8lQSgjk
	 lAlF+ap0iWU/dVmpgbJWBC/1N56hbV3gF9CbuIgyxjlFb/VKq0InBF7qmh4x42ayPNrlp
	 bTOc4S6XaS7qP3TChmJUM/9cKxmgxi/OBRBywsUd2ou0OehKmfWxfEOCXNs13L0ugJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D58B1F000C5;
	Sat, 14 Nov 2026 05:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633000;
	bh=vmWSlG3T6Gjv/qXwty2XuH3eZy9oFt/Pmz6ZT32ZI4E=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=TapAidR1P1dXkPE8M5FgktQdyHbol/CKXNIiZVcwNtSOem8m1jK0YIR6zADNizyJH
	 Stu+utNqs3MPxdSvYFDMk9ANrE+MtoNuraIXvim7YpMlwK3S40+rIZv7tmfBcx/r0L
	 qsJgcpeTxj3H1/wmweuRGUICelKkWtVj8i3v5hpM86wdTiP1H4cGOdbdMvCQJ0frd6
	 doYruJC8gvkmY5F4FC8aYbOmFLCgtZLzq8gQ0qvuRyenLAoILr4yL8/lKcSxv+pygx
	 Oy24Bd1aOuzTOvr9/MrhEeIT4HK/sCvmurIccsbA86W9vYxDSR0xyMg04mKNpdAFGi
	 CXHtYAN6IbKXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6180E49CA2;
	Sat, 14 Nov 2026 05:09:58 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Subject: [PATCH v7 0/4] perf script: Lazy symbol loading
Date: Fri, 13 Nov 2026 21:09:05 -0800
Message-Id: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQTWrDMBAF4KsErasyGv046qr3KF1Y0qhRqe0gJ
 SYh+O6RUyjG4HT5YOZ7w9xYoZyosLfdjWUaU0lDX0PzsmP+0PZfxFOomSGgASs0P1KOvFw7N/z
 wjrohX3mhPnBqfPStaL0MltXtY6aYLg/54/M3l7P7Jn+auXnikMqprj+qRzHP/d8yCg5cBCkNE
 IoIzfvZUX71Q8fmkhGXjN1msDLKarePAG1o/IqRCwafXCMrI0kRSuWlkW7FqD9GAOA2oyoDrbb
 oHGppacXoJfPkGj3/xujgyaEDZVeMWTC432ZMZRqyoISOIEAsmGma7ktvRRsyAgAA
X-Change-ID: 20260915-perf-symbol-memory-send-e7cfca1ac3d9
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5471; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=bNNSbm6xwr2UqnFKuseW/pVuQUw737DtM/ehJlv2AjE=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq9+0j+RjBe3ySIX53a2BOZU5tuU6o0PEqWBZoJ
 gpdJ+crwoOJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCavftIxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtipjg//WX6P1UXk4VAjmiOYr5UVEXwsZyBnt6v
 lmcfjmgsm4PhcFw79UMYsXpcKodTgTQD+oeqmU/8tSte27ap7aBJejMHEnXTN9AftlKUWIm03G7
 b40xnQu5uEr+bPG7psfqMzJOpeCFV7ayrLsu5WsNhC9opRWcMNcCpF1Fs5ifA8PA09LnMTRs5i4
 we2ZyOIDODadhvctsVB6sgE48t9cPGyr97zt7aYG9P5Kog+jfvAv0duRV6b2ki85oaZSlmJ7iv2
 QNW0qRVaF5f/5b1uqHfpV947wn6F9N36LFAHxYy/vnEffjTJ9ydVU8+Qq723gJH+PvTk/wYU4Wm
 HFGUl48bMY1pc08sziTy80TNxu0BdnbLrCxNWod5D3BlgfIWJYuK3LCroJz9cfGvFXXLiQTkxFN
 RvNQSTDKB2/JA/+ekaRkYy9U4vngFZAJ6XaPFOyNN5ALUrdYZPcfPI2WrlCJ3AHtoLijApPtkmx
 9DFNheLVRuZQTD9y7h9Uz/bH0A5s2KJnRww3YGYhGhKSKM3+YzAJgD/2pkVJAjwhbVSmzkfUSQP
 7eruY8c7geVoVQ9ZtF0rsqGQ3yslZl+n0PQi1OXgrpZCGhcw9m9J5IwMRiOQPCUv5TwSdVX3uaE
 EtYgPj8F/32mO4I2i+g9JpHA5yqogRw5gLVi25J9jddr4p7Mupy8=
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

This series adds an opt-in lazy loader for userspace ELF DSOs, after two
preparatory patches:

  [1/4] Split the size, type and binding checks out of
        choose_best_symbol(), so that the loader can tell which aliases
        need their names. No functional change.

  [2/4] Make the symbol name a pointer instead of a flexible array, so
        that a name can be set after the symbol is in the rb-tree.

  [3/4] Add --lazy-load-symbols to load symbol names lazily.

  [4/4] Unit and shell tests.

On a perf script run over a 45,073-sample callchain profile of a large
C++ service (about 1M symbols), the output is identical in all three
cases (medians of seven runs):

                                      time    max RSS
  perf-tools-next                     2.9 s   320 MiB
  v7                                  2.9 s   327 MiB
  v7 --lazy-load-symbols              1.3 s   135 MiB

Eager loading remains the default, and costs 8 more bytes per symbol for
the name pointer. Lazy loading covers userspace ELF .symtab and .dynsym.
The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
eagerly.

Ian's series [1], which removes the priv area and replaces the rb-tree
with an array, would shrink each symbol further. The two series conflict:
both use bit 14 of the symbol flags, and the alias name loading and the
.dynsym copy check in 3/4 walk the rb-tree that [1] replaces. This series
does not depend on it, and I'll rebase on it if it lands first.

[1] https://lore.kernel.org/all/20261113171734.2188066-1-irogers@google.com/

Changes in v7:

- Drop v6 1/5, now in perf-tools-next as 794579ff4959 ("perf symbols:
  Fix broken ELF_C_READ_MMAP fallback guard").
- Rebase onto current perf-tools-next. Since baef30dd8308 ("perf
  symbol-elf: Fix zero-size symbol end calculation across .symtab and
  .dynsym") moved duplicate selection to dso__load_sym(), 3/4 loads the
  alias and IFUNC names there, once after all symbol tables.
- 3/4: Check that the symbol table file is still the one that was
  loaded (device, inode, size, mtime) before reading names from it.
  If a binary is replaced during the run, perf warns once and shows
  "[unknown]" instead of names from the new file.
- 3/4: Load names under the DSO lock instead of a global mutex (Ian,
  Namhyung).
- 3/4: Rename symbol__has_lazy_name() to symbol__needs_lazy_name()
  (Namhyung).
- 3/4: Lazy loading stays opt-in for now; see the reply on v6 4/5.
- 4/4: Add a test for a replaced symbol table file.
- 4/4: Skip instead of failing when names load eagerly (.opd,
  .gnu_debugdata, compressed .strtab), check that test_loop resolved
  before requiring lazy names, skip a kernel DSO given with --dso, and
  include <elf.h>, <stdbool.h> and <stdio.h> (Sashiko).
- Reword the changelogs and trim some comments in 3/4.

Previous versions:

v6: https://lore.kernel.org/all/20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com/
v5: https://lore.kernel.org/all/20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com/
v4: https://lore.kernel.org/all/20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com/
v3: https://lore.kernel.org/all/20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com/
v2: https://lore.kernel.org/all/20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com/
v1: https://lore.kernel.org/all/20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com/

---
Alireza Haghdoost (4):
      perf symbols: Split out name-independent duplicate symbol selection
      perf symbols: Point to the symbol name instead of embedding it
      perf script: Add --lazy-load-symbols to load symbol names lazily
      perf test: Test lazy symbol name loading

 tools/perf/Documentation/perf-script.txt           |   9 +
 tools/perf/builtin-script.c                        |   2 +
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/lazy_load_symbols_parity.sh | 293 ++++++++++
 tools/perf/tests/shell/lib/lazy_names.sh           |  19 +
 tools/perf/tests/shell/script_lazy_load_symbols.sh | 191 +++++++
 tools/perf/tests/symbol-lazy.c                     | 606 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/stdio/hist.c                         |   1 +
 tools/perf/util/dso.c                              |   2 +-
 tools/perf/util/dso.h                              |  20 +-
 tools/perf/util/symbol-elf.c                       | 299 +++++++++-
 tools/perf/util/symbol-minimal.c                   |   6 +
 tools/perf/util/symbol.c                           | 141 ++++-
 tools/perf/util/symbol.h                           |  29 +-
 tools/perf/util/symbol_conf.h                      |   1 +
 18 files changed, 1599 insertions(+), 25 deletions(-)
---
base-commit: a1c3b14c28ebfa79dd56e2743c2fbad0c02a7146
change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9

Best regards,
--  
Alireza Haghdoost <haghdoost@uber.com>


