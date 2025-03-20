Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710E2080D9;
	Thu, 20 Mar 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467975; cv=none; b=r+BzltwubOS0vxF6Ho0UhaAwbVoz6iKCXxapDbhdDohgJGJKkLx+O1CwzDZ3KKFpj84yPZs3EoHoJHE02mGyCyihJZcThZKwHcq1Un8AD9lTgH2wDogHozC0QHdgsR7JuJEYlopJoANFoq29cuUO/Kn9SdC3g7Xr6KgED5dJtQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467975; c=relaxed/simple;
	bh=PYDOmSl2p1Fip80TqRIZOF7AApAkcengg2Yk1qVLQFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4J9n/fhBmx61R+ibjBwzJFuQVXMqRoiRnMpNpmuo04dfLuIn+kDjILGglDajElrLi+EPYCyFmDkWZ9viSvYTqThsTBDN7ir51jk6fUb9IH6YIq25TGGaMPDIxOgjbI3JF5H3aUdPDMZqsP9HgsoryIuvra0EHaAdQREEQkkFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F4F1424;
	Thu, 20 Mar 2025 03:52:53 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 386D03F694;
	Thu, 20 Mar 2025 03:52:44 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] perf build: Use -fzero-init-padding-bits=all
Date: Thu, 20 Mar 2025 10:52:35 +0000
Message-Id: <20250320105235.3498106-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC-15 release claims [1]:

 {0} initializer in C or C++ for unions no longer guarantees clearing
 of the whole union (except for static storage duration initialization),
 it just initializes the first union member to zero. If initialization
 of the whole union including padding bits is desirable, use {} (valid
 in C23 or C++) or use -fzero-init-padding-bits=unions option to
 restore old GCC behavior.

This new behaviour might cause unexpected data when we define a union
with using the '{ 0 }' initializer.  Currently, the perf tool has ruled
out these cases with the sanitizer "-fsanitize=undefined".

But the sanitizer is not enabled by default, we need to manually enable
it with EXTRA_CFLAGS='-fsanitize=undefined'.  This means developers
might encounter issues caused by the initializer with new compilers.

Enable -fzero-init-padding-bits=all to zero padding bits in unions and
structures that might otherwise be left uninitialized.

[1] https://gcc.gnu.org/gcc-15/changes.html

Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v1:
- Changed to use '-fzero-init-padding-bits=all' to replace
  '-fzero-init-padding-bits=unions'. (Namhyung)
- Updated commit log for a bit background info. (Ian)

 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a148ca9efca9..b4f6d656c729 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -323,6 +323,8 @@ FEATURE_CHECK_LDFLAGS-libaio = -lrt
 FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
 
+# Explicitly clear padding bits with the initializer '{ 0 }'
+CORE_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
-- 
2.34.1

