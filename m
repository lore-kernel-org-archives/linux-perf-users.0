Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981425772
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIO7SJYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEAEC433C9;
	Wed, 22 Nov 2023 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700671318;
	bh=7EKdU32WWa/sEoS6u1uS+G0T8qjltebPy5sZKOAuHMU=;
	h=Date:From:To:Cc:Subject:From;
	b=DIO7SJYfX8czGIfPUzI7CtRQbOjHEu0W3xEqzylbNEJqlliAVA+b2ypsBO2aF4s3D
	 9QFpRCnzTSqp6WXSFYlfOnq1G1O1kpaOmgLN/kbHkJEp/75G1j62tLjFSz3nFgHJRM
	 WE/1Hr2iv5PZN2ueDWHBY2EKoFl5TVwwHVNwR5JwUf8WGwBoSz3neK+tJ1IedsUL1O
	 5tF64A8FjIkMZo4WDt3dzadVFdaZYOfV0qzOR6KMAIgb2tYfcqqFRshT5Ac2p8/Inm
	 r5B4leRabnQmOdMyh4d59TiwiptzWznKTJBwzYZ9FMsGMMbDS4JIY74NiMr0zH+3Hp
	 hm0RP8z6xuh8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0168840094; Wed, 22 Nov 2023 13:41:54 -0300 (-03)
Date: Wed, 22 Nov 2023 13:41:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools: Disable __packed attribute compiler warning due
 to -Werror=attributes
Message-ID: <ZV4vUuxBILOC3j73@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

Namhyung, I had to cherry pick this from perf-tools-next as I noticed it
was also failing when trying to build perf-tools/tmp.perf-tools + your
header sync series + Ian's ARM files missing in MANIFEST for the
detached tarball build.

With these patches I managed to complete 'make -C tools/perf build-test'
+ 'perf test' + my suite of perf build containers.

- Arnaldo

----

Noticed on several perf tools cross build test containers:

  [perfbuilder@five ~]$ grep FAIL ~/dm.log/summary
    19    10.18 debian:experimental-x-mips    : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    20    11.21 debian:experimental-x-mips64  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    21    11.30 debian:experimental-x-mipsel  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    37    12.07 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
    42    11.91 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    44    13.17 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    45    12.09 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
  [perfbuilder@five ~]$

  In file included from util/intel-pt-decoder/intel-pt-pkt-decoder.c:10:
  /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function 'get_unaligned_le16':
  /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:29: error: packed attribute causes inefficient alignment for 'x' [-Werror=attributes]
     13 |         const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);      \
        |                             ^
  /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:27:28: note: in expansion of macro '__get_unaligned_t'
     27 |         return le16_to_cpu(__get_unaligned_t(__le16, p));
        |                            ^~~~~~~~~~~~~~~~~

This comes from the kernel, where the -Wattributes and -Wpacked isn't
used, -Wpacked is already disabled, do it for the attributes as well.

Fixes: a91c987254651443 ("perf tools: Add get_unaligned_leNN()")
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/7c5b626c-1de9-4c12-a781-e44985b4a797@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/asm-generic/unaligned.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
index 156743d399aed223..2fd551915c2025ee 100644
--- a/tools/include/asm-generic/unaligned.h
+++ b/tools/include/asm-generic/unaligned.h
@@ -8,6 +8,7 @@
  */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"
 
 #define __get_unaligned_t(type, ptr) ({						\
 	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-- 
2.41.0

