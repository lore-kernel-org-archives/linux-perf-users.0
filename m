Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364493;
	b=tCAiTMq3NGOShFZIKhZ8awiIcAzlNhr4250V4tG6jo0RDxWkDOKQV2iyBhpqKRjj/x/7
	 VkYGRzoGMMS5br+RP4i8OF4F4x8EGePw/QGnmPpW0uMbAMQLlNzls5S9VPVzi6IHnzHPy
	 j7m6bHxUHyi/r2E0z06udehVELbwQlVBpTU71QnbIYpOcp2cuZZEQTGAgex4bSIENDmD7
	 V5DKxOhaN7ClULFZ0YGciW9KUYEBaloEEIg0rTg1LFBWRrfZe+LcWiAkX7gD2swC/sPGm
	 5ZPtA9Uza19WrUUJKrg0tYhpoGGXbSGTyQTNc4lxrnri168WMSSOW7LnQ2iJ8nF0SIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OMGGB93EmlGueDkjgwnpuuzgm9iPw+4Fv+LYRo7duqw=;
	b=mmJ+zFE6RQ+YF800LHqO3KRtIqjCGbZDkfv6Sqkcd/iLbe46ymbQc7VLJlxMbSeUPJ/T
	 VHlUUmOU/dAWY0fx2zcbGYofx8Bf5kMPM6svN5jW+Nhx1qC6LI4a900COKbHIBorPvDSc
	 Ff2V8pWy4DejBFfUebEgasHPoYw9PZhjB/QnfQ+xdZVgF1o5RUXVzGBXky52IErZuhwlf
	 hFJ/07fngmzI+6+ULU1i8y9TAE6e6eupyEOpaOEYmzjVTFX5u5gJerkGZ3Pv6SEY82XSA
	 FZE3WpZj+KJsFSIkmKvAthqH0Tn6SSLEbkIQ69Ofe+SNTi+0pV/TfYmJ/GNcy4dEkpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQbjFscJ;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A79606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A79606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQbjFscJ
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so4660317c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364492; x=1794969292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMGGB93EmlGueDkjgwnpuuzgm9iPw+4Fv+LYRo7duqw=;
        b=KQbjFscJ6nxNj6n6zH9SGuGxcM1FDMdKtHtfAd+bQHPrlmN8txXBWsiTzSvxeU8Lri
         kHh6A4GjBk/IhxdpRPp509s+JZxFuzh/f7ZRrIQu6taiVQ3tU7rkkfa97R9+Ko+JIoT7
         qjgqke8vlQ9L3m8cF+RL4HT3GE+rvYidvqfBTszOmqYYVAx/BkXZRmxBXMeYudUXRoPX
         R/wN+1IkOtgQ7/COFZqcZ9tHcf25AHINVuAMMUW+krFQ2hqqMqzeQbxYv3fcvFlQ0z98
         rlvXhC8A3hCZNbZdaLRwdZZjXZdWV7lQ0Nieao0m9MewEnb9itYQWmWbkXLy+93/31Uy
         PrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364492; x=1794969292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMGGB93EmlGueDkjgwnpuuzgm9iPw+4Fv+LYRo7duqw=;
        b=Rq7q0Imj0YEAShkzPpbmKIw8JbP+pOsX4+sdylv39pYVuL6yBD4zzWBDpYsgm351T+
         GZY7l6k2axhT4eG/1Fv3CkKS6eorU7m1LGnZl2ngLyRJhsaQSHXPBvhnTiIBePEsWWGj
         49lDyV54/88VnJsr+SBny8Qu3mhcLiXaxd0Rr7YHpnYOqQPEUfSlCmv9bF8/gscHSNVR
         yiJmJgA93lN6TWXNHF9Ku/8CO4s6HC+XBBqMYlare1v22ozx8kKoMvLBOe497S+Z7bq9
         05+jvS8/vD3st6913Hby4TgVVocCjnNfNslZAC6Cpy/w7iVRVqy6WKtFaLUm9vF6KwVW
         v9pw==
X-Gm-Message-State: APuU4Z+EASHksnssoGD5TpmLMrZTJKvmTnhKmJLNjQZM3QkbSzHfq8L3
	/rMVqrgRoAVHAIjGRmIs2fu7vudgskcTBfEyGgDPsMuR2+ZiMQxggxbMRRVpA4cp
X-Gm-Gg: AYBFou24jDbW6mlEWDWrDhBToIY5F/EMs7Tew4s1Jk6oMshD94W1sOVDy3gQq6UnZ9I
	dE8OSHAgFr3+M5ROvbHE+DzE/JaafoHH4oyDdOGo41b/SSdc+y3W+Ub3VLUNpE+vXAyKblAsO17
	3DqLV4mMlExc44L1BEEOcCEYf7WJycfEakEuQCQMBIMPTtlhFo3HCsw9R4Ah7FKKScIuESIRDYy
	3xen++VhhIJ8+DAxd2vMoyWutaRVXBMJnVr3a0780LHWyD6O2fbMP2gV/MZFMFJ3QOIRrVgC01k
	mI5XT1cIFSklpb3R3ym7At62foY63jVBQwJ1v8EJ9RO6fxOClJkYG+m50oyUuQN36YVDxveY+BL
	odRvneqARuSgBmoqGHsEbqpKWPDd3QapLDsu7hNGQp0v0O13XUmso35nJcKvmsraRHmt8FW1NSI
	By7F5/EhFb8sicwlObRNRkzObF/5J7rGNZKUaRoNb41Vl4dKDWXnChQScByNFovrkG87WTj27ba
	Ri+yoC0IvqIyReONaS+r+dYHjQRfzHJOpuY8pyx8bTYlUFdL9jcwtmp9jdzR0zqwgWwDZ0EEHsu
	G4CrnrUemJM5YZmc0eh4jBtLj1OhYztPLocXJ/wIHg==
X-Received: by 2002:a05:7022:ec02:b0:1af:16c4:d06b with SMTP id a92af1059eb24-1b3c02f36ebmr1120247c88.10.1794364491577;
        Tue, 10 Nov 2026 18:34:51 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm11752369c88.4.2026.11.10.18.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:34:51 -0800 (PST)
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
Subject: [PATCH v2 0/3] perf jevents: Report the JSON keys that jevents.py never reads
Date: Wed, 11 Nov 2026 02:34:45 +0000
Message-ID: <20261111023448.1970467-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110222250.1864777-1-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
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
 tools/perf/pmu-events/jevents.py        | 391 +++++++++++++++++++++---
 tools/perf/tests/shell/jevents_check.sh |  68 +++++
 4 files changed, 425 insertions(+), 49 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

