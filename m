From: Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH] pert/report: Support s390 diag event display on x86
Date: Tue, 21 May 2019 15:36:38 +0200
Message-ID: <20190521133638.GB10877@linux.ibm.com>
References: <20190520144242.53207-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520144242.53207-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 20, 2019 at 04:42:42PM +0200, Thomas Richter wrote:
> Perf report fails to display s390 specific event numbered bd000
> on an x86 platform. For example on s390 this works without error:
> 
> [root@m35lp76 perf]# uname -m
> s390x
> [root@m35lp76 perf]# ./perf record -e rbd000 -- find / >/dev/null
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 0.549 MB perf.data ]
> [root@m35lp76 perf]# ./perf report -D --stdio  > /dev/null
> [root@m35lp76 perf]#
> 
> Transfering this perf.data file to an x86 platform and executing
> the same report command produces:
> 
> [root@f29 perf]# uname -m
> x86_64
> [root@f29 perf]# ./perf report -i ~/perf.data.m35lp76 --stdio
> interpreting bpf_prog_info from systems with endianity is not yet supported
> interpreting btf from systems with endianity is not yet supported
> 0x8c890 [0x8]: failed to process type: 68
> Error:
> failed to process sample
> 
> Event bd000 generates auxiliary data which is stored in big endian
> format in the perf data file.
> This error is caused by missing endianess handling on the x86 platform
> when the data is displayed. Fix this by handling s390 auxiliary event
> data depending on the local platform endianness.
> 
> Output after on x86:
> 
> [root@f29 perf]# ./perf report -D -i ~/perf.data.m35lp76 --stdio > /dev/null
> interpreting bpf_prog_info from systems with endianity is not yet supported
> interpreting btf from systems with endianity is not yet supported
> [root@f29 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumsf.c | 95 ++++++++++++++++++++++++++++-------
>  1 file changed, 77 insertions(+), 18 deletions(-)
> 

Looks sane to me.

Thanks, Thomas.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
