Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516876;
	b=wL0W5xSENe0R9UY9PGd70hPQZrEMOYjLXxqWoF1JvwJvRa15YGyuNjPBEwZ4p8G+X1IR
	 VLOrQjAWkUC13vOqIJisDt3mUhXbb1dg5k6kgGZW2q3Pb4xogkxBirQ2M3RKKSI2BhjAw
	 6C4ANVIZVuubqlWCBxiVzgk7Z5WF/pjCogLhnhoVArnYz8HqpDU276EB3wmOhLUKR/83m
	 Q4K7jEWkKkdGjzUA9JAsBLlWqlIpy/AZCvt7+992KtwS/2oEjepxFCo+fVZqH53Z/NB55
	 VS1S2icy7F34bA2NCosyMqn7SV3PwaubLrUGy19yLSKo/c/F90uZGco9rprQMT8DOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516876;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TbeuB1pI6Qx3cFqyT3E7YKcwCBIJAjWx9mje7M15GYk=;
	b=UJ7llx5wvditeTJ61B1LmIDgUwoPEs/DUDGca/zlRwit5nr/JCHqB3J93dwreUr65L88
	 0OUMjMpDFiE08yJejGDerZoEC0+jPbeyLHuPfzt8ol5nV+Nh+JK/f0LYxLb6e6AA2JQAc
	 K96lB4SiAz1hqZsnC2fLUEOAGmRTeXCN9sNoodWfApf9ZY79K3YIZ8HNWhHsmuMwK0LqG
	 4FFePmyGM7jlZrknTAiSPx+ush0UFxttHwiVr7VcHtkF+4nGqTGctkrGWrZ6pXmrYrig9
	 fLdja0nkMLPdccRvpHx1haof92xztHvPa4RA8u338cfAiBYEj2X8I0rKfpTW0EelMCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="ngX/QL0B";
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F760A2601
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 17:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E69F760A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=ngX/QL0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1792516873; x=1792776073;
	bh=TbeuB1pI6Qx3cFqyT3E7YKcwCBIJAjWx9mje7M15GYk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ngX/QL0ByKU3avZXFy3YLhi/qik667+r8aHht74+YoBtRgLyXYqj9YvDsBVbTdkD/
	 dh6IgYdtkTFl1fImz532CUpidZTcWKerm+RjG3BMzwZdKLFMSQg71Z/QBaqpO9OXrA
	 q/gvDO0HJjhx8wTf+gpigTjOBgSMstAeW8ElE4lLAtegY0uSfliOKBMCcIODEf2sqw
	 lnhEROt0A/xxgOCletFyh9wqrblRXcga5foniSfX+ZstB5FaejuQuqMBlmYS4yU/N5
	 SxmzYB7Zx8/qrhBgQYoabe8SCV+YmZe0llmp0XTfRbap8Xy4Lsyis7vU2B7INCvZB8
	 bLphZFZX63B+A==
Date: Tue, 20 Oct 2026 17:21:07 +0000
To: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
From: Paul Moses <p@1g4.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, kan.liang@intel.com, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH 2/2] perf mmap: Preserve the consumed cursor in forward mode
Message-ID: <20261020171946.3593127-3-p@1g4.org>
In-Reply-To: <20261020171946.3593127-1-p@1g4.org>
References: <20261020171946.3593127-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: a07aa1e0e752fd93506ce82a31e4d75a620c6bbc
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

perf_mmap__read_event() updates prev as it consumes forward-buffer
records. perf_mmap__read_done() then overwrites prev with a fresh
producer head, even when unread records remain.

perf_kvm__mmap_read_idx() stops after 25 records per mmap and calls
read_done(). If more records are pending, prev advances past them. The
next drain starts at that new position and skips the unread remainder.

An event arriving after the last empty read_event() and before
read_done() can also be skipped. read_done() does not itself update the
kernel's data_tail.

Only refresh prev for overwrite buffers, which need the current head as
the end of the next backward read. Leave the forward cursor at the
consumed position.

Fixes: 53172f9057e9 ("perf kvm: Switch to new perf_mmap__read_event() inter=
face")
Signed-off-by: Paul Moses <p@1g4.org>
---
 tools/lib/perf/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index ec124eb0ec0abbcc4a395eca7478129a74309965..ab3adf1d8baf933d5386faf743f=
178b0a7da44c5 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -200,7 +200,7 @@ void perf_mmap__read_done(struct perf_mmap *map)
 =09/*
 =09 * Check if event was unmapped due to a POLLHUP/POLLERR.
 =09 */
-=09if (!refcount_read(&map->refcnt))
+=09if (!refcount_read(&map->refcnt) || !map->overwrite)
 =09=09return;
=20
 =09map->prev =3D perf_mmap__read_head(map);
--=20
2.56.GIT


