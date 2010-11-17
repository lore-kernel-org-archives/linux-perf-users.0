From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: off-box analysis of perf.data file
Date: Wed, 17 Nov 2010 16:31:53 -0700
Message-ID: <4CE465E9.4070107@cisco.com>
References: <4CE0B108.8020205@cisco.com> <20101116234042.GA4856@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:40162 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0KQXby (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Nov 2010 18:31:54 -0500
In-Reply-To: <20101116234042.GA4856@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, "Amit Patel (amitpate)" <amitpate@cisco.com>



On 11/16/10 16:40, Arnaldo Carvalho de Melo wrote:
> Em Sun, Nov 14, 2010 at 09:03:20PM -0700, David S. Ahern escreveu:
>>
>> I'm trying to understand how the latest perf tools are designed with
>> respect to off-line analysis.
>>
>> Specifically, I have a system running binaries and libraries that are
>> stripped and no vmlinux is installed. For analysis, I have a local tree
>> based on software versions with full debug symbols. Events are collected
>> into a perf.data file and the file is pushed off-box for analysis.
>>
>> Without assuming write access to local tree or even ownership of the
>> perf.data I imagine running a command something like:
>>
>> perf report -fi /path/to/perf.data \
>>     --rootfs /path/to/symboled-tree \
>>     --kallsyms /path/to/kallsyms
>>     ...
>>
>> where /proc/kallsyms is dumped for the running system and retrieved
>> along with the perf.data file.
>>
>> I've been reading the source and can't say I follow all of the build-id
>> stuff. Before I spend time working on code modifications I wanted to
>> better understand the expectations and options for the latest code.
> 
> The usual workflow is the following, after it I'll talk at how to change it to
> fit your described setup:
> 
> On stripped machine:
> 
> $ perf record
> $ perf archive
> $ scp perf.data.* devel-machine
> 
> on devel machine:
> 
> $ tar xvf perf.data.tar.bz2 -C ~/.debug
> $ perf report
> 
> This all assumes that build-ids are enabled, to see if they are, try
> this:

Thank you for the detailed response. Very helpful. I also read the
Fedora project page for a bit of background on build-ids:
http://fedoraproject.org/wiki/Releases/FeatureBuildId

I spent a bit of time looking at the perf-archive and seeing how it
works. I get the general idea now. The build-id option is supported by
our linker, so something we could enable. However, ...

> . Populate your devel machine ~/.debug build-id database with the unstripped
>   binaries, do that using another perf command, buildid-cache, example:

The need for populating ~/.debug does not seem practical for a
"large-scale" development organization - at least not for our setup.

In our case the product has "official" builds at regular intervals
(e.g., daily) with image trees in some automount area (e.g.,
/auto/${majorver}/${release}). Then developers create builds in personal
workspace areas, e.g. /auto/${user/my-build-${ver}-${release}. The
builds are done using cross-compile environments, so there is no single
"development machine".

When you consider 100's of engineers working on 100's of versions of
software images with a mix-and-match of who generates a perf.data file
and who is analyzing the data (and where) it does not seem practical to
require pulling in the debug data into a ~/.debug tree. e.g., QA or
system test can record and pull a perf.data file for analysis by one or
more DEs.

We already generate trees with links to files with full debugging
symbols for analyzing core files - leveraging the outputs of the builds.
It would be ideal to reuse that tree for perf too.

--

Kernel versions and kallsyms: We have a single code base that generates
images for N different platforms. Multiple platforms use the same kernel
version but requires different kernel modules, and each image can
contain slightly different builds of the same kernel module name. Would
this cause a conflict in a cached area from a build-id perspective? ie.,
is the build-id based on the kernel version and not a function of loaded
modules?

--

Development systems: We use a cross-compile environment for builds and
lab servers which would be used for analyzing a perf.data file can be
running a variety of linux versions and flavors - from RHEL4, RHEL5,
Fedora 10, Fedora 14, etc. In this case we would not want perf to look
at the vmlinux, kallsyms, libs and binaries on the system where the
analysis is done - something that perf does today as part of of its
default paths in dso__load.

--

The above factors are why I was expecting arguments such as --rootfs and
--kallsyms - to point an analysis invocation to a specific tree to use
and a specific kallsyms file.

David
