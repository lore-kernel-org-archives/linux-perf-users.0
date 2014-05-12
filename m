From: xiakaixu <xiakaixu@huawei.com>
Subject: Does perf support different length of user-space hw_breakpoint?
Date: Mon, 12 May 2014 15:52:54 +0800
Message-ID: <53707DD6.2000108@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from [119.145.14.64] ([119.145.14.64]:22605 "EHLO
	szxga01-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaELHyQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 May 2014 03:54:16 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: paulus@samba.org, Ingo Molnar <mingo@kernel.org>, a.p.zijlstra@chello.nl, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>, Namhyung Kim <namhyung@kernel.org>, Huxinwei <huxinwei@huawei.com>, peifeiyue@huawei.com

Hi guys,

Does perf support different length of user-space hw_breakpoint,
such as  HW_BREAKPOINT_LEN_1/HW_BREAKPOINT_LEN_2/HW_BREAKPOINT_LEN_4/
HW_BREAKPOINT_LEN_8?

Seems perf only support HW_BREAKPOINT_LEN_4/sizeof(long)
by default from the source code and simple test.

May I have your opinions if I want to trace different bytes of
hw_breakpoint addr?

Thanks,

Xia Kaixu
