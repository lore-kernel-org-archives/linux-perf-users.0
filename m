Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349375;
	b=J6NJ3TTEgvDFhRtP8kpiTK7fN+H8L7789QW20UTp3y63YtjemPdXgu5VaReruR7iQrVD
	 /s0/7QKU6EQMqtspDSPxN2qUazwoppLxUWrYOuGk9iTbZ8fqU6uufiGX1Osm/FI13/EAt
	 PLSsFb0G5njhACaNEJIN8dRGP4zhI0Al79NlnF/VlIt9UKj36Mx3zrbMCou6JcggrXXTh
	 xIRZ7K2js3WF/cDMzXdpnevx+DZhkqGgnNyDZYvgsaUF3Xjd0sTJKjPlRg1IqnUV4gsxv
	 onnBF0g7HtgJU4cW0a718cuMm1CfiqJRVVVlLJLqyMUlW8i90qu6cLPr3qbqkhW240A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nzkx5Y7z3GIChRU/hZqVulN4xodJ9kYrg3nMUZEDXio=;
	b=PSY68V4Z2NOEga6M28ASuHEXClNwMK/6XfJ8K+cAanZZr3q7I+m0zRYAAVfWZuSEJzei
	 8vz7hsWR+SNVPUL937AP00K0NF2d9msU3+KOdfwOj5Ygxi33ILlNuHMlp78iD99yzc9iX
	 HGOGJbyPtNC7wV0bM27YIDxYGcff9x98nqiOhX/lLUMzDMFHGWHoQsePrH2dBfk6sg3T2
	 6LRxa0c2dbHOZIE5cgciV4A9ZwwlbSz/I83dywzEUUB7S/oBCIYcjfz5Fb2W86gErTCRx
	 6iH01G+svARTHEAgaW0Gnw4HI/lU3yZU9Jz/eDTWBqI3kq9xAJFEA4ZmM+VVFiOK99Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvGTBhNm;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E96606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E96606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvGTBhNm
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36dbde64409so5283485eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349374; x=1794954174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nzkx5Y7z3GIChRU/hZqVulN4xodJ9kYrg3nMUZEDXio=;
        b=XvGTBhNm8d0MD11G6qWywKQ35ggeOg4FT1eSVAWDia5zbdPY+cv81led/POLu1qcUJ
         vZ7ppnRN8Il9qxWg22mvNWwtGQH/kfSBvAFTvVyww9qOx9FGY/wIYoJAOBMMG10zuAYd
         1Ds/uBOOs7FXFC1mXSthyZ94QY2NDrUt9ggbehlWkgZlYhQAgv+4LN73AufnKE8p41zU
         JdUSFbeJJv1MU1STWIf1lUC2NiOVkZTpN91QBSjidO0D09Rb1wIgoxY9Hsji2ZYL+n3M
         69L8gROaZFGz9y/+Hmghfy+vQhaRnwop9UwlAceugMzE/V9dzrIZ6eJ3nk+EYtAKUrc0
         +lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349374; x=1794954174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nzkx5Y7z3GIChRU/hZqVulN4xodJ9kYrg3nMUZEDXio=;
        b=wTgSDDTWIerhpctJSgUPD7LxhMoPJ9dqozSpTVkX3UYJDbxRKaCGJXXhjoSS6WV8H1
         4sd7xDbjRD4kT7r2kerqPFWFBmifcLMoUoDEJBmtcfulIYY6coiX0RBICxdi5JsO1qYT
         ty0dhv2kjXOzCU1KJEjuqNLrqhSYZz7Qcmxp2HpE6isb4R/NWMXGeZp1knS6TwRlBehE
         NOP1BVgQo/i3ie+/3e8BB/RIu8GsJVBwX614VBOrHsa2N/4CSSoggGXBGPVPFXismFHe
         vHUTXG+ATS3e9G30+31U2KMfX58Jo5yZ2KR1SltAAyfG/QvxgpMvKNzSFoG/WqCl5i0Q
         tN3w==
