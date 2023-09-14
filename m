Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519DEEAA77
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 21:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjINVUG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjINVUE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA226B2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:20:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d802ecb5883so1753059276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726399; x=1695331199; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3jVQnyzaN1ERNCJQeHBDC5w9lFgMjdheWTQKUJ7noQ=;
        b=LqH6s/1UW2CdNuFdOjRUHkkS910pLhX0+tt4o9vhPm97EUX+mqDQTtYawn2nhk5S2n
         nxkunCZcwj6iAHQMbEgDNxc5k6TNwxDYMWHRjUbdv+LmyrafWvsNFGRIKygQMbSpa1ws
         bru/3wVtMbA3vt9KVx4gTA2rbrhkF7yJS3oPalKWkiLsxLJeN9DpZqi8F3Z2jeGD2ZaL
         EbZRSaL8Av5GOTaxKQuqg+Z28wc24cgpWSuRoM1NC1tUjJDdT47BnZDSkLWFbgOR+99e
         SbzV25eHVm5PKCWNQ0weuuXAyuNDudOY9fazLUU66nWBvigYDSNnKe9/oEme4d3lNB+r
         740w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726399; x=1695331199;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3jVQnyzaN1ERNCJQeHBDC5w9lFgMjdheWTQKUJ7noQ=;
        b=m17447eK7B+VO7a7oNHscWFBsTB1hUZm5WXXQ+yZ0cI05jTtCUB6G0eRI+aPMWNhuS
         2tg3eWdxBeeriPk4LH7x3jAGfFrjt12Tl8Fz1bYejqHd8R/xL3YJxNk+CiCrCie6VEr8
         8DibJGQSO2GXXEEjXVmkFhHUcSDRas9qNP3xn3brAyAsDMW1ogGfoQBsz2pQOZP8FFJB
         YW7esaq41QpU3vvN0VDB38HbroiwKC7WFHvQjrAz22BC8tOEVELdU7Z6RTlL70fMovPm
         dL04jAN2cn+Gb/+zTlRBlPUnT9T4B52galbc9xdoOa3qecYKCFw78u644idO2iZhrFmz
         IP4A==
X-Gm-Message-State: AOJu0Yzy6pnkfhDdsZ23SHLR2rkY/mi25H6ImOQdJmiaacEBmL0N9EoP
        P12OgsTr0/0Sm53Ypp6wsX7H+lAvsW7G
X-Google-Smtp-Source: AGHT+IFf8LiHETjdJOMkgyABGonPNfygVlLPcRmeIzrdeNSCgieUQG/MM4JXzNQp5a4GH33BKmh9TwiXvCaP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1102:b0:d0b:d8cd:e661 with SMTP
 id o2-20020a056902110200b00d0bd8cde661mr203768ybu.12.1694726399348; Thu, 14
 Sep 2023 14:19:59 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:19:44 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-2-irogers@google.com>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 1/5] perf version: Add status of bpf skeletons
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
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add status for BPF skeletons, to see if a build has them enabled:
```
$ perf version --build-options
perf version 6.6.rc1.g0381ae36d1a6
                 dwarf: [ OFF ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ OFF ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ OFF ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ OFF ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ OFF ]  # HAVE_BPF_SKEL
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index e5859c70e195..ac20c2b9bbc2 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -81,6 +81,7 @@ static void library_status(void)
 	STATUS(HAVE_ZSTD_SUPPORT, zstd);
 	STATUS(HAVE_LIBPFM, libpfm4);
 	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
+	STATUS(HAVE_BPF_SKEL, bpf_skeletons);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.42.0.459.ge4e396fd5e-goog

