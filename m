From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/18] perf/core improvements
Date: Thu, 10 Aug 2017 17:09:53 +0200
Message-ID: <20170810150953.my5z777bfljckt3o@gmail.com>
References: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37507 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdHJPJ6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2017 11:09:58 -0400
Content-Disposition: inline
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, Lawrence Brakmo <brakmo@fb.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael S.


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit c3a3800fe46f00ceeeb181cc07cc4fdaed4574f1:
> 
>   Merge tag 'perf-core-for-mingo-4.14-20170728' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-07-30 11:15:37 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170801
> 
> for you to fetch changes up to 81e3d8b2af2e7417f1d5164aab5c1a75955e8a5d:
> 
>   perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg (2017-08-01 13:33:50 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements:
> 
> User visible:
> 
> - Beautifiers for the 'cmd' arg of several ioctl types, including:
>   sound, DRM, KVM, vhost virtio and perf_events.
> 
>   This was done by using scripts that extract the information from
>   the UAPI headers, generating string tables that are then used in
>   the 'perf trace' syscall argument ioctl beautifier.
> 
>   More work needed to further use it, for instance, to use the
>   _IOC_DIR value where it is used sanely to suppress the third
>   argument, to set formatters for non-pointer values and ultimately
>   for using eBPF + pahole-like code to collect + beautify structs in
>   the third arg.
> 
>   Using the current scheme of having tools/ copies of kernel headers
>   we'll make sure tooling stays working when changes are made to the
>   kernel ABI headers and will be notified when they get changed,
>   reducing the time for 'perf trace' to support new ABIs and allowing
>   the tools/perf/ codebase to have the definitions it needs to
>   build in dozens of distros/versions, as routinely tested using
>   containers for, at this time, 47 environments. (Arnaldo Carvalho de Melo)
> 
> Infrastructure
> 
> - Clarify header version warning message (Ingo Molnar)
> 
> - Sync kernel ABI headers with tooling headers (Ingo Molnar, Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (15):
>       tools headers: Fixup tools/include/uapi/linux/bpf.h copy of kernel ABI header
>       tools include uapi: Grab a copy of asm-generic/ioctls.h
>       tools perf: Do not check spaces/blank lines when checking header file copy drift
>       tools headers: Fixup tools/include/uapi/linux/bpf.h copy of kernel ABI header
>       perf trace beauty ioctl: Improve 'cmd' beautifier
>       tools include uapi: Grab copies of drm/{drm,i915_drm}.h
>       perf trace beauty ioctl: Beautify DRM ioctl cmds
>       tools include uapi: Grab a copy of sound/asound.h
>       perf trace beautify ioctl: Beautify sound ioctl's 'cmd' arg
>       tools include uapi: Grab a copy of linux/kvm.h
>       perf trace beautify ioctl: Beautify KVM ioctl's 'cmd' arg
>       perf trace beauty ioctl: Pass _IOC_DIR to the per _IOC_TYPE scnprintf
>       tools include uapi: Grab a copy of linux/vhost.h
>       perf trace beautify ioctl: Beautify vhost virtio ioctl's 'cmd' arg
>       perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg
> 
> Ingo Molnar (3):
>       perf build: Clarify header version warning message
>       perf build: Clarify open-coded header version warning message
>       tools headers: Sync kernel ABI headers with tooling headers
> 
>  tools/arch/arm/include/uapi/asm/kvm.h          |    8 +
>  tools/arch/arm64/include/uapi/asm/kvm.h        |    3 +
>  tools/arch/powerpc/include/uapi/asm/kvm.h      |    6 +
>  tools/arch/s390/include/uapi/asm/kvm.h         |   12 +
>  tools/arch/x86/include/asm/cpufeatures.h       |    2 +
>  tools/arch/x86/include/asm/disabled-features.h |    4 +-
>  tools/include/uapi/asm-generic/ioctls.h        |  118 ++
>  tools/include/uapi/drm/drm.h                   |  933 +++++++++++++++
>  tools/include/uapi/drm/i915_drm.h              | 1474 ++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                 |   16 +-
>  tools/include/uapi/linux/kvm.h                 | 1419 +++++++++++++++++++++++
>  tools/include/uapi/linux/vhost.h               |  209 ++++
>  tools/include/uapi/sound/asound.h              | 1026 +++++++++++++++++
>  tools/lib/bpf/Makefile                         |    4 +-
>  tools/perf/MANIFEST                            |    6 +
>  tools/perf/Makefile.perf                       |   61 +-
>  tools/perf/arch/x86/Makefile                   |    2 +-
>  tools/perf/builtin-trace.c                     |   44 +-
>  tools/perf/check-headers.sh                    |   18 +-
>  tools/perf/trace/beauty/Build                  |    3 +
>  tools/perf/trace/beauty/beauty.h               |    3 +
>  tools/perf/trace/beauty/drm_ioctl.sh           |   13 +
>  tools/perf/trace/beauty/ioctl.c                |  162 +++
>  tools/perf/trace/beauty/kvm_ioctl.sh           |   11 +
>  tools/perf/trace/beauty/perf_ioctl.sh          |   10 +
>  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh     |    8 +
>  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh     |    8 +
>  tools/perf/trace/beauty/vhost_virtio_ioctl.sh  |   17 +
>  28 files changed, 5538 insertions(+), 62 deletions(-)
>  create mode 100644 tools/include/uapi/asm-generic/ioctls.h
>  create mode 100644 tools/include/uapi/drm/drm.h
>  create mode 100644 tools/include/uapi/drm/i915_drm.h
>  create mode 100644 tools/include/uapi/linux/kvm.h
>  create mode 100644 tools/include/uapi/linux/vhost.h
>  create mode 100644 tools/include/uapi/sound/asound.h
>  create mode 100755 tools/perf/trace/beauty/drm_ioctl.sh
>  create mode 100644 tools/perf/trace/beauty/ioctl.c
>  create mode 100755 tools/perf/trace/beauty/kvm_ioctl.sh
>  create mode 100755 tools/perf/trace/beauty/perf_ioctl.sh
>  create mode 100755 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
>  create mode 100755 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
>  create mode 100755 tools/perf/trace/beauty/vhost_virtio_ioctl.sh

Pulled, thanks a lot Arnaldo!

	Ingo
