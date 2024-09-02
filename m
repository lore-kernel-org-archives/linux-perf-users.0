Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6620FABE
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287496; cv=none; b=Ipt8KpFiSreEn4A11pUWZFeUuZchDu6PEAxr43tk10Na2drBTUTNLrTTzGB91My/8r0k3dMsdXAfCtY5eAziJCyCkv35TQNtLochTeVAdHH9BiWTJ4sP9ftULzQVfHQPYLO4Sok/VrnUwQZGujfepPW69ZmKsOfZ1UipGtwoHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287496; c=relaxed/simple;
	bh=CWI0zCD2kT1RhiyjOWS2t+XrubkZ7og6MI6BHya+4as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9gmS8ZLoSydi7lIbYrNOxipyK8ziLNSqHiEOuaUyG10xwjuBhBCUT3YFFfQ7Z/h7f2qkhob6oKnk2p2Pwc7ykwvNtDSUAtLo8+0F4SWNQUIAXtMyd3UhSPycdvIzH+2qSR4GApvw5GHAyw4HE5jQ+/ka/DPIXNv1too4PjBW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1dm8NVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1dm8NVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBDBC4CEC2;
	Mon,  2 Sep 2024 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725287496;
	bh=CWI0zCD2kT1RhiyjOWS2t+XrubkZ7og6MI6BHya+4as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1dm8NVZSMXbYFCjx2dYF5fsUJvvmRZTFNIdtRZSHJcFCyuojlCBpqgsoLFEmtS1n
	 SuqyUGp4z9FZASgkvxBDZj4rMjC245ICA4aCjJqfQgTMQY1/duMdg0a8MjiyrZNht3
	 mW0KpCIkVLUfovbq+/Z2D4MF5IXw3mmtL4z69EEifPajB0YHhJewSV97LUtSej9iK0
	 a6j8kTYvJNAihHXuwRG04MxwpfSzvtHIiJuZ/eaPOs78F1nGkZ3EV7moZE2BVxR5ok
	 WEeVbhmC42Z1xcAgDikzEOb2LvPRUduhZPphSa0DzRxGtkV9GRQonLhFqwak6eeo7k
	 dN5pg5E/IK0FA==
Date: Mon, 2 Sep 2024 11:31:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZtXMRffIGVmjptcf@x1>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
 <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
 <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>

On Mon, Sep 02, 2024 at 04:05:04PM +0200, Veronika Molnarova wrote:
> On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
> >>> Ping

> > So, is there some other knob to get further output from that FAIL case?
> > Like the command that is failing? I'll try to take a look at the
> > sources, but are you seeing this problem with what is in
> > perf-tools-next/perf-tools-next?
> 
> Couldn't reproduce the issue on multiple systems. There is no further way
> of getting more logs from the test case. The output of the failure is from
> the regex checking when a line wasn't matched to any possible regex.
> Looking at the test case "adding blacklisted function warn_thunk_thunk",
> the failure is caused by command 'perf probe warn_thunk_thunk', which is
> a blacklisted function taken from "/sys/kernel/debug/kprobes/blacklist".
> 
> If the variable "PERFTEST_KEEP_LOGS=y" is set to keep debug logs located in
> "/tmp/perftool-testsuite_probe.XXX", those could provide some more info.
> 
> Would it be possible to get system specification for the possible issue
> reproduction?

root@x1:~# head /etc/os-release 
NAME="Fedora Linux"
VERSION="40 (Workstation Edition)"
ID=fedora
VERSION_ID=40
VERSION_CODENAME=""
PLATFORM_ID="platform:f40"
PRETTY_NAME="Fedora Linux 40 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:40"
root@x1:~# uname -a
Linux x1 6.10.4-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Aug 11 15:32:50 UTC 2024 x86_64 GNU/Linux
root@x1:~#

