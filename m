Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D641DB350
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126442; cv=none; b=Xjx10k9KJtLTkEh/DCtdo+cllQJ93j8iNHtiVInTjd3EuF5VH1S2k/cW7lhFyW7JVDP9a5b7kf7aWoKLzTpxDIxMeB2nGuPJojLVUysft9SwbaKH4lRVbU2/7oLyeywUQGRWXuFWpOlZVAivKl6O22DCrsEcqW72sFjTKBiPFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126442; c=relaxed/simple;
	bh=7Mh0WvD6X0KO7UwWvHQaJMD+R8Vu7Z0KJVH9XT6CGgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SjxV8gGALNJxESHI20oddRrBcp+K2LZgYAd3V3dQkbyiB1g4JCQrlEGAinSRBeauns5dRmVH288CozPpptlm8oh+gwuii7lGMbAmWi6wBfw5dfBFVR4wq/C0uckugBtUv8u/VPDl+8zEBbFv1LdBOslvBSqNGCN5T3/C8LjTw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbIPUdxA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbIPUdxA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D62771380368;
	Mon, 28 Oct 2024 10:40:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 10:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730126439; x=1730212839; bh=7Mh0WvD6X0KO7UwWvHQaJMD+R8Vu7Z0KJVH
	9XT6CGgY=; b=UbIPUdxAik1+JjVxpbLe2STASxjMAMVHw5UZt171+cJANnB8k43
	KuUR5ZtRcj1H3hDktG/8DO2fleMHwZLMlUcOCjQAd3Yd5fEHG3NxriArH4niFq90
	2UYs+qY5TkMtZD1akGBkIptdlRf5b0Ft6srYo03etSMmWCCMkraZvPCExUjxpuwC
	GfJLRF2GAflq1xW2Nhl2TgkzmOTf+LD7HN4yP/BZgPVoP8znQD20GjXQpJcWAvio
	W41V0kNUE76f8vpRoRZnEUiY6pz/WbjNpECKM4eb19dvDFCqnxbjM+fslph4CQBB
	g8pC+oXR3yaskgSbaFLO6lAf6ImU30YqCsg==
X-ME-Sender: <xms:Z6IfZ26971-C4HpaEvAbbjWuM5Bx0fV3qhjNEZhy2g9fn-NSBrpMkQ>
    <xme:Z6IfZ_6XooohDkIU3ufgDxdVxR9MYbhMfEdYb2OksPsFBQkFxLJFetJfAtTJrUwqy
    lKCZnHocDtWJbs>
X-ME-Received: <xmr:Z6IfZ1dDUXUcE36c2ahUoQjEZzb_XpNbyHN2Bgh9FwmWQ5CK0nPDUMH_Rzw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehi
    ughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvieejudeftd
    fgkedtjeetvddugeevgefgieefvefhfffgtdelgfeuffefvdeuheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstg
    hhrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhnuhigqdhpvghrfhdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhgrmhhhhihunhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z6IfZzJCMcFE7Ro3jwdKx80GJGy2iK2PMyxzF7Oyu44MXgdzoXe-3g>
    <xmx:Z6IfZ6LfzSHbdXVgX27yodx1t5Sqd9S8cdPict41HB2iRlOi-0Omcw>
    <xmx:Z6IfZ0xg0oFBHW4Iiwywx3UWLcwrz-YfDt5YjOWpjASEQdE71pFawA>
    <xmx:Z6IfZ-LZxGlUuFymuuGzyUiqP0qCK9xXJwmjavuWNu-wD--7rGil3Q>
    <xmx:Z6IfZ_ECTxYqr_GHhTihJPkWWt9-G-fGkICBbGrF9uGjpAajIF1Ub-de>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 10:40:38 -0400 (EDT)
Date: Mon, 28 Oct 2024 16:40:36 +0200
From: Ido Schimmel <idosch@idosch.org>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org
Subject: Suspicious RCU usage in perf_event_exec()
Message-ID: <Zx-iZPVtJHLNMGfk@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have recently enabled CONFIG_RCU_EXPERT and CONFIG_PROVE_RCU_LIST in
our debug configuration file and started observing the following splat
[1] on one of our machines. Can be reproduced using something as simple
as [2]. Searched the archives, but did not find a similar report.

It seems perf_iterate_ctx() is expected to be called from an RCU
read-side critical section and all the callers honor that except
perf_event_exec(). Note that perf_event_exec() did invoke the function
from an RCU read-side critical section prior to commit bd2756811766
("perf: Rewrite core context handling").

Thanks

[1]
WARNING: suspicious RCU usage
6.12.0-rc4-custom-g84fcd02ffaf6 #169 Not tainted
-----------------------------
kernel/events/core.c:8124 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by perf-exec/348:
 #0: ffff888007ff5998 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0xb8/0x18d0
 #1: ffff888007ff5a40 (&sig->exec_update_lock){++++}-{3:3}, at: begin_new_exec+0x237b/0x33d0

stack backtrace:
CPU: 6 UID: 0 PID: 348 Comm: perf-exec Not tainted 6.12.0-rc4-custom-g84fcd02ffaf6 #169
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 lockdep_rcu_suspicious.cold+0x4f/0xd6
 perf_iterate_ctx+0x438/0x580
 perf_event_exec+0x628/0xb50
 begin_new_exec+0x172e/0x33d0
 load_elf_binary+0x80f/0x4fc0
 bprm_execve+0x70d/0x18d0
 do_execveat_common.isra.0+0x51b/0x5f0
 __x64_sys_execve+0x91/0xc0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[2]
# perf record -q -e fib:* -- ip route get 1.1.1.1
