Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793230970;
	b=kB0cdm2PPWNzRfPtFkIEg6W+4lpJsl56YF2gkbZQet2Abx+/mU60UGalfkSvu2zus++J
	 Ur+CawAls/N+elMoygVq1Frx0X3tncZAo7UdGVUyN7/UFbQsoeD/nSrMNdtgsl8IIhG2p
	 09d7Uqe3Ht7NU8UhGsvGFBBDTos94AT9S5WeaF9wvGD9ibDkMZe2gvrd7tCWz1qtLbp7H
	 y5OaXB/uPaOP60RnWp5ys9vdPiKX4t9CJ/hDVeGs4qmfp089zBbqQl1pPZr8HbAgW9cHd
	 J9dBteJnmA7cEtlOO9VSr0flFRsAFnGIKP0ONK2G+B31kgNcXyOXW8ItepJFCFW6lpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230970;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ECZz0r+RTXv9bOuCAGgaq/PzW5nzGtLjy2x20XBo0ng=;
	b=i35cg6FtIO6lIvNtTFnSxHDsDSS6pRB71Y2wPLrQ+9OqLMI6gDkHRMrSc+l5erU0OoCF
	 M4UgEbgnOPyMOsPUJcncpb7SRfTdlt4Itfm69+y1o+A3m1sheu2MD5hZTMxIELxM8xZvE
	 iUv8lAEo07NfLrmGJK13rYH9gJwlGtZhFC7QCs2C0x1WYG3n4UTI1vpWnS47xi9859cTP
	 3t9oDCZaVhUmAvPKBk974Hlp3aeKFFM0aWkfGgwg1Jm/QInSikFo3Ay4so8UAJDZlV+EL
	 ULilvUagZA6F2UUHmM0CeOB7YgCBZXobDF1kpR05w4FRBlDB3fbh3zgB8VJBC6YOIqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvERsC52;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653F606A31C;
	Wed, 28 Oct 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvERsC52
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793230970;
	b=f7IMFjhzRzaeSHzLugXVpUxBCgENzLG36kKC4JL5fST7tAXTQRaMJd76pp0L04xZUfIn
	 wxzOR9XYwCj4B1WqV4lbf/lKeUybvWkxcW9cYQUuN+R3ShvUMlY68HwHwCYkgMC+Ut/1h
	 12tCJ0dzlMW8WISbmb0rWBb48IUNAKkOoy8nZ/2xZKGajcBkZD/2r6xXP1WRtrfM6+RqJ
	 xXqlRmVtRfSAlogzyDvgyk4MOUwbmIGe8GrFa9Goi90kETtNBfFLPXqpXh3mTcG3s3vfJ
	 J2IxYfzNTHr0qqsM/eWAAaKBdKMYkI5eJzbVxtSfyAdqXtL9Y1XixGcdz9aTZ3KIkzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793230970;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ECZz0r+RTXv9bOuCAGgaq/PzW5nzGtLjy2x20XBo0ng=;
	b=wif5oobg0L1FUuBV8d3RzmCePVDE1guhU5AepV6g9jJx3wTHHp8j9Ci7+fV19e4W0uxT
	 CNCvwkaEfwU+tWJRcfhsq/UHG516sQf5vqZFi+Mn8khr4PkKMdwpouSf/Nj7ImllovUUt
	 tcS/P1lN+V5sEqL4m6H45CIKx72vJVagLyn5d2ReFRxOgnIsq5R5pFpRQz1UodUG3V9TF
	 v/U/8WyAVhN/sV9fV4hDy8xQKCLMSpi1MWhW8PE6egCGdjLnKWG+eY25mntC8isV4R/gO
	 oKw+j0kZklD079KjN43VS2XpAfHuxdjEuSvvpkSMuqzrGMghUXL+HRfxt/cMkhHzHmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 23E971F031E0;
	Wed, 28 Oct 2026 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230970;
	bh=ECZz0r+RTXv9bOuCAGgaq/PzW5nzGtLjy2x20XBo0ng=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=cvERsC52myc/weFGChKPYPqIZ/RMbxuZHUXkEPSoRyySQIAXRnj8/cbPstA7D98Sw
	 yX8Qve7HX/WAXg/6rICFY8U/QJfC51Vc3WeqoojT90kqYNSDtbvE3uooQCuRhCIfGp
	 WNNwbVDnpAx/LZNclEubIMYbCLdXZ0oTryt7MkLjAuflpos4ThgRA0JbMs9kpD3J2l
	 azqhSDk090k4y+iDmcS/ycWRkJ6MQLC0itEq+8l6/Vcxjz2c2G6D9ZM0yA+09pU9VP
	 pV0Qh1xRdO56EJvwDWdJ7vswiu8oxi3gfXJojQK5858umJrge7lBSgReCwj5ddxAXG
	 0S04aU6DL7KTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E8C845623;
	Wed, 28 Oct 2026 23:42:48 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Subject: [PATCH v6 0/5] perf script: Lazy symbol loading
