Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403590;
	b=4N7LotpLFTFX4LmSM4qCacIXvntHWPjZ9HOwNrQethOUvud5j6GNAzzUF4JyMrbh6ovU
	 +ggHB0kc/Rk4v3AA4tmdJx9+o1OmkmSJvaO5FGyXlGn7oYT4RfQMbnttae3SKBvMFyva/
	 /mapb5FFer8GA3CmimV2uwxka9xFjFv9SXc1toywT4/dZ+1P9aKNfGV28wZ93yWBoKvys
	 j76mwdStcSq1C6JCrXhJgATRIXH6bWJuW0/2c9PDq4KBqZ9MLchCLBuxuSDM5UqqtRLK1
	 hybgpquWoDneqaHhVQkk31lFvBXvxRzmhsHiz/cMP5RenGZMOn1Yl4VpK6XBAUbBAPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=88rAM2oHhFqNhLiz8qe8zFsCZuZ5oGk0TJbNGquyza4=;
	b=cB9coWvQJeC3aBJ2expmoQOJ8chsC+50hJAhdmihu2PnXAoJr3VzpswDNnN1h22fI0zE
	 SkR6VF4WJ00Uggpv3p5tmdyfesRR1VNhj+ExfhVhYTewfSx4nHxHgXDhD6qDrIQGLQ2mq
	 kSp3E1b6/fyXyjlaL2UTeEoN4v+ZxQGxNK0SBoQAEs99Bn5w8mPxYyo4DYdg9qCsZwpx8
	 J4CBTTkcovrNbBqoU+OJGeU58b7tY9Se4fGpSorVdGLM5+5+sopYd7rnGJjY8dWml6MaA
	 +miWUZOsFf7UoT5fBTcyNKZBWvcrBEWh153VaamEfChlPfFuJ/GYLoQ2nkVdoLPe1mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEeLGdIL;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815B606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 13:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6815B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEeLGdIL
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a8cc11ac42so3098089c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794403589; x=1795008389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88rAM2oHhFqNhLiz8qe8zFsCZuZ5oGk0TJbNGquyza4=;
        b=mEeLGdILxddied5+J5ytDjMBs8y/z9lOnZA92CI5+T5OGiiKebFbIyyn/YflaHYzhy
         loWwkNlUG2Dq9A5lFvCmZDsFKmAzTaEW98Ibzg5ZZMXpRarIj7JPYzW6XoFSe+5lJrzg
         7ULt5y+KeoFQ83fNf1h1IxX9H7W4yNXa1Clg4KI8i/8RMp5Z9/YoacwDqYd0rlMkTk3V
         4amUgodqLEUZVYv6Ej6/qUWAdXR4aAH/2In4aFQarkv/ThxmovVDsUlgmtpMldkp0NwI
         ySJLfF6gd9EbGhEFQ0aAzmkqaAfY54hHTCJ1dPQb8E0C26VEiOmSFmIfthQ/3COuHOXw
         FPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403589; x=1795008389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88rAM2oHhFqNhLiz8qe8zFsCZuZ5oGk0TJbNGquyza4=;
        b=EFBXZg64VpWeqx6AuvMBWEoYm/OevLwDOm210D+zxwGPlEzhSu4kn4Xv2elzayXx+w
         QZvaNzAG5NNwr18aVtltP42PdMGJaI4Qwju/irbgBZ87uktet135q255/MtIvN0hZc6o
         WFWDnK8RohCDkUw9TWHGMDjJ78Q+veyY6awA6jI/TveaAsX+sHUJEBvFfXAMgiOiT03f
         YCCKxusww/7BF9t9FvUKh1qBuPJhtNQRS3Ugui1zNv0tJ4WS0OPOq470+LGt285m64HW
         K3JXdId0hL9vs/KJx9nIP1B20vmk7UNStBAL99SZSqOQDUh14iR31vvAHdz9L6rcLjy3
         s5rQ==
X-Gm-Message-State: APuU4Z/xMolFwJTfNckNyF+w+RvgG4v6+Pz+UphsLCIdHnWjmV2ECQxx
	nPRjpEbGJ+OIk/V3dJllv+SbKHZsHDz5UBan2Z4bJ4Y4xzxbRGj3xiLrsALtLgqs
