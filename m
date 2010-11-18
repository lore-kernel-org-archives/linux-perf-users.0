From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: off-box analysis of perf.data file
Date: Thu, 18 Nov 2010 18:19:23 -0200
Message-ID: <20101118201923.GA21029@ghostprotocols.net>
References: <4CE0B108.8020205@cisco.com>
 <20101116234042.GA4856@ghostprotocols.net>
 <4CE465E9.4070107@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44931 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab0KRUTe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Nov 2010 15:19:34 -0500
Received: by gxk23 with SMTP id 23so2156629gxk.19
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Nov 2010 12:19:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE465E9.4070107@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, "Amit Patel (amitpate)" <amitpate@cisco.com>

Em Wed, Nov 17, 2010 at 04:31:53PM -0700, David S. Ahern escreveu:
> On 11/16/10 16:40, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Nov 14, 2010 at 09:03:20PM -0700, David S. Ahern escreveu:
> >> I've been reading the source and can't say I follow all of the build-id
> >> stuff. Before I spend time working on code modifications I wanted to
> >> better understand the expectations and options for the latest code.
> > 
> > The usual workflow is the following, after it I'll talk at how to change it to
> > fit your described setup:
> 
> Thank you for the detailed response. Very helpful. I also read the
> Fedora project page for a bit of background on build-ids:
> http://fedoraproject.org/wiki/Releases/FeatureBuildId
> 
> I spent a bit of time looking at the perf-archive and seeing how it
> works. I get the general idea now. The build-id option is supported by
> our linker, so something we could enable. However, ...
> 
> > . Populate your devel machine ~/.debug build-id database with the unstripped
> >   binaries, do that using another perf command, buildid-cache, example:
> 
> The need for populating ~/.debug does not seem practical for a
> "large-scale" development organization - at least not for our setup.

You don't need to have one single ~/.debug database, its up to you to
determine what is the best setup for your organization, I believe that
it is possible to have multiple databases and for you to specify which
one to use.

> In our case the product has "official" builds at regular intervals
> (e.g., daily) with image trees in some automount area (e.g.,
> /auto/${majorver}/${release}). Then developers create builds in personal
> workspace areas, e.g. /auto/${user/my-build-${ver}-${release}. The
> builds are done using cross-compile environments, so there is no single
> "development machine".

But it is possible to have a single development server or to have
multiple databases according to your needs.
 
> When you consider 100's of engineers working on 100's of versions of
> software images with a mix-and-match of who generates a perf.data file
> and who is analyzing the data (and where) it does not seem practical to
> require pulling in the debug data into a ~/.debug tree. e.g., QA or
> system test can record and pull a perf.data file for analysis by one or
> more DEs.
> 
> We already generate trees with links to files with full debugging
> symbols for analyzing core files - leveraging the outputs of the builds.
> It would be ideal to reuse that tree for perf too.

Well, you can, just create the ~/.debug/.build-id/ links pointing to
whatever places where you already keep your binaries.
 
> Kernel versions and kallsyms: We have a single code base that generates
> images for N different platforms. Multiple platforms use the same kernel
> version but requires different kernel modules, and each image can
> contain slightly different builds of the same kernel module name. Would
> this cause a conflict in a cached area from a build-id perspective? ie.,
> is the build-id based on the kernel version and not a function of loaded
> modules?

Nope, the build-id is not based on versions, it is based on contents:

$ pinfo ld
<SNIP>
`--build-id'
`--build-id=STYLE'
     Request creation of `.note.gnu.build-id' ELF note section.  The
     contents of the note are unique bits identifying this linked file.
     STYLE can be `uuid' to use 128 random bits, `sha1' to use a
     160-bit SHA1 hash on the normative parts of the output contents,
     `md5' to use a 128-bit MD5 hash on the normative parts of the
     output contents, or `0xHEXSTRING' to use a chosen bit string
     specified as an even number of hexadecimal digits (`-' and `:'
     characters between digit pairs are ignored).  If STYLE is omitted,
     `sha1' is used.

     The `md5' and `sha1' styles produces an identifier that is always
     the same in an identical output file, but will be unique among all
     nonidentical output files.  It is not intended to be compared as a
     checksum for the file's contents.  A linked file may be changed
     later by other tools, but the build ID bit string identifying the
     original linked file does not change.

     Passing `none' for STYLE disables the setting from any
     `--build-id' options earlier on the command line.
<SNIP>

If you look at the kernel Makefile:

# Use --build-id when available.
LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
                              $(call cc-ldoption, -Wl$(comma)--build-id,))


no style passed? sha1 used, hence, git like content based unique ID.

> Development systems: We use a cross-compile environment for builds and
> lab servers which would be used for analyzing a perf.data file can be
> running a variety of linux versions and flavors - from RHEL4, RHEL5,
> Fedora 10, Fedora 14, etc. In this case we would not want perf to look
> at the vmlinux, kallsyms, libs and binaries on the system where the
> analysis is done - something that perf does today as part of of its
> default paths in dso__load.

"perf" is too vague, covers many subcommands, what specific subsystem, perhaps
the above explanations made this question moot?
 
- Arnaldo
