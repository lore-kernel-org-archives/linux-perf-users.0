Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDE70839;
	Mon,  4 Nov 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730903; cv=none; b=gSat/j70ngx+us1uzeQ0JWGxGUdVc0l++jDHcRQjCD4UVe6v8t4InkAXG3+TMhb7H6yJt85inr07uLxeqWHvz4+2iEyi1CJMsq3jhtuk4aBp859obx32p2MjoMOagSUhblgxB/Ond229UOPH45p50NDkEAZlDT8XUgNCg0UkIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730903; c=relaxed/simple;
	bh=r2ry74pVmp0n33EFjc8I7+2VSluyMRgJAOoUydcYAao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mnQDjnVWBgP1DrKXxlGeJ+uAFnS7SYvMUN2o1weualRgZ1d2dHFUwzQLsRSCLvdg9BWRgqe/8Ry3T+Cp6MHVmJKmh7eNljB6P2vozlr03ZuoZw3MMh+YqrwOijS1gSQ4sk6USdXp/2btuKAyYHHXFs7WZFN+/7dApjrSMp9NlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjtT+7b5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjtT+7b5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B614CC4CECE;
	Mon,  4 Nov 2024 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730902;
	bh=r2ry74pVmp0n33EFjc8I7+2VSluyMRgJAOoUydcYAao=;
	h=Date:From:To:Cc:Subject:From;
	b=QjtT+7b5OAJKG0WR4IeE0XL7DhRQ73oU8iHsf9/5HEAXtMEoEgA+GGfYC2vxIV2iR
	 ETpdi47eG4YPiABKRLL5oryQ5sT61SlF1CbSOFNHJpbW6Ekw3LrvwRqxb+6qun48Lg
	 HZVg2j3SxriSzxauHnYHnh2+cTYlXJwgz4CgzSJ+xtqG/VH5WUJkLVqM0jvxUeeE39
	 yfp2/cNyFtJsQLdYSkfOsDh/mHh0/wZjTfasE1c/d07Q9mLoGH7/bi7cRev5O+hsi7
	 cqR/R1BIjw6hOYbB8TzG7KU3ojhFXUX8Ezh3A4XafuJVnHwsQFPu7FJ7xJf3HBH0iv
	 3qdGnkmwMiEZg==
Date: Mon, 4 Nov 2024 11:34:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Weilin Wang <weilin.wang@intel.com>, Ze Gao <zegao2021@gmail.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tests: Remove dangling CFLAGS for removed attr.o
 object
Message-ID: <ZyjbksKYnV22zmz-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since the C test wrapper for attr.py was removed we don't have an attr.o
object for that CFLAGS_attr.o to apply for, remove it.

Fixes: 3a447031f5fc21c4 ("perf test: Remove C test wrapper for attr.py")
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Weilin Wang <weilin.wang@intel.com>
Cc: Ze Gao <zegao2021@gmail.com>
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 03cbdf7c50a09be4..01ed9335db4dba4e 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -72,7 +72,6 @@ ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
-CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
 
-- 
2.47.0

