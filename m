Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30012EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 20:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjFMUnV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjFMUnU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 16:43:20 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8BE57
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 13:43:16 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QggVl2Hbcz9tFc;
        Tue, 13 Jun 2023 22:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jauu.net; s=MBO0001;
        t=1686688991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Ge2zDH4C5WcYe3JrCtOQM7SlUHF5WPe+wiOXOV0zPo=;
        b=OyeK6ibmkrkMQ8OJEJONhckGjXAA0ePebIVRTwBjgmddRZMWPp581G+ebSJYlgOlZURkpF
        8kB0idlVaDqzOAAjcM+Mhf10Gnwbe7eN0tKF9k7SLEQW5uwhNWOES4HnyGNMUod20ahhco
        m8BNjdtxvqc4Ckq0ZQ6zXz7HDvjrvyVq+h4XAqax0bRBZA6rtwmpzbt3QgfuiA6vln7Ows
        6VmXOmKwPZ//fDTaowqutxxkRAijWYFrj0qVPn9Rc42W+OH/LTpmDQVhmgClof/TAqgiHB
        P6zQFUlKTf7Y6KDSiU9ByeWayZe2jKkNc1XsFyrej4MV2HOUep8/D8NI19gtVg==
Date:   Tue, 13 Jun 2023 22:43:05 +0200
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com,
        john.g.garry@oracle.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Aditya Gupta <adityag@linux.ibm.com>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Subject: Re: [PATCH 16/17] perf tests task_analyzer: print command on failure
Message-ID: <20230613204305.uiv3g5r3cmzo2ucx@ic1101>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-Operating-System: Linux ic1101 6.2.0-hgn
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-17-atrajeev@linux.vnet.ibm.com>
 <ZIjMmKvo9QsPK+B/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjMmKvo9QsPK+B/@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

* Arnaldo Carvalho de Melo | 2023-06-13 17:07:52 [-0300]:

>> From: Aditya Gupta <adityag@linux.ibm.com>
>> 
>> Instead of printing "perf command failed" everytime, print the exact
>> command that run earlier
>
>Looks like a nice improvement, added the test authors to the CC list on
>this message,

Thank you Aditya and really great catch - thank you very much! Shell scripting
can be nasty. This is another example where you can see that with one stupid
typo the whole system can be undermined and you don't get a single hint.

Acked-by: Hagen Paul Pfeifer <hagen@jauu.net>
