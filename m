Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548557;
	b=Kr3DGyzhcVPnImQjb89lf4xHmth85W29rn0SiwFYHGTk+C3xd6VCENfRsBlfFw3kuqUY
	 lP2W86xB2kNYJAIVMJW5YnkdMago6nxj9eEPQhdLDqVPMNPqz/9mhacK2Ksb0VOjHlayK
	 qrUvbF06igAK2jg8i9yRvG28EjkrLdQFC9LRlTV1JziaHec42sBb78vP3AtqYYNN6RdtT
	 FPn15/D3mRSG4Dy9qyq5+EG9sHDKBcfSlZcBrifSlRvm0PUHl1TrE1zX0PM8mc2C6gCpq
	 4UbZQYaoGSE30JiAwsSUBgDgeInKgYfT4M5Z330kgQeezOEeg34MBJDk8cYN+LMO7Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548557;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=OfVEhGf8cUzONtsRWTLPLkoJktKSKEvKxG0RWHBW0PM=;
	b=cwx2OtzAEEBG0V0wCUbxE+TH1hROeq6bT1KvV55/rg6DvueXGUmkNXOcAV19BPRGTMwA
	 VOzc1759LWHyYN1+/oK+8Ybs6QYU2u6u3C3CnAiJKvA3V6ct03ezumrvR/PN9H98vdK4a
	 mZcpodLYbr1cu5DO3mczfb6LeIp6Q/DZ3rGqnyhH66SHu+GbuXiQSv1Vc4EY480C6ChEb
	 vF1w8UbkSBmHyIqd9mXNRXptz67ndAsZjvDRO4OS43poz+bsTLiHv8IR1KsmMYNPdvyJm
	 rQilOhpmT9KiikXFslfFq/tpw0YQCHsEHjyMJqh81/zFZpILZtO/GvLBpYQHDiYvFAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO5Ra2l2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA4606A31E;
	Tue, 24 Nov 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO5Ra2l2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795548556;
	b=mLZkiGm6jb7ajd05zS22jQ9BDUnpjjEKmzNV1/Duz+bc9RpdU1LW1lsNi6D5NfonnNlY
	 j8zdWlgDksLMV1CelYlnRc4N6K2MqNiOSZWqv8rEkYtr3Pvg7GIQnPPjUZxnwkELMkxa+
	 X+R4Ni9ukEh3w33jqC+5CPgjh+S1zB5p9hR0u6H2LNW2ZDVKWICTMAXDiNh2rdtHYmILp
	 WN6+nZeUz/yZunzrk3GRubON6/nIbebSZwk+4FEf+E94W/sXhZXmcXzDq09knrNAYpzV5
	 nDcZDHoYv4E6V0Pe0bN3DKBlilBF99RQRhtYgBxVv2ZepLU/oUgkGDokB944ipi1+Pw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795548556;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=OfVEhGf8cUzONtsRWTLPLkoJktKSKEvKxG0RWHBW0PM=;
	b=i/VmvcIrqg1+bICePFvX7iESdfaJGXXf7pSSqVRBVA83NpVopRdoahnakQCkhGdC7k67
	 rIBFpzE9gWK60bNoACkZT+xg6SrZXi7gTjSMGf1zbRKI0DqKNiybcl2lbV8o1qnctBTqo
	 oh28T8953PgORJQyM7ENG86fLH1980ItC99Kv+DGaANhMyvMJm+aGsKKqufoN/nd+PcCj
	 dadx2fdTtMnPLwl8F1ke3zFExLQslKNYe5lRVeiD0zgSYlJU+CGMtJlCbiRryLOi6K6rR
	 R44KO86OedukE4+HdlFxzGu5gN2GliaH7sHy6b1D2w1XEG+KtW4+Er3m4GnpW6SxuSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 36CCC1F000D4;
	Tue, 24 Nov 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795548556;
	bh=OfVEhGf8cUzONtsRWTLPLkoJktKSKEvKxG0RWHBW0PM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=SO5Ra2l2hic5Tazab3Z1M2wO2dtA5X29z32Le4OA6s2Sji5m57JRNQc4K5mqhQcWf
	 /C2Z2+tEHsPQ9m2Jk7RZp/6sdij8dFPyLRoltWo38CjPPqOILbchlrVHGjSTcnZ9Pc
	 s/I+mTA0EHI7pHmfBVxOnrZkbLKy2M+6wL7otdWY0d9kzTnIbYEX82HHI39qsdxHjF
	 oodXXafLyVBsjyNqu+9HQ7EoG6TkXGBzA+9ddez1RXFmLdwiljK42xT5yoJRENevK3
	 7J4Rl7sYvOlUVF6OkjRWnhMPO9+udqjw2T+9jWOkl/N7EWjQqErZ8C/aRUUQfQbjdT
	 Es2LNXjRdWIcg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BBA9E4CB65;
	Tue, 24 Nov 2026 19:29:11 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Subject: [PATCH v9 0/7] perf script: Lazy symbol loading
