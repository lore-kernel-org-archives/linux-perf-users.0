Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88A3FE640;
	Thu, 18 Jun 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795791; cv=none; b=u1jSVvTgH7z9ROJMTy/ySAx9xr2fioTqUjw2s49B23WfQCDbTr1jpXXmKyEjrEyEvV5jysw6PewLcSg8pSvAKOz7JZCRcw1Ov5igZJCCXw9tjFffsOKu+s1l8Cqdb+ckxntsI009wnhe5P9nAS7z+P/++rUoRKCVeE8RUqDadvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795791; c=relaxed/simple;
	bh=l0C3Eed+UzM48G3KXLNU4ZGRBI55zXOw7FsoleeQEfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBhYP+lxaZ0XJ69mQfKA8/4+7u9XrRfMgm4/gavbgRhIoH9YBpwAJMGoV6jiKmaws1wHZ0k35gTU9l8vs/MoeorVTQd6WqfJ5f15Oe/EXQqV5fo0shVkSI32wDLtm6bRFtn64eW9UhJUlWagAQ4z9nMz/8J45runfkwzXWvCMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN1qxfz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN1qxfz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D8B1F00A3A;
	Thu, 18 Jun 2026 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795790;
	bh=YDKSxFLBv8zkmVvNLw+i8yyMLyvtdvmb5PwaMddGrcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YN1qxfz6jjhXUAUFiTWmZ7nkyjbrf6e6w3RbdS0DmWO1SxlfuRPh4bJ1p5OLiYuTE
	 YLrXLqKVzElgpw7ZksD3RoAz0TBUmYilzaaHwdzq9VeRsJFXF/pb2iHKIaS/yGUthS
	 NE678zbd4uhAVZdVFEzgbHI9eElCWIim4D9fE20r2b/B+O9bYGcfx2uYi92DERmwAe
	 5/cAVYsc9SX+JShtbi8wXViQj2bJ4TeqfkgQgcb5O7llm43KoIwxx+lDU5rHkN21fD
	 1MFJ70WrY4Tryi3zdnqWDfzH8nbe5jy6tx8FBqCzEJ9q/oNnNrUUL2ztyGjmWn1A+w
	 DZSuY/F4J/ZCQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/7] dwarves_fprintf: Accumulate function__fprintf return value in enumeration printing
Date: Thu, 18 Jun 2026 12:16:04 -0300
Message-ID: <20260618151606.82747-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The return value of function__fprintf was being discarded, causing the
printed byte count to be wrong when enumerations contain DW_TAG_subprogram.

Fixes: a1b3ec41fcc2433d ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 4b6edcce81ebce71..9c12fc1ce8b2037a 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -490,7 +490,7 @@ size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
 
 		switch (pos->tag.tag) {
 		case DW_TAG_subprogram:
-			function__fprintf(&pos->tag, cu, conf, fp);
+			printed += function__fprintf(&pos->tag, cu, conf, fp);
 			break;
 		case DW_TAG_enumerator:
 			printed += fprintf(fp, "%-*s = ", max_entry_name_len, enumerator__name(pos));
-- 
2.54.0

