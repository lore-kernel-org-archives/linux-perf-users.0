Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950371;
	b=tw27AJbqrh2uzdYqrPvbztorWuBRmbbSwbakWxccOH6s7wnEEWu2b4OOk17d+Q5IZewy
	 8KNvyABpI0XHXKmQv6YigPnEuoWcFRRtNkdw9QotcNQK6lANE8gxPfpTOqaQlPkW5K0lc
	 gEcUR8FiQb5cbC72CDC4Ocz8SHYDK6PTu2IF1f/saCa39DQ8nT3N/ukq6s024b8SKqTFA
	 OK/m/WpJAMqV4ymy9FPaUJU+f58xtbeKsEm9/eThVyfME1vRGq/D2S6z7Pmn7VTIWC54P
	 MJ9xPK/3TXX8GBTiKf6c8YALEaGB3SDhfhBQ9q3x994lT2cqhZCcpem8FDPXja528nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950371;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eJE2E8MBiaVeR3MGDyU5Af2igw0yvT5XqQQKyQmZlys=;
	b=5nwM1qxjotgJaFTxaXuivnmT4lhMy8YlLOaTS/uXPNamjpLq6QWOU5KZ7+NmiIlli4Dy
	 UJjBMU9WWeVO6pdUFhgSJWP64mY6VWZ/EmSkrWFLBFDLd4HNrkDSEhkCSa2K0+Twu4yfD
	 nY0PvRUVJge27y3UI6Alba9wpUrbXG9BtJB5y3e0QgXfDiM4GY8XXQAKVe6phsG5Gy9GU
	 AAWgpaFMPha4X2z8CQH9LT/LjjjVI5wUfGY164WVygXnp3CbhSOMzqKbDG94DNqAAP41S
	 FzvEK+sQ+QmtlKk/lsP6Ex51SgpP6OMdO9dwqNv2GhQpCT/rn4XRfgrnk9IuBi2G9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	arc=none smtp.remote-ip=109.224.244.20
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3E606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A3E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793950355; x=1794209555;
	bh=eJE2E8MBiaVeR3MGDyU5Af2igw0yvT5XqQQKyQmZlys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y9aS45IlRYHi28TaUZgE1/ZTzUUK2aRwuOWTxcx/Uks20cSwIGM4cg+yqOD42RAhw
	 RBIx3StyguzYg+NH9WwAiru11/Feo7gpG5D3lX5mvpIjkSd+zKQaVyVnVZz7CDqw4/
	 oSTfu1/RfoZ1Y5LfqqDVKKB/XbbDqt1edJ6DEZdCTFdKuZXMKFixqj79ujv478xr2k
	 cLTgF74kkpm/gm/SgdwgQRp78aP+uirbj2GLG7nnU2FLWGnsLuY6lfQx2/dDdWtn9L
	 BMlszhF+Es+J8aWqdmb7aqmo5zW3B//gDjZm7yalReN5+rBkqiTHUeXZwlcLIK/3hO
	 PBT8yzZo4pRSw==
Date: Fri, 06 Nov 2026 07:32:29 +0000
To: Namhyung Kim <namhyung@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, alexey.budankov@linux.intel.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Skip affinity for per-thread mmap buffers
Message-ID: <WbYsffp5YfE6DLkD1OT419MobQzwgeDDX5a3V2uu_MWCiCVCNHTzTu2gu2mQ9174qccVUepCdcCJEzrgp_BDlmQSJRvX69vdDKIn3j4ex5w=@1g4.org>
In-Reply-To: <au1_U_VQGMCLNih1@google.com>
References: <20261030065857.2157899-1-p@1g4.org> <au1_U_VQGMCLNih1@google.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: dc1ef41daf9dd3e918a1ddfe2cda0a9e93274505
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





On Friday, November 6th, 2026 at 1:18 AM, Namhyung Kim <namhyung@kernel.org=
> wrote:

