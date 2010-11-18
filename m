From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: off-box analysis of perf.data file
Date: Thu, 18 Nov 2010 14:54:27 -0700
Message-ID: <4CE5A093.8020809@cisco.com>
References: <4CE0B108.8020205@cisco.com> <20101116234042.GA4856@ghostprotocols.net> <4CE465E9.4070107@cisco.com> <20101118201923.GA21029@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:47402 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab0KRVyd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Nov 2010 16:54:33 -0500
In-Reply-To: <20101118201923.GA21029@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, "Amit Patel (amitpate)" <amitpate@cisco.com>


On 11/18/10 13:19, Arnaldo Carvalho de Melo wrote:
>> In our case the product has "official" builds at regular intervals
>> (e.g., daily) with image trees in some automount area (e.g.,
>> /auto/${majorver}/${release}). Then developers create builds in personal
>> workspace areas, e.g. /auto/${user/my-build-${ver}-${release}. The
>> builds are done using cross-compile environments, so there is no single
>> "development machine".
> 
> But it is possible to have a single development server or to have
> multiple databases according to your needs.

Hmmm.... From a user perspective maintaining build-id databases for
short-use builds is more complex than using a --rootfs argument. i.e.,
add rootfs to symbol_conf with a default value of "", add a --rootfs
argument to analysis commands to allow a user to specify a path, and
within dso__load prepend the paths within rootfs. This appears to be
similar to what has been done for builtin-kvm and analyzing guest data.
Furthermore, this allows a wide range of options - loop mounting KVM
disk images, NFS trees, bootable USB keys, initrds, etc. Anything with
an OS tree can be analyzed from anywhere without the need to populate a
local data store.

Similar argument for kallsyms point to a file rather than pointing to
/proc/kallsyms -- which again parallels what has been done for builtin-kvm.

I guess my point is that perf contains a lot of hardcoded paths which is
great for standard use cases - default settings for users. But allow a
nerd knob that changes the path or offsets the path -- either for each
origin or at a minimum for the ORIG_DSO.


>> Development systems: We use a cross-compile environment for builds and
>> lab servers which would be used for analyzing a perf.data file can be
>> running a variety of linux versions and flavors - from RHEL4, RHEL5,
>> Fedora 10, Fedora 14, etc. In this case we would not want perf to look
>> at the vmlinux, kallsyms, libs and binaries on the system where the
>> analysis is done - something that perf does today as part of of its
>> default paths in dso__load.
> 
> "perf" is too vague, covers many subcommands, what specific subsystem, perhaps
> the above explanations made this question moot?

"perf" in the above meant all the commands that eventually call
dso__load. In my F14 - F13 test case (data collected on a Fedora 14
system and analyzed on a Fedora 13 system), 'strace -e trace=open perf
report ...' shows perf opening a lot of files on the F13 system - even
though the ~/.debug tree was populated using perf-archive.

David

>  
> - Arnaldo
