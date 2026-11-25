Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628528;
	b=mfXow7/pGuNtLgFOBoVu8IoHdevIBnN2BEl0eT2s2PAZcpzuytqYDYSzi2bh3KfM/YCo
	 /uWVRReuObi+a783nfabYevbPHDmKpEHNiicsELIX1abuAH6/Fg46EsHDjpTC8B3qkbpb
	 nY6ZgfrIQm2Tse62NJ98igBUVsFzoTdAGmQncfQ1TdQj0zflRqMx75Ei3ch3/p3DljHk4
	 XJyMjW/mqO+5Pjf/kafraYaTnzJRcXXM6lWrRsDcg/AvjYXlBYOhROT+T0qMQ1wEpacKE
	 APAQOjOmXlqnNkN2cDUGcqvbw9juUYhboG+h4/ab1Rfm8lj5WIc35Dem5fppFEV1kjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Vvp3ilJwF70gp7zC7+bPYOzHHX3v4kHv4/LvqFhbccY=;
	b=liWQvED12NK2pN4aTPoKbM9GNDcKpCltKE0Nf1D2A5LABcDDk6utmEpU/tnavlA2Ie5T
	 onPGJX8GjqAfg12fOLBVcQk9T0G0AQK+iiu7+tOcXTgQOLstuoykRp3pF0ONzjDhlr9fr
	 s4+Z0fss6a/U41oHCeNumYvBtdIBowHRl6oMGTtUU7K2VmCfxVgHBUfJo82P/yv2YT9ZG
	 2SCCjHancSUT+SHXXmp/nY5BZQ22TnIpxz15G4Tt1COz6b77tISaiRPwhijlgGS5fPB+7
	 GxX8nvO1zt7ZgheVt+NG76aoFW63lMuMfV4VWwwuWC0pRzE2XdeG9A/6GngK1pCXWuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P1xunkRL;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C6606A32D;
	Wed, 25 Nov 2026 17:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627C6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P1xunkRL
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYbG8585371;
	Wed, 25 Nov 2026 17:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Vvp3il
	JwF70gp7zC7+bPYOzHHX3v4kHv4/LvqFhbccY=; b=P1xunkRLMmaj1bYHDELlgw
	UfFkUzcxaAoMEd9tgOpqO+IMs2RQJiHGNVkXPg0kYSyyvNalY/d5Iddhg8EcdBUm
	crjk20lAGxLFA+JIb9VbnDjUZjxuXE++KugNysE6bnf4hj/XdlZETHopitGf+yHY
	ntUC946URXFxJyDsedB8F+YLBILtV9cGeUPMlXWvPJFfCCwW8SlRos4O6yx3N5e3
	MyOlgB9ncDRjAXD/3jrVusPm496zU6gcO5xPvKe85bHL43KJ2fQhwHKlYLYPLez+
	1rSO+/bcvgbFiYpfRDteeSkJ6l1u+xeBpgYblqA5QpcRu+ssrIM8bPGFbHxQL4lg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4n2nn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:41:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYFia1063060;
	Wed, 25 Nov 2026 17:41:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuva9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:41:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APHfcBe45351174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 17:41:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A551820043;
	Wed, 25 Nov 2026 17:41:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1091F20040;
	Wed, 25 Nov 2026 17:41:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.30.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 17:41:34 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 00/10] perf jevents: Block-indexed string compression
 and default JEVENTS_ARCH=all
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fU9C5BTqgHXLvXMzo90a2+LA6PmXbvUkXsrjJ2A_mMyWg@mail.gmail.com>
Date: Wed, 25 Nov 2026 23:11:22 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5B66C3D-C42E-4C9F-9C57-B71941F55A40@linux.ibm.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <CAP-5=fU9C5BTqgHXLvXMzo90a2+LA6PmXbvUkXsrjJ2A_mMyWg@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfXzh/AiU7KOhk+
 ZpPVufuj1N9LIG1fmoYj6oz8XR/JbBrLUSjpCWeIktZQ072L4kyHuXAhaIp0M+DC7XLziGApKHy
 u5Gx/Lhp9E8W7mFYPrPO3l6oQIjfk24=
