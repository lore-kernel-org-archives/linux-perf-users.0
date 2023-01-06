Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9EC54EBD
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 20:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjAFUig (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFUif (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 15:38:35 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB0251
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 12:38:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fc4so6008466ejc.12
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2023 12:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ8vNtKBDiySoD80bt/pCXQzLAnvqyHtk0rN9WYamxc=;
        b=YETykXwJCVB2FAsOb9VW7FY3y+9b/GBz/I6/WGyru4IVV3PIDNtIZAhXZEGGn08bA5
         CqOnZQnXE2XBl73iQeqDQ9tgjgNIRRkeFLNw0VD2Ae0uzbBq9srrfV/jZ6HZaTPonFYS
         zbg61IgPwyUmUwrK0g3MN/gEVDEzmiHfIA4+wl+CfSCocaPI+L1RrrueZcfmV5BzHwsR
         aswn+5Ck1tSz3Qf0n7nbQNdANbeDMBv6yRROvHCEu4Pt7ZXtoSadMjG0cssSC+bRRqr0
         XvCh6dnHWvUhe3TqzXuEOzbpjtG5bkz3ogFgXY8wSlk+kgGNoxvXh6LYXStsMVi5TxqV
         3HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ8vNtKBDiySoD80bt/pCXQzLAnvqyHtk0rN9WYamxc=;
        b=6NNkDb1ho0pjSrsXiR2dIRq2NQPNE8iht2Oy9eNx6YR3bJz970pctVC5p2zBxPU004
         qtqQZ5G0s1SBSG3KhaKw1yV0b4IciedYkt/WKSdSnwc8t8x+ilou34X8VYcKth33kpnY
         3cPRgVSkrg864tFH/d9WwHRRtRuiYIDCpfkZXbvOWylDRUCUrnkd8TZa91wwZ++wlnE7
         h9cFmyRA5e5x0aSi1djfF2Gi7SJRUWFXS+vcXPLHPp+gYTYEJEuNTJAAR8fPMmU7i5xs
         O2TZw5ZQYerzdUdEoZSAb1TtU7n34qDKD0xCaHpKH806+R0VIpk+/+EpFRxbJy1qRPH3
         oZvA==
X-Gm-Message-State: AFqh2kok6QAzpcfbmSH6gM1SNtLV4rpvN+VAF2CBrALx8sohas4z5xxO
        Vm/m5nygf1z49UFs+OIqjCET3CpMKJs=
X-Google-Smtp-Source: AMrXdXsZpnEaKnb4cD+TCmdLPKfB15hsSfc/xMcOK8q9AmVWZApn0q8dMePZg1ZuCtTYTfTCNY4U/Q==
X-Received: by 2002:a17:906:d216:b0:7ae:ccf3:7be5 with SMTP id w22-20020a170906d21600b007aeccf37be5mr63461436ejz.32.1673037512356;
        Fri, 06 Jan 2023 12:38:32 -0800 (PST)
Received: from ddolgov.local (dslb-178-012-041-046.178.012.pools.vodafone-ip.de. [178.12.41.46])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090646c900b007806c1474e1sm716060ejs.127.2023.01.06.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:38:31 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v1] perf record: Correct address filters for duplicated symbols
Date:   Fri,  6 Jan 2023 21:37:51 +0100
Message-Id: <20230106203751.403270-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It seems the logic to handle duplicated symbols is off. In case if the
symbol index is specified it will:

* find a match
* continue searching
* check that start is not null and idx is set on the next loop
* exit with the error code 1

My guess is the expectation was that at this point the second match is
found (because *start is not null), although the new symbol hasn't pass
dso_sym_match yet. Here is how it looks like:

    $ readelf -a postgres | grep simple_heap_update
        4716: 00000000004e23e5   352 FUNC    GLOBAL DEFAULT   13 simple_heap_update
        27829: 00000000004e23e5   352 FUNC    GLOBAL DEFAULT   13 simple_heap_update

    $ perf record -p <pid> -e intel_pt// \
        --filter 'filter simple_heap_update #1 @ postgres' -- sleep 60

        Failed to parse address filter: 'filter simple_heap_update #1 @ postgres'
        Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
        Where multiple filters are separated by space or comma.

Correct by returning error only after checking whether the symbol is
matching or not. After modifications the case above seems to be working
as expected:

    $ perf record -p <pid> -e intel_pt// \
        --filter 'filter simple_heap_update #1 @ postgres' -- sleep 60

    # update heap a couple of times

    $ perf script --itrace=c

        branches: 4e23fe simple_heap_update+0x19 => 54829c GetCurrentCommandId+0x0
        # [...]
        branches: 4e23fe simple_heap_update+0x19 => 54829c GetCurrentCommandId+0x0
        # [...]

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/util/auxtrace.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b59c278fe9ed..112cef56d6c2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2593,15 +2593,23 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 
 	sym = dso__first_symbol(dso);
 	while (sym) {
+		/* Verify duplicates if one match was already found */
 		if (*start) {
 			if (!*size)
 				*size = sym->start - *start;
-			if (idx > 0) {
-				if (*size)
-					return 1;
-			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
-				print_duplicate_syms(dso, sym_name);
-				return -EINVAL;
+
+			if (dso_sym_match(sym, sym_name, &cnt, idx)) {
+				if (idx > 0) {
+					/*
+					 * There is already one match with the specified index, now
+					 * we found the second one, something is wrong.
+					 */
+					if (*size)
+						return 1;
+				} else {
+					print_duplicate_syms(dso, sym_name);
+					return -EINVAL;
+				}
 			}
 		} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
 			*start = sym->start;
-- 
2.31.1