Date: Tue, 24 Nov 2026 11:28:23 -0800
Message-Id: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRzWrDMAwH8FcZPs9Dkr/infYeY4fYlteMpSlxG
 1ZK331OB1sIpDv+QfpJSBdReOy4iOeHixh56ko37Gvwjw8i7tr9O8su1SwIyIJHIw88ZlnOfRg
 +Zc/9MJ5l4X2S7GKOLbZRJS9q92Hk3H3d5Ne3n1xO4YPjcebmil1XjrX9NnrCue7/KRNKkJiUs
 sCEGdzLKfD4FIdezEMmWjJ+m6HKaG9CkwHa5OKKUQuG7myjKqNYMykdlVVhxehfBgFom9GVgdZ
 4CoGM8rxizJK5s42Zb2NNihwogPYrxi4YarYZWxnHHjSaDAi4Ytwfg6i2GVeZ5D1x5OSzX5+4W
 TCE20wzn9iBsRhDMO3y4dfr9RuNNv1jwAIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6612; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=s+QfDEgIZpS1721SLh5KYfvgNU4Z4Zw7nKKmCLuvJdM=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrBeWElrd09TUg2V3YNsy+4aOhl7zK+LyvIdphU
 zZmQ/dulhGJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawXlhBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjYUA//aS+y55JeEFDWaeEcD3ZN10PaC7srZNd
 0FX95UelJwgNx9ST2chrAvm0g71Gz1t/UhVZMdWpEBwVty8RwxTBAbawx2sz+FICzMmJjic7aDC
 m/ruAy7G8/hBg0xKsDDVYKr7IUf/HLYIfaMrDOzbAp2ms7QoScvIzXbBzgMF0sy2da0eYbXos7+
 4CgSjGvnIrLXsZmJmv1Gmp2dSILwtYETeegE3vG+Gmc/Y1AoVaSEWjkRHtEmSiz+E20II5J13K5
 /oTu7uqqYm4vi3M7EsZgwQm+JETy6mZWPRifS8yZyml4VkJJaXREea9w7Z2Ao5nHMNOCU1q6epS
 f/iubrDDC+PU9EotqUhyHkWx6/E3EOdKJ2TqXK5DuMaBVh0x49AcLdY7K42lJreX76jcyCK+go/
 rfgvwvijg58ovd68xuX9PgJMw5kfkrPsUTIpMvAMf+w9QrcHQZ8HbfoqelFsdGdGjxoprsIjOy2
 +NJBkLSEe0kRcle2Rp6KvFrdAOr2SBpuyKBNbz+UcMN+LwvoIHSzJNf+Lef5F3oZkH8yZTKLjk0
 6lPo7zXl0quzcPg41YW4L9dUULYsFqbthsJGCcChvkKwTeLD9Ov82Gtv5s7zAC41CPRs1TgajHP
 XALPAsad8lu/QxfGe3KNHXSxsQCLJ/tb/dQ8Y2bULvDuO9CRyuz4=
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

With this series, perf script, perf report and perf top
--lazy-load-symbols read a symbol name only when a sample needs it. On a
perf script run over a 45,073-sample callchain profile of a large C++
service (about 1M symbols), the output is identical in all three cases
(medians of eleven runs):

                                      time    max RSS
  perf-tools-next                     2.24 s  305 MiB
  v9                                  2.26 s  315 MiB
  v9 --lazy-load-symbols              1.97 s  164 MiB

