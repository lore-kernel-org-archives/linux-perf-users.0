Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E21C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Fri, 31 Mar 2023 00:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCaAty (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Mar 2023 20:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCaAtr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Mar 2023 20:49:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70612CF3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 17:49:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5416d3a321eso205470997b3.12
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680223779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjS2ubyipVi2ZMDZ77od8b4DQTs3LsPG+UyJYia9quE=;
        b=Z3sRXpowh/3nWuTnA9ABQqlwKz9e/xaBcX8rB1G+JuHoqvIkDMhppRkNVRu2bUEHZD
         DcC346N6icjGxjlxtlLeXPBaAoXHoIDXDh/8n1hZk1rYidPWX5OaeuTCkDt50Bv0q+Lu
         80Xjxt8eqOOsrqHIuSE0bNDLJRDkZXu6yTVVZ62h9kqTeGsLVb9Yo0Ov9CtNO8orwV9A
         0LmbNG+Wz6nzzMPQ19TvVwytQedxgKy0Nm7IRaiblHe2QebEnrZhCIxN1WOuvKyBciAi
         d/wPJXHFQHM9MVHHwCPIjIIKK7gCJj02pIeZBIQipfsYZR+VBL4ws1tnoHf+kPTyKWXD
         gnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjS2ubyipVi2ZMDZ77od8b4DQTs3LsPG+UyJYia9quE=;
        b=M43ve/nzo5w6nLCIv9Ye/6+RnvZG7DJoKoj9zGpuMh5G2U9Chf9xva1vGdPUzGJgXD
         WEmSZ7TdwLlErx2WHA3ZS4WxoxdLSLeTO2Hw3YQMIIDyVDSr3iwKyGahuIOcL+QzbkpO
         1DmbIdamY7bmc96k6PnuTRmOmuq8JVXmvd3sxv+LJG/rPqblISWgt9QoW5pYKYl9+F75
         13RXIodeWlOtNRdXA92Zg8uS7TmTqoaXphAumDTZoQoeLqbJZ68yW0MdzI+0PcKThWx8
         ik4BUDdugXuCFyxpbdS6l9BZatV2R2/lZTdY2/kLK1LK94fqlx5ZWDSdsK9Sl00R3nmf
         9Vcg==
X-Gm-Message-State: AAQBX9fLGxkU4Pn6/jtsU8G9410zYc3g0COl1ujICYDrqHDi/p/ly1lg
        48GfGpnQpICjKhuj0wa/otWYnJazbB8r
X-Google-Smtp-Source: AKy350a3m5BHFnMmj6UwcvTHHQb2LbUjX3nn1IHOfBofEyRM+5fd1eyYoe8wYYAs+1wdFn70nEN5YmCfcHDW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a81:ac64:0:b0:545:6106:5334 with SMTP id
 z36-20020a81ac64000000b0054561065334mr12667656ywj.8.1680223779432; Thu, 30
 Mar 2023 17:49:39 -0700 (PDT)
Date:   Thu, 30 Mar 2023 17:48:44 -0700
In-Reply-To: <20230331004844.1592789-1-irogers@google.com>
Message-Id: <20230331004844.1592789-5-irogers@google.com>
Mime-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 4/4] perf srcline: Avoid addr2line SIGPIPEs
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ignore SIGPIPEs when addr2line is configured.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 423ddf3967b0..bc3e48afe054 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -473,6 +473,8 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 				ch = io__get_char(&io);
 			} while (ch > 0 && ch != '\n');
 		}
+		/* Ignore SIGPIPE in the event addr2line exits. */
+		signal(SIGPIPE, SIG_IGN);
 	}
 	return style;
 }
-- 
2.40.0.348.gf938b09366-goog

