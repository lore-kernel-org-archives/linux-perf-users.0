Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343576;
	b=PlwI+czPrfJ7/zmXfpo59OSrP7eeVk73IWOudpf7KAdkH1PFXmZ0Hgxb2OZpovbmfJFc
	 1OHdnumf3oqvfWkyzNTnJV7vbpaaFjBk7lG7lsMHiOAL90H6sBMge+8l8TogpmqiJuvIR
	 oljEcsBqhDRJWW+HsEPyU1SBP4F9bYFObVeoBUWtE93d5lU3o27AaNLrZa2dVbNXwe8fM
	 goT51nuixcbYHBtXzgnTYPlbV9VOQap46vOsnAhSytI8G3BnXNgLnwOhy4jczVQMig6BR
	 O57QlCOKn5FpPt32amopR+IYSkw6sYFhoF0+bEumkl4EyWJOlRlJSbuKhMNmE3e1Szg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343576;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cs9D0HY32Cso7YnxVSoyyLLlor/aF98StXHYbAJIbtM=;
	b=yOXSvAwW5PtmNiJqArF4yYthw2/6BYj31v0T4SPSiqvm68dC2x4hrZc9IjFHFcT7e/ch
	 ar0s5Rj+wpHNsC68Ri1qsyHGzcChl3GndodPXEEgakk5wxT+sYY7IWylAt8fF1XlN35p7
	 f1lF6cMd7k0RDP/Lqaf3wRUyAHmxDKxFA5CKeB4CcrobNgqPOYiMU9FfffuDbmVPnmki3
	 hZpsBXmbx7yrSe2OydWLxcamEUAp1+UX8kzij05Z/ZqTiolw1KJyyhMoAUpr+0Ye3xyCG
	 wUsvVDhR0mWfi/1lLndN5e6QNi8Nnhot4dxLuUmbAtvVQAocLsBBj22Cka7rdziihZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="rQ/lO6+M";
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFB606A31C;
	Fri, 30 Oct 2026 06:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=rQ/lO6+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793343573; x=1793602773;
	bh=Cs9D0HY32Cso7YnxVSoyyLLlor/aF98StXHYbAJIbtM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rQ/lO6+MM6O0c9Lri28+sr03loz1eKU8Moh/sR8lKA2yMySoq1XuhynlwKOUVJPIq
	 9+rEIgCWiQGQY+j57N8lvhdif2jGUOZDMQM9NWaOnjdady6levdVLKFmSzzbMl3/Jj
	 3Uxm+nXIUoQadHtmXNQT982D6CPLQozBUqtdhZt7aClt1OMaFng2AnextvBcWewKPl
	 p/dHZf8rq55/+h93GJwO3NNH1tPay13VmjjuKwB/iGwMbMxvaMW5J/Yl8YeYndu4ml
	 7lPB0ECAGEyDgERnN8/zkjQHMJ78i9dqNxschgO/JJxSQPY6DfxaRCiL8XDr/gkH4m
	 ImYNbJwlh5qVw==
Date: Fri, 30 Oct 2026 06:59:28 +0000
To: acme@kernel.org, namhyung@kernel.org
From: Paul <p@1g4.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, alexey.budankov@linux.intel.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH] perf record: Skip affinity for per-thread mmap buffers
Message-ID: <20261030065857.2157899-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 30567b2a5a2c3d284c4b55dfa40f2fb37edd2741
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Paul Moses <p@1g4.org>

Per-thread mmap buffers use CPU -1 to mean any CPU. Combining --per-thread
with --affinity=3Dcpu passes this value to __set_bit() when constructing th=
e
reader affinity mask, causing an out-of-bounds bitmap access and SIGSEGV.

