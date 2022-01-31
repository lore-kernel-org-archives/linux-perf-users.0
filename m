Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1039C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jan 2022 10:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358222AbiAaKeX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jan 2022 05:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358241AbiAaKeW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jan 2022 05:34:22 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19BC06173B
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 02:34:22 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id 9-20020a170906218900b0065e2a9110b9so4814566eju.11
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/V9lGjda+sqhZSBIJFUSQvnNkRukniydQDjwMIcq1AU=;
        b=HaftrDy8RRZtNqvnRpslsmbCqV9LiDFdIpZqwMNom/SjfzRRxA6W+AJHeY6gS2Zo3T
         iBdb9aP19dtekWTVyG+Z26xhKT8yJwf7LQ4sX3CMKmnQX/ViGS/wXhqE2YBaLz15N37y
         bg9wPGARvypQGeT4E3W0tJojbhLNpDaCaQ3hDEqq4AYnwHGuaIpXtemH/yFRIwvFgda3
         xxW9JhdJqyZTIjc9ZhwrCd5tCcSLzH7fQvStpRThe6rgOFOxk72d30vdOTNjsZ4V9NiI
         Jv9m5QgRAhBu+5T8HSLDFW2BTD0MxoShbuhAoXjL1V062FUPlQ0HnuNbPbWrO0w080Sp
         MElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/V9lGjda+sqhZSBIJFUSQvnNkRukniydQDjwMIcq1AU=;
        b=HVd89p5aWxgqhMBzZrMUtb6njZfUnxtlipNsqTsaPScX0JNG4PrGbzN1SwanDeih+I
         pUNEXZL7FQw45Y3UhWcbXFBRYu6FaMssBT/clX+S7LnZ6QDU2HvkxvqrSiyY4var306Z
         m4pbSpfJDZFtAd5zIuDtpiXnyXiZNfULkicFG9BGHXM9qBpZ7wmTuQVBPyN6aTIBkDg5
         2p3Qb4k3W5C6zayVSKTJDA+DmRs0aJlKvU7YstgOuY/cgL/0Tjl8QvUyHr9TiKkR82kZ
         u7eh2cPRn7WgJ7jduA7AJheUqRCBBBHM50oY9cA2OcwavSl2Abyd+uIceN6rQ3udrl2g
         foxw==
X-Gm-Message-State: AOAM530ujc7dqEtgS65a9ua5cssos1hos/3JpppWKlqBY7FyuC1cnQ7x
        1ERhTTfJxiZXBODvWilSeoIxL1JpmQ==
X-Google-Smtp-Source: ABdhPJwRojx1P2rs4U2N3TIrdML9KdiEdQ8wjzMzd5TadS0x2DyuDnvNCCtu1KgU/wviVFpEDMSC7iy2pQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:76:dcf3:95f9:db8b])
 (user=elver job=sendgmr) by 2002:a17:907:d28:: with SMTP id
 gn40mr12058531ejc.750.1643625260505; Mon, 31 Jan 2022 02:34:20 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:34:07 +0100
In-Reply-To: <20220131103407.1971678-1-elver@google.com>
Message-Id: <20220131103407.1971678-3-elver@google.com>
Mime-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 3/3] perf: uapi: Document perf_event_attr::sig_data truncation
 on 32 bit architectures
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Due to the alignment requirements of siginfo_t, as described in
3ddb3fd8cdb0 ("signal, perf: Fix siginfo_t by avoiding u64 on 32-bit
architectures"), siginfo_t::si_perf_data is limited to an unsigned long.

However, perf_event_attr::sig_data is an u64, to avoid having to deal
with compat conversions. Due to being an u64, it may not immediately be
clear to users that sig_data is truncated on 32 bit architectures.

Add a comment to explicitly point this out, and hopefully help some
users save time by not having to deduce themselves what's happening.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1b65042ab1db..82858b697c05 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -465,6 +465,8 @@ struct perf_event_attr {
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
 	 * siginfo_t::si_perf_data, e.g. to permit user to identify the event.
+	 * Note, siginfo_t::si_perf_data is long-sized, and sig_data will be
+	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
 };
-- 
2.35.0.rc2.247.g8bbb082509-goog

