Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E61C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 04:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191F861353
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 04:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhKHEwM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 23:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbhKHEwM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 23:52:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC76C061570;
        Sun,  7 Nov 2021 20:49:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u18so24591789wrg.5;
        Sun, 07 Nov 2021 20:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXsAy5lwDoNIP3HIN36dbwzU2dcUo0qxrXYK9O483nw=;
        b=HGLitnTgOt5b8ZccWK8ELS79A/exRGlogXHyVpjjHEFF/VyKe0fPvKnUxDWr/cDZoc
         q7bX4KjQvRIGhCpKwUOlnMMowjcFNG12VJMX51Fwjzs5tgU9zJd39HdSFTkqAU7+M/z8
         IRB4vD1vbTPFJg+oJ2UZ2Iv1BsqXgZhuAHhntKOl0aDg1wZXZ8SNOjjvaFa51lQGLKht
         jzZUKW8sO2GPEd2z8SZhcgZfNUpeGG42YJ1Q77YIGTAPNPaYax0wveoz102SKlE9SHsO
         gMb3IplhD8R5AGufEL1bK25vCF5kpePGdQSEMJOFlz6GLPSVun17/LN/6ywyu1m96hK/
         v5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXsAy5lwDoNIP3HIN36dbwzU2dcUo0qxrXYK9O483nw=;
        b=ALshvatX9eXZ77gWPjZgyN4WqFOAi4G7Z00zTcS4FdXp0DGCqUTUXu1LlYIvZEdv/K
         Nj1O80KoOhVm19JNZXzkIF2RvOrQozz0/YUsPTyq3/wzKngbCftzW/MWsHX5KSKuxWJd
         7sftNIOnqdhOXIuXo85oP2Ho4v4hXhJZZlGBbmpmXwVfudR7iqbJk61qklSsgxtUWECq
         rF77xamyIvp2Zsly9YhC0geMczrooTUXAMh/2A5pgbz0h6ObdcXn+gHbwIlOamO3P5zz
         6c4xPUX2O0UlB4e4eK0A0riwJz1KGrKKMfm0+QvtegH6EcOZG0Fn+yb4Q5ZNW/MXqExD
         63lg==
X-Gm-Message-State: AOAM530Hs1InIcwYTJ4ZJj4E2hysvpvld/QMVbpbixVCJrGit83JhbvO
        J7or45ALQOGldKkq6qFkCdE=
X-Google-Smtp-Source: ABdhPJyYJ11iH+Ik5Nt+peaCuKrOM/NY1RhlNp+Zgdk7vnfwKugPbZsDCVmmu8UMHsTlhVKvcmgwIg==
X-Received: by 2002:adf:f012:: with SMTP id j18mr88783451wro.353.1636346966702;
        Sun, 07 Nov 2021 20:49:26 -0800 (PST)
Received: from localhost.localdomain ([197.49.136.152])
        by smtp.gmail.com with ESMTPSA id 8sm17772173wmg.24.2021.11.07.20.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 20:49:26 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench: Fix memory leaks.
Date:   Mon,  8 Nov 2021 06:48:25 +0200
Message-Id: <20211108044826.138781-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports memory leaks while running:

$ perf bench sched all

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 tools/perf/bench/sched-messaging.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 488f6e6ba1a5..fa0ff4ce2b74 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -223,6 +223,8 @@ static unsigned int group(pthread_t *pth,
 		snd_ctx->out_fds[i] = fds[1];
 		if (!thread_mode)
 			close(fds[0]);
+
+		free(ctx);
 	}

 	/* Now we have all the fds, fork the senders */
@@ -239,6 +241,8 @@ static unsigned int group(pthread_t *pth,
 		for (i = 0; i < num_fds; i++)
 			close(snd_ctx->out_fds[i]);

+	free(snd_ctx);
+
 	/* Return number of children to reap */
 	return num_fds * 2;
 }
--
2.25.1