Date: Wed, 28 Oct 2026 16:42:31 -0700
Message-Id: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQy2rDMBAF0F8JWldlNHq4yqr/UbrQY9yo1HaQE
 tMQ/O+VUijGkHR5YebcYa6sUE5U2H53ZZnmVNI01mCediwc3PhBPMWaGQIasELzI+Wel8vgpy8
 +0DDlCy80Rk5d6IMTLshoWd0+ZurT901+e//N5ew/KZwa1yYOqZzq+q16Fm3u/5ZZcOAiSmmAU
 PTQvZ495ecwDayVzLhm7H0GK6Os9i89gItd2DByxeCDa2RlJClCqYI00m8Y9ccIALzPqMqA0xa
 9Ry0tbRi9Zh5co9tvjI6BPHpQdsUsy/IDQQ3JFusBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5717; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=I7N5Bf76g9ySc8B9hPxsvNQM5HTuObGIpMG8qtSCIQs=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq4oh218Zng+HW1pW3buKMJJD5qD4KnJyTfSmEA
 sdOu458+9GJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCauKIdhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAthy7g/+MCxAMZWJXt65QlGMj4OWSnS+bd1niWD
 Z8fm35UghymiP+MefBW+cArgFGd3AZ8YXXtFfo51HHK3ERv9CIdT2LC4MQpKhTWNjnvkVF80Z0l
 qQ9yAGsa3yxCDk0fOfKayw5BC86NDzwWB14sAOeMp8k0V8RAEAm1URHINmsLZeYXBJY3DIeYmoA
 F7x1vLtfuSiW/w8SgkanA3AKpvv8d0Z8ilrquW3yzaTPWV63MJdOOoCH/6nF0s/w/T02SHkWrtC
 cGBs0DaM54C4dWgurwhwobmmIi/RA1wPxBox2CSmFTG3MAqVlwZCV+d5XmQWNu5k9Fce8XSw2XB
 1IVcxlGIEVrmjTeNevvDqPOQ58bxhyWTpvCDPVAtFGNpyAHq6YAVAiZoWtJfGS3WePfi4YuUDKa
 GS9BZtSHF2mLNGz3SLR8jcUm4n04eIWvvLxtzA6jQEa1xOid/C6l6kogXI76qim64mK6UVhbGEd
 b04r5599WuHqu4Qld05fTVHpPYPZ6Pl4LABm6HMwBg09bj5koPjT7JrPRvo1XmSOu4bjITpUCyP
 EySq5vqGkJe4fajvZ4CqNvZIByi8d3YrZ+EQDTjvjPqibvDoDVRZ3kq1FCyOYypW3j0rWZAzE2A
 PKdQalE1pHeqSoQ5vX67kk2Iu7q0kSdpEDG7wOKwqnsURTY31eMM=
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

This series adds an opt-in lazy loader for userspace ELF DSOs, after a
regression fix and two preparatory patches:

  [1/5] Fix a broken "#ifdef ELF_C_READ_MMAP" guard so perf actually
        mmaps ELF files instead of malloc'ing section data. This is a
        standalone regression fix for 22dd1ac91a77, which Ian's series
        [1] also depends on.

  [2/5] Split the size, type and binding checks out of
        choose_best_symbol(), so that the loader can tell which aliases
        need their names. No functional change.

  [3/5] Make the symbol name a pointer instead of a flexible array, so
        that a name can be set after the symbol is in the rb-tree.

  [4/5] Add --lazy-load-symbols to load symbol names lazily.

  [5/5] Unit and shell tests.

