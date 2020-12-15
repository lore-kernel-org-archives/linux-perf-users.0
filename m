Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60450C4361B
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Dec 2020 13:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226C92246B
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Dec 2020 13:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgLONGq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Dec 2020 08:06:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729202AbgLONGl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Dec 2020 08:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608037514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6i1R/Jux6rGJveB2XImrKP/x2SEO2B2XneZ8p4LAjo=;
        b=OC9bNfmv+mFqgDBIzA5NcqXApCTKJ6uw7CoHkrsDwa7KxXLz55dYZ0BBGjTVwhvtsubsxE
        OSPZdq5Gfdd2NrD6rUuo+7vK/WW1Y8ITjaniG73KpyrcrOXwOHKjGu+xKBNxuo1TGE07h1
        w0xaabTOQe4Xr9/T7BRlDab24FWNiTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-MWPDB960PNKA957o_gb9yg-1; Tue, 15 Dec 2020 08:05:10 -0500
X-MC-Unique: MWPDB960PNKA957o_gb9yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81ED80875;
        Tue, 15 Dec 2020 13:03:44 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10EB560C0F;
        Tue, 15 Dec 2020 13:03:44 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 0E0D3243; Tue, 15 Dec 2020 10:03:40 -0300 (BRT)
Date:   Tue, 15 Dec 2020 10:03:39 -0300
From:   Arnaldo de Melo <acme@redhat.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: perf test 42 failure on x86
Message-ID: <20201215130339.GA11613@redhat.com>
References: <18a7ad32-1da7-f744-411d-d08ff4dfa91a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18a7ad32-1da7-f744-411d-d08ff4dfa91a@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Dec 14, 2020 at 05:30:46PM +0100, Thomas Richter escreveu:
> Hi,
> 
> I just installed Fedora 33 and its latest kernel on my x86_64 virtual machine and
> ran into a perf test issue:
> 
> [root@f33 ~]# uname -a
> Linux f33 5.9.13-200.fc33.x86_64 #1 SMP Tue Dec 8 15:42:52 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@f33 ~]#[root@f33 ~]# perf test -F 42
> 42: BPF filter                                            :
> 42.1: Basic BPF filtering                                 : Ok
> 42.2: BPF pinning                                         : Ok
> 42.3: BPF prologue generation                             : Ok
> 42.4: BPF relocation checker                              : FAILED!
> [root@f33 ~]# 
> 
> The last test fails due to unexpected success:
> [root@f33 ~]# perf test -v -F 42
> 42: BPF filter                                            :
> 42.1: Basic BPF filtering                                 :
> --- start ---
> ....
> libbpf: skip section(9) .eh_frame
> libbpf: section(10) .rel.eh_frame, size 16, link 12, flags 0, type=9
> libbpf: skip relo .rel.eh_frame(10) for section(9)
> libbpf: section(11) .llvm_addrsig, size 5, link 12, flags 80000000, type=1879002115
> libbpf: skip section(11) .llvm_addrsig
> libbpf: section(12) .symtab, size 192, link 1, flags 0, type=2
> libbpf: looking for externs among 8 symbols...
> libbpf: collected 0 externs total
> libbpf: maps in [bpf_relocation_test]: 1 maps in 16 bytes
> libbpf: map 'my_table' (legacy): at sec_idx 5, offset 0.
> libbpf: map 6 is "my_table"
> libbpf: map '_bpf_rel.bss' (global data): at sec_idx 6, offset 0, flags 400.
> libbpf: map 1 is "_bpf_rel.bss"
> libbpf: collecting relocating info for: 'func=sys_write'
> libbpf: relo for shdr 6, symb 7, value 0, type 1, bind 1, name 26 ('this_is_a_global_val'), insn 7
> libbpf: found data map 1 (_bpf_rel.bss, sec 6, off 0) for insn 7
> Success unexpectedly: libbpf error when dealing with relocation
> ---- end ----
> BPF filter subtest 4: FAILED!
> [root@f33 ~]#
> 
> There is success when failure is expected. Has anybody already started to look into this?

I saw this but didn't manage to start working on it, if you could try to
investigate this, that would be fantastic.

Thanks,

- Arnaldo

> 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

