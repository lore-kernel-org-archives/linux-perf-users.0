From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 57/63] perf beauty mmap: Print PROT_READ before PROT_EXEC
 to match strace output
Date: Wed, 19 Dec 2018 10:10:29 -0300
Message-ID: <20181219131029.GB16225@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-58-acme@kernel.org>
 <20181219091500.GB18068@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181219091500.GB18068@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 19, 2018 at 06:15:00PM +0900, Namhyung Kim escreveu:
> On Tue, Dec 18, 2018 at 07:07:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > Helps with comparing 'strace' and 'perf trace' output, for mutual
> > regression testing.

<SNIP>

> > +++ b/tools/perf/trace/beauty/mmap.c
> > @@ -17,8 +17,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,

> > -	P_MMAP_PROT(EXEC);
> >  	P_MMAP_PROT(READ);
> > +	P_MMAP_PROT(EXEC);
> >  	P_MMAP_PROT(WRITE);
 
> EXEC should be printed after WRITE..
 
>   $ cat mmap.c
>   #include <sys/mman.h>
   
>   int main(void)
>   {
>     mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>     return 0;
>   }
   
>   $ strace -e mmap ./a.out
>   ...
>   mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c643ec000
>   +++ exited with 0 +++

Thanks, will change that as well, and probably use your test proggie as
the first of a series of 'perf test' for the beautifiers :-)

Now, with your program:

[root@seventh c]# cat mmap.c
#include <sys/mman.h>

int main(void)
{
	mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	return 0;
}
[root@seventh c]# strace -e mmap ./mmap |& grep -v ^+++
mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f5bae400000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae3fe000
mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5bade40000
mmap(0x7f5bae1ec000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f5bae1ec000
mmap(0x7f5bae1f2000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f5bae1f2000
mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae419000
[root@seventh c]# trace -e mmap ./mmap |& grep -v ^+++
mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f6646c25000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c23000
mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f6646665000
mmap(0x7f6646a11000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f6646a11000
mmap(0x7f6646a17000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS) = 0x7f6646a17000
mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c3e000
[root@seventh c]#

- Arnaldo
