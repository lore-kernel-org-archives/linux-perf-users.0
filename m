Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44027346ACB;
	Mon, 22 Dec 2025 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444245; cv=none; b=L3UsTb9As9FGTgn11utkAHFVu3+AvZHHyFBlG2YgzJzyLeR3kBR/InOsKW06gYN3QyvUciANkdj7+sBpt5JJGyaeSsRPXTywLUD95QhVXD1RUiAKCE1QbBDltyEK4pnTThg8otZ+WDG/MHKxQfXfeTtEdakHT2JVHlnB+67sX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444245; c=relaxed/simple;
	bh=0a17z+b1KhA8Lz1K0fL/UR9O/H21Il19WH7GUt6FYfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIwDT8AQFZSRW3sMSOmU9NNbnMU1IwXphGSd4nBSXHTQp/s2M6PUuIs4viNlqiWVCzKvdiJhI/FUw/E77IUL9Dj00lBsFIHyhVmZdzsQZhHGycl7ZS22R+p5E+Z1ScBgVBUbAFYEXibS255DxyoYqJU5EDhMcnmDRRte1XLAzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4rIU9G7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4rIU9G7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662BAC19421;
	Mon, 22 Dec 2025 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444244;
	bh=0a17z+b1KhA8Lz1K0fL/UR9O/H21Il19WH7GUt6FYfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4rIU9G7TCnzvjlDY+CL+7shqH9WYX0LAtIesk0t5K6XUeB27bU3gaLmOhGELTWDS
	 5DIy5uoy7AmVtrvDUZQ7/culeKy1ML3+tOQzKDxT0Qf8A22EmEYlgpzntlN2cr+8/V
	 PnUuD0Rb/2RMa6iphu8gsVpaFfsjt8ouWFA6KvczMaxQnUVAIC/3a4mlLs+D7kyLDh
	 ZA5QVlzfvK9lsi5lvDRm1tXziGmoJgoTuW4iG18ryBkFnp1PohFaDyV5S6qDCZtvQU
	 EwZLzfCVFIp6OFXsGgHNrZWgYa+vPFJdjWKrWcT93k+HXldZlL2Pask5lf7nUCi1Wo
	 BPbbYED/wr+LA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/11] tools headers: Sync linux/gfp_types.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:14 -0800
Message-ID: <20251222225716.3565649-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  4c0a17e28340e458 ("slab: prevent recursive kmalloc() in alloc_empty_sheaf()")

This would be used to handle GFP masks in the perf code and address these
tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/gfp_types.h include/linux/gfp_types.h

Please see tools/include/README.kernel-copies.

Cc: linux-mm@kvack.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/linux/gfp_types.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
index 65db9349f9053c70..3de43b12209ee79f 100644
--- a/tools/include/linux/gfp_types.h
+++ b/tools/include/linux/gfp_types.h
@@ -55,9 +55,7 @@ enum {
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
 #endif
-#ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
-#endif
 	___GFP_LAST_BIT
 };
 
@@ -98,11 +96,7 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
-#ifdef CONFIG_SLAB_OBJ_EXT
 #define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
-#else
-#define ___GFP_NO_OBJ_EXT       0
-#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
-- 
2.52.0.351.gbe84eed79e-goog

