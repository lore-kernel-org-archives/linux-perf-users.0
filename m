From: Alex Newman <posix4e@gmail.com>
Subject: Bug Report
Date: Mon, 11 May 2015 09:57:42 -0700
Message-ID: <CAPMERti9KnqyR7U3upPz0wh14CEO=W1T=0_cDQ61cBASdKH-yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33771 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbEKQ6E (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 May 2015 12:58:04 -0400
Received: by qgdy78 with SMTP id y78so71003378qgd.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2015 09:58:03 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello mailing list friends,

I am sorry if this is not the best place for this (where should I
report improvements for perf).

This command works when I have the correct permissions but if I don't
rather than getting "bad permissions" I get

posix4e@posix4e-P27GV2:~$ perf stat -e 'ext4:' -a
invalid or unsupported event: 'ext4:'
Run 'perf list' for a list of valid events

usage: perf stat [] []

-e, --event <event>   event selector. use 'perf list' to list available events

I'd be happy to help fix this but I am still getting my head around
the parse_events infrastructure.

-Alex
