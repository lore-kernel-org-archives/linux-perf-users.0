From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH] perf tools: Add rootfs option for off-box analysis using
 specified tree
Date: Sun, 21 Nov 2010 10:02:24 -0700
Message-ID: <4CE950A0.2060705@cisco.com>
References: <1290356275-9969-1-git-send-email-y> <20101121163455.GA4024@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70]:19088 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0KURCZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 12:02:25 -0500
In-Reply-To: <20101121163455.GA4024@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org



On 11/21/10 09:34, Arnaldo Carvalho de Melo wrote:
> Em Sun, Nov 21, 2010 at 09:17:55AM -0700, y@cisco.com escreveu:
>> From: David Ahern <daahern@cisco.com>
>>
>> The rootfs argument allows analysis of perf.data file using a locally
>> accessible filesystem tree with debug symbols - e.g.,  loop mounted
>> KVM disk images, NFS, USB keys, initrds, etc. Anything with an OS tree
>> can be analyzed from anywhere without the need to populate a local
>> data store with build-ids.
> 
> Patch looks sane after quick look, just in doubt if "rootfs" is a good
> name for this, will look if this can be somehow combined with the kvm
> parameters.

I do want to have the ability to analyze a KVM hosted VM using an
external tree as well. e.g., --guestmount points to an sshfs mount and
--rootfs points to a tree with symbols for the stripped image running in
the VM.

I think my followup patch for kallsyms should be able to leverage some
of the guestkallsyms code from KVM.

David

> 
> Anybody else with cycles to think about this?
> 
> - Arnaldo
