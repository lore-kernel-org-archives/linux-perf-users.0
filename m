From: Daniel John FitzGerald <daniel.j.fitzgerald@gmail.com>
Subject: perf_event sampling ring (mmap) buffers on architectures with large
 pages
Date: Tue, 9 May 2017 12:23:26 -0400
Message-ID: <8d792775-8e75-afdb-48bc-723ced7783b2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34052 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdEIQX3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 May 2017 12:23:29 -0400
Received: by mail-qt0-f172.google.com with SMTP id j29so5293115qtj.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 May 2017 09:23:29 -0700 (PDT)
Received: from [9.56.117.237] ([129.42.208.174])
        by smtp.googlemail.com with ESMTPSA id n42sm288616qta.17.2017.05.09.09.23.26
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2017 09:23:27 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I have a question about how to allocate and handle the mmap'd ring
buffer required by perf_event sampling on systems with potentially large
page sizes.

According to the perf_event_open man page:

        When using perf_event_open() in sampled mode, asynchronous events=

        (like counter overflow or PROT_EXEC mmap tracking) are logged int=
o a
        ring-buffer.  This ring-buffer is created and accessed through
        mmap(2).

        The mmap size should be 1+2^n pages, where the first page is a
        metadata page (struct perf_event_mmap_page) that contains various=

        bits of information such as where the ring-buffer head is.

But what if the underlying architecture supports large page sizes?  If
my application were running on a modern POWER processor, there is a very
real possibility that it has been configured to use 16GB page sizes.  In
that case, I would be allocating a whopping 16GB of memory for the mmap
metadata page.  Is there a workaround to prevent the allocation of such
a large amount of memory for the mmap metadata page?

In addition to this question, I would be interested in hearing if anyone
has had to deal with any other issues related to perf_event sampling on
a system with large pages.

--=20
Regards,
Dan FitzGerald

An enlightenment painter would paint a grand house on a lawn;
A romantic painter would paint it on fire.
