Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD11D52B;
	Fri, 13 Sep 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214447; cv=none; b=QsAcllLhMIFv45Y64DQ+G+LkHioVE/tGePdU2S4gZHvquh+OyDp0Upa2jm1QqfQe9krQqnE7UrO+aK32UyA4KpfU5mDxsKugXH3IrWiLNyPfkP7U3dPAldkOokwAkJYghTQuH/Mjnbf0GN7vL+R9djILW4OBJOtYmGhtGVlyzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214447; c=relaxed/simple;
	bh=PccrXOCdLtQfjCGDGyt5d/LJHCcVYMyN25csi+oWEyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IoIepKbFqPZzppRKZOfJJYwKu0L3MmWfS7dNrutI6/Io4rIPGLfbg1vtr8tNsEY1riA6z297iUNcbZLSptNOX6NKo04EyeUwKiNfz4/2a6Us4QUO70zmjmZVp2a9aBzHjsGwJnhvtG8rYEbV8jnZBqS3t8ihShk47KJP0jcMN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaLSgZj8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaLSgZj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A2C4CEC0;
	Fri, 13 Sep 2024 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726214446;
	bh=PccrXOCdLtQfjCGDGyt5d/LJHCcVYMyN25csi+oWEyA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=WaLSgZj8CBmGD723az40e0xa7KvBGxTYoosRFCnDtIhawvyLeQ0yJm1iukMujV54W
	 P/HLlUoGiPXwpbmFqj0Bybpab6vLDfLT2DgoS8649kARt47GXPxzMb8PDnMMazLGtg
	 pDqJx/nFO+tyWCMq4HYW16FkQIoJeMUeEHhMIYz1uLBf3ZWyNg+v1kst9CIxA8Tcmw
	 OFasbKW0jU9GU9ev3z1nW6w6rQ5/Pq5Jh0wk9dsv2khqv8aiUANh5Ofzwh9Mzek/gU
	 RoKjn7TmF8mmqQC/19+j9tYJMUJvhUE4UTk+3de9g89ao5HP9mBFHjZ9Yg/v4F75z2
	 6UfyAzNiumr9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16E22CE0EDF; Fri, 13 Sep 2024 01:00:44 -0700 (PDT)
Date: Fri, 13 Sep 2024 01:00:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com
Subject: [BUG BISECTED] Missing RCU reader in perf_event_setup_cpumask()
Message-ID: <2b66dff8-b827-494b-b151-1ad8d56f13e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On next-20240912 running rcutorture scenario TREE05, I see this
deterministically:

[   32.603233] =============================
[   32.604594] WARNING: suspicious RCU usage
[   32.605928] 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238 Not tainted
[   32.607812] -----------------------------
[   32.609140] kernel/events/core.c:13946 RCU-list traversed in non-reader section!!
[   32.611595]
[   32.611595] other info that might help us debug this:
[   32.611595]
[   32.614247]
[   32.614247] rcu_scheduler_active = 2, debug_locks = 1
[   32.616392] 3 locks held by cpuhp/4/35:
[   32.617687]  #0: ffffffffb666a650 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
[   32.620563]  #1: ffffffffb666cd20 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
[   32.623412]  #2: ffffffffb677c288 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2f0
[   32.626399]
[   32.626399] stack backtrace:
[   32.627848] CPU: 4 UID: 0 PID: 35 Comm: cpuhp/4 Not tainted 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238
[   32.628832] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   32.628832] Call Trace:
[   32.628832]  <TASK>
[   32.628832]  dump_stack_lvl+0x83/0xa0
[   32.628832]  lockdep_rcu_suspicious+0x143/0x1a0
[   32.628832]  perf_event_exit_cpu_context+0x2e5/0x2f0
[   32.628832]  ? __pfx_perf_event_exit_cpu+0x10/0x10
[   32.628832]  perf_event_exit_cpu+0x9/0x10
[   32.628832]  cpuhp_invoke_callback+0x130/0x2a0
[   32.628832]  ? lock_release+0xc7/0x290
[   32.628832]  ? cpuhp_thread_fun+0x4e/0x200
[   32.628832]  cpuhp_thread_fun+0x183/0x200
[   32.628832]  smpboot_thread_fn+0xd8/0x1d0
[   32.628832]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   32.628832]  kthread+0xd4/0x100
[   32.628832]  ? __pfx_kthread+0x10/0x10
[   32.628832]  ret_from_fork+0x2f/0x50
[   32.628832]  ? __pfx_kthread+0x10/0x10
[   32.628832]  ret_from_fork_asm+0x1a/0x30
[   32.628832]  </TASK>

I bisected this to:

4ba4f1afb6a9 ("perf: Generic hotplug support for a PMU with a scope")

This adds a perf_event_setup_cpumask() function that uses
list_for_each_entry_rcu() without an obvious RCU read-side critical
section, so the fix might be as simple as adding rcu_read_lock() and
rcu_read_unlock().  In the proper places, of course.  ;-)

						Thanx, Paul
