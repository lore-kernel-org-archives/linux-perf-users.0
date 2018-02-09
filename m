From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: RE: Records call-graphs on ARM, reporting on x86_64
Date: Fri, 9 Feb 2018 18:06:03 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989262D993@AZ-US1EXMB02.global.avaya.com>
References: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
 <2197547.58bztnllri@milian-kdab2>
 <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from p-us1-iereast-outbound.us1.avaya.com ([135.11.29.13]:9294 "EHLO
        p-us1-iereast-outbound.us1.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752649AbeBISGF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Feb 2018 13:06:05 -0500
In-Reply-To: <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Vuille, Martin (Martin)" <vmartin@avaya.com>, Milian Wolff <milian.wolff@kdab.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> > Afaik this is not yet implemented in perf report when you use libunwind.
> > When
> > you use elfutils instead of unwinding, it could work if I'm not mistaken.
> 

After further investigation, here's what I have found:

1) With the perf code as it stands, it is absolutely impossible to do cross-platform
     unwinding because the unwinding code selects Program Counter and Stack Pointer
     registers based on the host architecture, not the architecture of the ELF file.

After doing an ugly hack to work around this, I found:

2) The DSO path passed to libdw does not account for --symfs option. So libdw
     cannot find the debug information, ever.

I think I can tackle fixing (2).

It seems (1) is more of an architectural issue. If I understand correctly, perf can only
support one architecture, which is selected with conditional compilation based on
the architecture of the machine on which perf is built. This would have to change
to be able to dynamically select the architecture based on ELF content, same as libdw
does.

MV
