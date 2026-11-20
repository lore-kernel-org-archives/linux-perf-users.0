Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182178;
	b=Ue+YkWItm+yHxvi/3VY2IAZn7l3gwIeBfX7HPAYhsHZUGzpQur07F/2n/NIa6d/3Zros
	 lMj+F/XSAXCtiBh/LW32i5Fa3GSNaAH6ALe+mQOe8mdY/KygktSRtKpfXftJ7nvL377PJ
	 vso+XCTgx7TvaYU+zr9xdNQwQk+xx4/7/PDUZWbTMpD5FjqmfXircvyWJIbZtdeor79zB
	 brIOOqHl9dvU/V93abPwoblLRBA+I2+jc7b7fNupnPJV74Drq5/C+ndKJgAYkTvc0CA7W
	 eVFI+wrQZ7sFzeP6BDfck1XdJEORC0WZDyH6mzJVDFDdNkDABW/ri6Zmky/ata1BpRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y8Ts16+pEgKO3za6EY6j5FLRvh5fbwbzMTmSXwpDQqU=;
	b=dl2QfW6Wk/UaUNF6UIFlcKP02KXnyrX+cQnWP364CCgXChLFCd0GD1fzXfUQr8xVKvSD
	 Vg0p0uFPpuJlUE+pfRlvta6wrzK60gRw21tfBf/VFvAzsw7tNb4NXEPyoCKqT4M6u74Sx
	 /EtonVPQXwXvBNE5k1SXLJqcYk+B3hRFJQBGoNnsbKIsPz6vPEsClZcP5+swjiNvtgg+q
	 P/pPJHlaipbDcfWBK2BMKZpHUFKFYheSq7wfNccAVxQH0grO2FEvDYGuWsb1JsiMw+Fo4
	 Z6QTY5QWs6Ge4Otoh+3XIX9seDTuYgUsQM3H/khLj32xuN217CuCDLIdrT718LtE7lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XuxFIVtT;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C760A2600
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 13:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3C760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XuxFIVtT
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-380c28f9e35so1879975eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 05:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182177; x=1795786977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8Ts16+pEgKO3za6EY6j5FLRvh5fbwbzMTmSXwpDQqU=;
        b=XuxFIVtTWzsZyWpiewZ01Z8a05VnZBztKpAKQwWQvIS5TtcKHvnFpw1C6t72RbgHQj
         qbJ8i6UsUYOc6ccJcT8p5zfVUIU62k3+/f6mUmK1vnDyX4iccXdgWeXj4dFzJm9G4Uqk
         2gDZA9IBYVFoWoCdE3S7aQQadJRVEgNrNKFMKHFXaVb8E/rX5oAfxCLq0BUbw+lkgeiN
         A1O4JjEOskVV9y2igd1bNjIoTThdfVEiouA5ssykR0JxG+27FeAF3FtvsBsgWNQv+ojy
         DdWZ9rTIhZfD5yQGHGEfo7mGWN6rvEMm89Sx6ZKCCDSRo/2THCGplRwh89NtoGY2NSaT
         qnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182177; x=1795786977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8Ts16+pEgKO3za6EY6j5FLRvh5fbwbzMTmSXwpDQqU=;
        b=ezdCwrp3JjBj+bqvSxcXrrp6xEIE8Da0o5kKKqRq6NXn8liWxYL8LXL1M2V+rEIJKe
         WVi4x05yC4PuW684MA7ztKzxY7qeNAp6gmcP64T+9xRcKB+AFapX5JDJoIGv8v1AA2lP
         KsArq5Roi3vB4Y628vx2lSIfutf6x0X6PIWh6RE00ikcDXMBgyriWn+ABmJznPQO0He1
         yWg79H4uFBL6bCN+rlcbp3UceB5nf4GtZNCou3p54B8PtXvJPjOZVfuCT2cf+BK0wt2r
         +gViV0nRmQ9A4PkuikdjbWJR/WG+YFSiUebPE8rXBQUO92ufT6tyx+PRmCFr0N3ZLkkR
         Humg==
X-Gm-Message-State: APuU4Z/oQzulQSqcHdjdDKIPP21BxptZEV0Bx7rwpWdfevNe8z7hEwA/
	X4GkypWSHsADNIXoRrISPYrF3EBGV+1EA658a+AbzdhLk7c+Gui+6yeKiYZ/uzcq
