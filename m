Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D07277815;
	Wed, 11 Jun 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636267; cv=none; b=ewSC6XX+nQMOEoWxD6dzWb9wIFU1MGIGnDBxBYQe7s1DkUVsrEpbtm5kXWj9jXGX4zFkcuo8OcMZH80EVlJfNXZIE3ft5/EcsVtWW9h2j4lwYDZV+0BM98wyYqr/s/m+ESLufdG1Y/ljPgc9qpjBx2Ibme86p4Tph13jDjrvV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636267; c=relaxed/simple;
	bh=vQriXNo3SHn5ib9zXUnEsU0dOrTflBIOlZP+7FPjGEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwHTg2yatASMjUbuuvnDL3zzeJGj8X4FLwcHvGpWxDIMtrIIOrOBPSiZrjxkKQq7B4l5vXc/o6XISMUsV57zo+Lu8qwljmGvKyOp1j+/xCWTQwbBMrehqzQ9EAMhzqD5c7k82uAzNYk2MyizQ7w8NSMHBhB/MH3r9ySkgL2itgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCD3Jq5s; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCD3Jq5s"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e302191a3so48671897b3.2;
        Wed, 11 Jun 2025 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749636264; x=1750241064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYmk3ao9IlIY1c5axmE1MDDFLCqOCI5mOPbMZ778bEw=;
        b=HCD3Jq5sYp5uomA3Bynly0hPJUsnMdJOMOWFUYn9LpB/n0IRiUaHTRnafV+ervRZ+2
         I0RB9NSNKHGOti4lnZD31Dz/DHbJp9s9wiAnLYH1K+bXLeV3NmZYDQKozIzOoTi646sC
         bN8jLpKwulD9CFhGX3b69q5ox5DzA77avaQabGxhwrktZJcqK1InLRzPEG6mJ0RUbFft
         xGVue1FB84JRaS/0lFgTNpx33LZZ6dCrYjg39zBAYxwM/BpPcpAfmpeY8LJFzRNq4j9L
         jfqBwcxnjTUfipGcUl6gmS0Aoe3kuMC7RbBegy3TDXW+2jnXHGBA4bNmRmtxE0lgA82d
         qFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636264; x=1750241064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYmk3ao9IlIY1c5axmE1MDDFLCqOCI5mOPbMZ778bEw=;
        b=j/n5oyttlfUXnwUO8MN29iKv30NIxocCCPovwZePmBEOZwpuhhe7R0hi0OVUkIMa6s
         GsdB527joSFA1esfsMZ+aw1aIpvkXgBMQ+YxMuP1bMBZPcZZEMLKc32X7vo9RWcPBRrj
         9t39VP/lVBxapGslNQzMZAHnaSO2k76qFvpi7pZazKcd0+XosKFDBh/ccOba0SzaEtqK
         dDr+nkweu5cdOBNe4zBOc4UQ96Bm098yjbRu0eqltWego3/bIpmFvwGERT/AL+Y/xkWx
         TGwpt1DLgORSHBH9pusLhObwOj4Nz0v4bPOJGs+u0qanzpagNtnxOPLyDslX6G2iSZp5
         OAXw==
X-Forwarded-Encrypted: i=1; AJvYcCXNEnoVxdxJEfApkeLIdeCmpKs/PiAKlNgCKP+FYnVvRKX2paHPR448aPELW/L6717f70spUL6nOPKkSyI=@vger.kernel.org, AJvYcCXWCL2V/KoZnGLmrvE9W2aS+lAGl5p0zyq/Oa14qlKAJsteMj11HsF+ZhGoagC72XmI/vV89JyRlHsZdAEFL7bXng==@vger.kernel.org
X-Gm-Message-State: AOJu0YycAsPKJBel3HzyCt8jUFLFOeqWqaA97uKtoVZchXK2U9CzucZT
	GT886jJbE8r0LyrxdEDJUhmTeAQqZytRWiVzDX1IlamXJlxnKzKKChH0
X-Gm-Gg: ASbGncsDjgmx9kvWaNAKdHT2SMQmvKFv7HFatoRmZbXhYQzKqiCHzgf+8RWEWpCe0pm
	qNfKEHjHE6WTKio8JNqP6X+XMWyKmTpo379D9Vevf0YmADYKfyuuxDMps2Zo/wT/26kZYK6x/3P
	1xYegz7YDISr1l8/kmIUYkdmGeUEP007hLPe7unXk7+nHmEwAdGeVZLvlPWvGQvuQbxOOVgG0iI
	5CZov+JSsawxbUX4uK/5pHsY3Jc7za1HUYvGF3agb4OKlT7uSfXIcQQICVQkDaz0XjnhBJbmMaC
	QlVF621q1aHRCuOtJtDHn294/ro+lhtH8kEvtl/w3hHZHR5Q9mA/0x3yPB9P+Wgc5PcQmsc=
X-Google-Smtp-Source: AGHT+IG9ULc/QUke+pkGNG1SHYEwPl56L3q3ynnXmmvvYZEbBCDg6AMn8eZjEW88pM3xtW4L7aJQ5A==
X-Received: by 2002:a05:690c:6f0d:b0:6f9:7a3c:1fe with SMTP id 00721157ae682-71140ad3b66mr36409907b3.23.1749636264320;
        Wed, 11 Jun 2025 03:04:24 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710f9a1255bsm19356177b3.103.2025.06.11.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:04:23 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools:perf: Remove excess variable declarations
Date: Wed, 11 Jun 2025 15:29:03 +0530
Message-ID: <20250611100256.31089-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I thought array declaration might be done in the same line as assigning the value
to it.

Hence, getting rid of extra steps of reiterating the array name.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/perf/check-headers.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e9fab20e9330..d0029a109b6e 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -4,8 +4,7 @@
 YELLOW='\033[0;33m'
 NC='\033[0m' # No Color

-declare -a FILES
-FILES=(
+declare -a FILES=(
   "include/uapi/linux/const.h"
   "include/uapi/drm/drm.h"
   "include/uapi/drm/i915_drm.h"
@@ -73,8 +72,7 @@ FILES=(
   "scripts/syscall.tbl"
 )

-declare -a SYNC_CHECK_FILES
-SYNC_CHECK_FILES=(
+declare -a SYNC_CHECK_FILES=(
   "arch/x86/include/asm/inat.h"
   "arch/x86/include/asm/insn.h"
   "arch/x86/lib/inat.c"
@@ -86,8 +84,7 @@ SYNC_CHECK_FILES=(
 # tables that then gets included in .c files for things like id->string syscall
 # tables (and the reverse lookup as well: string -> id)

-declare -a BEAUTY_FILES
-BEAUTY_FILES=(
+declare -a BEAUTY_FILES=(
   "arch/x86/include/asm/irq_vectors.h"
   "arch/x86/include/uapi/asm/prctl.h"
   "include/linux/socket.h"
--
2.49.0

