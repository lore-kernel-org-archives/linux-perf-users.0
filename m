Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75E37E2E1;
	Mon, 13 Jul 2026 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940925; cv=none; b=H77Em+rkB9iSCsOlqRehCj8k5u25B7BotvlIT+v3UUWSWNhQUBBoTfzGVbRR1JyC0HoPuaWPQQpy5h06UXOGX9XTwNr3+1LZi2xEdMyXYcOFWZiXBkwNejINT9UjhmMqV8M3a7FZ7BC06frxxLyEp1Si/8+pcdWZ6v5RSljU0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940925; c=relaxed/simple;
	bh=7kLOQwxtGLs72jGkxLoljFaINE3GxHjDG+cquL6Q8Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tEzJIaa5nFh79yL1DMJBb8uPu1mf+LVbrfcIvcb7IlMNKBd7XCGdGHGsAi7MFHF5v58KbTQLieRSuzCjA/mJvW8XDQ8Hj04WT1YlSuZ1lMrSasEqAsNZ364+5yyLUskHXecGpZrZkFVAmeSifPE8uJsDUnqo75MQPuR8wixsKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PSY+uB3U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PSY+uB3U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3D3153B;
	Mon, 13 Jul 2026 04:08:38 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 977023F7B4;
	Mon, 13 Jul 2026 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783940923; bh=7kLOQwxtGLs72jGkxLoljFaINE3GxHjDG+cquL6Q8Jc=;
	h=From:Date:Subject:To:Cc:From;
	b=PSY+uB3UIemUUIAh7m7Sy1WHy79+auZr2PsRkI6Yy6O+LmKRRJbXysD9P/UA2VdWY
	 xzfzaO3WwgiQBwUXU29Zqj0Rcy3Fd4kQVwTowJIGkr3k6mZBJUyabvFPiix389MZnJ
	 Q9B/Zlo4eE0qCmyUStVmmpNwZDV/yrdnWxJsSkVI=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 13 Jul 2026 12:08:35 +0100
Subject: [PATCH] perf capstone: Fix build with Capstone versions before 6
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>
X-B4-Tracking: v=1; b=H4sIADLHVGoC/x2MWwqAIBAAryL7naBGBV0lQnystRAmWhFEd0/6H
 JiZBwpmwgIjeyDjRYX2WEE2DNxq4oKcfGVQQvVikC1PmIMOdGtnUjn2iNqetHneSeFdawO6YKH
 WKWO1/vM0v+8HzZvn6WkAAAA=
X-Change-ID: 20260713-perf_fix_capstone_build-510dc3bfecfb
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783940921; l=1602;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7kLOQwxtGLs72jGkxLoljFaINE3GxHjDG+cquL6Q8Jc=;
 b=+RGVDY4hYTKXGbori0Ah55rkReIFua7jqkRT0skRhLB/9CJ0UcdshLqz0eX7p2ARCzrgpG4P1
 lYKmdb2K1zIB21qCaaWyaTiudyBItc8q+6WqNoxyfw5rHd07RpxK/3q
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The commit 12c4737f55f2 ("perf capstone: Determine architecture from
e_machine") added a RISC-V mapping for Capstone disassembly.

However, the RISC-V arch and mode definitions are only available from
Capstone 6.0.0. Older Capstone headers do not define CS_ARCH_RISCV,
CS_MODE_RISCV64 or CS_MODE_RISCV32, so perf fails to build.

Guard the RISC-V mapping with a Capstone major version check. Also use
CS_MODE_RISCV_C instead of CS_MODE_RISCVC, which is the mode name used
by Capstone 6.

Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machine")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/capstone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 9bba78ee0c5a2e6c86a97ffe69ca4db966bafd9b..99efeb40ed03621e781ef9b888321e28d237a0ca 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -182,10 +182,12 @@ static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is_big_end
 		*arch = CS_ARCH_SPARC;
 		*mode |= CS_MODE_V9;
 		return true;
+#if defined(CS_VERSION_MAJOR) && CS_VERSION_MAJOR >= 6
 	case EM_RISCV:
 		*arch = CS_ARCH_RISCV;
-		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
+		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCV_C;
 		return true;
+#endif
 	default:
 		return false;
 	}

---
base-commit: ef3af1df4f3372bd8ad47619452a283048b3bc8d
change-id: 20260713-perf_fix_capstone_build-510dc3bfecfb

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

