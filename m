Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F8C47083
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 23:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E62A61028
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 23:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFBXSd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:18:33 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37470 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFBXSd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 19:18:33 -0400
Received: by mail-wr1-f52.google.com with SMTP id q5so3896516wrs.4;
        Wed, 02 Jun 2021 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ay5J1mNVMWdSXPcS6ozTjgGPNhxiZyf4nSKZIJf7/Gc=;
        b=Rqn/Os4bo2xRtUqE+nNbNLxsFLDKW4R+xHpbMAx9K/pVJg8kB1mb4Rx3p4+jGGou9R
         C+hUdqTfwZv2sD/LhTCxQE4SFmUidoREJ2ZZqTLv7p6ILcFytS2culx+G/k0E3WoAVRT
         rAVQQx3B/GZXVVJdRkXR8wGNgzFT+FurSm3ksYh7CW0HMZz18PtSS0taJr+8Ntrol8Ch
         VVPlNIGjGwH3U136taxKkatHEGPRi6xA/HvdjvL1jK8LhCo/nKT/RdMV2bMzrNUFsKA4
         WipmOIz2/RkR1lfUhyH3HyF5MiIEhfOTExu6tvJRuVbivNyefWLasUj9XhW7CjBZGWLZ
         CTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ay5J1mNVMWdSXPcS6ozTjgGPNhxiZyf4nSKZIJf7/Gc=;
        b=NRtehC3juborSE+Z4SImAm8YinLRm+pkTwDZGe2Ojdf1+Yn4aJ1v22Yfq3CPs9vf3C
         nlLY0vvYA4xysKxRZWB74hwCKaiBn1V26ej88BUwUFcRFErxI+VVKPKJ2KTWLHJ31FHP
         voi27cpy880ehmXnN4LCmC4eUYEkS3/qe6lfgiEo35SUsgx1bm9QzpZINuoW0MxnL0ru
         F0xTa0Uu0J1/YDh8SOWEFLXRwaTOgkWMDB/LbtgkVblU37SbrS/3UXmPdDE1QrBqtpaq
         yH367XYi5DnY34aFf3/NiAFdmyKL4gIn9dOJscqL9H5OlJLTtXYw97zBuuWKevhZveQn
         Snww==
X-Gm-Message-State: AOAM531m4DT7k1Y3PDHJyylQV3HmaRUnoTFbHL/PI/78WiMErc9phEtf
        RLGBkoA4Fo5sbuTYcdVcpEs=
X-Google-Smtp-Source: ABdhPJzv0zV4uNTPFtCgCeWdcbkovxAGzd2+y0v3nxxGGeHXjL7CzLNnJjZvGfrfXcKWy7Smtf8G+g==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr8784387wro.187.1622675732865;
        Wed, 02 Jun 2021 16:15:32 -0700 (PDT)
Received: from honeypot.epfl.ch ([151.29.82.133])
        by smtp.googlemail.com with ESMTPSA id i2sm929057wmo.40.2021.06.02.16.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:15:32 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map and dso
Date:   Thu,  3 Jun 2021 01:10:53 +0200
Message-Id: <20210602231052.317048-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reported a memory leak of BPF-related ksymbols map and dso. 
The leak is caused by refcount never reaching 0, due to missing 
__put calls in the function machine__process_ksymbol_register.
Once the dso is inserted in map, dso__put should be called, 
since map__new2 has increased its refcount to 2.
The same thing applies for the map when it's inserted into the 
rb-tree in maps (maps__insert increases the refcount to 2).

$ sudo ./perf record -- sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.025 MB perf.data (8 samples) ]

=================================================================
==297735==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 6992 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x8e4e53 in map__new2 /home/user/linux/tools/perf/util/map.c:216:20
    #2 0x8cf68c in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:778:10
    [...]

Indirect leak of 8702 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x8728d7 in dso__new_id /home/user/linux/tools/perf/util/dso.c:1256:20
    #2 0x872015 in dso__new /home/user/linux/tools/perf/util/dso.c:1295:9
    #3 0x8cf623 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:774:21
    [...]

Indirect leak of 1520 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
    #2 0x888954 in map__process_kallsym_symbol /home/user/linux/tools/perf/util/symbol.c:710:8
    [...]

Indirect leak of 1406 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
    #2 0x8cfbd8 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:803:8
    [...]

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3ff4936a15a42..d5937778875e1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -776,6 +776,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		if (dso) {
 			dso->kernel = DSO_SPACE__KERNEL;
 			map = map__new2(0, dso);
+			dso__put(dso);
 		}
 
 		if (!dso || !map) {
@@ -792,6 +793,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+		map__put(map);
 		dso__set_loaded(dso);
 
 		if (is_bpf_image(event->ksymbol.name)) {
-- 
2.31.1