On a perf script run over a 45,073-sample callchain profile of a large
C++ service (about 1M symbols), the output is identical in all four
cases (medians of five runs):

                                      time    max RSS
  perf-tools-next                     3.3 s   334 MiB
  v6                                  3.2 s   341 MiB
  v6 --lazy-load-symbols              1.5 s   154 MiB
  v5 --lazy-load-symbols              1.4 s   136 MiB

Eager loading remains the default, and costs 8 more bytes per symbol for
the name pointer. Lazy loading covers userspace ELF .symtab and .dynsym.
The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
eagerly.

Ian's series [1], which removes the priv area and replaces the rb-tree
with an array, would shrink each symbol further. This series does not
depend on it, and I'll rebase on it if it lands first.

[1] https://lore.kernel.org/all/20261027231513.816148-1-irogers@google.com/

Changes in v6:

- Keep the symbols in struct symbol and load only their names lazily,
  instead of v5's separate per-DSO index (Namhyung).
- Drop v5 2/5 ("perf dso: Allow reading DSO data from an explicit
  file"). Names are read with pread() from the symbol-table file that
  dso__get_filename() returns. The file remains open only while perf
  reads the names. This path does not use the data cache (Namhyung).
- Replace v5 3/5 ("perf symbols: Factor out duplicate symbol
  selection") with 2/5, which only splits out the name-independent
  checks. struct symbol_candidate is gone, and choose_best_symbol()
  still takes struct symbol (Ian's v4 question).
- New 3/5: point to the symbol name instead of embedding it.
- 4/5: rewritten for the new design.
- 5/5: replace the index tests (truncated names, lazy address and name
  lookup, nested range lookup, address lookups racing name lookups,
  lookups racing DSO data reads) with tests of long and unreadable lazy
  names and of names loaded concurrently. The duplicate selection test
  now checks which pairs need names. The eager/lazy parity unit test,
  the parity shell test and the perf script shell test stay. The parity
  shell test drops its nested symbol case, since both modes now share
  the same address lookup. The perf script shell test compares the
  whole output, and reports a skip only if none of its cases can run.
- Rebase onto current perf-tools-next.

Previous versions:

v5: https://lore.kernel.org/all/20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com/
v4: https://lore.kernel.org/all/20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com/
v3: https://lore.kernel.org/all/20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com/
v2: https://lore.kernel.org/all/20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com/
v1: https://lore.kernel.org/all/20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com/

---
Alireza Haghdoost (5):
      perf symbols: Fix broken ELF_C_READ_MMAP fallback guard
      perf symbols: Split out name-independent duplicate symbol selection
      perf symbols: Point to the symbol name instead of embedding it
      perf script: Add --lazy-load-symbols to load symbol names lazily
      perf test: Test lazy symbol name loading

 tools/perf/Documentation/perf-script.txt           |   7 +
 tools/perf/builtin-script.c                        |   2 +
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/lazy_load_symbols_parity.sh | 284 +++++++++++
 tools/perf/tests/shell/script_lazy_load_symbols.sh | 177 +++++++
 tools/perf/tests/symbol-lazy.c                     | 544 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/stdio/hist.c                         |   1 +
 tools/perf/util/dso.c                              |   2 +-
 tools/perf/util/dso.h                              |   3 +-
 tools/perf/util/symbol-elf.c                       | 251 +++++++++-
 tools/perf/util/symbol-minimal.c                   |   6 +
 tools/perf/util/symbol.c                           | 140 +++++-
 tools/perf/util/symbol.h                           |  40 +-
 tools/perf/util/symbol_conf.h                      |   1 +
 17 files changed, 1429 insertions(+), 34 deletions(-)
---
base-commit: e74880764bf94b738102b4b6b6e8304d0c8375d3
change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9

Best regards,
--  
Alireza Haghdoost <haghdoost@uber.com>


