Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924F23EA84;
	Tue, 25 Aug 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639037; cv=none; b=o/pAkSas0O8HzQm/kdvsZGetIymQE/TqOGvIXCGqcnmcaan8bC4w4NDKExcg12VD1QjcHQUAzb3m95s9KCc8bhNysE729t105cfB+e0L97Z1w2egSdf9/6rD3wnjOgNx0a5DcpeONd2bJ/5U9GO5sYrJZAx5t9cdZJeV9gkXgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639037; c=relaxed/simple;
	bh=gMcaeuL7gQiZD0R7QzIVhuagTZVKgJGu4C4th3MI9YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izGU6y/AnCX182RnIbP+iUG4uRb/7RxJ2IiErioIw+/sMNrrfW56GURBDQs++K13CLxwfvPF3PH/PYwbBQAYr2h9M4MvU3LR1nQkQSha0lNigx7s6SLuLAuxQOwNvIbOHNpsrbQ8PblZIOyCOfLtiE11wZsVPWHIH2MN7pBXtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UParPmS5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UParPmS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787639036; x=1819175036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gMcaeuL7gQiZD0R7QzIVhuagTZVKgJGu4C4th3MI9YA=;
  b=UParPmS5bJvQZBsp6GmZ0qPUDkZC8K2/B/695Q4e1gQqUZQNzgYDT7qJ
   Hp07YrUxmecl6q7UkL1WAzqt1QRlNYEclFk+8I75SP9zmewkvZPK0jvyN
   9zVDvxps31Z9w8Yr4U4CLRlbCG7lSZMXKicKyqSyWQroudk1s3q9AmtSp
   myEbgQT/6Wj7Zcf7YihfXHamhOfG2qr+FhVeBu1acPSlp9SE4k95X3zF/
   5GMIaHGOCQj65lbGAb/FbDrceYysslnaqV3fx6umLk3uPWunhWOE2j3I4
   aGUCOblqIkouWamfKgsaMhL5Xhd6XdSvw9FrZGzPkV6aie9qj6K4888nZ
   A==;
X-CSE-ConnectionGUID: y7jeLNkQRBKMwAN4SpJKNg==
X-CSE-MsgGUID: mgzJWf+5RiKEkR6XBJRufw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99446572"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99446572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 23:23:55 -0700
X-CSE-ConnectionGUID: ysoIRGCHR8aVnrRfT9I5cw==
X-CSE-MsgGUID: hvj0OGOPQliJ9BYIrn994w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="290720464"
Received: from abityuts-desk1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.23])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 23:23:53 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	tlipcon@google.com,
	eranian@google.com
Subject: [PATCH] perf symbol: Do not use debug file as the binary type
Date: Tue, 25 Aug 2026 09:23:45 +0300
Message-ID: <20260825062345.115073-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

dso__load() sets the binary type of a DSO to the type of the first symbol
source found. For a DSO with a separate debug file linked via
.gnu-debuglink, that is DSO_BINARY_TYPE__DEBUGLINK, which makes
dso__get_filename() return the name of the debug file instead of the file
that was actually executed.

Consumers that need to read instruction bytes, such as Intel PT decoding
in 'perf script', then read from the debug file and produce wrong
instructions.

Prefer DSO_BINARY_TYPE__BUILD_ID_CACHE, and otherwise
DSO_BINARY_TYPE__SYSTEM_PATH_DSO, over debug-only types, which restores
the behaviour of using a file that contains the executed instructions.

This is a workaround. Properly separating the binary file used for
instructions from the file used for debug symbols is left for later.

Example:

 Create a shared object with a separate .gnu_debuglink debug file. Note
 that 'objcopy --only-keep-debug' leaves .text as NOBITS, so instructions
 read from the debug file are zeros:

  # cat > foo.c << EOF
  unsigned long foo_work(unsigned long n)
  {
        unsigned long s = 0;

        for (unsigned long i = 0; i < n; i++)
                s = s * 31 + i;
        return s;
  }
  EOF
  # cat > main.c << EOF
  #include <stdio.h>
  unsigned long foo_work(unsigned long n);
  int main(void)
  {
        printf("%lu\n", foo_work(1000));
        return 0;
  }
  EOF
  # gcc -g -O2 -shared -fPIC -o libfoo.so foo.c
  # gcc -g -O2 -o main main.c -L. -lfoo -Wl,-rpath,'$ORIGIN'
  # objcopy --only-keep-debug libfoo.so libfoo.so.debug
  # objcopy --strip-debug libfoo.so
  # objcopy --add-gnu-debuglink=libfoo.so.debug libfoo.so
  # perf record -e intel_pt//u ./main

 Note that branch samples must be requested, because it is the resolving
 of the branch target symbol that causes dso__load() to be called, and
 hence the binary type to be set, before the decoder walks the code.
 With '--itrace=e' alone, nothing loads symbols for libfoo.so, the binary
 type is left as DSO_BINARY_TYPE__NOT_FOUND, the correct file is read
 anyway, and no errors are reported either way.

 Before:

  # perf.before script --itrace=be 2>&1 | grep "instruction trace error"
   instruction trace error type 1 time 2350.467489498 cpu 9 pid 75634 tid 75634 ip 0x77d48480718f code 6: Trace doesn't match instruction
   instruction trace error type 1 time 2350.467489832 cpu 9 pid 75634 tid 75634 ip 0x77d484807341 code 6: Trace doesn't match instruction
   instruction trace error type 1 time 2350.467496412 cpu 9 pid 75634 tid 75634 ip 0x5b4de37a8074 code 6: Trace doesn't match instruction
   instruction trace error type 1 time 2350.467593393 cpu 9 pid 75634 tid 75634 ip 0x77d4848070d0 code 6: Trace doesn't match instruction
   instruction trace error type 1 time 2350.467593954 cpu 9 pid 75634 tid 75634 ip 0x77d4848075a8 code 6: Trace doesn't match instruction
   instruction trace error type 1 time 2350.467595728 cpu 9 pid 75634 tid 75634 ip 0x77d4848324de code 6: Trace doesn't match instruction
  6 instruction trace errors

 After:

  # perf script --itrace=be 2>&1 | grep "instruction trace error"
  #

Fixes: 5363c306787c8 ("perf symbol: Set binary_type of dso when loading")
Reported-by: Todd Lipcon <tlipcon@google.com>
Closes: https://lore.kernel.org/all/CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com/
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cd379ced19e5..1f714b47bbf4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1947,7 +1947,16 @@ int dso__load(struct dso *dso, struct map *map)
 		if (next_slot) {
 			ss_pos++;
 
-			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+			/*
+			 * The binary type is used to find the file containing
+			 * the executed instructions, so prefer the types that
+			 * refer to the actual object over debug-only files such
+			 * as DSO_BINARY_TYPE__DEBUGLINK.
+			 */
+			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
+			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
+			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
+			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
 				dso__set_binary_type(dso, symtab_type);
 
 			if (syms_ss && runtime_ss)
-- 
2.53.0

