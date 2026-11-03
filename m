Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793724937;
	b=ovVTqRI3e+ZUIhzVNPHRloLyU3y7ZAeD7qqJeX8WbXKQk/AvPqxGXp6yoFWSXOUSiQX4
	 v9mfmES+Kf6VdxIeQ/BJSjlqkOgLjYBiwCsX1o4q6Ad12cgpKHzjTa2PzftGyfvFKz8wJ
	 +v+Q9BHl7yIwOIEPbzDVWBJTpo/p9EwvgtEGbZAKQG5ckxIQg//82vTHbW67XOt3Wtis1
	 qmtEEVEacmdZMqj5d9xE0xkjbfb4fD77lfWMLTux9DH/59ALKtarJqH9cQQTk2gHmLpfs
	 Dr9czPzTYB0fBEVVWCjF2WpqINYn9B/Z0Ao2W157VTkF2PE47RwBgfWpXMLeWlzEYqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724937;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vtzxVRwqZmfk5AEq2vupGZz6eBPkGfsgpq+78OTTu0M=;
	b=K/mZu5IuyY9uLFLHaNMGAMwFACO/kF4j7c8g3GBp8ZNDe2/VYur6aPyjsbVjp4FpCgEf
	 8j/Hw5bs8TlK+tbeivR6dnQjNeomtIkZ3n/eUcLuXci7Vz/HKdNQEZN+O5GVfv/WF50Pt
	 lNToS3x5jFAgMbA3kg9klv7NXcbi4VDQk7O4d98hza2OhRfffDhP/yAuDRQHRZu9tq2ee
	 AkMVwKt0GVQqITRO/CStApU06Bwh7OliVnV48NTUIgukD8U7VWzYJ6pl8nYqxG68jX+jb
	 Z+kzQqVGIqrlAjULu3zCQyl87txa5rPIixACPDqqvE20V2bMieUIzF7Sh6waPLNtANg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwsmWjVr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED10606A327;
	Tue,  3 Nov 2026 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwsmWjVr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793724936;
	b=npfIExIDcBiecluDJ7o+nlkyzgvinCsea5RhLv8E+0ZFjL6Z4ebV9IEam5vUZyNCETYH
	 /UIa/JfoOZf8RGJxBeNVBwCSyK1XrPWq0Va5yCne9oGEjR+vyaGK32KvJt54uMcNv3XUg
	 iN/2JrN3209hgyxclIKpNR8BgREFhtPlgnTGyoxeA4f0KM4HSG1WsEj/Mwdo1SXiieqxh
	 eB/fbzXJJToVfwb/PdpJULWlPR7bt3VxYc4ZbnTXpATHCrTVvTG13qw81OyJxXDSOY0xP
	 SZSz297q880Ek+SVWTHTq75ugK/ttY6teySb3Okh71LEP12714kYjeNFtJL0lEapquw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724936;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vtzxVRwqZmfk5AEq2vupGZz6eBPkGfsgpq+78OTTu0M=;
	b=2FALVkaR7FflQ+O8bsH01SjDqdOguPJaCACmxKRmMpaeLibYFbXkFQKe0CRfjGkLnEhR
	 7TaFlTVFOMmxXFKhOpWI+tSpffV/QcFTV+k5Vd5Df2dcpDT95p3q0TlUEh0sHU4JRO+xo
	 mvNIfaoflle9qaW03OpSLHiKLgs013te4U0sSBz0uGLs2FoLC86hPd07eoOLVlPfK716l
	 EaqFfe/RuPy5bSoawLBumW0W1Lp076rRVVrIYw7iR9Nku20daemoN+RVfBD8N9fQNPkGM
	 5qgqHtmWNb1t8UqgK2rlWGOAySDHNz8WLaVsa5x7ykBjqj8+e5SzkV4fhDOiKHZFLBA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A65D61F0093A;
	Tue,  3 Nov 2026 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724936;
	bh=vtzxVRwqZmfk5AEq2vupGZz6eBPkGfsgpq+78OTTu0M=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KwsmWjVrk25bYYm6yVaYBaUuZuPQXGg7vcKoejvJF/Qc8w4t0r2Hqn/aXeIQ22/xt
	 GE5rAOwh+/m9/eTyAmql2yCPpk2HnMILfHe7Qmq6TAzydBq4zl3takDnii+yzo3Bk8
	 ui0v2szR+yVoUIvi7XRL4CRk2VJ2gv4Lt3FNvlGJxY6GOeABZfYbl+m9zVcItD3SVh
	 ATYMdoQ3hWgUdXekskbO7++HxXnnVgzgYOEwLC95M7xLML59banoX4A8E+imTtg006
	 JCag3sznQ/iYeFawUUETTHUqKmi+4YJbUYP4B/P7QS4LuE20kVYB2OQFSafqCPTO3a
	 pbuEBKxZSvcHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 06E8646A49;
	Tue,  3 Nov 2026 16:55:35 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 03 Nov 2026 16:55:21 +0000
