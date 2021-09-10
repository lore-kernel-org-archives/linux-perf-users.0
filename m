Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAFC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD424611C5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhIJTt7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhIJTt6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BED1611B0;
        Fri, 10 Sep 2021 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631303327;
        bh=WlKvndzneJd2e9JKCiQzIZcOsLW//thETeJFkvlCOyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9DBJNgXq2rUSme1cNWHgjKrMG5CMI5STZ/+mXmvvpRqLaFzL25CHNscZeLS32EtX
         fsJ6bL6EIOIi600ewX3TFfiII2vGP7HSkLPPCmPlbWe4xaOLdk8RBmvDijaDsHfTBA
         7VJ3ir8qGJikks64ZMuNqW/NwN3k3fdVUqG/rjMOUpnfjyYdMRfJodCWDwRJ9vr3gH
         ktwMOZ00a4jFTn6StLEAIZzkJza21t85kdwMUta5BXV5/8L1POCRUSGhsVU4YpKAJK
         DO2yOCjFEcc+2K50UWYRYmgPY4wS5ViFS9bCWKoe/IOGmvwy6dTu4ECa5EjBQZGPF0
         Maqf6wEndtzjw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3FC44038F; Fri, 10 Sep 2021 16:48:42 -0300 (-03)
Date:   Fri, 10 Sep 2021 16:48:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Another bug: Re: [PATCH 0/3] perf report: Add support to print a
 textual representation of IBS raw sample data
Message-ID: <YTu2mu6a4lkx92ee@kernel.org>
References: <20210817221509.88391-1-kim.phillips@amd.com>
 <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
 <YTth5DLWGbyAzxvQ@kernel.org>
 <YTtmwrZ6iy0TzG3l@kernel.org>
 <YTtnpAcaCNYozoJF@kernel.org>
 <YTto5xw/XSMuiGrG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTto5xw/XSMuiGrG@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


All the cross builds are failing:

  28     9.20 debian:experimental-x-arm64   : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
    util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
       12 | #include <asm/amd-ibs.h>
          |          ^~~~~~~~~~~~~~~
    compilation terminated.
  29     7.29 debian:experimental-x-mips    : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
    util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
       12 | #include <asm/amd-ibs.h>
          |          ^~~~~~~~~~~~~~~
    compilation terminated.
  30     8.50 debian:experimental-x-mips64  : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
    util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
       12 | #include <asm/amd-ibs.h>
          |          ^~~~~~~~~~~~~~~
    compilation terminated.
  31     8.50 debian:experimental-x-mipsel  : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
    util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
       12 | #include <asm/amd-ibs.h>
          |          ^~~~~~~~~~~~~~~
    compilation terminated.
  32    26.37 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  33    66.13 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  34    79.47 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  35     6.89 fedora:24-x-ARC-uClibc        : FAIL gcc version 7.1.1 20170710 (ARCompact ISA Linux uClibc toolchain 2017.09-rc2)
    util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
     #include <asm/amd-ibs.h>
              ^~~~~~~~~~~~~~~

