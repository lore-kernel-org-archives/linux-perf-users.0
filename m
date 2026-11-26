Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673338;
	b=W4xs++5XstIR4JRqQT1c9jo87sGzVPKXfs3lAj1NeG1FHEyhkzK/30jC1cHNSQZ8vwoI
	 l5rp4gkyo1NZuLM+JhLYFLvf98qeV3uYKKf9Aw/DPRwGYrPghUsKIDihI/RXj4HwRCWak
	 YN1f5KCw97XyDZr/nKQci35b0Jv84YevTlQtecy/pVnNX35hgUkD6nr63rmC655xddiHW
	 Ddz1RRPf9QL5khCHL2wjW/DWvhylQHNo6o2MkXhsr9JskRgWv24eXg2ENu2c1yql3O7Ka
	 EkV+lEk5I7llFoOv16+PzANe/RclxL/6G3g4Iogkt1ubg23xlKUOALIHjWE/o3SiP0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673338;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xdtTDUnoeBAPasihOpr7L47beeE5kaFiR2vS7GmQVaY=;
	b=F/9/fqAGu6wYxY3sl3fd+9u1SfVVQz+t4EBjK89pxciwR8LltY48uLm5KBFGiN0oY3Lc
	 43dXPNRY1kmmt6ZbJ1DuhPcB5w/KYGghAQbHit01cRXUz6IM2YO+fswKC+Gb/JhjimCII
	 liqUaKI99EuwQjF7XXXlySoQtisRxirbbhyI7joiMgFmfZnL1QRBSgxIPow7Ivy1SUoTa
	 32/Ajqt6DeZCj7QNWJpOJUsf6VS1qNtAU9guWX7rvvApe1MduVWDLacw0bY+HBsIOwDUp
	 FdQxrgnodCBomsAQSCpsaKx3z2D7mPjHiA657yVE543RLdapS0/CTfQFZAl2fY9RvCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rgnh/y0n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3D606A31C;
	Thu, 26 Nov 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rgnh/y0n
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795673337;
	b=pug/ofzdxYl5oHnR8Ev8+474VIRiwu9aIwzeU7hBFGkbBXlsIoLANs05kKg66/AA9sms
	 DMcK7S7dPB/b6e4cFRupl6PQbcFbZ5v+afoX37AgrI2S3AJRiuER9kx5++7Te9gCkiDmo
	 HNPFNF9DxOMD4liUXWwojLitZXfAkWQQ8GYKpy73qKFPOIWytPoSB+ptjImGajh1qKIA2
	 JUFQJB3menRVypeuB+m7FjY6gmoRv4yxpMUAA5tcUhd+ECyVAraIa1qGWkgFfR/KC7DI7
	 L+/0hJasMZPDOBsCimRgpPpUJP1IQebNsSFyvfC1O4uxPTfwV+Z2zY+uLnJ+WIc+m3w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795673337;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xdtTDUnoeBAPasihOpr7L47beeE5kaFiR2vS7GmQVaY=;
	b=qZq6HGUiNXYUSat0rEM9c5oXoiG/IuIctVlZcRsgRzvN7fd2mZlm7OoRpC/yFue+PR52
	 6fdb30JiC+wSeWkIXpCUP3+YYplzaAjZUcbwEaZ9Y7ax9MkC2q1yj4tGTTSQH7is6Pinu
	 k0rB39gFSB9VOYIbjkPrptPL2KB0nNz1/cWPeZwHm4pqjzOyiRSlNaUWEcHQbV/V2gKl2
	 I0layWuCE1PNcxTvgq9/cgRff81AcirbNoZXZaRZlsF9EEg4iWlBs/1wEWNFAYHMfBgTk
	 5vUSX3gNYE4vyCql2IJcKSJrFqcFIcny4+8DQLp6vUOLSkeIvVa2MRD+GE3sJTDUItQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D10931F000C4;
	Thu, 26 Nov 2026 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673337;
	bh=xdtTDUnoeBAPasihOpr7L47beeE5kaFiR2vS7GmQVaY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Rgnh/y0n1ghGCmUGKQSBmJiPAcD8ebsgCMdYPSvIDKveaJzcO/LQvCIrz+5n87SeL
	 v0Az/1exOeg6YXn3OdKFPgWQMtYajyrZc6LhchHJcODSE6fdgaNtBC+Vkd6OYuk+ZN
	 o0Iwv9YN9YEBLauhUQU5KKgvrvZbEZGHqUXGsdjm1Yay73wDvb5sKojp6YfXtYmV6N
	 zaCJ10vDHk5gGiCkbY0S6NMELPsRIoOawca9k6l3vFdQHyb1ekYtul2rYTEvIt/qjw
	 7D6r2r31ewl2GQ9wOdjVoRX7reAEYJEM5dNCwKrYQDlcwHhotc7ekKE05wLNxHpDx+
	 VC2cesoDMLSpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A2134D241;
	Thu, 26 Nov 2026 06:08:43 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Thu, 26 Nov 2026 06:08:35 +0000
Subject: [PATCH] perf/build: Include linux/string.h by jitdump.c for
 strlcpy()
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-perf-string-h-v1-1-8f5c39ff30f0@arista.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UCTYhZeRVxM4rQZwVhmYhFK7
 26iy/f57+1grMIGl2EH5U1MXqWBOw2QMpWFUe6NwY8+OOcDrqwzWlUpC2YcKbhIU5g4nKE5q/I
 sn1/vevuzveODU+2R/ohkjFGppNynJ1llheP4AnTHBl+KAAAA
X-Change-ID: 20261126-perf-string-h-0a61ba363e65
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673322; l=1805;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=g9y3VzWr2i/uTd9kE3tOPKSuvKsRe85S2o8Ykr74pG8=;
 b=MPmy2s67QLHmgUQymeQX9y6X8dAbiW1d4DWOxW1B2i8riTk56eTwXyUhMUhNJ5ywqB/mTcEFq
 XtVVRb29W8xACVOIvjt0fBS8nystM/maKHsW1eSR5vMJZyLC+NtIUqx
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com
Content-Transfer-Encoding: 7bit

From: Dmitry Safonov <dima@arista.com>

jit_open() now calls strlcpy(), but jitdump.c only includes the libc
<string.h>. With glibc older than 2.38, that header does not declare
strlcpy(), causing the build to fail:

util/jitdump.c:246:17: error: implicit declaration of function 'strlcpy'; did you mean 'strncpy'? [-Wimplicit-function-declaration]
  246 |                 strlcpy(jd->dir, dname, sizeof(jd->dir));
      |                 ^~~~~~~
      |                 strncpy

Current mainline gets the declaration indirectly through symbol.h after
commit 5a9dd835894c ("perf symbols: skip livepatch symbols when loading
kallsyms"). Stable trees are affected, in my case it's v6.12.119 with
stable backport/commit 649bf062b91d ("perf jitdump: Use dirname()
return value in jit_open()")

Replace <string.h> with <linux/string.h>, which includes the libc header
and declares the tools strlcpy() implementation.

Fixes: 4eddf7d9e341 ("perf jitdump: Use dirname() return value in jit_open()")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/perf/util/jitdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 45a05316b3ca..626a12280ca3 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -5,7 +5,6 @@
 #include <libgen.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <inttypes.h>
@@ -16,6 +15,7 @@
 #include <linux/stringify.h>
 #include <linux/kernel.h>
 #include <linux/unaligned.h>
+#include <linux/string.h>
 
 #include "event.h"
 #include "debug.h"

---
base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
change-id: 20261126-perf-string-h-0a61ba363e65

Best regards,
--  
Dmitry Safonov <dima@arista.com>


