Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACFCC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJFO24 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFO24 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 10:28:56 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3A5072FF0
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 07:28:54 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 275C072C8DC;
        Thu,  6 Oct 2022 17:28:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9C7644A472A;
        Thu,  6 Oct 2022 17:28:52 +0300 (MSK)
Date:   Thu, 6 Oct 2022 17:28:52 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Subject: /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No
 such file or directory
Message-ID: <20221006142852.mhrgi3r4fvtkircw@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I noticed that perf examples do not compile anymore with v6.0 (first on ALT,
but on Fedora is the same). Fedora example for convenience:

  # dnf install kernel libperf-devel gcc
  # cc /usr/share/doc/libperf/examples/counting.c -lperf
  In file included from /usr/share/doc/libperf/examples/counting.c:8:
  /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
      9 | #include <linux/compiler.h>
	|          ^~~~~~~~~~~~~~~~~~
  compilation terminated.

I don't see compiler.h installed anywhere by the `make headers_install`.

Thanks,