X-Proofpoint-GUID: RmRhnmgcVUyECRsl3GZahu2RnL8eHGz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfX6pe0yzFEJ+9n
 X+OpzGGj6SQMrbMICTp25RH3Woc4JmtqrUuFPIaabK5oz4VNJr9Xo3/HYAw5fbIjNwKUeo0nk9l
 DmIIXamWQiIcDx15VQj+O/rax4YFDzj352hDLnZs3OzoSzvnRO4Emag1A5KGsymx+A0wLFMns0+
 eswjlkv6D0FeSbTouk1eeF7bYh0ZTbx/oKoVAHl4hzgJBzYjquNaifRPCpQeY+gXcdIM8fgVinJ
 +EvZQ5/V9qtxZvKO4WJAlW6B4s61tLVOuFjCjdkHt0OsRD+sn4hFZCNttjZ73SrRu95TlJXIi5V
 QvQNpH4zpL4f7OqVs9YyJBCIfjVX+ZkoFHnLNc08anSe0pIa1DQWGrehIgK/RCbm1L0R/Mh/8Pl
 5l+OHNjgACjbgobQs7xgaJtljbdi/FbrZTQDC8qxVPzf1ITaVxUvO/sCpnk0jmUlLJ8x5YTzmwz
 dBuJACiQGS10+V3cC1Q==
X-Proofpoint-ORIG-GUID: kz6tw8jZVoJIXHLS3uUpTyTk_cE00Yby
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b071dd5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=1XWaLZrsAAAA:8 a=nqtVisVhz27csRJPC9YA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250070



