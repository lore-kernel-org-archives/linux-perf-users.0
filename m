Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE333556D;
	Tue, 11 Aug 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470715; cv=none; b=fpQGog7iuIzwzttn5OBVz7YRBdW2Qt9H3LNxWNTokchX2B09bKdLXDHr091aUlfcQYppp723Uwg1/i8hkxDzmHclshycbSTY8floCNfnPBkMECkWfoyAgb9kM76KVhsvkCpHWLhM39Y/+i/xEOlI1mCyLlhglJluAlQN2jGaB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470715; c=relaxed/simple;
	bh=kzk5CkX8RdMqsObJo/KcrtAPYLjuJEBMsALxhLkWy2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O26W+Ohs0IkalzKYUGVTvCNNib/KHAj0eVR+G46Q5hfFMDkcV/COTJlD4lokyryOYLwjAJH3O/LbnWVSn18jHtgx1TzR3jYLzJSbHNtO+H0IIz8hNNKQg+N4ErlIfDA1KK4/Co3aABmMk3aACnV0gnohNyDZQO5DAVQ8X5CJ0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWS4vQak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWS4vQak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CFF1F00A3A;
	Tue, 11 Aug 2026 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470714;
	bh=bAWbDiaqUHu4M/1lpQvabgGT2SgHwRAcAZ90fggnios=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWS4vQaktsmJrbZZ8JLm0VXNkfioAJUANJtMzIh6BB7Cb5egf7Ee+xlpzW8aNaJov
	 ggM5GSGLA/OgF4cfhkYNMbSdetpzr+/7LWL+jSkmg6zGUHfG02hjHEj2IBMJE3Hm70
	 LGOOtPahYeHCkWK1MOCBcZoZVn/HgTmLfFIdMJh+jMdV6kkHxCtqCieAPSDRtySUNz
	 mk6VMhTyG0qgpTaYf7fcLS4mo9BxrfPrQQLKqQyJK7WPnqvyfqKgjnzQs/IoHsEM7k
	 6pJwR+khDpZkvTVkm/C7yiFixwr1hfmfaO5dqw0SpcZqoHXFmcQhTfpDLYo2Os6JxL
	 iXYe1UCevFvZw==
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
Date: Tue, 11 Aug 2026 14:51:30 -0300
Message-ID: <20260811175140.7235-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811175140.7235-1-acme@kernel.org>
References: <20260811175140.7235-1-acme@kernel.org>
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

