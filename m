From: Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH] pert/report: Support s390 diag event display on x86
Date: Tue, 21 May 2019 15:38:13 +0200
Message-ID: <20190521133813.GC10877@linux.ibm.com>
References: <20190520144242.53207-1-tmricht@linux.ibm.com>
 <20190520170322.GN8945@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520170322.GN8945@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 20, 2019 at 02:03:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 20, 2019 at 04:42:42PM +0200, Thomas Richter escreveu:
> > Perf report fails to display s390 specific event numbered bd000
> > on an x86 platform. For example on s390 this works without error:
> > 
> > [root@m35lp76 perf]# uname -m
> > s390x
> > [root@m35lp76 perf]# ./perf record -e rbd000 -- find / >/dev/null
> > [ perf record: Woken up 3 times to write data ]
> > [ perf record: Captured and wrote 0.549 MB perf.data ]
> > [root@m35lp76 perf]# ./perf report -D --stdio  > /dev/null
> > [root@m35lp76 perf]#
> > 
> > Transfering this perf.data file to an x86 platform and executing
> > the same report command produces:
> > 
> > [root@f29 perf]# uname -m
> > x86_64
> > [root@f29 perf]# ./perf report -i ~/perf.data.m35lp76 --stdio
> > interpreting bpf_prog_info from systems with endianity is not yet supported
> > interpreting btf from systems with endianity is not yet supported
> > 0x8c890 [0x8]: failed to process type: 68
> > Error:
> > failed to process sample
> > 
> > Event bd000 generates auxiliary data which is stored in big endian
> > format in the perf data file.
> > This error is caused by missing endianess handling on the x86 platform
> > when the data is displayed. Fix this by handling s390 auxiliary event
> > data depending on the local platform endianness.
> > 
> > Output after on x86:
> > 
> > [root@f29 perf]# ./perf report -D -i ~/perf.data.m35lp76 --stdio > /dev/null
> > interpreting bpf_prog_info from systems with endianity is not yet supported
> > interpreting btf from systems with endianity is not yet supported
> > [root@f29 perf]#
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >  tools/perf/util/s390-cpumsf.c | 95 ++++++++++++++++++++++++++++-------
> >  1 file changed, 77 insertions(+), 18 deletions(-)
> > 
> > diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> > index c215704931dc..884ac79528ff 100644
> > --- a/tools/perf/util/s390-cpumsf.c
> > +++ b/tools/perf/util/s390-cpumsf.c
> > @@ -17,8 +17,8 @@
> >   *	see Documentation/perf.data-file-format.txt.
> >   * PERF_RECORD_AUXTRACE_INFO:
> >   *	Defines a table of contains for PERF_RECORD_AUXTRACE records. This
> > - *	record is generated during 'perf record' command. Each record contains up
> > - *	to 256 entries describing offset and size of the AUXTRACE data in the
> > + *	record is generated during 'perf record' command. Each record contains
> > + *	up to 256 entries describing offset and size of the AUXTRACE data in the
> 
> What is this for? Just a text reflow?

Look like this is indeed a text reflow to fit into 80 column space.
For me this is OK.  In case you any objections, I think Thomas could
respin the patch and exclude that hunk.

> Also, can you get a Reviewed-by from some other person that works with
> s/390?

Reviewed by me.

Thanks and kind regards,
  Hendrik