Subject: [PATCH] perf build: Override OUTPUT when building internal
 libraries
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-perf-output-v1-1-df33a0368cf2@arista.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oEm0vj4FXGRx9RGMA0ziQil/
 26iy3O552wgxJEErsMGTO8ocU0N1GEAv9j0IIyhMehRG6XGI2biGddaci04nYO5mCnokzbQjMw
 0x8+vdrv/Wap7ki890R/OCqFjm/zSp5eVQgz7/gX7J+4KiAAAAA==
X-Change-ID: 20261103-perf-output-58d6965d2726
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793724934; l=2896;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=l8SCNpqTNyh3+owYKih6JxRjJiWS4WDYwh5MD7aaoHE=;
 b=IXevTkU5SJ4FxscC8KtUUltaxTyySoo3Kc97o5EFCSGat23lGvJqtzK/0hiUbmodEAgN3oPbN
 ch/1qQDcdyaDqlwAZspbMw5slSBH+Vur9UuhUqTyE86e6uEK5rpUcHG
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com
Content-Transfer-Encoding: 7bit

From: Dmitry Safonov <dima@arista.com>

After commit 1572ba36fbca ("perf tests: Improvements to build-test
performance"), building perf with OUTPUT on the command line fails:
  make -C tools/perf OUTPUT=/tmp/linux/bld/perf/ ARCH=x86_64 LC_ALL=C CC=gcc HOSTCC=gcc LD=ld
  ...
  make[3]: *** No rule to make target '/tmp/linux/perf/libsubcmd/libsubcmd.a'.  Stop.

MAKEFLAGS propagates the command-line OUTPUT assignment to recursive makes.
The library builds pass their output directories through $O, but the assignment
to $OUTPUT in tools/scripts/Makefile.include cannot replace a command-line
argument. This affects libapi, libperf, libsubcmd and libsymbol.

With "unexport MAKEFLAGS" returned and added $(info) debug in libsubcmd
Makefile produces:
  OUTPUT = /tmp/linux/perf/libsubcmd/
Without it, on current master it prints:
  OUTPUT = /tmp/linux/perf/

Pass OUTPUT explicitly to each library build, including the trailing slash
required when constructing file names. This follows the existing libbpf
build rule and preserves MAKEFLAGS and jobserver propagation.

Fixes: 1572ba36fbca ("perf tests: Improvements to build-test performance")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/perf/Makefile.perf | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..4cc5bb3011da 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -798,7 +798,7 @@ $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
 $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
-		DESTDIR=$(LIBAPI_DESTDIR) prefix= subdir= \
+		OUTPUT=$(LIBAPI_OUTPUT)/ DESTDIR=$(LIBAPI_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBAPI)-clean:
@@ -816,7 +816,7 @@ $(LIBBPF)-clean:
 
 $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
-		DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
+		OUTPUT=$(LIBPERF_OUTPUT)/ DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBPERF)-clean:
@@ -825,7 +825,7 @@ $(LIBPERF)-clean:
 
 $(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
-		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
+		OUTPUT=$(LIBSUBCMD_OUTPUT)/ DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBSUBCMD)-clean:
@@ -834,7 +834,7 @@ $(LIBSUBCMD)-clean:
 
 $(LIBSYMBOL): FORCE | $(LIBSYMBOL_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSYMBOL_DIR) O=$(LIBSYMBOL_OUTPUT) \
-		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= subdir= \
+		OUTPUT=$(LIBSYMBOL_OUTPUT)/ DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBSYMBOL)-clean:

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-perf-output-58d6965d2726

Best regards,
--  
Dmitry Safonov <dima@arista.com>


