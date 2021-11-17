Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73651C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562F761BE3
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhKQOZK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238764AbhKQOYI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:24:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8B161C32;
        Wed, 17 Nov 2021 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637158869;
        bh=MCPfARBpJJThbFL0TzFg3jRiZZonYoLfEIhpqybnZ9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kye+IvFQerBUs5T0zD4RvlsnUpQN0muJoRW/StXCp9AFnOZbAsFlZ6hUg9iLyK+zI
         YITKCzrdlE0OVFjOx4v+tkkO1YSbeUXGkg/CS6YzTh/0LD/2F4t6A4zw3rimyqsYJN
         ALeVGjRBQY7lsocgNPViAjBa2f4c99OHMuDBauwYyQ64k1Mc6gj9MD88yz1LXmREGB
         5ufgq1jEgjlTcmZnG2sfUJqUhTMWKgu6z/Z3tvSstCYH7UtEa00ai76iEfut6ewEwQ
         WnDWBBWhWNO5dtd/sbW3e0+ejjo6yzl5++xdVyqUbONp9cDTvXxBRpA36bbzEYR93b
         sPfwMi5pBZojw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E7BA4088E; Wed, 17 Nov 2021 11:21:06 -0300 (-03)
Date:   Wed, 17 Nov 2021 11:21:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, jolsa@redhat.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: Test case 27 broken on s390 in linux-next
Message-ID: <YZUP0rlCX8PP93l2@kernel.org>
References: <20211103155215.2941895-1-tmricht@linux.ibm.com>
 <beeecf6d-3cd9-2072-ee7c-13712a77807d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beeecf6d-3cd9-2072-ee7c-13712a77807d@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 17, 2021 at 02:35:29PM +0530, Madhavan Srinivasan escreveu:
> 
> On 11/3/21 21:22, Thomas Richter wrote:
> > Commit 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
> > broke the test case 27 (Sample parsing) on s390 on linux-next tree:
> > 
> >    # ./perf test -Fv 27
> >    27: Sample parsing
> >    --- start ---
> >    parsing failed for sample_type 0x800
> >    ---- end ----
> >    Sample parsing: FAILED!
> >    #
> > 
> > The cause of the failure is a wrong #define BS_EXPECTED_BE statement
> > in above commit.  Correct this define and the test case runs fine.
> > 
> > Output After:
> >    # ./perf test -Fv 27
> >    27: Sample parsing                                                  :
> >    --- start ---
> >    ---- end ----
> >    Sample parsing: Ok
> >    #
> 
> 
> Hi Thomas,
> Thanks for the fix. Not sure, I guess I messed up my big endian setup or
> test run I had before sending
> the patch. My bad. It fails for me too, but with your patch the issue fixed.
> 
> Acked-and-Tested-by: Madhavan Srinivasan <maddy@linux.ibm.com>

Thanks, applied.

- Arnaldo

