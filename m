Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E1FC433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F9220799
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbhAMSr3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbhAMSr3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jan 2021 13:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610563562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8Q6mEfrBU0AEw44GsxCrnO22c6UFvQr7rBoM7GbkR4=;
        b=gMiGRLR2iqR0ttBZtSwMFDkFsKHSU4HrhFXm7tfKdM4JIffPb93ntPy/n9WsOSFyHbxUE/
        CezMjfRT2XhQ1Nm1ZCRO8Vrt5pCvoGOXNS/88zrzYVF8Fn2EiabH1jzvUNFABVnCKJQ2+p
        tCuxUX3tLWmvRgrdEmL2mAEO8MxyF3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-r30Y7LDjOWOSxdo9lK7Ozw-1; Wed, 13 Jan 2021 13:45:58 -0500
X-MC-Unique: r30Y7LDjOWOSxdo9lK7Ozw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A58100C681;
        Wed, 13 Jan 2021 18:45:56 +0000 (UTC)
Received: from krava (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4742C5B4C4;
        Wed, 13 Jan 2021 18:45:54 +0000 (UTC)
Date:   Wed, 13 Jan 2021 19:45:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <mail@milianw.de>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Message-ID: <20210113184554.GB1358609@krava>
References: <8218693.uYs0DeGetE@milian-workstation>
 <20210113103031.GA1331835@krava>
 <3012158.k929uczAvT@milian-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3012158.k929uczAvT@milian-workstation>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jan 13, 2021 at 06:47:22PM +0100, Milian Wolff wrote:
> On Mittwoch, 13. Januar 2021 11:30:31 CET Jiri Olsa wrote:
> > On Mon, Jan 11, 2021 at 05:56:52PM +0100, Milian Wolff wrote:
> > > Hey there,
> > > 
> > > in hotspot I noticed a symbolization bug for perf.data files that are
> > > recorded without `--call-graph dwarf`, i.e. something like this:
> > > 
> > > ```
> > > $ cat test.c
> > > int main()
> > > {
> > > 
> > >     int sum = 0;
> > >     for (int i = 0; i < 100000; ++i) sum += i;
> > >     return sum > 0;
> > > 
> > > }
> > > $ gcc -O0 -g test.c
> > > $ perf record ./a.out
> > > $ perf script --show-mmap-events | grep /a.out
> > > 
> > >            a.out 149719 18106.394277: PERF_RECORD_MMAP2 149719/149719:
> > > [0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > > 
> > >            a.out 149719 18106.394748:     275254 cycles:u:     
> > >            55e0b3b5e72e
> > > 
> > > main+0x25 (/tmp/a.out)
> > > 
> > >            a.out 149719 18106.395011:     486078 cycles:u:     
> > >            55e0b3b5e72e
> > > 
> > > main+0x25 (/tmp/a.out)
> > > ```
> > 
> > for some reason I can't reproduce this and also I'm not getting
> > randomized VA for your example, while I see it in other processes,
> > which is strange.. I'll check on it deeper
> 
> Out of interest: what exactly are you not reproducing? And what do you mean by 
> "randomized VA"?

that address 55e0b3b5e72e is randomized by kernel,
but I had to compile your example with -pie to get it,
otherwise I was seeing the standard 0x0400000 something


I'm now seeing:

              ex 1381597 1084961.360877: PERF_RECORD_MMAP2 1381597/1381597: [0x558f08599000(0x1000) @ 0x1000 fd:03 155428 2806170740]: r-xp /home/jolsa/trash/ex
              ex 1381597 1084961.360889: PERF_RECORD_MMAP2 1381597/1381597: [0x7f283cc80000(0x21000) @ 0x2000 fd:01 274841 3265102552]: r-xp /usr/lib64/ld-2.31.so
              ex 1381597 1084961.360898: PERF_RECORD_MMAP2 1381597/1381597: [0x7ffc2cd9c000(0x2000) @ 0 00:00 0 0]: r-xp [vdso]
              ex 1381597 1084961.360917:          1 cycles:u:  ffffffffabc01007 [unknown] ([unknown])
              ex 1381597 1084961.360920:          1 cycles:u:  ffffffffabc01007 [unknown] ([unknown])
              ex 1381597 1084961.360922:          9 cycles:u:  ffffffffabc01007 [unknown] ([unknown])
              ex 1381597 1084961.360924:        180 cycles:u:  ffffffffabc01007 [unknown] ([unknown])
              ex 1381597 1084961.360929:       3839 cycles:u:  ffffffffabc01007 [unknown] ([unknown])
              ex 1381597 1084961.361010: PERF_RECORD_MMAP2 1381597/1381597: [0x7f283caa4000(0x150000) @ 0x25000 fd:01 313184 1927740165]: r-xp /usr/lib64/libc-2.31.so
              ex 1381597 1084961.361695:      22432 cycles:u:      558f08599140 main+0x17 (/home/jolsa/trash/ex)
              ex 1381597 1084961.361702:      20545 cycles:u:      558f08599140 main+0x17 (/home/jolsa/trash/ex)
              ex 1381597 1084961.361709:      99474 cycles:u:      558f08599140 main+0x17 (/home/jolsa/trash/ex)

and it seems to work because there's 0x1000 pgoffset (number behind @)
which for your test seems to be 0

I'm having sample with:
  558f08599140 main+0x17

that falls into:
              ex 1381597 1084961.360877: PERF_RECORD_MMAP2 1381597/1381597: [0x558f08599000(0x1000) @ 0x1000 fd:03 155428 2806170740]: r-xp /home/jolsa/trash/ex

0x558f08599140 - 0x558f08599000 + 0x1000 = 0x1140

with main symbol:

	$ nm ex | grep main
			 U __libc_start_main@@GLIBC_2.2.5
	0000000000001129 T main

0x1140 - 0x1129 = 0x17 which is correct


> 
> > > How does perf resolve the address 0x55e0b3b5e72e to main+0x25 here? If we
> > > look at this purely from the singular mmap event, this shouldn't be the
> > > case:
> > > 
> > > 1) The mmap event starts at 0x55e0b3b5e000, has size 0x1000, so its end is
> > > at 0x55e0b3b5f000.
> > > 
> > > 2) Address 55e0b3b5e72e is thus contained in this map, and at offset
> > > 0x72e.
> > > 
> > > 3) But main is not at this offset, it starts at 0x1709:
> > > 
> > > ```
> > > $ nm ./a.out | grep main
> > > 
> > >                  U __libc_start_main
> > > 
> > > 0000000000001709 T main
> > > ```
> > > 
> > > How does perf report/script still get the right answer here and knows that
> > > there's an offset of 0x1000?
> > > 
> > > Note that in reality, multiple mmap events occur. And the first one maps
> > > the file at an address with the 0x1000 offset. This can be seen by:
> > > 
> > > ```
> > > $ perf record --call-graph dwarf ./a.out
> > > $ perf script --show-mmap-events | grep /a.out
> > > a.out 149953 18488.265340: PERF_RECORD_MMAP2 149953/149953:
> > > [0x55b2f29d2000(0x4000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> > > a.out 149953 18488.265346: PERF_RECORD_MMAP2 149953/149953:
> > > [0x55b2f29d3000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > > a.out 149953 18488.265348: PERF_RECORD_MMAP2 149953/149953:
> > > [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> > > a.out 149953 18488.265350: PERF_RECORD_MMAP2 149953/149953:
> > > [0x55b2f29d5000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> > > a.out 149953 18488.265706: PERF_RECORD_MMAP2 149953/149953:
> > > [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> > > 
> > >             55b2f29d372e main+0x25 (/tmp/a.out)
> > >             55b2f29d372e main+0x25 (/tmp/a.out)
> > 
> > when you use '--call-graph dwarf' you also enable data mmaps,
> > so the extra mmap events are non-X mmaps
> 
> I see, is this an optimization to reduce the overhead when doing this 
> "shallow" sampling? Can one opt-in to the data mmaps without going the full 
> `--call-graph dwarf` way?

5c0cf22477ea perf record: Store data mmaps for dwarf unwind

says:
    But we've seen cases (softice) where DWARF unwinder went through non
    executable mmaps, which we need to lookup in MAP__VARIABLE tree.

it's hardcoded

jirka