X-Gm-Gg: AYBFou1tXG6cXhkIHYASeGbd/RoEDsaF012cAOo/MpDXRVFnOZHQCbtQc017F0fOFfo
	fb3Qt5GkVxe2FU6fv6hhhj+fMMs93wtPCNLJaMIjPd1dXa7NycRudnb0vuuBy5I7wIGlXz6iL1S
	yrAz9hl35xTrK6twQ6pB6MmDLZdGkN3aWR3oIAN4DZKVaQa62q4Itu0TQtwkHZV3X9MJqObQ/Z6
	1m84RtL9jxD89BhhDRt1z7vTeAG+8mZ0nSv74jJU3QOCjgUpKlYklIBu5mUpe+x6ZBIFDQUybZS
	f7I8fWLWOeCga5DkmYrmjsMZc61leIOPRjRmwqaLWYk3Ggclc+rkgGwi4MHB/D/pzqIF/vJuRe3
	UnZZANLWtiaGdc/dqa5f7wpvc84pHm9Aj5GzLYWGAP11l/moFInp89pf6uRdYe7PcGaUfaQggMx
	/Yy+/fjAUrtcW/U+f6pU4X15/Cla/dYyEtBU87QcMIYwEBwgEh/eLH+/NHHF5x/dKXerHVlG1Va
	2czrsCtOYXRKHyEHK44DVCMMDwY/JouRCJ3Zs/C10dtwtgbiVUKRvwRYPMgHHLWBdIh9V4H4Q5q
	vABsTpmwXbXc7XPUh7e2
X-Received: by 2002:a05:7300:51d4:b0:384:fef7:5876 with SMTP id 5a478bee46e88-384fef75c78mr3949500eec.24.1795182176981;
        Fri, 20 Nov 2026 05:42:56 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm9590857eec.28.2026.11.20.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:56 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v12 0/2] perf jevents: Fail the build on a key the tables may not carry
Date: Fri, 20 Nov 2026 13:42:50 +0000
Message-ID: <20261120134252.1036963-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120060931.711483-1-takano32@gmail.com>
References: <20261120060931.711483-1-takano32@gmail.com>
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

v12.  James asked for the raise and nothing else, so the try/except
plumbing v11 carried is gone: the generator already names the file it was
reading and the exception names the keys it did not expect.

What is left is two hunks in jevents.py: _valid_keys, and the check in
JsonEvent.__init__ that every event and metric table goes through.
(metricgroups.json is a plain dictionary of group names and is not
checked.)  The test is jevents_bad_key.sh and checks the failing case only.

1/2 is the prerequisite James asked for: the mainline tree carries 19
objects with a key the tables may not carry, so 2/2 cannot land on an
unfixed tree.  It is the two fixes posted on their own, squashed, so the
series stands by itself.  The AMD half went into perf-tools-next on
11 November; the arm64 half is acked by Ilkka but not applied.  If your
tree has both, 2/2 is all that is left; if it has the AMD half only,
apply 1/2 with -3 (its AMD hunks are already there) and then 2/2.

Measured on 1/2 + 2/2: the generator run over all architectures, over x86
alone and over arm64 alone exits 0.  Putting EvendtName into one AMD table
makes the x86 run exit 1, with "Exception processing <path>" on stdout and
a traceback ending in "ValueError: Unknown keys: ['EvendtName']".

Changes since v11:

  - the try/except changes and the sys.exit() are dropped (James)
  - the message reads "Unknown keys: [...]"; the test comment says the keys
    a table may carry, not the keys the generator reads

TAKANO Mitsuhiro (2):
  perf vendor events: Fix misspelled keys in the event tables
  perf jevents: Fail the build on a key the tables may not carry

 .../arch/arm64/ampere/ampereonex/mmu.json     | 32 ++++++------
 .../pmu-events/arch/x86/amdzen4/cache.json    |  2 +-
 .../arch/x86/amdzen5/load-store.json          |  2 +-
 .../arch/x86/amdzen6/load-store.json          |  2 +-
 tools/perf/pmu-events/jevents.py              | 24 +++++++++
 tools/perf/tests/shell/jevents_bad_key.sh     | 52 +++++++++++++++++++
 6 files changed, 95 insertions(+), 19 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_bad_key.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

