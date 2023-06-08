Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807BCC7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 06:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjFHGUw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 02:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFHGUv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 02:20:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682F1BC6
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 23:20:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565a336caa0so4146117b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686205246; x=1688797246;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oCHAdyzxyXJCPKNToxaJ+/uJTiW/5tUYTGtXZUilb8U=;
        b=19DXUiCZNdYKsdFDJ3ur+WHGcWPXMEkoWXa2URLwFS/q+rfFqfiJCv6at1OZtp1i1L
         fCvM9lT999dsoIcBS1ZwV2pqp1D9qUZUyqZnyblgV/t/n08xoXh329Op8qH176UDI5VN
         NIP8RCbPUUn0uDCJ2UlC69EFygqeYdvvXcpoUx/udvAqbR9l7iHrjq0bS1FXvHqG/xVr
         9kmoiu/MPaiRFS8JIxkksurEjWTPBIbwl06kgRaC1AMUmGPL3+sC27R2sSzt6/te0Bsc
         xM217PBUk0QpcBr3AkHlYtxGWUutc6guDstf6UCSJwDPLiwvI9LVObOC8KfiNwSsMgGm
         YYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686205246; x=1688797246;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCHAdyzxyXJCPKNToxaJ+/uJTiW/5tUYTGtXZUilb8U=;
        b=Tb/On5YAYI+87DT446x9YuGPnuhW90T6SJwvqJd28sCPu1C/1U/3ZXI1fTXaZKEjqu
         AB9T62QeTQik27dvofFKPXAiFrb+CFQ46/3X0/N5OLqiDt15uP/rQJ5l7uVO/ftJVnXI
         LtgsxXTg1FqML0H8dDJdiTK4TJDzht8cVLD5xQt7A9Hpn1c6u/amA+zs+zVexurpNXyI
         xbZpMaqQoY0juF6oFjxBH5ZGlEliO4dRp0dpnUr/cDjAIMq83YVmAvizLgomLFdT2SSI
         yLgZEYWGpUjX/ICLttnu8MXzN+5xu43xiJxlAZXleaWg/zJAxlX/xWymauGR4mNoOQVA
         IyIg==
X-Gm-Message-State: AC+VfDyCZQf5tACcD/I/5SomsmBUXaihQ7nsCebeWs7y7t+zhwd+U9Ub
        IY7EgD2IWUxf6gxh9eqOx8fO7jE2R4sK
X-Google-Smtp-Source: ACHHUZ4klS3E/eInu1S/8JB22grYBCOV8jXXf8NXKl16/zHSQ/qPsb1zLKVpliGpVAA3yG3Cagwz3z9Gj1V4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:886b:58d8:e227:9ed9])
 (user=irogers job=sendgmr) by 2002:a81:a702:0:b0:565:bf4b:de20 with SMTP id
 e2-20020a81a702000000b00565bf4bde20mr4111385ywh.2.1686205246605; Wed, 07 Jun
 2023 23:20:46 -0700 (PDT)
Date:   Wed,  7 Jun 2023 23:18:11 -0700
Message-Id: <20230608061812.3715566-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 1/2] tools api: Add simple timeout to io read
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In situations like reading from a pipe it can be useful to have a
timeout so that the caller doesn't block indefinitely. Implement a
simple one based on poll.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d5e8cf0dada0..9fc429d2852d 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -8,6 +8,7 @@
 #define __API_IO__
 
 #include <errno.h>
+#include <poll.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -23,6 +24,8 @@ struct io {
 	char *end;
 	/* Currently accessed data pointer. */
 	char *data;
+	/* Read timeout, 0 implies no timeout. */
+	int timeout_ms;
 	/* Set true on when the end of file on read error. */
 	bool eof;
 };
@@ -35,6 +38,7 @@ static inline void io__init(struct io *io, int fd,
 	io->buf = buf;
 	io->end = buf;
 	io->data = buf;
+	io->timeout_ms = 0;
 	io->eof = false;
 }
 
@@ -47,7 +51,29 @@ static inline int io__get_char(struct io *io)
 		return -1;
 
 	if (ptr == io->end) {
-		ssize_t n = read(io->fd, io->buf, io->buf_len);
+		ssize_t n;
+
+		if (io->timeout_ms != 0) {
+			struct pollfd pfds[] = {
+				{
+					.fd = io->fd,
+					.events = POLLIN,
+				},
+			};
+
+			n = poll(pfds, 1, io->timeout_ms);
+			if (n == 0)
+				errno = ETIMEDOUT;
+			if (n > 0 && !(pfds[0].revents & POLLIN)) {
+				errno = EIO;
+				n = -1;
+			}
+			if (n <= 0) {
+				io->eof = true;
+				return -1;
+			}
+		}
+		n = read(io->fd, io->buf, io->buf_len);
 
 		if (n <= 0) {
 			io->eof = true;
-- 
2.41.0.rc0.172.g3f132b7071-goog

