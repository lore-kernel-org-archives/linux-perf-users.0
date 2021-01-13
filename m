Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF46C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F236233A2
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 10:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAMKcF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbhAMKcF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jan 2021 05:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610533838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8+c+ECouPj6GQAzOZpqbQlPoCT8jjgyDkeWyU2nRPA=;
        b=RAs1XondqHKcpsaBe1idZWYAc9+hEwNAhF1orsiJpt9Au/x4/eiMiF0pBEOLq2t+G1Txp0
        FtcRtCT1wKc78f53HLGX6kvbKgfcjXTRRzm7GXiDomVX7JM/TRG9kCchfv3p9x6AWrfldO
        JuHS1V7SgA83ZCdEemLlgKYRXIpd3UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-PvzMc2SyMAu_rHEnJG2RyQ-1; Wed, 13 Jan 2021 05:30:36 -0500
X-MC-Unique: PvzMc2SyMAu_rHEnJG2RyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7162CAFAB6;
        Wed, 13 Jan 2021 10:30:34 +0000 (UTC)
Received: from krava (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id BDA195D9DC;
        Wed, 13 Jan 2021 10:30:32 +0000 (UTC)
Date:   Wed, 13 Jan 2021 11:30:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <mail@milianw.de>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kenel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Message-ID: <20210113103031.GA1331835@krava>
References: <8218693.uYs0DeGetE@milian-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8218693.uYs0DeGetE@milian-workstation>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 11, 2021 at 05:56:52PM +0100, Milian Wolff wrote:
> Hey there,
> 
> in hotspot I noticed a symbolization bug for perf.data files that are recorded 
> without `--call-graph dwarf`, i.e. something like this:
> 
> ```
> $ cat test.c
> int main()
> {
>     int sum = 0;
>     for (int i = 0; i < 100000; ++i) sum += i;
>     return sum > 0;
> }
> $ gcc -O0 -g test.c
> $ perf record ./a.out
> $ perf script --show-mmap-events | grep /a.out
>            a.out 149719 18106.394277: PERF_RECORD_MMAP2 149719/149719: 
> [0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
>            a.out 149719 18106.394748:     275254 cycles:u:      55e0b3b5e72e 
> main+0x25 (/tmp/a.out)
>            a.out 149719 18106.395011:     486078 cycles:u:      55e0b3b5e72e 
> main+0x25 (/tmp/a.out)
> ```

for some reason I can't reproduce this and also I'm not getting
randomized VA for your example, while I see it in other processes,
which is strange.. I'll check on it deeper

> 
> How does perf resolve the address 0x55e0b3b5e72e to main+0x25 here? If we look 
> at this purely from the singular mmap event, this shouldn't be the case:
> 
> 1) The mmap event starts at 0x55e0b3b5e000, has size 0x1000, so its end is at 
> 0x55e0b3b5f000.
> 
> 2) Address 55e0b3b5e72e is thus contained in this map, and at offset 0x72e.
> 
> 3) But main is not at this offset, it starts at 0x1709:
> 
> ```
> $ nm ./a.out | grep main
>                  U __libc_start_main
> 0000000000001709 T main
> ```
> 
> How does perf report/script still get the right answer here and knows that 
> there's an offset of 0x1000?
> 
> Note that in reality, multiple mmap events occur. And the first one maps the 
> file at an address with the 0x1000 offset. This can be seen by:
> 
> ```
> $ perf record --call-graph dwarf ./a.out
> $ perf script --show-mmap-events | grep /a.out
> a.out 149953 18488.265340: PERF_RECORD_MMAP2 149953/149953: 
> [0x55b2f29d2000(0x4000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> a.out 149953 18488.265346: PERF_RECORD_MMAP2 149953/149953: 
> [0x55b2f29d3000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> a.out 149953 18488.265348: PERF_RECORD_MMAP2 149953/149953: 
> [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> a.out 149953 18488.265350: PERF_RECORD_MMAP2 149953/149953: 
> [0x55b2f29d5000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> a.out 149953 18488.265706: PERF_RECORD_MMAP2 149953/149953: 
> [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
>             55b2f29d372e main+0x25 (/tmp/a.out)
>             55b2f29d372e main+0x25 (/tmp/a.out)

when you use '--call-graph dwarf' you also enable data mmaps,
so the extra mmap events are non-X mmaps

> ```
> 
> In this case, we see that the first mmap event happens at 0x55b2f29d2000, so 
> if we take that as the base address, we arrive at the offset 0x172e for 
> address 0x55b2f29d372e. This then indeed matches main+0x25, i.e.: 0x1709 + 
> 0x25 = 0x172e.
> 
> But... The question again is: How does perf stat/report know this fact with 
> just the singular mmap event in the plain `perf record a.out` case above?
> Why is there just one mmap event recorded in such a profile?

it's simple binary, and you're getting just executable mmaps

but the calculation seems weird and we're mising something,
I'll try to reproduce and come with an answer

jirka

