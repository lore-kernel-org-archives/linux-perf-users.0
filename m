Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73B37143
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNM1OXn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB511C433C8;
	Thu,  9 Nov 2023 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699559598;
	bh=K0AUQAMTIJSKGYrpxLpGFIhw+V6BY/dYaUiQAhNcbNo=;
	h=Date:From:To:Cc:Subject:From;
	b=qNM1OXn2sVzVmbd9yIKcxVqr4XPMp8yxwyryPiQqHElXVebxUYepeYvFZZcdv5lxk
	 iMOtim6A9wkSSnJrTM4Ayq50vyovktKObS0+5aB0tYwAwPeq9OtINhMuKjIFSbchEp
	 ULR6MecJ5xUoLBp40WeEpGNekywep0KKH3rD8qYic6R0whiG0gcuU4y/XYoPRBXgFF
	 8UzRY69H6isCyWl5GErWK1BCe3sbCdMRM3ON2k4+YXaFY4VLrGSt1QDQbjQM17nK+N
	 luBGP2PINNnnibwF5DGrKbTNrGxoPs9xDVrM9NkC05PDqXZkuWzR/qP7Db8hhMGUtO
	 crH8s/cQ929wg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7856440094; Thu,  9 Nov 2023 16:53:15 -0300 (-03)
Date: Thu, 9 Nov 2023 16:53:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools: Disable __packed attribute compiler warning due
 to -Werror=attributes
Message-ID: <ZU04q6UZvbJn8OoT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

