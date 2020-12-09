Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF76C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Dec 2020 17:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E004223D1C
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Dec 2020 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgLIRiP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732321AbgLIRiP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Dec 2020 12:38:15 -0500
Date:   Wed, 9 Dec 2020 14:37:43 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607535454;
        bh=lUHJqhuIA3sDRrFDDIRZHT2mURVMt9o5kThEgQGifhk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hORScaubAB2Dw3xq5K6JppzZdyguaTZn7xUDqDpIJSbi5cJmWA3vWqKcjZWzqvt5e
         32k3295NDqmWYfA1ae5wy92GhcxJzECqyDFxxHCjmCMOZkLtaL7w7DvMnzFhcwuq0R
         1pme2FLfpcMZV3T/7EH1L5pxGgdE/WdSCB0hMxzjneZjh4vaMJa6BrQEts8rkRctBO
         FILFMkpnR9a2lUnNI3V2zTbUItf1llSOvgM2vUk+Zjv2jD8Bcd4Z+FL5SRiCfBW0dH
         RES3W4kvKM703U48CY+mugesKbeltjhRpKBRdU8Ob+O8VfxS2mDsTVgtANP84zH/PC
         y7ztU6rqhT3kw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        rbernon@codeweavers.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
Message-ID: <20201209173743.GB185686@kernel.org>
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
 <20201119135022.36340-1-kjain@linux.ibm.com>
 <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
 <20201207163524.GF125383@kernel.org>
 <763d4593-d581-0971-338c-b811925be45b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763d4593-d581-0971-338c-b811925be45b@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Dec 08, 2020 at 03:43:17PM +0100, Thomas Richter escreveu:
> On 12/7/20 5:35 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 24, 2020 at 03:04:53PM +0530, Ravi Bangoria escreveu:
> >>
> >>
> >> On 11/19/20 7:20 PM, Kajol Jain wrote:
> >>> Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
> >>> adds a WINDOWS EXE file named tests/pe-file.exe, which is
> >>> examined by the test case 'PE file support'. As powerpc doesn't support
> >>> it, we are skipping this test.
> >>>
> >>> Result in power9 platform before this patach:
> >>> [command]# ./perf test -F 68
> >>> 68: PE file support                               : Failed!
> >>>
> >>> Result in power9 platform after this patch:
> >>> [command]# ./perf test -F 68
> >>> 68: PE file support                               : Skip
> >>>
> >>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> >>
> >> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > 
> > But why is it failing? I.e. what is that
> > 
> >  perf test -v -F 68
> > 
> > outputs?
> > 
> > Using 'perf report' on a perf.data file containing samples in such
> > binaries, collected on x86 should work on whatever workstation a
> > developer uses.
> > 
> > Say, on a MacBook aarch64 one can look at a perf.data file collected on
> > a x86_64 system where Wine running a PE binary was present.
> > 
> > - Arnaldo
> > 
> 
> Hi 
> 
> What is the distro you are using?
> I observed the same issue on s390 but this was fixed for fedora33 somehow.
> The error just went away after a dnf update....
> 
> [root@m35lp76 perf]# cat /etc/fedora-release 
> Fedora release 33 (Thirty Three)
> [root@m35lp76 perf]# ./perf test -F 68
> 68: PE file support                                                 : Ok
> [root@m35lp76 perf]# 
> 
> 
> However on my fedora32 machine it still fails:
> [root@t35lp46 perf]# cat /etc/fedora-release 
> Fedora release 32 (Thirty Two)
> [root@t35lp46 perf]# ./perf test -F 68
> 68: PE file support                                                 : FAILED!
> [root@t35lp46 perf]# 
> 
> Note that I am running the same kernel on both machines: linux 5.10.0rc7 downloaded
> this morning.

Fedora 33.

What does 'perf test -v -F 68' says?

- Arnaldo
