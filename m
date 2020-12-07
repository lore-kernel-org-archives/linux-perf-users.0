Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D59BC4361B
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Dec 2020 16:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37606238E8
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Dec 2020 16:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLGQf4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:35:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgLGQf4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Dec 2020 11:35:56 -0500
Date:   Mon, 7 Dec 2020 13:35:24 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607358915;
        bh=MoKNkCCQLssCM2eQlwQkIPKZBt3fQJFl8EPNvdC6uz8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzX+llb2fn88lHi72wD3wOBn1GRvHwKSBVF0h8wCPxlcREq03ioUhRoc6R31wRisM
         so0Wt1veq64ZOfktqabaafjDEj+QApOx3ebPTl+8W5YCi7pz8KgrXdfmICj9EMLCEY
         e8dXFr6zZqkoVpKKK50zON6vPgbbzaQfDvYcz41fY62QS428DIrmgY8kEsps7g+neI
         6GU4LZGRaiMefDrRcpiqaTfcZ1YoNzqEW4dHtUdB4GH0HJCUrd1H13M5fhVWuvVGkE
         PRjejGcITeFn9BlVl/yIgdJeR1byvi4CIhSnnO/WAP833YO3BO9+WiwA29peV6KtPF
         V82GJKvjmuGqQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        tmricht@linux.ibm.com, rbernon@codeweavers.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
Message-ID: <20201207163524.GF125383@kernel.org>
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
 <20201119135022.36340-1-kjain@linux.ibm.com>
 <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 24, 2020 at 03:04:53PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 11/19/20 7:20 PM, Kajol Jain wrote:
> > Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
> > adds a WINDOWS EXE file named tests/pe-file.exe, which is
> > examined by the test case 'PE file support'. As powerpc doesn't support
> > it, we are skipping this test.
> > 
> > Result in power9 platform before this patach:
> > [command]# ./perf test -F 68
> > 68: PE file support                               : Failed!
> > 
> > Result in power9 platform after this patch:
> > [command]# ./perf test -F 68
> > 68: PE file support                               : Skip
> > 
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

But why is it failing? I.e. what is that

 perf test -v -F 68

outputs?

Using 'perf report' on a perf.data file containing samples in such
binaries, collected on x86 should work on whatever workstation a
developer uses.

Say, on a MacBook aarch64 one can look at a perf.data file collected on
a x86_64 system where Wine running a PE binary was present.

- Arnaldo
