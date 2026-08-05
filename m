Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B62F7EFF;
	Wed,  5 Aug 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936706; cv=none; b=ulCpJ+4nxr9lZ0gYt1uX+rZ7lhOnT8u71RFPgqcAzbkWMxvyDz3I3O38Ac4SY+TE+UGSdHVz/jy6IAcsU9N6ORaeXTnYfJ/KBSK7nuIEBAqJlYkNe5r1516K5g+F7kAtpYM3zBuDCZd8OeZQV2z7NGIbyVBhHNrDAP9B/ibkA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936706; c=relaxed/simple;
	bh=geZvGpWtCpSHvuOy88Iz4tlsILhjVeHi8M1bwDQRjbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWA4o5RTBVbGlwSSqfE4Eno0cxg4YpYwq/vl+1ipaWAeR+54hqfnuWB9y0QtQkI7LaC010XhEhSO8o+GkqsRY34xn0+ajE/pndejAX7kuulOVdHCvFIDrtTK/LurgDyv6P23mUVhxJEcYQUSDePXkNAFVXHIhtZw/k+s+zaO10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODoAKbcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODoAKbcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7BB1F00A3A;
	Wed,  5 Aug 2026 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936705;
	bh=AMEg+V1cxs5MY7/YSPVJVJP2Y1cO8+LuG733zJV/BTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ODoAKbcwOingCsjlbCt/TCNthqLQOpEa5wU/c/nHGvXwclBsKwB1DsQnz2kBCoZOq
	 5h2EWWwRWQJRBsvd6kuEupbexpHAjfiTt+Gpfp4ZwslurQ/DsYQLKtWwQw3Jv6540Z
	 nJhfj0+9qbsVDPr1RUvrA3qHoKooEepYTm240uJ1AfqleSV11cWBcecvZ41vwDn0XH
	 pney/ke4nMeOIgFxGHPrY+Wir6KpbxZi8yNPAXVyWNuLplDMGPV4n4sQxOCPZs1iqh
	 s1CoUZtnKZnRoG3ZZSJSXNTVuhBJK87EnJ2MF8k/AoL8Uon3bVmE876CXUbzxF/MnC
	 7Mh92RrrQYocg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 06/12] perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
Date: Wed,  5 Aug 2026 10:30:05 -0300
Message-ID: <20260805133013.235016-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If the malloc() for the initial read buffer fails, jit_open() jumps to
the error label which calls funlockfile(jd->in).  However, flockfile()
is called later in the function, so at this point the stream was never
locked.  Calling funlockfile() on an unlocked stream is undefined
behavior per POSIX.

Split the error path into two labels: 'error' (after flockfile) calls
funlockfile before cleanup, 'error_noflock' (before flockfile) skips
the unlock.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index fd11e07bf00b7978..c3f11d1c1d76d6c7 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -155,7 +155,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 
 	buf = malloc(bsz);
 	if (!buf)
-		goto error;
+		goto error_noflock;
 
 	/*
 	 * protect from writer modifying the file while we are reading it
@@ -244,8 +244,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 
 	return 0;
 error:
-	free(buf);
 	funlockfile(jd->in);
+error_noflock:
+	free(buf);
 	fclose(jd->in);
 	return retval;
 }
-- 
2.55.0

