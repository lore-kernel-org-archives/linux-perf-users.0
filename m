Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38960C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124A861051
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhKFTfa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbhKFTfa (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 15:35:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 768EE610E9;
        Sat,  6 Nov 2021 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636227168;
        bh=P93O+SA047jbmBF1axixZgk787DKzkhZJ/kogxjr1uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyc0Ci3kxfMs5/vB62dPSdLOl6o7ErX7aW+7qJRJhWaecFsQ+gJxSF2nz+O7aFT8s
         0Q2a0TctuQSxkbABqOt7JcLuX5afJb24q4apzuDCB9zpdqxyVQ7A+86QLingr2ZoSt
         M/8zdYcLqD83OcUYotLS9vGp9j9UJJnsgQUtoefnGdbSxmU3y4dduHOIBxP0G4mfl7
         stLmgDy+mXckNLe2ilBoY3PInLfG0+9HEfjbW9gw7O1Kr5I4NcZULcFFYTZos2YKU7
         d348HNQ4d3y3CdlTADyEWWM6BlueWFCVbtBsvHIpfUkeFW9yQtTD5qUuhRGgrBPxmQ
         HZjEvw8nVeQag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04AF2410A1; Sat,  6 Nov 2021 16:32:45 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:32:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, jolsa@redhat.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: Test case 27 broken on s390 in linux-next
Message-ID: <YYbYXT5O2KTxLAKC@kernel.org>
References: <20211103155215.2941895-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103155215.2941895-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 03, 2021 at 04:52:15PM +0100, Thomas Richter escreveu:
> Commit 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
> broke the test case 27 (Sample parsing) on s390 on linux-next tree:

Maddy,

	Can you please ack this one?

- Arnaldo
 
>   # ./perf test -Fv 27
>   27: Sample parsing
>   --- start ---
>   parsing failed for sample_type 0x800
>   ---- end ----
>   Sample parsing: FAILED!
>   #
> 
> The cause of the failure is a wrong #define BS_EXPECTED_BE statement
> in above commit.  Correct this define and the test case runs fine.
> 
> Output After:
>   # ./perf test -Fv 27
>   27: Sample parsing                                                  :
>   --- start ---
>   ---- end ----
>   Sample parsing: Ok
>   #
> 
> Fixes: 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/sample-parsing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index c83a11514129..9c7af55b74db 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -36,7 +36,7 @@
>   * These are based on the input value (213) specified
>   * in branch_stack variable.
>   */
> -#define BS_EXPECTED_BE	0xa00d000000000000
> +#define BS_EXPECTED_BE	0xa000d00000000000
>  #define BS_EXPECTED_LE	0xd5000000
>  #define FLAG(s)	s->branch_stack->entries[i].flags
>  
> -- 
> 2.25.1

-- 

- Arnaldo
