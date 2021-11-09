Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0083C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 14:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AB4610A3
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 14:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhKIOKN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 09:10:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234268AbhKIOKL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 09:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636466843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8IWYaCZlAMvQcJ5TVTR1XodrjIRasEo3kq2JO1EVOI=;
        b=h2h86sX/bHhLX9jUtlyZilNnvUh96YfTKdQO1+fW0kqDS72+VHQMxSczsNvQlUcHp+se+G
        /Skcp6nwFpy2eXS9f5/Ci5dgQoXMVjp+CDbFEmqoepYntRB+L+S7d4wpV1pB1+/g3Yow6I
        duhyANnLECf2axLiYfc/hREHimreM1Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-X2fTZWsJPk6BTyquRAQjBw-1; Tue, 09 Nov 2021 09:07:23 -0500
X-MC-Unique: X2fTZWsJPk6BTyquRAQjBw-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so7780267wmj.8
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 06:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8IWYaCZlAMvQcJ5TVTR1XodrjIRasEo3kq2JO1EVOI=;
        b=SumLj82JAKJhXlFudoWZYGx6/JWsjgAy/SaouIcBJMIUEyXTcUd3wVVDqmXFOPsRkg
         eINo8ouzkjecpnj89Ooqr0s/qSfBK6Ri983om066MamLa1aGXOK7CJwiKcoN9CeRotRq
         kKfndWhPByxJor3tdrsAf7ydLbIjX/P+Ffq3XPleMBWt9SSEsEqoKYCMdNxfqkywKL9p
         /lgxn4yQwvEqDtG2DlURUZBgXxO65lE/lyYTwwZCtPbBZaJWpF1rUU6QGNsHuD5sLxkn
         EcPE9tWKY8hjpo+bht0p4aURC7TPMHEy3hv9/aozUKvWrRw/1zuNYpgUBBCke+Y3uNPX
         34pg==
X-Gm-Message-State: AOAM531l5XllOia04aM7elZpKNnMM0noPywCDqyiin6PGPt4WCc5IYuX
        HrM6PWZHNTkxa3RTqn4lc2KrN9oLx7UvuTXC2rgxxjVGP209zBRxoZL+dMnWXGYyzWXvc+jO/dF
        ADM8vK1sIuXRiyQcURVB1AIfUDFxKjQ==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr9383144wrm.406.1636466841712;
        Tue, 09 Nov 2021 06:07:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm3Eg2xLV7/stGgfqXXyZZrlrvOxe7TP06DzWMBQYrlkwl2CfraXHiVE23qwGtuNqqGv/S3A==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr9383121wrm.406.1636466841571;
        Tue, 09 Nov 2021 06:07:21 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d16sm2559637wmb.37.2021.11.09.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 06:07:21 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 2/2] perf tools: Add weak variants for the deprecated libbpf functions
Date:   Tue,  9 Nov 2021 15:07:07 +0100
Message-Id: <20211109140707.1689940-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211109140707.1689940-1-jolsa@kernel.org>
References: <20211109140707.1689940-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding weak functions for deprecated libbpf functions, so that
we don't get build fail with libbpf version where they are
finally removed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-event.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index ceb96360fd12..476427f3e804 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -22,6 +22,20 @@
 #include "record.h"
 #include "util/synthetic-events.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+int btf__get_from_id(__u32 id, struct btf **btf);
+struct bpf_program *bpf_program__next(struct bpf_program *prog,
+				      const struct bpf_object *obj);
+struct bpf_map *bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
+const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
+#pragma GCC diagnostic pop
+
+int __weak btf__get_from_id(__u32 id __maybe_unused, struct btf **btf __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
 struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
 {
        struct btf *btf;
@@ -33,6 +47,13 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
        return err ? ERR_PTR(err) : btf;
 }
 
+struct bpf_program * __weak
+bpf_program__next(struct bpf_program *prog __maybe_unused,
+		  const struct bpf_object *obj __maybe_unused)
+{
+	return NULL;
+}
+
 struct bpf_program * __weak
 bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
 {
@@ -42,6 +63,12 @@ bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
 #pragma GCC diagnostic pop
 }
 
+struct bpf_map * __weak bpf_map__next(const struct bpf_map *map __maybe_unused,
+				      const struct bpf_object *obj __maybe_unused)
+{
+	return NULL;
+}
+
 struct bpf_map * __weak
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
@@ -51,6 +78,12 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 #pragma GCC diagnostic pop
 }
 
+const void * __weak btf__get_raw_data(const struct btf *btf __maybe_unused,
+				      __u32 *size __maybe_unused)
+{
+	return NULL;
+}
+
 const void * __weak
 btf__raw_data(const struct btf *btf_ro, __u32 *size)
 {
-- 
2.31.1

