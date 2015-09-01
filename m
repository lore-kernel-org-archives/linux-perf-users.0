From: Donatas Abraitis <donatas.abraitis@gmail.com>
Subject: perf uprobes
Date: Tue, 1 Sep 2015 15:19:21 +0300
Message-ID: <CAPF+HwXJAK_8ei03RucWgkQ+x0fLhf53RTGY+44SjBQ3J3bBYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35823 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbbIAMTY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Sep 2015 08:19:24 -0400
Received: by qkcj187 with SMTP id j187so35503507qkc.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Sep 2015 05:19:23 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi folks!

what's wrong here? Looks like it's valid variable (c->cmd->name), but
perf says it's invalid argument, any thoughts?

outputs: https://gist.github.com/ton31337/3bd154e9b229fc033c48

Thank you in advance!

Donatas.
