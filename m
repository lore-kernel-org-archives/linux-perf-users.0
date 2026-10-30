Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342941;
	b=WZezW06pjBclNPE8dBQApdXHnvHmNT80VLQSXDJgUu16AgOUeX1Zp1/ENZseiLjrHvj5
	 ceNPGx9a9wwhibxJAMycFf4pdsNd6qQv0dPH9pKAHPUPyGZTkOPbofi1e9XI6LwVJ962l
	 R0wsd2BrzBhtdfWq5d4m+AAVBwfGrmrz648ZxdLuQp7MQb6q8mUvvuvCw9VJLPiM4Y/e0
	 F3RePvUvznD8m0PuLW7/5dKbiQMrwH8Aeek4T3GE6rfI+sMIyU/YzBHplHcJX4VVGSktR
	 yblfDLZZZnHHFplPa1RxJ4LU8drFetb3t75pdWlW58JMFOjEvy0OOZqqdzMbgyS7iOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342941;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tFOTpkNEL1hP4uAqzlTD1FxSXnZgA4Pxue5jGbCLMUg=;
	b=drncJyiHNLh4PDfAUN2dRg5ylfKXVthhpj/t6bIdczbIJCvXgGVEeE1R67sub88SnIsV
	 Ia1oHKpr5g52db+F3apN9/NzgCJLEq5JfRIuHaVGt4qwpXbzLCuzy5joHW3glDQ2oFo6O
	 Cje1nUo5fixkuMcZUHGEbb+c55ZJjzTYXJecPW8ZByreCZhvuozMKBgtMzw7SN2p4onCi
	 vH5qZf7NVNYPfbmmxNP+VfLLAhLolUx/FpIOCE/DWlUtXMfF9xLFVRJUgyFywLsb53KI0
	 LEF9JkwpjCz10pEMes2bo3fZU9oqmMN1/sqHPd61PCv1y2mbqD7n+F1mQXtAUzXSPsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=lwlsSzqo;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7C606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA7C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=lwlsSzqo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793342935; x=1793602135;
	bh=tFOTpkNEL1hP4uAqzlTD1FxSXnZgA4Pxue5jGbCLMUg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lwlsSzqoKIvwIH3adiG40omDH6F7re4iug77w3G/zWBHT6e23JpJqH2ChsA3EbOMM
	 bfEpoUik72iIuKVNsEj1BNc8V9K5iw2j7Ofjjs09m7ln1QH1bYxEph3coC7r5Wp32W
	 H+DihdB7DmF15M8xGSgzMbtfFpnUY06juQSOgcE9+ghyktbVcBnutm5DS34z/VrRVR
	 P9WczbyODjmcH3XT7mq1epoYN6wUhcTACWBJGelUnwIaB0ZqvxO7QSkWTepjkruFJR
	 I8xdLp7oglXIEbsd3cgWwFOh2srb9a5aJM/8b5jFqPEJKZt6ACXkwh/Rn1BjOrI2mV
	 89J5PDCiogy9A==
Date: Fri, 30 Oct 2026 06:48:50 +0000
To: acme@kernel.org, namhyung@kernel.org
From: Paul <p@1g4.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH] perf record: reject CPU indices equal to the mask size
Message-ID: <20261030064825.2156317-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 2745c43373760e728a2ae74218bd47c5d873665d
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

record__mmap_cpu_mask_init() rejects CPU indices greater than nbits but
accepts nbits itself. Valid indices end at nbits - 1. When nbits is a
multiple of BITS_PER_LONG, __set_bit() accesses the word immediately past
the bitmap allocation.

User specified recording thread masks reach this write before they are
intersected with the selected CPU mask. For example, an affinity mask
containing CPU 64 overruns a bitmap allocated for 64 possible CPUs.

=3D=3D40343=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x7bbab4000018 at pc 0x6195de57af45 bp 0x7ffe25545d20 sp 0x7ffe25545d18
READ of size 8 at 0x7bbab4000018 thread T0
   =20
Reject indices greater than or equal to nbits before setting a bit.

Fixes: cbd7bfc7fd99 ("tools/perf: Fix out of bound access to cpu mask array=
")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d7c8f490cb62..80aaad7d51ec 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3689,8 +3689,8 @@ static int record__mmap_cpu_mask_init(struct mmap_cpu=
_mask *mask, struct perf_cp
 =09=09return 0;
=20
 =09perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpus) {
-=09=09/* Return ENODEV is input cpu is greater than max cpu */
-=09=09if ((unsigned long)cpu.cpu > mask->nbits)
+=09=09/* Return ENODEV if the CPU index is outside the mask. */
+=09=09if ((unsigned long)cpu.cpu >=3D mask->nbits)
 =09=09=09return -ENODEV;
 =09=09__set_bit(cpu.cpu, mask->bits);
 =09}
--=20
2.56.GIT


