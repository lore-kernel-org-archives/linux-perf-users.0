Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457BAC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Dec 2021 21:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhLCVJ3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhLCVJ3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Dec 2021 16:09:29 -0500
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7478C061751
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Dec 2021 13:06:02 -0800 (PST)
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
        id E2FDE1BC8C9; Fri,  3 Dec 2021 22:05:59 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        James Clark <james.clark@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Adrian Bunk <bunk@debian.org>
Subject: [PATCH v2] perf: Drop requirement for libstdc++.so for libopencsd check
Date:   Fri,  3 Dec 2021 22:05:44 +0100
Message-Id: <20211203210544.1137935-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=koJoDAZC3+6kV5LHNJ5Zb7lWngubuZW+FHW/gedXEO4=; m=UlFEzwHCaN91YaIMpXxD6Y4UO6IDTNrLsO2p/9juIkI=; p=WdQWshJ66e77MFZWl1nrDXd9UyGrSqE2nTY9RnigWas=; g=051884f5882962d440bed4420036c3b1af0ebf39
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGqhqMACgkQwfwUeK3K7AlXnAgAi0x oRGZEAJNkXMCQuxp0JklYB/W4vqxWfIXVP5eIcS/96E4lApWC1EC/UYLrgQTRXekUNOZJKtA87urK hmhWSSOJdXczyQX9Ln9dRD8w2U7zdMr0yiSsl36sBMVgkOJ8Xs+826u/YRwJTISHzYr2PfOx/WtJR 25mtt9ilek96sEZVXFrlT4mgJiITN/Q1WyT0yeCWdpyXFKg72h/SIiXB9cOM611xsG0d1UwG/7PqI ZA0aW3eCLINVXWcnug+EC5L9GHBLdVatZ+BN5I3/PVLl2Mo2c8XbdQhM092dfLQWo8+AFLm8EhBfg BucfzKxuocwhs/eR7JAaFescnCcTfmQ==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's possible to link against libopencsd_c_api without having
libstdc++.so available, only libstdc++.so.6.0.28 (or whatever version is
in use) needs to be available. The same holds true for libopencsd.so.
When -lstdc++ (or -lopencsd) is explicitly passed to the linker however
the .so file must be available.

So wrap adding the dependencies into a check for static linking that
actually requires adding them all. The same construct is already used
for some other tests in the same file to reduce dependencies in the
dynamic linking case.

Fixes: 573cf5c9a152 ("perf build: Add missing -lstdc++ when linking with libopencsd")
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 tools/perf/Makefile.config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index afd144725a0b..3311fa321754 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -143,7 +143,10 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api -lopencsd -lstdc++
+OPENCSDLIBS := -lopencsd_c_api
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  OPENCSDLIBS += -lopencsd -lstdc++
+endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
 endif
-- 
2.30.2

