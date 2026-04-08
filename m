Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272034FF40;
	Wed,  8 Apr 2026 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669545; cv=none; b=AporNJ5JRGtmCBeEhOdV6W+nmivb4mDP6orrG4MEdyeOfYAVkDz4AJaVS6dhWE3O2EnjHyzXa95l+Mq2jc0UnjV0I8Pnmt354WxwxqclSLpg3DryW2N7c3ScibR8Bar5UDnNpv81ia8YCpDHxVvArDtUAEoHyG9cgyWCHTZGSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669545; c=relaxed/simple;
	bh=HbJ7sM0ZRYJQnV7G5bpqZIrpwmMLTALc9DKvcWNeLkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ph1BNyl6zy6hFhhLo4fGVpfEhOpGoEnM/7HBqkvqzoulKEmPG6hho30a1PyPC6ApxJKc+M01ubACBpr5EbCNCrex3ebLcKs6XgaIlumNDOxxK2iCoUx54N/qqADX95hKfiHSxZHneE2wZ9eYv6hIWODRt16Ke8bgfbq21CRBuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGPE6a4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGPE6a4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D10C2BC9E;
	Wed,  8 Apr 2026 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669545;
	bh=HbJ7sM0ZRYJQnV7G5bpqZIrpwmMLTALc9DKvcWNeLkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGPE6a4/X1G6JV32o6LPeVbN3cDSm/cy6mgQkCWxU4rv4yO1/VyjR/BFlx7VMmjxe
	 lYkA1miF86WeoLasl5+GlNrg92rMz5UfneXFn3mDOGSy4EQyMlv8wKHR59XeFQ/E2x
	 kAHeJWi6XpOqhTCxJWnlKuIISoAi0eSCE2oe7zf+h1aNWbA3srG/QZ8agF+2rTfPsl
	 +GGhCPubXJy8KlzxNOBSWRyldQciZYiFpyhUzhFy3qArdlBug2BedTXRX8Dc0YEHWl
	 DDemv3K+ZWncnsUhabzXizrd2QzUPRbDTLft0RU+vev//29Sep5+JLFz4RAlol/LtW
	 L5EwoGhjVdkYA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/8] perf util: Kill die() prototype, dead for a long time
Date: Wed,  8 Apr 2026 14:31:57 -0300
Message-ID: <20260408173203.96700-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408173203.96700-1-acme@kernel.org>
References: <20260408173203.96700-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In fef2a735167a827a ("perf tools: Kill die()") the die() function was
removed, but not the prototype in util.h, now when building with
LIBPERL=1, during a 'make -C tools/perf build-test' routine test, it is
failing as perl likes die() calls and then this clashes with this
remnant, remove it.

Fixes: fef2a735167a827a ("perf tools: Kill die()")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 394dbfa944ac706c..e935438451b81fda 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -30,7 +30,6 @@ extern bool perf_guest;
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-void die(const char *err, ...) __noreturn __printf(1, 2);
 
 struct dirent;
 struct strlist;
-- 
2.53.0

