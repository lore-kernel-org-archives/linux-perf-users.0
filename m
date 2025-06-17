Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD652BEFF3;
	Tue, 17 Jun 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157902; cv=none; b=vC3QdBpmFLWg/W+n1trjI2BpWcdH9UQJl3XHvnlA8P4g0FV9lCH861TGSCzSefGc4YinInTL/rfOruJRwq2aWae1awdw8fp9h2LcqiZUlK8PHu/QiqGt+lslvqAmCQ4+4lWC4v9lKK22TqE1hth0Tip66QnHXC0AkF42E+9AX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157902; c=relaxed/simple;
	bh=uODVERJuVAE2TSNC+j7GBrQikA041X9A0rYYyItUjkw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PMIwDAhfJckyJgfFU9o0UuI45UNeOJbBzD/CwMoeTDEIN+kV5QTR6pHupYrXcSnjq4UL0vsIeHTaIp0ejrc6wZsm8iNryvg1Cck+NqbQDWgyRRPmdrVLAHW4XyqlPwdSELHrz7bkLvtublKZUG2urAh8KQ3lh64xFTR8K98TWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bM3hq1rrJz2TSJH;
	Tue, 17 Jun 2025 18:56:43 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B7BB14010D;
	Tue, 17 Jun 2025 18:58:10 +0800 (CST)
Received: from kwepemq500002.china.huawei.com (7.202.195.240) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 18:58:10 +0800
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 kwepemq500002.china.huawei.com (7.202.195.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 18:58:09 +0800
Received: from kwepemq200002.china.huawei.com ([7.202.195.90]) by
 kwepemq200002.china.huawei.com ([7.202.195.90]) with mapi id 15.02.1544.011;
 Tue, 17 Jun 2025 18:58:09 +0800
From: duchangbin <changbin.du@huawei.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: duchangbin <changbin.du@huawei.com>
Subject: [Bug] Kernel BUG in function_graph tracer in linux kernel 6.16.0-rc2+
Thread-Topic: [Bug] Kernel BUG in function_graph tracer in linux kernel
 6.16.0-rc2+
Thread-Index: AQHb33aZF0iIj1tGCESL7m5jEC9Dug==
Date: Tue, 17 Jun 2025 10:58:09 +0000
Message-ID: <4ab1a7bdd0174ab09c7b0d68cdbff9a4@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemq200002.china.huawei.com (15.02.1544.011)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFAA930B54AD0344A7CDD0DFD58794FA@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,
This is a bug report for kernel function_graph tracer when enabling the
'funcgraph-args' option. It seems that the registration logic is not quite
correct, but I haven't conducted an in-depth analysis of the issue yet.
This problem has already existed since version 6.15 at least.

The following are the steps to reproduce the issue.
1. Enable CONFIG_FUNCTION_GRAPH_TRACER CONFIG_PROBE_EVENTS_BTF_ARGS
2. Trace a function using function_graph tracer and enable the 'funcgraph-a=
rgs' option.
# echo 1 > /sys/kernel/debug/tracing/options/funcgraph-args
# perf ftrace -G vfs_read
------------[ cut here ]------------
WARNING: CPU: 7 PID: 331 at kernel/trace/ftrace.c:3509 ftrace_startup_subop=
s+0x3b8/0x460
Modules linked in:
CPU: 7 UID: 0 PID: 331 Comm: perf Not tainted 6.16.0-rc2+ #531 PREEMPT(unde=
f)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga=
6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:ftrace_startup_subops+0x3b8/0x460
Code: 00 01 00 00 00 00 ad de 49 89 85 e0 00 00 00 48 83 c0 22 49 89 85 e8 =
00 00 00 e9 b5 fd ff ff 41 bf ed ff ff ff e9 aa fd ff ff <0f> 0b 41 bf f0 f=
f ff ff e9 9d fd ff ff 4c 89 e7 e8 53 3d 6a 00 84
RSP: 0018:ffffc90000f67c90 EFLAGS: 00010202
RAX: 00000000000c2041 RBX: 0000000000000000 RCX: ffff88800b079e00
RDX: 0000000000000000 RSI: ffffffff833dc130 RDI: ffffffff833dc5c0
RBP: ffffffff833dc120 R08: ffffffff8320e580 R09: 00000000fffffff8
R10: ffff888004447c70 R11: 0000000000000000 R12: 0000000000000008
R13: ffffffff833dc130 R14: ffffffff833dc5c0 R15: 0000000000000008
FS:  00007f95586c8780(0000) GS:ffff8880fa011000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056248e0c1ce8 CR3: 0000000004f51004 CR4: 0000000000372ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_ftrace_graph+0x1fd/0x6a0
 ? mutex_unlock+0x5/0x20
 graph_trace_init+0x5e/0x80
 tracing_set_tracer+0x183/0x330
 tracing_set_trace_write+0x75/0xc0
 ? vfs_write+0x30e/0x440
 vfs_write+0xee/0x440
 ? 0xffffffffc0000083
 ksys_write+0x67/0xe0
 do_syscall_64+0x67/0x2e0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f9556b0bee4