X-Gm-Gg: AYBFou2f3FiVJ1Fhv58T7S36gjrvF4cYPOr/zTvU9nPK9s3roWqkvTP2cUpwwXtAB64
	0gGs49DcbinGEJIu1r2NbM/468NKum4Av6+U9I1qsrS8dU2SOUeJguSSx0Al2mTEOMzia0b9wzZ
	pAvzIc0OGMy7bScPMVW20u0CHF3QKtXWWbeL/qQVFAClYB/JgLg1xkceA2JJzadmZD7LTRKbe2+
	PSdjMzU1YehLx1PDjCgKA9Ov9M4OQfD+RG3/K/1CnzDZsbakPJ88oUttkAEp3lSRbUQ07+qNYkI
	5X8CGt44v4mvTtwVK+G46aZsSpKBT1OyfsH8fRr9+x5CfOGeufV4DdTL9aPWE4biie3sP6kyrZJ
	rz8gfkeLgiPRvNgq96UtVVOQvs6k7MYl5IryNv/zKCAbnt3rlxsYvWXCdBe/6b35k/zAUGHO88x
	D0tLcb32oBPbHlGve8tn37ZQqV0DJojbEg28O1VLxP4se/sttyhOzICvM1Uu0jUADOixVbUoOq1
	IX0bD+XbvKCs7vB9JINq7FanUPVxlVyhIDt9hBZ74KiStZSPNSPYUxIF8bc3OL2q4L1UAttIFZ/
	Rc/2g5hOGVgV1PLNIzKO
X-Received: by 2002:a05:7022:2510:b0:1b2:6844:25c9 with SMTP id a92af1059eb24-1b3c024a16amr3072928c88.3.1794403589243;
        Wed, 11 Nov 2026 05:26:29 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm33053502c88.10.2026.11.11.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:26:26 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v5 0/3] perf jevents: Check the JSON keys a table may carry
Date: Wed, 11 Nov 2026 13:26:19 +0000
Message-ID: <20261111132622.2349165-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041045.2031464-1-takano32@gmail.com>
References: <20261111041045.2031464-1-takano32@gmail.com>
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
and the object is built without whatever that field held.  Two of those
are in the tree: "PublicDescrition" in 16 entries of an Arm table, where
the lost long description repeated the brief one and so nothing a user
saw changed, and "BriefDescript6ion" in one entry each of three AMD
tables, where the event is generated with no text at all.

Patch 2 makes the model argument optional when the tables are generated by
hand, and patch 1 names the metric that has a name and no MetricExpr
instead of failing on the file.  Patch 3 says which keys a table may carry
and checks the tree against that, instead of reporting the keys a run of
jevents.py did not read.

v5 rewrites patch 3 rather than revising it.  The review asked for
something strict and simple instead of a near-miss heuristic, so the
similarity cut-off, the tracking of which keys were read and the wrapped
objects are gone: the schema is a list of 51 names, 47 of which this
file reads, and a key outside it is reported with the object that
carries it.  A JSON Schema would say the same thing, but perf's build
would then require jsonschema, which it does not use today and which is
not in every builder's python; the list holds the same names either way,
and a vendor that adds a field adds one line here.

Patches 1 and 2 are unchanged.  The check is still something a maintainer
runs - make check-jevents, with JEVENTS_CHECK_ARCH to look at one
architecture - rather than a step of the build, so the generated tables are
byte identical.  An architecture that is not there, or named as a path, is
an error rather than a silent pass, an object where a list belongs is
reported, the name of a metricgroup is not treated as a key, and a small
perf test runs those cases.

The two misspellings the check reports in the tree today were posted
separately in November.

Link: https://lore.kernel.org/linux-perf-users/20261108183846.3804875-1-takano32@gmail.com/
Link: https://lore.kernel.org/linux-perf-users/20261108184600.3810059-1-takano32@gmail.com/

TAKANO Mitsuhiro (3):
  perf jevents: Name the metric when a MetricExpr is missing
  perf jevents: Make the model argument optional
  perf jevents: Check the JSON keys a table may carry

 tools/perf/Makefile                     |  13 +-
 tools/perf/Makefile.perf                |   1 +
 tools/perf/pmu-events/jevents.py        | 228 ++++++++++++++++++++----
 tools/perf/tests/shell/jevents_check.sh |  62 +++++++
 4 files changed, 272 insertions(+), 32 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

