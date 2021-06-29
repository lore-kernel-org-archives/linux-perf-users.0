Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC0C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 05:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE7B61DBE
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 05:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhF2FFL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 01:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhF2FFL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Jun 2021 01:05:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE4A461DB8;
        Tue, 29 Jun 2021 05:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624942964;
        bh=5kEpzVu3oLnG5FhYXg0dSCY/VaTnUUhjQKZsXXbQ2RA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2rq0C4maJVnE9/c3pbAxgxXxB0/b2SxM9XPvGVFdYdqiI/s9Jb2qbJqf0IWlVTqp
         ftsxgaOIMhXsImgV8WzvUsIYKGfA+escRLOmgj8N6zOQli7xGx6le4LC+nD3qHVySv
         05uaZzRlVV76w19XQ3brQxW6O1xaYveOIlHrnRqbn1TRJNPfyzVJSwOsr56lNT5+5V
         Kcvo5TlSLZYrsYJ334ASFuJvZbmqrm4aobLwYInYeyfyYhqTuEvfXMGMoL2xQmV/wc
         uHDfgmo5EzByvsoxSv7f8k2QbLLs4vqKkvuzgUQPZYueBWzsA/yugHWIjgYRtWA3+1
         V/l7zn1hn+64A==
Date:   Tue, 29 Jun 2021 14:02:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: Part 2: perf test case probe libc fails with latest Fedora34
 glibc update
Message-Id: <20210629140242.c16d9bf368865025e0ead480@kernel.org>
In-Reply-To: <f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com>
References: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
        <f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 25 Jun 2021 12:43:29 +0200
Thomas Richter <tmricht@linux.ibm.com> wrote:

> I think I found one issue:
> 
> Fedora 33 named the debug files for glibc 'libc-2.33.so.debug'
> [root@s8360047 ~]# rpm -ql glibc-debuginfo-2.33-5.fc34.s390x|fgrep libc-2.33.so
> /usr/lib/debug/lib64/libc-2.33.so.debug
> [root@s8360047 ~]#
> 
> The file was located in
>    /usr/lib/debug/lib64/libc-2.33.so.debug
> and hard linked to (or vice versa)
>    /usr/lib/debug/usr/lib64/libc-2.33.so.debug
> 
> With Fedora 34 the glibc debug file name changed to:
> /usr/lib/debug/lib64/libc-2.33.so-2.33-18.fc34.s390x.debug
> and
> /usr/lib/debug/usr/lib64/libc-2.33.so-2.33-18.fc34.x86_64.debug

Oh, the naming scheme has been changed.

> 
> This is important. The call chain is
> 
>  ...
>  try_to_find_probe_trace_events()
>  +-> open_debuginfo()
>      +-> debuginfo__new(/usr/lib64/libc-2.33.so)
>          +-> dso__read_binary_type_filename()
> 
> Function dso__read_binary_type_filename() now tries to find the debug file
> for /usr/lib64/libc-2.33.so for various distros starting with
> FEDORA_DEBUGINFO. Tt builds the file name by prepending
> '/usr/lib/debug' and appending '.debug'. This was ok until the Fedora 34
> name change. Now the debug file is not found anymore and various other
> distro name schemes are tried. None is found and the /usr/lib64/libc-2.33.so
> file itself is used.

Hmm, we might need a generic way to get such debuginfo path among
linux distros... are there any good command?

> 
> This even worked for Fedora 34 until the glibc 2.33-18 change, because the
> /usr/lib/libc-xxx.so file contained the complete symbol table in the
> .symtab section. The function debuginfo__find_probe_location() found
> the symbol inet_pton. So it did not matter is the debug file was found or not.
> 
> With the glib 2.33-18 change most entries in the .symtab section where
> moved to the .dynsym section and are not found anymore when the default
> /usr/lib/lic-xxx.so is used as fallback. So the issue surfaced.
> 
> Second issue:
> The symbol 'inet_pton' is defined as WEAK. Even when the correct
> debuginfo file is loaded for libc in function dso__read_binary_type_filename(),
> the perf probe command fails.
> However it works for GLOBAL and LOCAL symbols, so it would be definitly an 
> improvement.
> 
> I have no clue on dwarf so I put Masami on the addressee list.
> This second issue is somehow related to dwarf_getfuncs() and
> the probe_point_search_cb() call back function invoked by dwarf_getfuncs()
> in the probe_finder.c file. Too far away from my horizon :-)...
> 
> On 6/23/21 4:21 PM, Thomas Richter wrote:
> > I just updated Fedora34 to the latest level and discovered that perf test 78 fails:
> > [root@m46lp22 perf]# ./perf test 78
> > 78: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> > [root@m46lp22 perf]#
> > 
> > It boils down to this command and happens after glibc is update to level 2.33-18.
> > 
> > [root@f34 ~]# perf probe -f -x /usr/lib64/libc-2.33.so -a inet_pton
> > Probe point 'inet_pton' not found.
> >   Error: Failed to add events.

