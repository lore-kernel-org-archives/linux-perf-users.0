Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6DC2D0E4
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Nov 2020 22:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A23206A5
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Nov 2020 22:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1enj2LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgKWWNQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:13:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728989AbgKWWNQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Nov 2020 17:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606169595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUzeaMowYEmx6ZVoUNh1z7hTPU36/6HTvCubjhwIgxw=;
        b=H1enj2LQ5gltY7Y65aCi52IQN0AGuIkSZjCbKM9wh9w3IvH4nSmCvZVbHvXpdgJgUjLh9W
        kfOyeFkbxv13ni7OZZz+p/M89ovGyjrzIUQWybUCiGdp/462LbBNCKbBqRar0EUiTVBM9r
        Tkvf3XkIrzzhEVB9VXUzwVfPeCram/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-XPe7M0S2NUKxa2Ga9LXB2Q-1; Mon, 23 Nov 2020 17:13:00 -0500
X-MC-Unique: XPe7M0S2NUKxa2Ga9LXB2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1665A0C06;
        Mon, 23 Nov 2020 22:12:58 +0000 (UTC)
Received: from krava (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A2455D9E3;
        Mon, 23 Nov 2020 22:12:47 +0000 (UTC)
Date:   Mon, 23 Nov 2020 23:12:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jan Kratochvil <jan.kratochvil@redhat.com>
Cc:     "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        John Levon <levon@movementarian.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: libdw dwarf unwind issue
Message-ID: <20201123221247.GC2003988@krava>
References: <20201103221709.GL3597846@krava>
 <20201122222751.GA1362915@host1.jankratochvil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122222751.GA1362915@host1.jankratochvil.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Nov 22, 2020 at 11:27:51PM +0100, Jan Kratochvil wrote:

SNIP

>              --1.15%--iothread_run
>                        aio_poll
>                        qemu_poll_ns
> 
> 
> > any idea why libdw is doing that? ;-)
> 
> Because libdw was reporting separate debuginfo file as the main file:
> 
> (lldb) p thread->process->dwfl->modulelist->main.name
> (char *) $1 = 0x0000000000b52490 "/home/jkratoch/.debug/.build-id/fc/d0111443729957fa8ef9511ff5dc3e9a5ccf9d/debug"
> (lldb) p thread->process->dwfl->modulelist->debug.name
> (char *) $2 = 0x0000000000000000
> 
> The correct way is to report the main ELF file as the main file:
> 
> (lldb) p thread->process->dwfl->modulelist->main.name
> (char *) $1 = 0x0000000000b52490 "/home/jkratoch/.debug/.build-id/fc/d0111443729957fa8ef9511ff5dc3e9a5ccf9d/elf"
> (lldb) p thread->process->dwfl->modulelist->debug.name
> (char *) $2 = 0x0000000000000000
> 
> In some cases it may later fill-in even the ->debug.name with "/debug" filename.

hi,
it fixes the issue for me, but it breaks the dwarf test:

72: DWARF unwind                                                    : FAILED!
[jolsa@krava perf]$ sudo ./perf test dwarf -v
72: DWARF unwind                                                    :
--- start ---
test child forked, pid 2084484
unwind: failed with 'No such file or directory'
got wrong number of stack entries 0 != 8
test child finished with -1
---- end ----
DWARF unwind: FAILED!

thanks,
jirka

