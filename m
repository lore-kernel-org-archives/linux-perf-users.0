From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf CPU profiling in Xen guest fail & workaround
Date: Wed, 29 Jul 2015 15:21:54 -0700
Message-ID: <874mkm8v0d.fsf@tassilo.jf.intel.com>
References: <CAE40pdd6Ab9w1da7ztwed+h9NUbtLyqiC1-tarrGQsFo2MrmzQ@mail.gmail.com>
	<55B92661.7010309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53694 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbbG2WV5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jul 2015 18:21:57 -0400
In-Reply-To: <55B92661.7010309@gmail.com> (David Ahern's message of "Wed, 29
	Jul 2015 13:15:45 -0600")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

David Ahern <dsahern@gmail.com> writes:
>
> It's a known problem with VMs (Solaris based ldoms and apparently xen
> guests as examples). The hypervisor tells perf it has a PMU (see dmesg
> | grep Performance) but does not really implement it (no NMIs for
> example).

Actually Xen has a PMU model. I've never tested it, but from a quick
source review some time ago it seemed reasonable for Arch Perfmon v1,
when disabled.

If something doesn't work you should report it to the Xen people

BTW sampling works with KVM's PMU model; I'm using that occasionally.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