root@x1:~# perf probe warn_thunk_thunk
A function DIE doesn't have decl_line. Maybe broken DWARF?
A function DIE doesn't have decl_line. Maybe broken DWARF?
Probe point 'warn_thunk_thunk' not found.
  Error: Failed to add events.
root@x1:~# perf probe -vvv -L warn_thunk_thunk
capget syscall failed (No such file or directory - 2) fall back on root check
Looking at the vmlinux_path (8 entries long)
Using /usr/lib/debug/lib/modules/6.10.4-200.fc40.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/.build-id/32/6993e6ef36099bc55f5d9c9d3c6cefe2c9a5fb.debug
fname: (null), lineno:0
New line range: 0 to 2147483647
Failed to get the declared file name of warn_thunk_thunk
path: (null)
Debuginfo analysis failed.
  Error: Failed to show lines. Reason: Invalid argument (Code: -22)
root@x1:~#
root@x1:~# perf probe -L warn_thunk_thunk
Debuginfo analysis failed.
  Error: Failed to show lines.
root@x1:~# perf probe icmp_rcv
Added new event:
  probe:icmp_rcv       (on icmp_rcv)

You can now use it in all perf tools, such as:

	perf record -e probe:icmp_rcv -aR sleep 1

root@x1:~# perf probe -L icmp_rcv | head
<icmp_rcv@/usr/src/debug/kernel-6.10.4/linux-6.10.4-200.fc40.x86_64/net/ipv4/icmp.c:0>
      0  int icmp_rcv(struct sk_buff *skb)
         {
      2  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
         	struct rtable *rt = skb_rtable(skb);
         	struct net *net = dev_net(rt->dst.dev);
         	struct icmphdr *icmph;
         
         	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
      8  		struct sec_path *sp = skb_sec_path(skb);
root@x1:~#

root@x1:~# grep warn_thunk_thunk /proc/kallsyms 
ffffffff97004ae0 T __pfx_warn_thunk_thunk
ffffffff97004af0 T warn_thunk_thunk
root@x1:~#

root@x1:~# rm -f /tmp/perftool-testsuite_probe.*
rm: cannot remove '/tmp/perftool-testsuite_probe.C62': Is a directory
rm: cannot remove '/tmp/perftool-testsuite_probe.cyR': Is a directory
rm: cannot remove '/tmp/perftool-testsuite_probe.XOQ': Is a directory
root@x1:~# rm -rf /tmp/perftool-testsuite_probe.*
root@x1:~# export PERFTEST_KEEP_LOGS=y
root@x1:~# perf test 88
 88: perftool-testsuite_probe                                        : FAILED!
root@x1:~#
root@x1:~# ls -la /tmp/perftool-testsuite_probe.RJh/
total 0
drwx------.  3 root root   60 Sep  2 11:24 .
drwxrwxrwt. 30 root root 1900 Sep  2 11:24 ..
drwxr-xr-x.  3 root root   80 Sep  2 11:24 perf_probe
root@x1:~# ls -la /tmp/perftool-testsuite_probe.RJh/perf_probe/
total 80
drwxr-xr-x. 3 root root    80 Sep  2 11:24 .
drwx------. 3 root root    60 Sep  2 11:24 ..
drwxr-xr-x. 2 root root   740 Sep  2 11:24 logs
-rw-------. 1 root root 80170 Sep  2 11:24 perf.data
root@x1:~# ls -la /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/
total 108
drwxr-xr-x. 2 root root  740 Sep  2 11:24 .
drwxr-xr-x. 3 root root   80 Sep  2 11:24 ..
-rw-r--r--. 1 root root  191 Sep  2 11:24 adding_blacklisted.err
-rw-r--r--. 1 root root    0 Sep  2 11:24 adding_blacklisted_list.log
-rw-r--r--. 1 root root    0 Sep  2 11:24 adding_blacklisted.log
-rw-r--r--. 1 root root  165 Sep  2 11:24 adding_kernel_add--add.err
-rw-r--r--. 1 root root  165 Sep  2 11:24 adding_kernel_add-a.err
-rw-r--r--. 1 root root  165 Sep  2 11:24 adding_kernel_add.err
-rw-r--r--. 1 root root 7280 Sep  2 11:24 adding_kernel_adding_wildcard.err
-rw-r--r--. 1 root root  165 Sep  2 11:24 adding_kernel_dryrun.err
-rw-r--r--. 1 root root  165 Sep  2 11:24 adding_kernel_forceadd_01.err
-rw-r--r--. 1 root root  214 Sep  2 11:24 adding_kernel_forceadd_02.err
-rw-r--r--. 1 root root  169 Sep  2 11:24 adding_kernel_forceadd_03.err
-rw-r--r--. 1 root root  201 Sep  2 11:24 adding_kernel_func_retval_add.err
-rw-r--r--. 1 root root  161 Sep  2 11:24 adding_kernel_func_retval_record.err
-rw-r--r--. 1 root root 1651 Sep  2 11:24 adding_kernel_func_retval_script.log
-rw-r--r--. 1 root root   58 Sep  2 11:24 adding_kernel_list-l.log
-rw-r--r--. 1 root root   72 Sep  2 11:24 adding_kernel_list.log
-rw-r--r--. 1 root root    0 Sep  2 11:24 adding_kernel_list_removed.log
-rw-r--r--. 1 root root  328 Sep  2 11:24 adding_kernel_nonexisting.err
-rw-r--r--. 1 root root   38 Sep  2 11:24 adding_kernel_removing.err
-rw-r--r--. 1 root root   78 Sep  2 11:24 adding_kernel_removing_wildcard.err
-rw-r--r--. 1 root root  294 Sep  2 11:24 adding_kernel_using_probe.log
-rw-r--r--. 1 root root  131 Sep  2 11:24 adding_kernel_using_two.log
-rw-r--r--. 1 root root  589 Sep  2 11:24 aux.log
-rw-r--r--. 1 root root    0 Sep  2 11:24 basic_quiet01.err
-rw-r--r--. 1 root root    0 Sep  2 11:24 basic_quiet01.log
-rw-r--r--. 1 root root    0 Sep  2 11:24 basic_quiet02.err
-rw-r--r--. 1 root root    0 Sep  2 11:24 basic_quiet03.log
-rw-r--r--. 1 root root 3064 Sep  2 11:24 basic_usage.log
-rw-r--r--. 1 root root  938 Sep  2 11:24 invalid_options_missing_argument-a.err
-rw-r--r--. 1 root root  485 Sep  2 11:24 invalid_options_missing_argument-d.err
-rw-r--r--. 1 root root  517 Sep  2 11:24 invalid_options_missing_argument-L.err
-rw-r--r--. 1 root root  535 Sep  2 11:24 invalid_options_missing_argument-V.err
-rw-r--r--. 1 root root  750 Sep  2 11:24 invalid_options_mutually_exclusive.log
-rw-r--r--. 1 root root    0 Sep  2 11:24 invalid_options_unnecessary_argument-F.err
-rw-r--r--. 1 root root    0 Sep  2 11:24 invalid_options_unnecessary_argument-l.err
root@x1:~#

root@x1:~# grep "decl_line" /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/*
/tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err:A function DIE doesn't have decl_line. Maybe broken DWARF?
/tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err:A function DIE doesn't have decl_line. Maybe broken DWARF?
root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err
A function DIE doesn't have decl_line. Maybe broken DWARF?
A function DIE doesn't have decl_line. Maybe broken DWARF?
Probe point 'warn_thunk_thunk' not found.
  Error: Failed to add events.
root@x1:~#
root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted_list.log 
root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.log 
root@x1:~#

So is it just a matter of adding this output to the expected outputs?
In test_adding_blacklisted.sh?

- Arnaldo
