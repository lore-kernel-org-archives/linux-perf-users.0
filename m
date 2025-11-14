Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B5303A03;
	Fri, 14 Nov 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112556; cv=none; b=aoDEHLi+MRDSHCXjPPZBtSAb0X3naKWmnnX/D7bLNqZoOqOiaqC8CJ/Z6CJfSeuiYgZLElqoLfR/UUf7oRurVIk7PIlFkAfmxfNYaevmu+zWL/D0gmX9KmfE1u2WMXosIDVrIN7DkHt50SFptFMppR5wCfFuy/Zs3Lae8vicqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112556; c=relaxed/simple;
	bh=3WNSCRqblIMCNzTE2n1uMeiFH+oTUvRCzErtYNIlyHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj2O29luImLoonMc9QF5w5852NO2e709AdyiY1IQLORgGaKw42fjXkNhFokuh5aznMHIgtTlfxqfLaAKXMsGkehYkMdiqYkhrt4YLlxOY2y9nqHxHYseJVduDNCxFNm2bu9LsDj5LY7cu/vuLdiigfrQ6oWzpzXnx2G1NsS84Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2RWIE0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2RWIE0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CA9C116D0;
	Fri, 14 Nov 2025 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112556;
	bh=3WNSCRqblIMCNzTE2n1uMeiFH+oTUvRCzErtYNIlyHU=;
	h=From:To:Cc:Subject:Date:From;
	b=n2RWIE0eb+nVveWZc+wgosul/H9xnDyyPVAcX4dpTVxw4bcIhUXM8oMCXDuilNU7H
	 UurzKJfO2YopBF6sC07xvLj7I+S6lyvbChlLU0qjWeef+Z9VQWy4VK4cRTCgy31Mcw
	 xShMU+0Xp8cBLVoongAemeQ7719Yrg+NQfDiIncx/PxUBfgxUVh4M8U0lmFXZO5w/1
	 3a1LG4zswvC5c8InRh8KvPzR+ilIWxf7DQEHqQVBGA1ce+TiZxqEtNJJ/eqteVanJs
	 zzbjSRxGzHf0cEmubTc3V+yd6PFsjcMK7n5gAc7mh/d+RzHbJ6xVHcX1yI70N6i3Bg
	 fHf/fCuOgGcZg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Pablo Galindo <pablogsal@gmail.com>
Subject: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
Date: Fri, 14 Nov 2025 01:29:13 -0800
Message-ID: <20251114092914.217533-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that python backtrace with JIT dump was broken after the
change to built-in SHA-1 implementation.  It seems python generates the
same JIT code for each function.  They will become separate DSOs but the
contents are the same.  Only difference is in the symbol name.

But this caused a problem that every JIT'ed DSOs will have the same
build-ID which makes perf confused.  And it resulted in no python
symbols (from JIT) in the output.

Looking back at the original code before the conversion, it used the
load_addr as well as the code section to distinguish each DSO.  I think
we should do the same or use symbol table as an additional input for
SHA-1.

This patch is a quick-and-dirty fix just to add each byte of the
load_addr to the first 8 bytes of SHA-1 result.  Probably we need to add
sha1_update() or similar to update the existing hash value and use it
here.  I'd like something that can be backported to the stable trees
easily.

Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Pablo Galindo <pablogsal@gmail.com>
Link: https://github.com/python/cpython/issues/139544
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/genelf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index 591548b10e34ef6a..a412e6faf70e37f3 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -395,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	 * build-id generation
 	 */
 	sha1(code, csize, bnote.build_id);
+	/* FIXME: update the SHA-1 hash using additional contents */
+	bnote.build_id[0] += (load_addr >> 0) & 0xff;
+	bnote.build_id[1] += (load_addr >> 8) & 0xff;
+	bnote.build_id[2] += (load_addr >> 16) & 0xff;
+	bnote.build_id[3] += (load_addr >> 24) & 0xff;
+	bnote.build_id[4] += (load_addr >> 32) & 0xff;
+	bnote.build_id[5] += (load_addr >> 40) & 0xff;
+	bnote.build_id[6] += (load_addr >> 48) & 0xff;
+	bnote.build_id[7] += (load_addr >> 56) & 0xff;
 	bnote.desc.namesz = sizeof(bnote.name); /* must include 0 termination */
 	bnote.desc.descsz = sizeof(bnote.build_id);
 	bnote.desc.type   = NT_GNU_BUILD_ID;
-- 
2.52.0.rc1.455.g30608eb744-goog

