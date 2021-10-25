Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7D760F6F
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 16:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhJYQzJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232613AbhJYQzI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 12:55:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51D4160E97;
        Mon, 25 Oct 2021 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635180766;
        bh=Hl6vfIz2kWxrCvEfYUe2q2+uL7HXYfA1sQ6X6F+krWw=;
        h=Date:From:To:Cc:Subject:From;
        b=CsRZPbyz6S7TxHBLPZJWrXqrh5gJhSpCVSRUPYXlN+sAW1QkJcxXUvagDlvhMQzB9
         QOd7Ow1BOnVbA7moNjYtCNhyRsBRttBuNxcYVyMQpTNkx1wxQxD1rTaKbhs4FOSDb3
         N6OY8/0ggFHuyBPspxeoAWzRVWyh3rqhftpfm1x3GfqDVwdOFaYKuruvALY/qqTQ0J
         vajHiHCmx/AZl3tJEktkQ0Rho+lR+XOpibDrHTmAwZI2cWlhvjbq+ZzhUDYgz5bfmP
         ygNOz/wXm0EmxeXiZP9unYHrcfBhZ1Rpn90u3TTlCVizJtPVhy/yICjXRDDd0Y42f6
         22E3uFs+K4hLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF5F2410A1; Mon, 25 Oct 2021 13:52:42 -0300 (-03)
Date:   Mon, 25 Oct 2021 13:52:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mingo@redhat.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH: Fix for_each_set_bit(u64) build on 32-bit arches, was perf
 intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
Message-ID: <YXbg2vbY71qGdsYq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 20, 2021 at 02:25:43PM -0300, Arnaldo Carvalho de Melo escreveu:
>   29     8.60 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-9)
>     util/intel-pt.c: In function 'intel_pt_synth_pebs_sample':
>     util/intel-pt.c:2146:33: error: passing argument 1 of 'find_first_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      2146 |         for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
>     /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:37:38: note: in definition of macro 'for_each_set_bit'
>        37 |         for ((bit) = find_first_bit((addr), (size));            \
>           |                                      ^~~~
>     In file included from /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops.h:21,
>                      from /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:34,
>                      from /git/perf-5.15.0-rc4/tools/include/linux/bitmap.h:6,
>                      from util/header.h:10,
>                      from util/session.h:7,
>                      from util/intel-pt.c:16:
>     /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops/find.h:109:51: note: expected 'const long unsigned int *' but argument is of type 'const uint64_t *' {aka 'const long long unsigned int *'}
> 
>  Adrian, this is on:
> 
>  commit 803a3c9233990e1adac8ea2421e3759c2d380cf8
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Tue Sep 7 19:39:03 2021 +0300
> 
>     perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
> 
>     Originally, software only supported redirecting at most one PEBS event to
>     Intel PT (PEBS-via-PT) because it was not able to differentiate one event
>     from another. To overcome that, add support for the
>     PERF_RECORD_AUX_OUTPUT_HW_ID side-band event.
> 
>     Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> 
> That is still just on tmp.perf/core, so we can fix it, probably its just
> making that uint64_t into a unsigned long, will check later if you don't
> beat me to it.

Do as other code in perf does, e.g.  arch/x86/events/intel/ds.c, dealing
with PEBS.

I'm adding this to that patch to fix the build on 32-bit.

- Arnaldo


diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 1073c56a512cdc6e..c9542fada8fb6f9b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2143,7 +2143,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		return intel_pt_synth_single_pebs_sample(ptq);
 	}
 
-	for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
+	for_each_set_bit(hw_id, (unsigned long *)&items->applicable_counters, INTEL_PT_MAX_PEBS) {
 		pe = &ptq->pebs[hw_id];
 		if (!pe->evsel) {
 			if (!pt->single_pebs)
