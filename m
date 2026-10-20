Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516867;
	b=TZB0W15FXDI31iohxit5Y7DaeJTU9h8b201juLs4etgwd2fXI1N2y1Ak8m3NGUtcx3fw
	 gR7+SBQGQOPjMaBXvUHzEo+HgGx9C+oqteooG4d5TI6RHxQnrQzFAVpfuLzMMyDtJUkxF
	 iKeV38NjrqqWl0BJTUnrJ1FSJOGGFPtOu1WaUg6iSTb6w7/BNZ2jfSJblpLI5jxEb+0Tz
	 c7SKXwbe+iUsmnwBuZXluX6HLJs0P9Dx3JdFBM6EB/qiC/m9wqb2499MVFCUPmNi+cO7o
	 2t/gxX6drfJcI8CmP8ssyhUpQ+Oyp4KvA8xRALTU5KkmVIL6bWNMwkJsMlIKFvc9jWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516867;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GMpU3aRZu4tgyi6FvTaazs0i1w/2Ourk2Zax7nqmLrk=;
	b=IZL03mjGmw/5V7c2aYRUvD1MPpIXiJ857//jN9yCliwpaK5i9x8zm+V4BUAIZTW1LIvC
	 As8vBIYklyyI8DSZmATS+1TJ4FwVVKslWro0jVSrYxqrrW4X70vcujN2zKAsIHQwQTEoK
	 vs7V1GEjD/KBYEYjQR4Ur/W//AJi89wYj6OtV7xbXeRu/mvb44q1yGS4lSIwovsk+Irrk
	 5qCkkD6ele5Y1De6R3fMeY6F3gOd6DnMDfedVlAkCWMyB1ENdv0dVHK+gMztsNdsZEbG6
	 MG04S4kT1FsqzYlnjqGR80R41tSlR0T2aOc6AAUbIzeSSPPo1Ha/3o/YzQpAACbBnxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=YmfzJbCh;
	arc=none smtp.remote-ip=185.70.43.97
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E93606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 17:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E93606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=YmfzJbCh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1792516863; x=1792776063;
	bh=GMpU3aRZu4tgyi6FvTaazs0i1w/2Ourk2Zax7nqmLrk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YmfzJbChsxGVZaPLl+OLhz+159ZvGibk4WajrPjg8/UY40jLt9X6kdpZ4pALcNogL
	 ApafoWrqv5pMWlKZmWleNdgOE8Yhk/iTwm7YArB/r76EBxd//DwO8+hjj4TpThRebL
	 uJqbjLtxskym5VsUV1b62rs4iNG2WCdbm01IaOJ2xXVsSD/6zSvz3QSDcKSydDU/Bh
	 yVztnhdFBfcbUXqIhyit4WWPgBBVU0VCaUjWMzoldxR4TuUPZxRPxI1/Q/omIua+up
	 BbbFy5wcr11q9TDwY38Mb4Kb61SyW5RG8cQL+cbsjhdg6s7/wjj/+pJZXWWHzT7raN
	 21VN5FWZCaBpQ==
Date: Tue, 20 Oct 2026 17:20:58 +0000
To: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
From: Paul Moses <p@1g4.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, kan.liang@intel.com, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH 1/2] perf mmap: Use the head selected by read_init
Message-ID: <20261020171946.3593127-2-p@1g4.org>
In-Reply-To: <20261020171946.3593127-1-p@1g4.org>
References: <20261020171946.3593127-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 1c3fd64d557e55c70a4a5fc748b2dc802ff08482
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

perf_mmap__push() reads the producer head before calling
perf_mmap__read_init(), which reads it again to select the range to copy.

If the producer advances between those reads, push() copies through the
newer head but stores the earlier head in prev. The next drain starts at
that earlier position and can write the same records to perf.data again.

Use the head selected by read_init(): end for forward buffers and start
for overwrite buffers. Save it before the copy loop advances start so
prev matches the range that was copied.

Fixes: 8872481bd048 ("perf mmap: Introduce perf_mmap__read_init()")
Signed-off-by: Paul Moses <p@1g4.org>
---
 tools/perf/util/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 358e70c4f3edd077c9752115329f29040f1c2a76..6dcc4a9304b926c4a8d4f401e40=
bfd79d18dd199 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -330,7 +330,7 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp=
, int fd, struct perf_cpu
 int perf_mmap__push(struct mmap *md, void *to,
 =09=09    int push(struct mmap *map, void *to, void *buf, size_t size))
 {
-=09u64 head =3D perf_mmap__read_head(&md->core);
+=09u64 head;
 =09unsigned char *data =3D md->core.base + page_size;
 =09unsigned long size;
 =09void *buf;
@@ -340,6 +340,7 @@ int perf_mmap__push(struct mmap *md, void *to,
 =09if (rc < 0)
 =09=09return (rc =3D=3D -EAGAIN) ? 1 : -1;
=20
+=09head =3D md->core.overwrite ? md->core.start : md->core.end;
 =09size =3D md->core.end - md->core.start;
=20
 =09if ((md->core.start & md->core.mask) + size !=3D (md->core.end & md->co=
re.mask)) {
--=20
2.56.GIT