X-Gm-Message-State: APuU4Z8ZsX4rW1pd4HoyhLRkPjmKA6R3bERoYy9I22P6SblkdMTAwZ/9
	IVQu9CKgrfD+IHoPzEsga/v2r0RnLScYSmh9crP5aWv5BttLSKEkRsV1x7oXepwt
X-Gm-Gg: AYBFou0domDo+NWxIBINMvSIZeHaV17nrs0piJFsHl5X5PKO2laW+iTw2eaCRc851a4
	jHvhu15F1OmtbjC2fvd/TjNY+7hQFqF0iuJN1WiieIHqVOZWxTrK1gwAZ3MoKyD+QcATU+KmqI+
	K9jp481Zxr5jwrIeHLxruq0gHvVfUatQWPIi9zw8FE/kcAT9N3d3dNY/BUYReWfrASj3lNBPr8z
	Y9nmRbUYUbINp7Mxi+seEM7WHDktSqBHzDvpr+7dDCl0GlSh9mPoreMbL6W19PVQ79AzVRS1RWg
	M7x/J+rXxI8QzCUnbsY/2ymvFqditePcVozD99mes3QtRT3onnEvYvx8azRLoQ5eAaIzibuYx4s
	do6Tj0uGkZJ6AGXyISOQdjZWmdEceAAHZfoJo1Xw9s+7AiQSnXEjQOuHNjGKkglEFK6fBjA5rZp
	OnxoD+/Ww4an2/VGm/BNVvLhoYxzeUFzvQdipQlUrh3+3UMkHtrhSE6B79p9KeZaIlJAKBP6Idk
	XQbPiqQP1asNp4+FsZSVRddP8fS2qm53JpdWrvNTL5QlvSMQuzaNFqYHICpS5Y01hAJYt6rNLXI
	21moaR1H1cVMku+HmhxA
X-Received: by 2002:a05:7301:428d:b0:375:c5e1:931d with SMTP id 5a478bee46e88-37686171ed4mr921591eec.25.1794349374111;
        Tue, 10 Nov 2026 14:22:54 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm9165030eec.10.2026.11.10.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:22:53 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] perf jevents: Report the JSON keys that jevents.py never reads
Date: Tue, 10 Nov 2026 22:22:47 +0000
Message-ID: <20261110222250.1864777-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jevents.py takes the fields it wants out of each JSON object by name and
ignores the rest, so a key spelled differently is dropped without a word
and the object is built without whatever that field held.

Patches 1 and 2 make the generator name what went wrong, and let the
model argument be omitted. Patch 3 adds a --check mode that reports the
keys jevents.py never asks for, along with a make target and a perf test
so that it runs without anyone having to remember it.

This is the second posting of the check. It went out alone in November
(https://lore.kernel.org/linux-perf-
users/20261110193239.1741014-1-takano32@gmail.com/) and the review found
two ways it could call a tree clean that no build can use: a MetricName
with a dash in it that loses its MetricExpr was invisible to both the
reader and the report, and a metric without an expression was skipped
rather than reported unless its key was spelled close enough to be a near
miss. Both are fixed here, and the failure-path changes the check needs
are no longer mixed into it.

The test runs the check over a fixture table rather than over the tree,
so it is green whatever the tables happen to look like, and it checks the
three exit statuses: 0 for a clean table, 1 for a reported key, 2 for a
table that does not parse.

The two misspellings the check reports in the tree today were posted
separately in November:

https://lore.kernel.org/linux-perf-users/20261108184600.3810059-1-takano32@gmail.com/
https://lore.kernel.org/linux-perf-users/20261108183846.3804875-1-takano32@gmail.com/

TAKANO Mitsuhiro (3):
  perf jevents: Name the metric when a MetricExpr is missing
  perf jevents: Make the model argument optional
  perf jevents: Check the JSON keys that jevents.py never reads

 tools/perf/Makefile                     |  14 +-
 tools/perf/Makefile.perf                |   1 +
 tools/perf/pmu-events/jevents.py        | 394 +++++++++++++++++++++---
 tools/perf/tests/shell/jevents_check.sh |  68 ++++
 4 files changed, 428 insertions(+), 49 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

