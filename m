Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A636B904;
	Mon, 12 Oct 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782770; cv=none; b=oAX1eiJofBh4voM95LU50C5zOgPCxxRnGL7Qd/zwgvIPlNfIsTkpSI+53izWEBvvwIoXH54/Ljqgwwl6DLRIpQ9IIiX4FNYlyyUDV4sliRDYjv8QzMjmN3SVeWMmuN938VfXNWH4iO16R6RIH2Rju1msUSXrInqyMqJ+45uyDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782770; c=relaxed/simple;
	bh=Qftn3p+e9yPINBLstEPI00wg9XoQWI5hg8FRERR9bXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4nDLRP8Bp9tmM8PG3eiqt691oyDOR41V4ibhl2r5SzMUmF1amgCfYFCxmKNPTNWERrgIhE7XFxtEGpxtbbt6W5aq8K9v2d7OsUfXgaEbgqqjtsbN12oTKR6Z++DeNvq8JXGYRexR0wH59Ip80dl88M04insA5THjr6PDqKRuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHvZtpu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHvZtpu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CE01F0089C;
	Mon, 12 Oct 2026 05:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782768;
	bh=jyiZ4+LYTBEwdUE51zI2mOkJBjCefdxEk/Ur4D3HA+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dHvZtpu9zhS0KYHF54BxTXvnKiQm4f8hYSGomDaBwKjG5ngsqGJRaNxa9hJRY75r2
	 W/KHRaXpaOKqcWohbHbN3he0/B7YRvg08KbphvCB9f3B0LWXIwoJNhEMGh/qWTBbN0
	 PODUCS28u5SNqxx7DlWFOVfrtgiPpwfDmpBjp8hNMdddqx3o26z2BjchRWZxVcgDk8
	 YEKjIKh3aBSIi8MD5CaIgf/4z0+EXd+58kP2Udo0ONER4xa8MDg5w0GW2UZg8zuzPc
	 F41iBhVW9UB/zHbujCcON0KnhpG+962n5QDc+WjP+j0axj49T+FBLOIoz2m5hYw8AP
	 gSw9GC+ZnmQ+w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 02/10] perf tools: Try linked debug files for DSO debug info
Date: Sun, 11 Oct 2026 22:25:53 -0700
Message-ID: <20261012052601.13920-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
can follow the .gnu_debuglink and find the debug information in the
separate file.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index df03f84c9723560e..913877b84b2d437e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2111,6 +2111,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
 		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
+		DSO_BINARY_TYPE__DEBUGLINK,
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
-- 
2.55.0