> Hello,
>=20
> On Fri, Oct 30, 2026 at 06:59:28AM +0000, Paul wrote:
> > From: Paul Moses <p@1g4.org>
> >
> > Per-thread mmap buffers use CPU -1 to mean any CPU. Combining --per-thr=
ead
> > with --affinity=3Dcpu passes this value to __set_bit() when constructin=
g the
> > reader affinity mask, causing an out-of-bounds bitmap access and SIGSEG=
V.
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x0000555555f3488e in mmap.mmap ()
> > #0  0x0000555555f3488e in mmap.mmap ()
> > #1  0x0000555555e2f7bf in mmap_per_evsel (evlist=3Devlist@entry=3D0x7ff=
fedcc1150, ops=3Dops@entry=3D0x7fffffffaf50, idx=3Didx@entry=3D0, mp=3Dmp@e=
ntry=3D0x7fffffffaf70, cpu_idx=3Dcpu_idx@entry=3D0, thread=3Dthread@entry=
=3D0, _output=3D0x7fffffffaf08, _output_overwrite=3D0x7fffffffaf04, nr_mmap=
s=3D0x7fffffffaf0c) at evlist.c:598
> > #2  0x0000555555e2ef96 in mmap_per_thread (evlist=3D0x7fffedcc1150, ops=
=3D0x7fffffffaf50, mp=3D0x7fffffffaf70) at evlist.c:650
> > #3  perf_evlist__mmap_ops (evlist=3D0x7fffedcc1150, ops=3D0x7fffffffaf5=
0, mp=3D0x7fffffffaf70) at evlist.c:748
> > #4  0x0000555555f2150d in evlist.mmap_ex ()
> > #5  0x0000555555db0b0a in record.open ()
> > #6  0x0000555555dadea7 in __cmd_record ()
> > #7  0x0000555555daca89 in cmd_record ()
> > #8  0x0000555555e27d53 in run_builtin ()
> > #9  0x0000555555e277cf in main ()
>=20
> Please indent terminal outpus otherwise git will eat up lines start with
> the hash (#).
>=20
> > rip            0x555555f3488e      0x555555f3488e <mmap.mmap+382>
> > rax            0x7fffef9e9bd0      140737213537232
> > rbx            0x7fffedd249a0      140737183369632
> > rcx            0x3ffffffffffffff   288230376151711743
> > rdx            0x8000000000000000  -9223372036854775808
> > rsi            0x0                 0
> > rdi            0x7fffef9e9bd0      140737213537232
> >    0x555555f34876 <mmap__mmap+358>:=09movswq 0x10(%rbx),%rcx
> >    0x555555f3487b <mmap__mmap+363>:=09mov    0xb8(%rbx),%rax
> >    0x555555f34882 <mmap__mmap+370>:=09mov    $0x1,%edx
> >    0x555555f34887 <mmap__mmap+375>:=09shl    %cl,%rdx
> >    0x555555f3488a <mmap__mmap+378>:=09shr    $0x6,%rcx
> > =3D> 0x555555f3488e <mmap__mmap+382>:=09or     %rdx,(%rax,%rcx,8)
> >    0x555555f34892 <mmap__mmap+386>:=09lea    0x17711b(%rip),%r14       =
 # 0x5555560ab9b4 <verbose>
> >    0x555555f34899 <mmap__mmap+393>:=09cmpl   $0x2,(%r14)
> >    0x555555f3489d <mmap__mmap+397>:=09jne    0x555555f348f7 <mmap__mmap=
+487>
> >    0x555555f3489f <mmap__mmap+399>:=09mov    0xb8(%rbx),%rdi
> >    0x555555f348a6 <mmap__mmap+406>:=09mov    0xc0(%rbx),%esi
> >    0x555555f348ac <mmap__mmap+412>:=09lea    -0x430(%rbp),%r12
> >
> > Only construct and apply reader affinity masks for buffers with a
> > nonnegative CPU. Skip the reader-side bitmap operations as well, since
> > per-thread buffers no longer allocate an affinity mask.
>=20
> Maybe we can just reject those options when they are used together.
>=20
> Thanks,
> Namhyung
>=20
> >
> > Fixes: 8384a2600c7d ("perf record: Adapt affinity to machines with #CPU=
s > 1K")
> > Signed-off-by: Paul Moses <p@1g4.org>
> > ---
> >  tools/perf/builtin-record.c | 2 +-
> >  tools/perf/util/mmap.c      | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index a57987851cf0..d7c8f490cb62 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1565,7 +1565,7 @@ static struct perf_event_header finished_init_eve=
nt =3D {
> >
> >  static void record__adjust_affinity(struct record *rec, struct mmap *m=
ap)
> >  {
> > -=09if (rec->opts.affinity !=3D PERF_AFFINITY_SYS &&
> > +=09if (map->core.cpu.cpu >=3D 0 && rec->opts.affinity !=3D PERF_AFFINI=
TY_SYS &&
> >  =09    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.b=
its,
> >  =09=09=09  thread->mask->affinity.nbits)) {
> >  =09=09bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.=
nbits);
> > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> > index 358e70c4f3ed..be3dffdaede8 100644
> > --- a/tools/perf/util/mmap.c
> > +++ b/tools/perf/util/mmap.c
> > @@ -292,8 +292,8 @@ int mmap__mmap(struct mmap *map, struct mmap_params=
 *mp, int fd, struct perf_cpu
> >  =09=09return -1;
> >  =09}
> >
> > -=09if (mp->affinity !=3D PERF_AFFINITY_SYS &&
> > -=09=09perf_mmap__setup_affinity_mask(map, mp)) {
> > +=09if (cpu.cpu >=3D 0 && mp->affinity !=3D PERF_AFFINITY_SYS &&
> > +=09    perf_mmap__setup_affinity_mask(map, mp)) {
> >  =09=09pr_debug2("failed to alloc mmap affinity mask, error %d\n",
> >  =09=09=09  errno);
> >  =09=09return -1;
> > --
> > 2.56.GIT
> >
> >
>=20


Hi Namhyung,

Can we please get this one settled first. There have been issues
with important patches being overlooked for months.

https://lore.kernel.org/linux-perf-users/20261020171946.3593127-1-p@1g4.org=
/

Thanks
Paul
