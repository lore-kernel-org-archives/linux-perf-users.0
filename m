Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C088C11F67
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 00:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F18D6140E
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 00:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhGBAoL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 20:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234391AbhGBAoL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 20:44:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3436761402;
        Fri,  2 Jul 2021 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625186500;
        bh=jgg/01k7XNlyHykkL21yCOqb1G088K69mvE94vN2MvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPQa8m+FlGhVRb22vgKO/UhRqY6xN0ZtFlBEzALeMAne1eVsywj33BR4ojnwkkMOp
         Wfx7tB8pscbybi4Ym4DhwrbHfo9cwkMtumgeouQ10rrQmwMtLvRYxzGvstbHaaocr7
         thW/htBGkrx6aBoHzSkg2YKokH6RRXJ8feS6g4RHa1pZEYFPUcozz8SCFU5HoMzK7n
         8UZCJA3KLG2Ax0WBIbkTxZzugw9lZjeB2i3skQ8+M+W20NJ5Sv1tgUcL8jSE90fBD2
         hJJkmXdaSqvs10XIz9alM0LUh7ec/W7f5rlqSDvQEWyinLXzHCttRCqb2wE57CqfDz
         J4BIYcm5mW2uw==
Date:   Fri, 2 Jul 2021 09:41:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: Part 2: perf test case probe libc fails with latest Fedora34
 glibc update
Message-Id: <20210702094137.8e4e8c14ff7956749bbbd38c@kernel.org>
In-Reply-To: <20210701010208.6c5129241ab490bc6a6b3197@kernel.org>
References: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
        <f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com>
        <20210629140242.c16d9bf368865025e0ead480@kernel.org>
        <a3b3487d-7eb7-cbdb-0bfb-d94cc621da83@linux.ibm.com>
        <20210701010208.6c5129241ab490bc6a6b3197@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, 1 Jul 2021 01:02:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Thomas,
> 
> OK, I finally found 2 root causes for this issue.
> 
> 1. debuginfo__new() forgot to call dso__load(). Thus, the dso is
> just initialized, but doesn't load the build-id. Then the build-id
> based debuginfo file is not searched. It must use map instead of dso.

I made a fix for this issue using dso__set_build_id() because
using dso__load() which loads symbols just for build-id seems sledgehammer.
So now I can see the perf probe opens build-id based debuginfo correctly.

However, this will not fix your issue because;

> 2. Not sure why, but /usr/lib64/libc-2.33.so is shown as "not stripped"
> binary. Then the elfutils is fooled by the information and open it
> as a debuginfo file. I think probe-finder.c also need to check the
> given file has DIE tree (debuginfo) or not by itself.

this part is not correct. perf-probe is using elfutils, which has
its own debuginfo search algorithm. Thus with or without the above
fix, perf-probe finally opens the correct debuginfo.
(from this reason, I can not show what has been fixed by the command
 output in commit message without debug print.)

And with decoding the debuginfo, I finally understand what was wrong.
The problem is that the "inet_pton" is a dynamic symbol, which does *NOT*
exist in the debuginfo. There is "__inet_pton" instead of "inet_pton".

-----
/* Like __inet_pton_length, but use strlen (SRC) as the length of
   SRC.  */
int
__inet_pton (int af, const char *src, void *dst)
{
  return __inet_pton_length (af, src, strlen (src), dst);
}
libc_hidden_def (__inet_pton)
weak_alias (__inet_pton, inet_pton)
libc_hidden_weak (inet_pton)
-----

Thus, if you pass the __inet_pton to perf-probe, it works.

-----
$ ./perf probe -x /lib64/libc.so.6 -L __inet_pton
<__inet_pton@/usr/src/debug/glibc-2.33-18.fc34.aarch64/resolv/inet_pton.c:0>
      0  __inet_pton (int af, const char *src, void *dst)
         {
           return __inet_pton_length (af, src, strlen (src), dst);
         }
-----

And -F (--functions) doesn't work yet.
-----
./perf probe  -x /usr/lib64/libc-2.33.so -F
@plt
@plt
calloc@plt
free@plt
malloc@plt
memalign@plt
realloc@plt
-----

I think we should remove @plt, and decode ".dynsym" in addition to ".symtab"
by map object for this issue at first. Then we may be able to get the address
of "inet_pton" from map.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
