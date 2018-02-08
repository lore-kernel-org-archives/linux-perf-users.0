From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: Records call-graphs on ARM, reporting on x86_64
Date: Thu, 8 Feb 2018 16:13:24 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co300216-co-outbound.net.avaya.com ([198.152.13.100]:2839 "EHLO
        co300216-co-outbound.net.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751190AbeBHQNg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Feb 2018 11:13:36 -0500
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

I would like to collect call-graphs on my ARM target and examine them on my x86_64 host.
I have no debug info on the ARM target; it is available on the x86_64 host.

On the ARM, I am passing the '--call-graph dwarf' option to 'perf record'.
As I understand it, this collects user stacks for each event and the unwinding is done by
'perf report' using DWARF debug info.

When I look at the data with 'perf report', most of the call stacks contain "bogus" addresses
that are in data (e.g., stack) or unmapped areas of the process address space. (This is pure
C/C++ code, there's no JITing that I know of.)

What I am unclear about is whether DWARF is DWARF or whether there are "ARM DWARF"
and "x86_64 DWARF". And if the latter is true, what do I need to do to interpret "ARM DWARF"
on my x86_64 host?

MV
