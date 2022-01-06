Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1AAC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jan 2022 07:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiAFH0h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiAFH0g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jan 2022 02:26:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F23EC061245
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jan 2022 23:26:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so3626358ybb.6
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jan 2022 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d710ZPv1ZicjcGevVjZQCjR4OAJMG4MEnMJsRS4zEJM=;
        b=jk2+YHDGL/qNcJBGTi9D3KUVhIxhGC1phVlgc2msPhBPO2WNdYqNEXghfrGNIXcHfE
         2wIBLDIXKhUa7j8Zwkm5w8GoAh3gzBIBf1+T2JBalumMUJJrAkvGpH7dJy9coH1qb8SN
         GpXI0bmEVN2dOm/pcBAtrdUpYQ0oYQfAFWFAKeqplOLNP43IHQwPlB84sYbHlqA/bxdr
         G/2/JwqdpLRGxnCIhro3zRrVBU78ManPCD1KSQoXTJP8VL9wK2HKPkhHV9jLjT80AzFe
         6GZNMU0THVFzHmIUMopYhNyHn4bE7AeV2n4Df4jVg1ty7YRMX+F4Uavjo7E6wE6QZiJ4
         S+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d710ZPv1ZicjcGevVjZQCjR4OAJMG4MEnMJsRS4zEJM=;
        b=HZu8SzllVEHd7nOit2uUzGvOPo2+jKP6wnjCuPUpCOxhGBUJkUzoV9gLyYaHcZfncR
         lN5jBQUNIb73Oltm9ZXltlYYjctbBMOjrujKBnXT/fdJFpzMbKvDOVUeiHRDFSLzTGr9
         gX9KiITtXjRIvWvgGz3j4pgf/abWSXHKXBI9+yq9sDwEkdoqq0qmcLhL6csDaT0cgCxx
         0I0vCEK6wssHQ3IAhU67bvIra4bgJOojSQNQ1s/nlIiCjTPvCyudsCCQC413PRb8QU6g
         IGsLEQstyljaeaBBLSIMbO8Fam5KLNKgntLHrW/5saeJD9uMjYfFINZEsoKiFWyrN89n
         SC4w==
X-Gm-Message-State: AOAM531umMjYX49DWbBTL24SqieaFvb4pB5142L5jMgVllVC9BpLpXvS
        BQktMs0E3tLNh6WYdG2zppRSy9Y8WK2Z
X-Google-Smtp-Source: ABdhPJycozqkkDkip2gfpICA+VYKBx7gjnRzvAWTAwN92rTLtZ5/QiVEieCPVqR9maArFMMa/vFcF281bVJ3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:30ac:e4b5:4f7c:bb91])
 (user=irogers job=sendgmr) by 2002:a25:5686:: with SMTP id
 k128mr38831727ybb.14.1641453995515; Wed, 05 Jan 2022 23:26:35 -0800 (PST)
Date:   Wed,  5 Jan 2022 23:26:27 -0800
Message-Id: <20220106072627.476524-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH] perf build: Lower the priority of tools/lib includes
From:   Ian Rogers <irogers@google.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        torvalds@linux-foundation.org, eranian@google.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

tools/lib has a 1.1.0 copy of libtraceevent. If a newer system
version is installed then its headers will go in /usr/include. As -I has
priority over system headers the 1.1.0 version gets used in preference
to the system one, which isn't what is wanted. To make the behavior
match expectations use -idirafter so that any system headers have priority
over the tools/lib version.

Fixes: 08efcb4a638d ("libtraceevent: Increase libtraceevent logging when verbose")
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 96ad944ca6a8..0627286380fa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -346,7 +346,7 @@ endif
 
 INC_FLAGS += -I$(src-perf)/util
 INC_FLAGS += -I$(src-perf)
-INC_FLAGS += -I$(srctree)/tools/lib/
+INC_FLAGS += -idirafter$(srctree)/tools/lib/
 
 CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
-- 
2.34.1.448.ga2b2bfdf31-goog