Program received signal SIGSEGV, Segmentation fault.
0x0000555555f3488e in mmap.mmap ()
#0  0x0000555555f3488e in mmap.mmap ()
#1  0x0000555555e2f7bf in mmap_per_evsel (evlist=3Devlist@entry=3D0x7fffedc=
c1150, ops=3Dops@entry=3D0x7fffffffaf50, idx=3Didx@entry=3D0, mp=3Dmp@entry=
=3D0x7fffffffaf70, cpu_idx=3Dcpu_idx@entry=3D0, thread=3Dthread@entry=3D0, =
_output=3D0x7fffffffaf08, _output_overwrite=3D0x7fffffffaf04, nr_mmaps=3D0x=
7fffffffaf0c) at evlist.c:598
#2  0x0000555555e2ef96 in mmap_per_thread (evlist=3D0x7fffedcc1150, ops=3D0=
x7fffffffaf50, mp=3D0x7fffffffaf70) at evlist.c:650
#3  perf_evlist__mmap_ops (evlist=3D0x7fffedcc1150, ops=3D0x7fffffffaf50, m=
p=3D0x7fffffffaf70) at evlist.c:748
#4  0x0000555555f2150d in evlist.mmap_ex ()
#5  0x0000555555db0b0a in record.open ()
#6  0x0000555555dadea7 in __cmd_record ()
#7  0x0000555555daca89 in cmd_record ()
#8  0x0000555555e27d53 in run_builtin ()
#9  0x0000555555e277cf in main ()
rip            0x555555f3488e      0x555555f3488e <mmap.mmap+382>
rax            0x7fffef9e9bd0      140737213537232
rbx            0x7fffedd249a0      140737183369632
rcx            0x3ffffffffffffff   288230376151711743
rdx            0x8000000000000000  -9223372036854775808
rsi            0x0                 0
rdi            0x7fffef9e9bd0      140737213537232
   0x555555f34876 <mmap__mmap+358>:=09movswq 0x10(%rbx),%rcx
   0x555555f3487b <mmap__mmap+363>:=09mov    0xb8(%rbx),%rax
   0x555555f34882 <mmap__mmap+370>:=09mov    $0x1,%edx
   0x555555f34887 <mmap__mmap+375>:=09shl    %cl,%rdx
   0x555555f3488a <mmap__mmap+378>:=09shr    $0x6,%rcx
=3D> 0x555555f3488e <mmap__mmap+382>:=09or     %rdx,(%rax,%rcx,8)
   0x555555f34892 <mmap__mmap+386>:=09lea    0x17711b(%rip),%r14        # 0=
x5555560ab9b4 <verbose>
   0x555555f34899 <mmap__mmap+393>:=09cmpl   $0x2,(%r14)
   0x555555f3489d <mmap__mmap+397>:=09jne    0x555555f348f7 <mmap__mmap+487=
>
   0x555555f3489f <mmap__mmap+399>:=09mov    0xb8(%rbx),%rdi
   0x555555f348a6 <mmap__mmap+406>:=09mov    0xc0(%rbx),%esi
   0x555555f348ac <mmap__mmap+412>:=09lea    -0x430(%rbp),%r12

Only construct and apply reader affinity masks for buffers with a
nonnegative CPU. Skip the reader-side bitmap operations as well, since
per-thread buffers no longer allocate an affinity mask.

Fixes: 8384a2600c7d ("perf record: Adapt affinity to machines with #CPUs > =
1K")
Signed-off-by: Paul Moses <p@1g4.org>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/util/mmap.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a57987851cf0..d7c8f490cb62 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1565,7 +1565,7 @@ static struct perf_event_header finished_init_event =
=3D {
=20
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
-=09if (rec->opts.affinity !=3D PERF_AFFINITY_SYS &&
+=09if (map->core.cpu.cpu >=3D 0 && rec->opts.affinity !=3D PERF_AFFINITY_S=
YS &&
 =09    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
 =09=09=09  thread->mask->affinity.nbits)) {
 =09=09bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbit=
s);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 358e70c4f3ed..be3dffdaede8 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -292,8 +292,8 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp=
, int fd, struct perf_cpu
 =09=09return -1;
 =09}
=20
-=09if (mp->affinity !=3D PERF_AFFINITY_SYS &&
-=09=09perf_mmap__setup_affinity_mask(map, mp)) {
+=09if (cpu.cpu >=3D 0 && mp->affinity !=3D PERF_AFFINITY_SYS &&
+=09    perf_mmap__setup_affinity_mask(map, mp)) {
 =09=09pr_debug2("failed to alloc mmap affinity mask, error %d\n",
 =09=09=09  errno);
 =09=09return -1;
--=20
2.56.GIT


