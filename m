Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C192ED154;
	Thu, 13 Aug 2026 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582183; cv=none; b=QBkpHDLBwNgY08/vrh9728v2AuAM5835xC7y8o6VtFvthcC56dKZfCVYf8g07PeJSvr7DQRtngAHPilzi/MTFov2aMg0e4U7mE3C4GaRS8zb7ylmXqZ8qN8njpkSvthyiu/hs55HAiJ/jBJTWRXySugd91pEfcxlmmiAiV8Q+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582183; c=relaxed/simple;
	bh=KCitQXu1asSsUX1uGrqEEM4zSjpm/F9WtsXOWN624/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrAPc0r9xrFdKmqTL09drcjFBL3lhGdO9a4hl3DpEn0ZKazhJZHNMbDfSFjK7yucAxFQWfMBKVfFY8PGhohrRxUaVQ+0ofujxCYM/IOQ+zfoiStg62gJnxDqpYsASSAtx7d+83QRPv2JNIzNJ2CL/9JVaQrLepQgNv0PfPAhukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Z6Tcv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Z6Tcv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD1E1F00A3A;
	Thu, 13 Aug 2026 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582181;
	bh=bJKMxMFwfRyoD41QPLnMNGozZrZBr+GuKgym/EPJZHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D5Z6Tcv8bycGzobt/XH4zmCEguikJE4qpc/IjJUrqai7G+iqNjox3MOc7fqnhbyXn
	 xX775MnaCl5t4fei9VmmZJpMkdyc+59CUc7Sax5WmM/iSr0pT435M/mos1GfPonQTZ
	 6/ZVCm3M7RatN5kTN+of8fIkraPFscPOv55oB3gOvayhOQOhCF5dfrj9TKYDGQwbnL
	 Is2BhWTCrg2sbMfHhK8Bu6WYJ/cO36qnHqap6UYrQF4sKHDr9ar77huDWLcjoNbhe5
	 p0fdZhKfPteFetg14MJjMhrGo9idDHsQggNQakuV5ojTxrBi4MS9iAWZvppCGxqPXL
	 MEOK36wDMtUdw==
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
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/5] perf dso: Guard against errno==0 when dso__get_filename() returns NULL
Date: Wed, 12 Aug 2026 21:49:20 -0300
Message-ID: <20260813004927.16738-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813004927.16738-1-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

__open_dso() computes fd = -errno when dso__get_filename() returns NULL.
Some failure paths in dso__get_filename() (e.g. binary type mismatch)
return NULL without making a syscall, leaving errno at 0 from a prior
successful call.  fd = -0 = 0, which is stdin — subsequent code treats
it as a valid file descriptor.

Fall back to ENOENT when errno is 0, ensuring fd is always negative on
failure.

Fixes: eba5102d2f0b ("perf tools: Add global list of opened dso objects")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 2309196d8df3111c..fcd4b462992be6f2 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -640,10 +640,13 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	mutex_lock(dso__lock(dso));
 
 	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
-	if (name)
+	if (name) {
 		fd = do_open(name);
-	else
+	} else {
+		if (errno == 0)
+			errno = ENOENT;
 		fd = -errno;
+	}
 
 	if (decomp)
 		unlink(name);
-- 
2.55.0

