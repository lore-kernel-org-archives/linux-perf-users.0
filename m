Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C0C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF56E60F70
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 18:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhIQSWu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:22:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50536 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhIQSWu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 14:22:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60365223FA;
        Fri, 17 Sep 2021 18:21:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E7B13C4E;
        Fri, 17 Sep 2021 18:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SaenGJ/cRGH7fgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 17 Sep 2021 18:21:19 +0000
Date:   Fri, 17 Sep 2021 11:21:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dvhart@infradead.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, atish.patra@wdc.com,
        arnd@arndb.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 1/2] perf benchmark: Call the futex syscall from a
 function
Message-ID: <20210917182113.nacg5zbjiexmhhjk@offworld>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 17 Sep 2021, Alistair Francis wrote:

>From: Alistair Francis <alistair.francis@wdc.com>
>
>In preparation for a more complex futex() function let's convert the
>current macro into two functions. We need two functions to avoid
>compiler failures as the macro is overloaded.
>
>This will allow us to include pre-processor conditionals in the futex
>syscall functions.
>
>Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
