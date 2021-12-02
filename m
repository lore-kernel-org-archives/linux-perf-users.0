Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E78C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 13:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhLBNrb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 08:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbhLBNra (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 08:47:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32DC06174A
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Dec 2021 05:44:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1msmNE-0007Ax-C0; Thu, 02 Dec 2021 14:43:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1msmNB-002It9-Oh; Thu, 02 Dec 2021 14:43:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1msmNA-00068C-Am; Thu, 02 Dec 2021 14:43:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
Date:   Thu,  2 Dec 2021 14:43:37 +0100
Message-Id: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=eNmWpT5xZuUpfAnUFna2ET4cRiEnJepungZWi4gorcw=; m=2Y93WzTmNHFeNOC6sfmoEraTmDu3R6WR9czfJqHYQSk=; p=E0sCFmjtI6d4B5nzjgPxbC24bXq02w0W7HZDaRAazI4=; g=488bce8d2eb84fe39e82c97afcd58e79d01a8ca6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGozYYACgkQwfwUeK3K7Am6Wgf8DFK VlLwhBzKCs2QHfWcOQEgkT9FkfquZ4V0aqrgLaG7vcP/jz03YiaaMH5fQk/yIKsFkrKpSPuIGc/QL T973qAnegO5W24Pcfr/Kx7En7T8wvlVapxjSCYqOKQb58TOhxqlgEcGs3HgWVjnJ7lRDIPp8X2xzs hBuBSmDVkdtotfceMPg+joP2trjkwxWLpI73moO1bo0JE8T+WK0d1ERgh2Ka6dR3Jho6EswuhO0ts z/7/vNlPMM1vt9RVUFKTEfbOB5lwa2vy88gfngRMLKKscwsEnClbtm2u1ACY7CUcwRYyUIDNVgdON QhcvxNQlDDR2QtlsZ5vvUIYX6oADDHA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-perf-users@vger.kernel.org
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>

When cross compiling on amd64 for arm64 the build failed on my machine with:

	Makefile.config:493: *** Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1.  Stop.

even though libopencsd was installed (for both amd64 and arm64). After
some digging around I found the relevant error message in
tools/perf/feature/test-libopencsd.make.output:

	/usr/lib/gcc-cross/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/bin/ld: cannot find -lstdc++

Instead of fixing the error message to also include a request to install
libstdc++, just drop -lstdc++. With this change the build completed.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

not sure this is a pure cross compilation problem. I think in general
it's a bad idea to link against libstdc++ explicitly. Still more if
there is no C++ involved.

Best regards
Uwe

 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index afd144725a0b..dc946b7a802e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -143,7 +143,7 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api -lopencsd -lstdc++
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
 endif
-- 
2.30.2

