Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368618;
	b=CBX1rmPRf15J+MTqY36vH1kQofHUSc4Q0ynOtyPhA+rF1rAwm4BycvUE8vQNarIO4qnr
	 sqP/KXfz99wJ2Pwd9vvnLo11rNlPgMnse7i83J/tvcYBnD7c8SjcJBl50tr9C3myN0uhK
	 uJyKvXnV7EUF6VJN5rNXt1rlH/d9pYr7jyRlRLsiFHDKcOh+JobZRGtugp8YCHd0XFtmP
	 gYZraJPMxGu8s+yxEOYKGtMnKFM2QT7lVhmcmhucG7KyET7iDffcguDJoBcf0U5jkiR8m
	 e/4mlxrG36f855JeGi8HL9xkqoOttwgtbk9nBaT0t2I+eyGariuurNx5vwphLY0h0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kwYmMiAK1P1mFFs+hIJi/yGH1cRLg6EtQq/T8ZaVPig=;
	b=3+chDDTTYZe+OazWjBL34B5ImVLUjj0xRmYqWB8xDyAYSN5y9Nd983WkqFkq6ksSSEaW
	 dmaqPiC9c9G5PfQ8K2RxUdjqfbuRiD0b8Go+07IOicSGYbKoNS4MrJViWcxizZW2xkKsa
	 QJaUk88Ue4619DA9/PiNNfvedFNpyzni7JE2TvbducQ8ac8ARIcTSzm1oubhWl2mYGGhK
	 A/QhKUibeMzwquxZyUkbDhcSXEp3b3wfD892fiJSi5ZycXAOCWqdMgD1fxXQwaFa3jTzG
	 I2bJ+bQicQstZULWmfKpVjkVEk3D7EQCkxrkcUKE0yAmCOlIrYnEY5eduySLBTICnRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D7HkTN/U";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199F606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8199F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7HkTN/U
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3720addb068so5000600eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368616; x=1794973416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kwYmMiAK1P1mFFs+hIJi/yGH1cRLg6EtQq/T8ZaVPig=;
        b=D7HkTN/UMhUlUGCGHstMsM8DqUu1y/DIEAddi662Y3nvS7TP417Zhe6oLXHZ2H8Pa1
         +SfmGE2KB/mOVHP+TJRSbhwuTpAZjsJLVSsXHT171CWgyNloUDuny/GegRV25gwJbyfI
         K27oacP2Cv4gptuEfj+Wj5lM3m1KLSmYTlYk9v5rDbrfi43SwDzshpSIDvKGQ0cMUmBs
         hRxwo4ClMnua1dCGwtZvHMyRhdPtJNbu919NiDDoZGQWooaY/cdKRVoECrOyg1xXxG9V
         yHaekrLyzkdZW665AgMxCLxyRUsmpIh45PKdatgN+zb73H5fqw8U3c8VNfduEZ3WwwY6
         QP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368616; x=1794973416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwYmMiAK1P1mFFs+hIJi/yGH1cRLg6EtQq/T8ZaVPig=;
        b=xsRFVKM8hcmvCqjqATR+FFu/Bpq01SULB2zuFoxrjM1KKZEBW/T1HeEafTYrsz4CSv
         rn+6DPeURAAaHGKoe3wQlmQ0Uq+kCDvZn4V6zq1biUZ315he8R7YxVHqGu9YA5CVGjmg
         lXxB3VbFCWnULhbCrYusmAgtugkafl27jxjgHAVFSfrObJS2nwaXNSbnZ0Zg2cpZZ42D
         QGXcrB5PfNesyZC/jpe+QojRCO3/0LTmZV/eyugVU4bYiujdjjXezU4a1XQomj9LSRja
         zHOqrP72iDP3azIk5J2coTX5LWJizepmG3gLPht6Mg4Erdh+1lh856d++xoLv03jtFep
         m7/g==
X-Gm-Message-State: APuU4Z++GUz38O9CJu6WlMDLKYIaTaL1cAHc1kPekbJsctllqioOTlbn
	MzUAYoc+5R7Dj15mWrdezbpN+7JVyQBc0QzfvXr2umCRUoR/4p/waYZ7/uQGeyzM
X-Gm-Gg: AYBFou3Igh7KRBIgQUEIrGtf059RBXLt89209ITdY0dXtUR8MzSz66q8mixqH+fiTYX
	GFn2OROrnLwZCsI9p7Zn01rx7I0wcPaokUwuNSSMMQmd4Cvx0nM9DUOx104/KqU14PHi0EEQxti
	9WD4v0oLrlC6UeVnvG6WAnmEv2IvYXOF1MPCx0q40oW5zThrD7hSrC3jNYyX3QkBGNVarQXMN/5
	LBVBa+v98qQOLdUFwQmUkwduqW4yXHDKTf+59QDMjabMz79U/IwCO/lF7WWW5crJmdNuTh9j79P
	vmGhaPIZFJMYwpZF6lSdu0Dlg2/lSH5mhQWgrpR0N7kMr/77beonGCtar2p5PiMRxCOxy3ELOCu
	99Yvgf5/bws8pAozPCQOCTLdnMgVVYLWHgFdd25AELVwa15ej/nFPZrA9YnIMdgLaBmp5CoQ1hX
	90crxjzwEnnZvIo+z8g/fYToaVbYAqtgU8zQJz99oosoQkia308iIk5G1JQWZGru92Gt86zIaoO
	A6MzjGbYl/fxNjDQ2o+F5wxjyblUvmhCcthP17PQ5clNZxcbZy+TFLU61Ihh2fjqHzIMh3FyPDx
	XNWgFNcOKU2HkopBLA7xxQ==
X-Received: by 2002:a05:7300:8a19:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-376854b83d1mr1582555eec.9.1794368616376;
        Tue, 10 Nov 2026 19:43:36 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm13498026eec.19.2026.11.10.19.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:43:35 -0800 (PST)
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
Subject: [PATCH v3 0/3] perf jevents: Report the JSON keys that jevents.py never reads
Date: Wed, 11 Nov 2026 03:43:29 +0000
Message-ID: <20261111034333.2019831-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111023448.1970467-1-takano32@gmail.com>
References: <20261111023448.1970467-1-takano32@gmail.com>
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
 tools/perf/pmu-events/jevents.py        | 397 +++++++++++++++++++++---
 tools/perf/tests/shell/jevents_check.sh |  68 ++++
 4 files changed, 429 insertions(+), 51 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