Eager loading remains the default, and costs 8 more bytes per symbol for
the name pointer. Lazy loading covers userspace ELF .symtab and .dynsym.
The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
eagerly. Names are read from the file that perf loaded the symbols
from, so the output is the same as with eager loading as long as the
binaries do not change while perf runs.

The patches:

  [1/7] Split the size, type and binding checks out of
        choose_best_symbol(), so that the loader can tell which aliases
        need their names. No functional change. Unchanged from v8,
        reviewed by Ian.

  [2/7] Make the symbol name a pointer instead of a flexible array, so
        that a name can be set after the symbol is in the symbol array.
        Reviewed by Ian; only the commit message changed.

  [3/7] Add lazy symbol names to the symbol code: the DSO address
        lookups read the name of the symbol they return, and walks and
        lookups by name read all names of the DSO first. Nothing
        creates such symbols yet.

  [4/7] Add --lazy-load-symbols to perf script, which makes the ELF
        loader create symbols with lazy names.

  [5/7] Add --lazy-load-symbols to perf report and perf top.

  [6/7] Unit tests.

  [7/7] Shell tests, including parity with eager loading for perf
        script and perf report.

This series is rebased onto the first six patches of Ian's v8 [1], now
in perf-tools-next. Ian's v9 [2] applies on top of it with one trivial
conflict in struct dso, and the symbol and lazy loading tests pass on
the combination. I'll rebase if his patches land first.

[1] https://lore.kernel.org/linux-perf-users/20261122050405.80335-1-irogers@google.com/
[2] https://lore.kernel.org/linux-perf-users/20261124032902.3859564-1-irogers@google.com/

Changes in v9:

- Rebase onto current perf-tools-next, which has Ian's symbol array and
  the fix that keeps cached debuginfo in perf's mount namespace. 3/7
  now tracks per DSO whether all its names are loaded, since a DSO
  sorted by name can still have lazy names.
- Drop v8 4/7, the check of the symbol table file, and its tests
  (Namhyung). The man pages say that the output equals eager loading as
  long as the binaries do not change while perf runs.
- 4/7 (was 5/7): drop the kmodule check, use pr_debug2(), and add
  parentheses around multi-line expressions (Namhyung).
- 4/7: create lazy names only for a symbol table file that perf can
  reopen by the same name in its own mount namespace, since perf top's
  sample thread cannot switch namespaces.
- New 5/7: --lazy-load-symbols for perf report and perf top (Namhyung).
- 6/7: drop the file check tests.
- 7/7: rename script_lazy_load_symbols.sh to lazy_load_symbols.sh, and
  add perf report parity and a case for a process in another mount
  namespace.

Previous versions:

v8: https://lore.kernel.org/all/20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com/
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
      perf script: Add --lazy-load-symbols to load symbol names lazily
      perf report/top: Add --lazy-load-symbols
      perf test: Add lazy symbol loading unit tests
      perf test: Add lazy symbol loading shell tests

 tools/perf/Documentation/perf-report.txt           |   9 +
 tools/perf/Documentation/perf-script.txt           |   9 +
 tools/perf/Documentation/perf-top.txt              |  10 +
 tools/perf/builtin-report.c                        |   2 +
 tools/perf/builtin-script.c                        |   2 +
 tools/perf/builtin-top.c                           |   2 +
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/lazy_load_symbols.sh        | 243 ++++++++
 tools/perf/tests/shell/lazy_load_symbols_parity.sh | 462 +++++++++++++++
 tools/perf/tests/shell/lib/lazy_names.sh           |  20 +
 tools/perf/tests/symbol-lazy.c                     | 647 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/stdio/hist.c                         |   1 +
 tools/perf/util/dso.h                              |  28 +-
 tools/perf/util/symbol-elf.c                       | 218 ++++++-
 tools/perf/util/symbol-minimal.c                   |   6 +
 tools/perf/util/symbol.c                           | 138 ++++-
 tools/perf/util/symbol.h                           |  29 +-
 tools/perf/util/symbol_conf.h                      |   1 +
 tools/perf/util/symsrc.h                           |   2 +
 22 files changed, 1804 insertions(+), 30 deletions(-)
---
base-commit: 964e8b1c9c795982886a6778cb0cd73c901ca4ca
change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9

Best regards,
--  
Alireza Haghdoost <haghdoost@uber.com>