Hmm, what does "nm" say? Also, Does perf correctly open the debuginfo file or only
open the library without debuginfo?

> > [root@f34 ~]# rpm -qa | fgrep glibc
> > glibc-all-langpacks-2.33-18.fc34.x86_64
> > glibc-common-2.33-18.fc34.x86_64
> > glibc-langpack-en-2.33-18.fc34.x86_64
> > glibc-2.33-18.fc34.x86_64
> > glibc-doc-2.33-18.fc34.noarch
> > glibc-headers-x86-2.33-18.fc34.noarch
> > glibc-devel-2.33-18.fc34.x86_64
> > glibc-debugsource-2.33-18.fc34.x86_64
> > glibc-debuginfo-2.33-18.fc34.x86_64
> > [root@f34 ~]# 
> > 
> > The symbol inet_pton is now in the .dynsym section of glibc:
> > [root@f34 ~]# readelf -sW /usr/lib64/libc-2.33.so | egrep '(dynsym|symtab|inet_pton)'
> > Symbol table '.dynsym' contains 2419 entries:
> >    628: 000000000011ea00   108 FUNC    WEAK   DEFAULT   15 inet_pton@@GLIBC_2.2.5
> >   2251: 000000000011e9b0    76 FUNC    GLOBAL DEFAULT   15 __inet_pton_length@@GLIBC_PRIVATE
> > Symbol table '.symtab' contains 104 entries:
> > [root@f34 ~]#
> > 
> > The .symtab section does not contain symbol inet_pton. It contains very few symbols
> > compared to previous versions.

Hmm, if perf probe can not find the debuginfo, it failback to symbol map,
can you add -vvv option to run the perf probe again?

> > 
> > Now perf does not find it. In the older version of the library the
> > symbol inet_pton was listed in the .symtab section. Here is the output from version 2.32-4:
> > 
> > 
> > [root@m35lp76 ~]# rpm -qa | fgrep glibc
> > glibc-common-2.32-4.fc33.s390x
> > glibc-langpack-en-2.32-4.fc33.s390x
> > glibc-2.32-4.fc33.s390x
> > glibc-headers-s390-2.32-4.fc33.noarch
> > glibc-devel-2.32-4.fc33.s390x
> > glibc-debuginfo-common-2.32-4.fc33.s390x
> > glibc-debuginfo-2.32-4.fc33.s390x
> > [root@m35lp76 ~]# 
> > 
> > 
> > readelf -sW /usr/lib64/libc-2.32.so | egrep '(dynsym|symtab|inet_pton)'
> > Symbol table '.dynsym' contains 2604 entries:
> >    668: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton@@GLIBC_2.2
> >   2418: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length@@GLIBC_PRIVATE
> > Symbol table '.symtab' contains 28858 entries:
> >  20655: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS inet_pton.c
> >  20656: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c
> >  20657: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end
> >  20658: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.hot
> >  20659: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.hot
> >  20660: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.unlikely
> >  20661: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.unlikely
> >  20662: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.startup
> >  20663: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.startup
> >  20664: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.exit
> >  20665: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.exit
> >  20666: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.start
> >  20667: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.end
> >  20668: 00000000001440b0   250 FUNC    LOCAL  DEFAULT   13 inet_pton4
> >  20669: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.start
> >  20670: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.end
> >  20671: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.start
> >  20672: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.end
> >  23591: 00000000001441b0   764 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton_length
> >  23871: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __inet_pton
> >  24506: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton
> >  25831: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI_inet_pton
> >  26410: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length
> >  27288: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton
> > [root@m35lp76 ~]#
> > 
> > And perf could find the symbol, extract its address and install a probe
> > on that address.
> > So is this a bug related to the perf tool because it can not handle .dynsym section?
> > Or is it releated to glibc's rework?
> > 
> > Thanks for your help.
> > 

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
