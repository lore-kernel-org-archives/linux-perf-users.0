From: Johan Tibell <johan.tibell@gmail.com>
Subject: 'annotate' confusingly reports 'add' instruction as taking most CPU time
Date: Mon, 30 Sep 2013 21:06:56 -0700
Message-ID: <CAK-tuPbbbWcbJxk88xO_urj2ktk861xnG+tkOs0cZBjnowjMeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:34294 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3JAEHS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Oct 2013 00:07:18 -0400
Received: by mail-qa0-f41.google.com with SMTP id ii20so3004362qab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2013 21:07:17 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to use 'perf record' to find the hotspot inside a function.
The results I'm seeing are confusing. 'annotate' claims that a simple
'add' instruction is the main CPU time consumer"

        0.00 :          408246:       mov    0x8(%rbp),%rsi
                                                               0.31 :
        40824a:       mov    0x10(%rbp),%rcx
                                              0.00 :          40824e:
     lea    0x4(%rcx),%rdi
                                0.81 :          408252:       mov
0x6(%rbx),%rbx
                  0.00 :          408256:       mov
0x18(%rbx,%rax,8),%r8
     --->   27.58 :          40825b:       add    $0x20,%rbp

0.00 :          40825f:       jmpq   408338 <Main_zdwpolyzugo_info>
                                             0.00 :          408264:
    mov    $0x7b9609,%ebx
                           0.00 :          408269:       add
$0x20,%rbp
                    0.00 :          40826d:       jmpq   *0x0(%rbp)

        5.41 :          408270:       mov    0xd(%rbx),%rax

How shall I interpret this? Is it really the following jump that is to blame?

-- Johan
