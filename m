Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CB29A1;
	Wed, 10 Dec 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377921; cv=none; b=OeV0q9/DA74HdHac+HBvqfQjGoCzIB3e6tzYuHBemeoAnEpOUkftUjH2aclwAHJ3tNz01TyfM03GWphpoFlKqGdFlFGEvrmkj9GdgOr5jCa6tAvuF6zCxhJuLW2OqRwpY/g4ZJDbTZGk5QiCCpG61ExJBFb6Gt8pX3BHHz76nSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377921; c=relaxed/simple;
	bh=xiVVakATWvtLQ/mYBKCgJpu616Rs/wWAeTzYE311nxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiMjTb8DwdsBPfosfoc8x0sYB6hZGtiOew3lLr4z+9Yfx7niIMrBNwLJJVAFS/TkPnY2zCwQi2QgmdXJQ8hP9eix1PEoeP4NYuvVimGFB5L4HOMpqpJ3UcdPBAqdXaDhbBZdImRp5itmRD5RwaL6x2FIwtQt93gTtmHMjbs/3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C38B1762;
	Wed, 10 Dec 2025 06:45:10 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CCD33F73B;
	Wed, 10 Dec 2025 06:45:16 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 10 Dec 2025 14:44:57 +0000
Subject: [PATCH v2 3/3] tools headers: Verify arm64's unistd_64.h
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-perf_fix_syscall_header-v2-3-b18b6016e0ea@arm.com>
References: <20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com>
In-Reply-To: <20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765377911; l=1490;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=xiVVakATWvtLQ/mYBKCgJpu616Rs/wWAeTzYE311nxw=;
 b=/aUvnGjCpUrn7rE7kaaac1zmLoOsgHbTgHpJ4XAxzTi8HsIgcZYERKhvD3mklPfIfDaCSCVXl
 RaaxFiTMpw3BAFDwVSuY7Ax0OhzeTHnsPceEjfO2NBzFRZf4aMrcuVy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a consistency check between the generated arm64 unistd_64.h header
and the one stored under tools.  This helps ensure that the syscall
definitions remain aligned with the kernel.

The new check reports mismatch such as:

  diff -u tools/arch/arm64/include/uapi/asm/unistd_64.h /tmp/tmp.BYFZqJfzCC/generated/unistd_64.h

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/check-headers.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e0537f275da2f79ea9e05b91300aa1e2f996e9f1..ebc09db1c6055bd29a7d8a4d7aba29e76a19cf5d 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -211,6 +211,15 @@ check_2 tools/perf/arch/parisc/entry/syscalls/syscall.tbl arch/parisc/entry/sysc
 check_2 tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl arch/arm64/entry/syscalls/syscall_32.tbl
 check_2 tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl arch/arm64/entry/syscalls/syscall_64.tbl
 
+# Generate Arm64's unistd_64.h dynamically and compare it with the one in tools.
+if tmpdir=$(mktemp -d); then
+	make -f scripts/Makefile.asm-headers srctree=$PWD SRCARCH=arm64 \
+		obj=$tmpdir/generated generic=include/uapi/asm-generic \
+		$tmpdir/generated/unistd_64.h > /dev/null
+	check_2 tools/arch/arm64/include/uapi/asm/unistd_64.h $tmpdir/generated/unistd_64.h
+	rm -rf $tmpdir
+fi
+
 for i in "${BEAUTY_FILES[@]}"
 do
   beauty_check "$i" -B

-- 
2.34.1

