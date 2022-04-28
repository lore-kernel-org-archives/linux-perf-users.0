Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C9C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 20:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiD1Uce (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351812AbiD1Ucd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 16:32:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8129C0D30
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 13:29:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4e17a5809so57027567b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=34jLRM4+BwEIYs9x6hhJ6ygHReUU/x5ddmg6oDAk/hE=;
        b=UY/OX2HTHXKOWNH/Vf+H9JXdTZgn2Yvyfurn3OjW1bzs55mQRh2aFHzvFQTzEDUZHw
         cLoJVm9KJGp+kjJRaOIe0FbY06ycLWn/8x0bmFbaIht1VuNn10xbCPfd+AdXcylCjJLp
         UF+IKMTpHR/gDIZY+ZZ3Qel96ZYSHDwrAbjepbEUBIMDcL6oMe7DUCQSA/ZFVwt0omPS
         DoNB+qt4bsTnioNsremEo+5SN9rZ4F/QXFyXYMhovVphuJmSfAgUuH9qDPn5ofs4wNma
         XMnejXGNOcwpVj3fBQMGwobKZRmuaYaYCAXebRq6l1IOdjvB5HWSIW++jXBADcGXRdx2
         OsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=34jLRM4+BwEIYs9x6hhJ6ygHReUU/x5ddmg6oDAk/hE=;
        b=k8HX2pJfloRSBGSCrA88XlMzfzus3iFGyPJGO/GoSj8yY+JFydj16cya+Ii2QTjoAM
         jpIR+7Wqd69SwwjtFWvytLS+JMKunQ5bnzqrl+fasTN+/f9QHon4WQAc3qmMhKMLl4n4
         CLIyLwx18SIst0su4SpZrH2WHCyvh1qXfGYqe7H5HYOkMIRYOLoC+8gkiLCrAQFsPDhs
         29fRzW7CeIZ/svNLabkWyw8eVH6vVnjJWBQN0NMqblT984VvJhmYqnirM0mY4aCnKR4w
         25YVXZYPEfY4TL9mBURhP7GFSyH0uOyVjLfs2uSEKiMSDpK5xFLTnJqsO/1diZIuhqMn
         0AGA==
X-Gm-Message-State: AOAM532lbr+j9kVUYXxQp8Ykf/qyp/4FnmcyPPhuR4+aq92YNb48zNnK
        qdWmZLF6Szwsj05g30FHJVDboVRMyRh1
X-Google-Smtp-Source: ABdhPJzPL028BTxJjC5e27Kddm/2Qp03nvzJZwIvl2B7mfBm3/Opb5+4zY6BSgpwSpZmbN1h4ZVsBKPiETAU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3c33:ed69:1770:973e])
 (user=irogers job=sendgmr) by 2002:a25:ec0d:0:b0:648:480d:7c08 with SMTP id
 j13-20020a25ec0d000000b00648480d7c08mr23981521ybh.206.1651177756844; Thu, 28
 Apr 2022 13:29:16 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:29:11 -0700
Message-Id: <20220428202912.1056444-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 1/2] perf bench: Fix two numa NDEBUG warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

BUG_ON is a no-op if NDEBUG is defined, otherwise it is an assert.
Compiling with NDEBUG yields:

bench/numa.c: In function =E2=80=98bind_to_cpu=E2=80=99:
bench/numa.c:314:1: error: control reaches end of non-void function [-Werro=
r=3Dreturn-type]
  314 | }
      | ^
bench/numa.c: In function =E2=80=98bind_to_node=E2=80=99:
bench/numa.c:367:1: error: control reaches end of non-void function [-Werro=
r=3Dreturn-type]
  367 | }
      | ^

Add return statements to cover this case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 44e1f8a44087..d5289fa58a4f 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -311,6 +311,7 @@ static cpu_set_t *bind_to_cpu(int target_cpu)
=20
 	/* BUG_ON due to failure in allocation of orig_mask/mask */
 	BUG_ON(-1);
+	return NULL;
 }
=20
 static cpu_set_t *bind_to_node(int target_node)
@@ -364,6 +365,7 @@ static cpu_set_t *bind_to_node(int target_node)
=20
 	/* BUG_ON due to failure in allocation of orig_mask/mask */
 	BUG_ON(-1);
+	return NULL;
 }
=20
 static void bind_to_cpumask(cpu_set_t *mask)
--=20
2.36.0.464.gb9c8b46e94-goog

