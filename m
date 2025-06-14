Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379C1D63E6;
	Sat, 14 Jun 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749876222; cv=none; b=HhCvprfM4oVQK5vABZZcZzM9N7nzSHAfeiY6GHXRdPeqAu3xWOUYGrnowouLSR5DnILg0zJhmHs5o4TlIJaqmlsujwP3xZmvwI92ZycpnQehr00tzpxzkKAG5nxKkx795ESqWIbe6N7q4MHp1bhmNgSJKMREItgFqd+1H/ycU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749876222; c=relaxed/simple;
	bh=zbn/JoysdxR8uLVh95IpmjoYIROjf0TIXjX/YPElpHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZG+6gxzmP1t0Urb/pVG6FtcTW60zFr8Rpro8NRbzf7CEib99osRVigtuf4Z8eUf0kNPubliDrn+3IZz/Fqkz4RiVVdl/k38FSSTLYvH62DU/bXwjBUfLy/3qTUZ1z3acXIJ5nRme5+8pOEvsnTVnqMOmJVjn1PijU7M5qIoAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su+TxGM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su+TxGM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C2BC4CEF2;
	Sat, 14 Jun 2025 04:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749876221;
	bh=zbn/JoysdxR8uLVh95IpmjoYIROjf0TIXjX/YPElpHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Su+TxGM0jzJBOvSCiCV1dN0/bW/3ptJlu3FRSKj34h+soSxa+ut96NjR+HyT0qjX+
	 oKBw4kaCGeOuM+UDRoURQ0hn0Gnv2f5ghYJ9grmhkf+L48K1HzJtDMmGs6HZ6yvGQ4
	 qBS5SjU0C5zST6rsboOuWDc0wQyWJtbEFKf3yFd06LAkA0ODYE0Z5YcqA0d1qAfi5n
	 EOa8r95tsRLMtxAtKSbVr0EyIc6Ljj8IJSLNJEPuahi0wOHjytD8SMZg8xoY5SJnVu
	 cnOW33WGfH4wyB/CjARqEljUGeDMGYAqzIvLgwUE2CPOXcMh3AH6wzs03MapILf6Zq
	 Xnr9F3DwO4yrA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: [PATCH v2 1/4] perf build: enable -fno-strict-aliasing
Date: Fri, 13 Jun 2025 21:41:30 -0700
Message-ID: <20250614044133.660848-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614044133.660848-1-ebiggers@kernel.org>
References: <20250614044133.660848-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

perf pulls in code from kernel headers that assumes it is being built
with -fno-strict-aliasing, namely put_unaligned_*() from
<linux/unaligned.h> which write the data using packed structs that lack
the may_alias attribute.  Enable -fno-strict-aliasing to prevent
miscompilations in sha1.c which would otherwise occur due to this issue.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/perf/Makefile.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d1ea7bf449647..1691b47c4694c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,10 +17,14 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
+# This is required because the kernel is built with this and some of the code
+# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
+CFLAGS += -fno-strict-aliasing
+
 # Enabled Wthread-safety analysis for clang builds.
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -Wthread-safety
 endif
 
-- 
2.49.0

