From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: Port the period data column to centos6.7 for perf script
Date: Fri, 15 Sep 2017 07:16:36 -0300
Message-ID: <20170915101636.GB3774@redhat.com>
References: <CAHCio2j0TO0dQtr1Dk+v0=k_1pzwzqhZCJBkUTHCKqFgNGdoBg@mail.gmail.com>
 <20170915042154.GJ24844@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbdIOKQk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2017 06:16:40 -0400
Content-Disposition: inline
In-Reply-To: <20170915042154.GJ24844@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>, namhyung@kernel.org, Wind Yu <yuzhoujian@didichuxing.com>, Milian Wolff <milian.wolff@kdab.com>, sj38.park@gmail.com, tardyp@gmail.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Thu, Sep 14, 2017 at 09:21:54PM -0700, Andi Kleen escreveu:
> On Fri, Sep 15, 2017 at 10:24:15AM +0800, 禹舟键 wrote:
> >    Hi, all.
> >    I want to draw off-cpu flamegraph using perf script on centos6.7(kernel
> >    version, 2.6.32-573), and I found perf script lacks the period data column
> >    on that version. IÂ  found two related patches, and modifed
> >    builin-script.c in reference to those patches.
> >    perf script:Add period data column authorJiri Olsa 2014-08-25 16:45:42
> >    +0200 commit535aeaae7de821ba5d43ee2a204ee667ca95aae4
> >    perf script: Add period as a default output column
> >    commite8564b710c6df2c3aeb56c507c22f4bcfa4c0b2d)
 
> I would just compile the newer perf binary for Centos6 and use that. It should
> work with older kernels too. That's much easier than backporting, and you get
> many more features.

yeah, look at the Dockerfile I use to build it for that OS:

[acme@jouet 6]$ cat Dockerfile 
# docker.io/acmel/linux-perf-tools-build-centos:6
FROM docker.io/centos:6
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
RUN yum -y update && \
    yum -y install make gcc flex bison bc elfutils-libelf-devel elfutils-devel \
		   libunwind-devel audit-libs-devel openssl-devel slang-devel \
		   gtk2-devel perl-ExtUtils-Embed python-devel binutils-devel \
		   systemtap-sdt-devel xz-devel numactl-devel && \
    yum -y clean all && \
    rm -rf /usr/share/doc /usr/share/gtk-doc /usr/share/man && \
    mkdir -m 777 -p /tmp/build/perf /tmp/build/objtool && \
    groupadd -r perfbuilder && \
    useradd -m -r -g perfbuilder perfbuilder
USER perfbuilder
ENTRYPOINT make -C /git/linux/tools/perf O=/tmp/build/perf && \
	   rm -rf /tmp/build/perf/{.[^.]*,*} && \
	   make NO_LIBELF=1 -C /git/linux/tools/perf O=/tmp/build/perf && \
	   make -C /git/linux/tools/objtool O=/tmp/build/objtool
[acme@jouet 6]$
