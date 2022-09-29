Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2074C04A95
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Sep 2022 05:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiI2FfM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Sep 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiI2FfL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Sep 2022 01:35:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAB91023AA
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 22:35:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MdMWZ1LWcz4xGZ;
        Thu, 29 Sep 2022 15:35:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1664429706;
        bh=pqR5rGmvmjiW6IzzBNyxyjMqjmig7ZQuTSD289XMXFs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LpOQdz9wAXe1fDYnpau8SIx13ROPWVr2D8+wCyRYxtf7aM7qULbEY0jKseJAHiwL9
         loWtnVHhZCHi1rDkbMmoZqmA2FjwKVIoRJ24Rx2j8qqQjnzG0WI4bj/5TmDvNkUisp
         tR0aEholHVwMyRAWqBKoKO1WI90K/vYVaUfiYEfzbprcZCUOjFxKm9LkE3BYsNqDvV
         9cncMXJusN+5f3TSKDeAGk8Bcxt4/zRpbpJ/DmtGJ+3Jga86XE4h0R4Ug4A8mD30lA
         fvnXD0r/8epCfGpwa2OnRbO817cpkxsn+NEfxcxd7IbndZ+r6iJZnaA5L+MLjkoD/N
         v3T8RGiYnvP9w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V2 2/3] tools/perf/tests: Fix branch stack sampling test
 to include sanity check for branch filter
In-Reply-To: <YzRaWCpWkEMV3HqS@kernel.org>
References: <20220921145255.20972-1-atrajeev@linux.vnet.ibm.com>
 <20220921145255.20972-2-atrajeev@linux.vnet.ibm.com>
 <YzRaWCpWkEMV3HqS@kernel.org>
Date:   Thu, 29 Sep 2022 15:35:05 +1000
Message-ID: <878rm2g2uu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Wed, Sep 21, 2022 at 08:22:54PM +0530, Athira Rajeev escreveu:
>> commit b55878c90ab9 ("perf test: Add test for branch stack sampling")
>> added test for branch stack sampling. There is a sanity check in the
>> beginning to skip the test if the hardware doesn't support branch stack
>> sampling.
>> 
>> Snippet
>> <<>>
>> skip the test if the hardware doesn't support branch stack sampling
>> perf record -b -o- -B true > /dev/null 2>&1 || exit 2
>> <<>>
>> 
>> But the testcase also uses branch sample types: save_type, any. if any
>> platform doesn't support the branch filters used in the test, the testcase
>> will fail. In powerpc, currently mutliple branch filters are not supported
>> and hence this test fails in powerpc. Fix the sanity check to look at
>> the support for branch filters used in this test before proceeding with
>>> the test.
>
> Applied the tools/perf/ part

Thanks, I have the other two queued.

cheers