Code: 15 39 9f 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 =
0f 1e fa 80 3d fd 26 0f 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
RSP: 002b:00007ffe2e0693c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9556b0bee4
RDX: 000000000000000f RSI: 000056248e0bbe60 RDI: 0000000000000003
RBP: 00007ffe2e069620 R08: 0000000000000073 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000056248e0bcc90
R13: 0000000000000003 R14: 00005624770ee1dd R15: 000056248e0bbe60
 </TASK>
---[ end trace 0000000000000000 ]---
failed to set current_tracer to function_graph
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0
Oops: Oops: 0010 [#1] SMP
CPU: 7 UID: 0 PID: 331 Comm: perf Tainted: G        W           6.16.0-rc2+=
 #531 PREEMPT(undef)
Tainted: [W]=3DWARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga=
6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000f678b8 EFLAGS: 00010002
RAX: 0000000000000001 RBX: ffff88800f6251c0 RCX: 0000000000000000
RDX: ffffc90000f67940 RSI: ffffffff833dc120 RDI: ffffc90000f678dc
RBP: ffffffff812fbbf0 R08: 0000000000000000 R09: ffffffff833dc120
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000f67940
R13: 0000000000000007 R14: 0000000000000000 R15: ffffffffffffffef
FS:  00007f95586c8780(0000) GS:ffff8880fa011000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000004f51004 CR4: 0000000000372ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 function_graph_enter_regs+0x22f/0x310
 ftrace_graph_func+0x38/0x50
 0xffffffffc0000083
 ? ftrace_ops_test+0x31/0x50
 ? graph_entry+0x216/0x390
 ? rcu_read_unlock_special+0x160/0x160
 ? restore_regs_and_return_to_kernel+0x22/0x22
 ? page_fault_oops+0x5/0x480
 ? trace_hardirqs_off_finish+0x22/0x70
 page_fault_oops+0x5/0x480
 exc_page_fault+0x44e/0x810
 asm_exc_page_fault+0x22/0x30
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000f67af8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88800f6251c0 RCX: 0000000000000000
RDX: ffffc90000f67b80 RSI: ffffffff833dc120 RDI: ffffc90000f67b1c
RBP: ffffffff8150b660 R08: 00000000fffffff7 R09: ffffffff833dc120
R10: 0000000000000000 R11: 807fffffffffffff R12: ffffc90000f67b80
R13: 0000000000000003 R14: 0000000000000000 R15: fffffffffffffff7
 ? static_call_del_module+0x80/0x80
 ? function_graph_enter_regs+0x22f/0x310
 ? ftrace_no_pid_write+0x10/0x10
 ? ftrace_graph_func+0x38/0x50
 ? 0xffffffffc0000083
 ? 0xffffffffc0000083
 ? 0xffffffffc0000083
 ? __SCT__tp_func_preempt_enable+0x8/0x8
 ? __static_call_update+0x5/0x200
 ? __might_resched+0x5/0x160
 ? mutex_lock+0x5/0x80
 ? __static_call_update+0x5/0x200
 ? fgraph_update_pid_func+0x78/0x80
 ? ftrace_update_pid_func+0x57/0x80
 ? ftrace_pid_open+0x82/0xd0
 ? do_dentry_open+0x1fd/0x570
 ? vfs_open+0x2a/0xe0
 ? path_openat+0x312/0x12d0
 ? graph_entry+0x216/0x390
 ? graph_entry+0x216/0x390
 ? do_filp_open+0xbf/0x170
 ? 0xffffffffc0000083
 ? preempt_count_sub+0x5/0x50
 ? do_sys_openat2+0x70/0xc0
 ? __x64_sys_openat+0x52/0xa0
 ? do_syscall_64+0x67/0x2e0
 ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---

--=20
Cheers,
Changbin Du
