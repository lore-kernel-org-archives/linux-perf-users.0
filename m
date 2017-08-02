From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 16/18] tools include uapi: Grab a copy of linux/vhost.h
Date: Wed, 2 Aug 2017 11:18:37 -0300
Message-ID: <20170802141837.GG12201@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
 <20170801195645.16986-17-acme@kernel.org>
 <20170802001802-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170802001802-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Aug 02, 2017 at 12:19:18AM +0300, Michael S. Tsirkin escreveu:
> On Tue, Aug 01, 2017 at 04:56:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > We will use it to generate tables for beautifying ioctl's 'cmd' arg.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: http://lkml.kernel.org/n/tip-nxwpq34hu6te1m2ra5m7o8n9@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Is this what tools/perf always does? Isn't there a way
> to reuse the single header?

So, that is how we did it at first, we tried to use files from the
kernel from tools/ directly, and it worked most of the time.

Shortest summary: We don't want to add to the workload of kernel
developers, they don't have to care about tools/, if they don't want to.

There are other reasons, but this is the main one, please take a look at
these others in some other patches in this series, first the one that
uses the files in the commit in this message:

 -----
commit ec6dd85f6e39bf516f4420d62270380b96bbee57
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jul 31 17:34:47 2017 -0300

    perf trace beautify ioctl: Beautify vhost virtio ioctl's 'cmd' arg
    
    Also trying a new approach, using a copy of uapi/linux/vhost.h we auto
    generate the string tables, then include it in the ioctl cmd beautifier.
    
    This way either the KVM developers will add the new commands to the
    tools/ copy, like is happening with other areas of tools/include/ (bpf.h
    comes to mind), or we'll be notified when building perf that our copy
    drifted.
    
    E.g., doing syswide tracing grepping for the newly beautified VHOST
    ioctls:
    
      # perf trace -e ioctl 2>&1 | grep VHOST
      3873.064 ( 0.099 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_NET_SET_BACKEND, arg: 0x7fff053dffe0) = 0
      3873.168 ( 0.019 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_NET_SET_BACKEND, arg: 0x7fff053dffe0) = 0
      3873.226 ( 0.006 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_GET_VRING_BASE, arg: 0x7fff053dff60) = 0

 -----

And on the cover letter for this patch series:

 -----
  Using the current scheme of having tools/ copies of kernel headers
  we'll make sure tooling stays working when changes are made to the
  kernel ABI headers and will be notified when they get changed,
  reducing the time for 'perf trace' to support new ABIs and allowing
  the tools/perf/ codebase to have the definitions it needs to
  build in dozens of distros/versions, as routinely tested using
  containers for, at this time, 47 environments.
 -----

tools/perf/check-headers.sh does these tests:

cd tools/perf
./check-headers.sh

This is done everytime perf gets built.

- Arnaldo
