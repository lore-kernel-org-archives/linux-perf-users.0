Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D34C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39782601FC
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhHIQb0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 12:31:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60688 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhHIQbY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54B8521EB5;
        Mon,  9 Aug 2021 16:31:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7199C13AC8;
        Mon,  9 Aug 2021 16:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +4SvC0VYEWEbTwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 16:31:01 +0000
Date:   Mon, 9 Aug 2021 09:30:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/7] perf/bench-futex: Factor out futex_flag
Message-ID: <20210809163057.no4icet42g6vu6uo@offworld>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-4-dave@stgolabs.net>
 <YRFBj3jGABt1zkQX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YRFBj3jGABt1zkQX@kernel.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 09 Aug 2021, Arnaldo Carvalho de Melo wrote:
>Wouldn't be better to have it defined in one place and then in futex.h
>just have a 'extern int futex_flag;' declaration?

Sure.

>
>I applied the first two patches already.

Ok so I'm clear, this one just won't get picked up right now then.
(you don't want me to respin this patch then in a form v3, right?)

Thanks,
Davidlohr
