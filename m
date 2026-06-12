Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5B3D34A2;
	Fri, 12 Jun 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303065; cv=none; b=Ag3hilJn2MG3vupWEgAOXblJJxV1bJ0K+vXhd5EGIwUfHCdXzGdQ5dbya4yE43yQt1ZTAIRHZEYfYhIuchjyGXAK49NNtILWf2abxT8wOENrDK4k3VZ4NSZgNNgGCXvw/E5rHTKjWky+wJnB99nR5KloN7BJT0vZ2NbK1V8VWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303065; c=relaxed/simple;
	bh=sUzViC1WFVYEcIbxbF8T56nDE6tG6MoOESqkY25KPgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGkrFmepxOWO9F0NjXoNaFlj2kn9YOTrGkf9nxBnp4jU7buZ2Ahsetjn5091A9kuY6slFowKCxQETMZigd0Gt7HT4EGopBmoqn7ofSbXppTToaefmrdBgaOxDf9rjkmEn1bXoGdN7HtxlQ+FHYdvQD+qtJ4BvlzTI++LXzD+5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyU7Rnz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyU7Rnz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83EB1F00A3A;
	Fri, 12 Jun 2026 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303064;
	bh=uKihYxeSFiFhXjPKrGLJkuVtnc6h8mryrIf11VT9gME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WyU7Rnz+/ZVtPsnA5rQ25iOy3VCrW9NNr4r5A3XwxoKloY3F6h3C/XDa1TSNkjmsm
	 U2tL86EVk6LMJ+AATSvLmiRVie2//NQbsb7CTaq+KuDEIIZRHfMbNVOzgZI+6SEAFh
	 Q3H6eg4wd+bQO9IWojqu6IkphobQbDpw5/111fzIkj0XNKtYTOaHtUv9eoxg8e2u/i
	 gktrR+5j62q1dyEmLd/CL/n3y8bXi0P6mPbrbu2NHCGHGkGgtHdhkWXlU+lKqDEPA6
	 LdrIepd/5vfXVgRlBb1AQmmpyegBKbCH/wMJpiWM2nGORQT52KuVWeTcy8CG5lYkZG
	 K2YTFNsTJW8Sw==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 01/13] perf symbols: Fix bswap copy-paste error for 32-bit ELF p_filesz
Date: Fri, 12 Jun 2026 19:24:00 -0300
Message-ID: <20260612222413.40791-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__read_build_id() byte-swaps 32-bit ELF program headers on
cross-endian files, but line 178 passes p_offset to bswap_32() instead
of p_filesz:

  hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);

This clobbers p_filesz with the already-swapped p_offset value.  The
64-bit path on line 182 is correct and swaps p_filesz from p_filesz.

The consequence is that the PT_NOTE segment read uses the wrong size,
which can cause either a short read (missing the build-id) or an
oversized read (reading past the segment into adjacent data).

Fix by swapping the correct field.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: fef8f648bb47726d ("perf symbol: Fix use-after-free in filename__read_build_id")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-minimal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 091071d06416e290..f4b0a711a62cf3de 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -175,7 +175,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			if (elf32) {
 				hdrs.phdr32[i].p_type = bswap_32(hdrs.phdr32[i].p_type);
 				hdrs.phdr32[i].p_offset = bswap_32(hdrs.phdr32[i].p_offset);
-				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);
+				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_filesz);
 			} else {
 				hdrs.phdr64[i].p_type = bswap_32(hdrs.phdr64[i].p_type);
 				hdrs.phdr64[i].p_offset = bswap_64(hdrs.phdr64[i].p_offset);
-- 
2.54.0

