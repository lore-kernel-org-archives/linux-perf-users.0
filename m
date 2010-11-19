From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: off-box analysis of perf.data file
Date: Fri, 19 Nov 2010 10:50:46 -0200
Message-ID: <20101119125046.GA24999@ghostprotocols.net>
References: <4CE0B108.8020205@cisco.com>
 <20101116234042.GA4856@ghostprotocols.net>
 <4CE465E9.4070107@cisco.com>
 <20101118201923.GA21029@ghostprotocols.net>
 <4CE5A093.8020809@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51661 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0KSMuw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Nov 2010 07:50:52 -0500
Received: by gwj17 with SMTP id 17so2622855gwj.19
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2010 04:50:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE5A093.8020809@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, "Amit Patel (amitpate)" <amitpate@cisco.com>

Em Thu, Nov 18, 2010 at 02:54:27PM -0700, David S. Ahern escreveu:
> Hmmm.... From a user perspective maintaining build-id databases for
> short-use builds is more complex than using a --rootfs argument. i.e.,
> add rootfs to symbol_conf with a default value of "", add a --rootfs
> argument to analysis commands to allow a user to specify a path, and
> within dso__load prepend the paths within rootfs. This appears to be
> similar to what has been done for builtin-kvm and analyzing guest
> data.  Furthermore, this allows a wide range of options - loop
> mounting KVM disk images, NFS trees, bootable USB keys, initrds, etc.
> Anything with an OS tree can be analyzed from anywhere without the
> need to populate a local data store.
 
> Similar argument for kallsyms point to a file rather than pointing to
> /proc/kallsyms -- which again parallels what has been done for builtin-kvm.

Yeah, I think it is worth having it for maximum flexibility, can you try
to implement it and post the patch for discussion?

> "perf" in the above meant all the commands that eventually call
> dso__load. In my F14 - F13 test case (data collected on a Fedora 14
> system and analyzed on a Fedora 13 system), 'strace -e trace=open perf
> report ...' shows perf opening a lot of files on the F13 system - even
> though the ~/.debug tree was populated using perf-archive.

What 'perf buildid-list' shows on this specific perf.data file? Perhaps
it is not finding the build-ids somehow and so fallbacks to looking at
the system binaries, checking if they have the same build-id, if
build-ids are present on the perf.data file header.

There is a bit of historical baggage here, in the pre-build-id days the
tools would look just at the pathnames, assuming the binaries hadn't
changed, etc.

- Arnaldo
