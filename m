Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F11309A77
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Jul 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478847; cv=none; b=JFc/ulXz4650v2YlN+5UIAdPGhERemGJiLK4/8J/7UuGW1WXFHrxYfbvglU0mf3PZRoRksRmzvsjz22ulBaD4xLk1UTS2fJMagH1hX5Y91Yb4jRp/iwTmNHj4yF37yizKGC3mRjwSwK7mq1/Sv2gFnfTFh8+1f7yGdWDM1P85kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478847; c=relaxed/simple;
	bh=k89fQPiBNyDB/0V+EIFMALygaQ9NdDpzKAK2yXffWXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=I6i9EK8Y7SqtGl5QJ3Z0OpF+fKymXH1YbMSQga3NF3MMqN+RvJCEd71Z3ysodivRSTjtBCanAmdRnr5YZUTHFkVtVMxqPNunYXKCFyK1UW9ZyT6PCM2uAuZaC4uUG1XIvpSpZenAeh5xA/dWL++/LsK+1fPqxRmt0oIf/1cLrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tG+k6u3b; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tG+k6u3b"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31366819969so5712230a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751478845; x=1752083645; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx+srozlbEc9LS3I6ua+gsxIOcIl9/CZgn+gg4jjp6A=;
        b=tG+k6u3bGbUPpFmi4eRYHQNPYme7n3F4hOLDpiWeoXSlFwLcLtkFrE6BN/hUHrDQW7
         bE22TNtZxrP8LG+UkEjMMhrHtBOhP1LxuzgiVXcBC6W7hPqCwIdF/HnuKVYvJ24wZWKO
         wr2SaveUavsdlDycypqSSafLRQh82frbBUIcteT3nBYjg9EM9pGx8USiHWrEF2B0apFV
         akyj++phDu0In74mHr7vVL8xpUbhAxTJse4j9EhCpSPVKONWkKDux1Xjkq0zKlEbb3QY
         owmSz+Uh8i0ZORuSubqyitkplFkAb4Kv5sH/mUdDZAcEIAvASnvxnBbJRo1mCpYPiUIf
         gpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751478845; x=1752083645;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx+srozlbEc9LS3I6ua+gsxIOcIl9/CZgn+gg4jjp6A=;
        b=KNu0Yp7KIqN7JGC+fCIMNfk512w7I2vgo53k6LaSvc6N3/LVhkQCKunGUVNs4Pc/86
         lk71dOm6F1d/C+0KiLaST6qwUPfwBd3xri4lL2OR5xqWec/R1+2kB+TDPAu2N4WtHgu7
         AxZLiaJdi2xnFkLfvUGawfXFy0288cb3n5f1TcSnllQjvOiZqCzpJoAEp+0bJWto5/MO
         /UT8d/x+MAt+Cll3QoO2IuEHz4oh9A2YgNuCD1VPaNY34rZnjBfTcuWKpex6BReQC/U5
         IA5rYIDw7ku9yQV3E+7w+EOcnBzP9+wrGH79D+4wL5gKDbodilLqqDbJYpTjPZQ6qv7q
         lFZw==
X-Forwarded-Encrypted: i=1; AJvYcCXsAbMzKvVnDoUHO/XLF/T0IpjLENocAX6GeB+7OXfUcxonUI4tRlhRRR2EJ+YDXa+RLLr5AMOMneOQxx0TOnox@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDVsHsFl1DkPycpqdY/Sf5+hXuDjtldheASFgiUhSfggU0hqq
	0uV6bkzYJ9eAnnYE27Q1NCVA6aYdvfPrkQVAPFrAodk7rvGsYRPlIvmLFkyKqvmUrNZGLdDAQnA
	NNoKsB5Zyug==
X-Google-Smtp-Source: AGHT+IEhKU+BfPwXUZA28Afv177AAOxLT+LlkCtxGs7XMWzoEm8no/XF9kxpC9GQYle/zPOoVwc8OzBjJTID
X-Received: from pjuw4.prod.google.com ([2002:a17:90a:d604:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dc4:b0:2ee:d371:3227
 with SMTP id 98e67ed59e1d1-31a90bd92a6mr6467837a91.17.1751478845442; Wed, 02
 Jul 2025 10:54:05 -0700 (PDT)
Date: Wed,  2 Jul 2025 10:54:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702175402.761818-1-irogers@google.com>
Subject: [PATCH v1] perf genelf: Fix NO_LIBDW=1 build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With NO_LIBDW=3D1 a new unused-parameter warning/error has appeared:
```
util/genelf.c: In function =E2=80=98jit_write_elf=E2=80=99:
util/genelf.c:163:32: error: unused parameter =E2=80=98load_addr=E2=80=99 [=
-Werror=3Dunused-parameter]
  163 | jit_write_elf(int fd, uint64_t load_addr, const char *sym,
```

Fixes: e3f612c1d8f3 ("perf genelf: Remove libcrypto dependency and use buil=
t-in sha1()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/genelf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index fcf86a27f69e..591548b10e34 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -160,7 +160,7 @@ jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t=
 unwinding_header_size,
  * csize: the code size in bytes
  */
 int
-jit_write_elf(int fd, uint64_t load_addr, const char *sym,
+jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
 	      const void *code, int csize,
 	      void *debug __maybe_unused, int nr_debug_entries __maybe_unused,
 	      void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding=
_size)
--=20
2.50.0.727.gbf7dc18ff4-goog

