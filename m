Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC0BC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Sep 2021 07:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4679361155
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Sep 2021 07:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbhIHHTN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347425AbhIHHTM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Sep 2021 03:19:12 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7BCC061575;
        Wed,  8 Sep 2021 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631085481;
        bh=w0M7G5ASfYWvcGPFot2QE8lkLjYhB1FteWbIE/Al0E0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hJ1SCoiuc/gGNb5N/rFfi2g/aqxg8B78zb3TwGnFoFZM/cKl+h8o/XIWGfDtaK5E6
         IeADsfIMT7wh7KtJgtWYN/FYdS5z6dnrIyAsnwsEPGCFuQEoljwSSZIVPgv1i/Xnnm
         X1ZApP5T0twDD7BLnNGjjcsvNyhsmZ1WMhNShuHbEKBI3rNfm1UZaX2wKYSPICtTn2
         NfFZHSJelK9CM1AuDOoIaHC58EUACOT484+1j2K4DJIKJFWCHu+6ShjO/2DF6NCHWI
         nyXDuwcOISS6459NjcXgreseilBHUSIvjobTuEb03Ix8AifL+aW3wCQu1rOKn+UR39
         aAxpXX3Z4t1Gw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H4D4Q54S8z9sW5;
        Wed,  8 Sep 2021 17:17:58 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com
Cc:     maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
Subject: Re: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
In-Reply-To: <20210904064932.307610-1-kjain@linux.ibm.com>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
Date:   Wed, 08 Sep 2021 17:17:53 +1000
Message-ID: <87ilzbmt7i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Kajol Jain <kjain@linux.ibm.com> writes:
> Add couple of new macros to represent onchip L2 and onchip L3 accesses.

It would be "on chip". But I think this needs much more explanation,
this is a generic header so these definitions need to make sense, and
have an understood meaning, across all architectures.

I think most people are going to read "on chip" as differentiating
between an L2/L3 that is "on chip" vs "off chip".

But the case you're trying to express is "another core's L2/L3 on the
same chip as the CPU", vs "the current CPU's L2/L3".


> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index f92880a15645..030b3e990ac3 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1265,7 +1265,9 @@ union perf_mem_data_src {
>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
> -/* 5-0xa available */
> +#define PERF_MEM_LVLNUM_OC_L2	0x05 /* On Chip L2 */
> +#define PERF_MEM_LVLNUM_OC_L3	0x06 /* On Chip L3 */

The obvious use for 5 is for "L5" and so on.

I'm not sure adding new levels is the best idea, because these don't fit
neatly into the hierarchy, they are off to the side.


I wonder if we should use the remote field.

ie. for another core's L2 we set:

  mem_lvl = PERF_MEM_LVL_L2
  mem_remote = 1

Which would mean "remote L2", but not remote enough to be
lvl = PERF_MEM_LVL_REM_CCE1.

It would be printed by the existing tools/perf code as "Remote L2", vs
"Remote cache (1 hop)", which seems OK.


ie. we'd be able to express:

  Current core's L2: LVL_L2
  Other core's L2:   LVL_L2 | REMOTE
  Other chip's L2:   LVL_REM_CCE1 | REMOTE

And similarly for L3.

I think that makes sense? Unless people think remote should be reserved
to mean on another chip, though we already have REM_CCE1 for that.

cheers