> On 25 Nov 2026, at 3:22=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Sun, Nov 15, 2026 at 11:00=E2=80=AFPM Ian Rogers =
<irogers@google.com> wrote:
>>=20
>> Compiled-in PMU event and metric tables (pmu-events-in.o) currently
>> store ~6.9 MiB of uncompressed string data in .rodata on x86 alone,
>> causing JEVENTS_ARCH to default to $(SRCARCH) rather than all and
>> preventing out-of-the-box cross-architecture perf.data event/metric
>> resolution unless explicitly built with JEVENTS_ARCH=3Dall.
>>=20
>> Compressing big_c_string as a single whole-table stream would force =
perf
>> to allocate and decompress megabytes of unused CPU models' strings on
>> startup just to resolve a single event, whereas compressing =
individual
>> short strings suffers from poor compression ratios and per-string
>> framing overhead.
>>=20
>> Instead, this series introduces "block-indexed string compression":
>> sorted, suffix-folded event and metric byte records are packed into
>> ~8 KiB blocks without splitting records across block boundaries, each
>> block is compressed independently (sharing a single preset or trained
>> dictionary across blocks so ~8 KiB blocks retain high compression
>> ratios), and every uint32_t string offset is encoded as
>> (block_id << 16) | sub_offset. An ~8 KiB target block size sits at =
the
>> knee of the compression vs. random-access curve (smaller 1-4 KiB =
blocks
>> pay 22-128% more .rodata for per-block entropy headers and index
>> entries, while larger 16-64 KiB blocks yield <15% extra savings at =
2-8x
>> higher decompression and page-fault cost per binary-search probe). At
>> runtime, pmu_events__get_string() uses a lock-free atomic block =
pointer
>> cache to decompress only the touched ~8 KiB blocks on demand, leaving
>> untouched CPU models' and non-host architectures' blocks compressed =
in
>> .rodata at zero runtime CPU or heap cost.
>>=20
>> The series starts with a standalone BigCString raw-byte fix for
>> describe_metricgroup() binary-search ordering, prepares the string =
and
>> PMU table layout, adds the zlib, lzma, and zstd block compression
>> backends, and switches the default JEVENTS_ARCH to all:
>>=20
>> - Bug fix, string layout, and hot-path isolation (Patches 1-4):
>>  - Patch 1 stores raw NUL-delimited UTF-8 bytes in BigCString instead
>>    of C-escaped strings, fixing suffix folding and =
describe_metricgroup()
>>    binary-search ordering on prefix-overlapping names (such as "Bad" =
vs
>>    "BadSpec"; Fixes: 66c6e0c10027) without changing =
empty-pmu-events.c
>>    so it can be cherry-picked standalone.
>>  - Patch 2 partitions non-folded BigCString event strings before =
metric
>>    strings and sorts entries lexicographically by their raw UTF-8 =
byte
>>    sequence within each partition so identically prefixed event =
names,
>>    encodings, descriptions, and metric expressions cluster into
>>    adjacent ~8 KiB blocks, improving block compression ratios by
>>    ~20-23%.
>>  - Patch 3 stores PMU names directly as const char *pmu_name string
>>    literals in struct pmu_table_entry (only 68 unique PMU names / 536 =
B
>>    across ~443 rows across all architectures, already in =
.data.rel.ro)
>>    so the compiler/linker merge them in .rodata.str1.1 and hot PMU
>>    wildcard scans never touch big_c_string or trigger block
>>    decompression.
>>  - Patch 4 encapsulates big_c_string offset lookups behind
>>    pmu_events__get_string(uint32_t offset) across pmu-events.c and
>>    pmu-events-string.c.
>> - On-demand block decompression backends (Patches 5-8):
>>  - Patch 5 packs big_c_string into ~8 KiB record-aligned blocks =
indexed
>>    by (block_id << 16) | sub_offset, adds lock-free thread-safe =
atomic
>>    per-block decompression on demand, and adds --compress=3Dzlib =
using
>>    raw Deflate with a <=3D 32 KiB preset dictionary.
>>  - Patch 6 adds --compress=3Dlzma using raw LZMA2 per block with a 64 =
KiB
>>    dictionary window.
>>  - Patch 7 adds --compress=3Dzstd using ZSTD_decompress_usingDDict() =
per
>>    block with a once-digested shared 64 KiB ZSTD_DDict (~26% smaller
>>    .rodata than dictionary-free ~8 KiB zstd blocks).
>>  - Patch 8 wires JEVENTS_COMPRESS into Makefile.perf and
>>    pmu-events/Build, preferring zstd, then zlib, then lzma, and =
falling
>>    back to none.
>> - Testing and JEVENTS_ARCH=3Dall default (Patches 9-10):
>>  - Patch 9 adds prefix-overlapping metricgroups.json test coverage =
and
>>    an 8-thread concurrent event/metric/metricgroup stress test in
>>    perf test pmu-events.
>>  - Patch 10 switches the default JEVENTS_ARCH to all. Bundling all
>>    architectures (x86, arm64, powerpc, riscv, s390, nds32) with zstd
>>    shrinks pmu-events-in.o from 7.16 MiB (x86 + none) to 1.11 MiB
>>    (all + zstd, -84.5%) and cuts the stripped perf binary from
>>    13.32 MiB to 7.28 MiB (-45.4%), with ~3 ms median wall-clock
>>    overhead on 'perf stat true'.
>=20
> Ping. Sashiko reviewed the patches, and they are clean:
> =
https://sashiko.dev/#/patchset/20261116070038.2968725-1-irogers%40google.c=
om
> The series adds a small decompression cost but yields much smaller
> binaries and cross-architecture JSON event/metric support (still
> optional but defaulted on given the cost is now minimal).

Hi Ian

I have an observation while trying this on powerpc.

=E2=80=9Cmake=E2=80=9D is picking all arch, logs showed json under =
pmu-events/arch/x86 and other arch as well which is good.
But perf list on powerpc shows "Memory_BW: [Grouping from Top-down =
Microarchitecture Analysis Metrics spreadsheet]=E2=80=9D

Below iis difference in =E2=80=9Cperf list=E2=80=9D, without/with this =
patchset:

--- cmp1 2026-11-25 17:24:21.433570078 -0500
+++ cmp2 2026-11-25 17:24:29.133570078 -0500
@@ -31,7 +31,7 @@ Instruction_Stats
 LOCAL_NODE_PUMP_RETRY_RATIO_P01
 LOCAL_NODE_PUMP_RETRY_RATIO_P23
 Memory
-Memory_BW
+Memory_BW [Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet]
 Others
 PowerBUS_Frequency
 REMOTE_NODE_PUMPS_RETRIES_RATIO_P01

powerpc's nest_metrics.json uses Memory_BW with no description of its =
own, so I think it picks up x86=E2=80=99s.
Do we need update in describe_metricgroup() to handle this Ian ?

Note: While trying this on top of tmp.perf-tools-next,  patch 8 and =
patch 10 has conflict on =E2=80=99tests/make=E2=80=9D, I applied it.
>=20
> Thanks,
> Ian


