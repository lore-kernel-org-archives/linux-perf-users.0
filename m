From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/4] perf/core fixes and improvements
Date: Fri, 11 Jan 2019 08:12:50 +0100
Message-ID: <20190111071250.GB92116@gmail.com>
References: <20190110165636.19338-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110165636.19338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, now there are no more ABI header
> warnings,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 576b50ea235699d83758c0c514c65b8d486a159d:
> 
>   Merge tag 'perf-core-for-mingo-5.0-20190108' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-09 07:59:40 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.0-20190110
> 
> for you to fetch changes up to 15c03092a9fbcdd041f58e5f832bf76c21c42e6a:
> 
>   tools headers powerpc: Remove unistd.h (2019-01-10 10:42:08 -0300)
> 
> ----------------------------------------------------------------
> perf/core fixes and improvements:
> 
> perf trace:
> 
>   Ravi Bangoria:
> 
>   - Rework PowerPC syscall table generation, now using a .tbl file just like
>     x86_64 and S/390, also silencing a tools build warning about headers out of
>     sync with the kernel sources.
> 
> tools include uapi:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync linux/if_link.h copy with the kernel sources, silencing a build warning.
> 
> perf top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add 'arch_cpu_idle' to the list of kernel idle symbols, noticed on a Orange
>     Pi Zero ARM board, just like with other symbols in other arches.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools include uapi: Sync linux/if_link.h copy with the kernel sources
>       perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols
> 
> Ravi Bangoria (2):
>       perf powerpc: Rework syscall table generation
>       tools headers powerpc: Remove unistd.h
> 
>  tools/arch/powerpc/include/uapi/asm/unistd.h       | 404 -------------------
>  tools/include/uapi/linux/if_link.h                 |  19 +
>  tools/perf/arch/powerpc/Makefile                   |  15 +-
>  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  22 +-
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 427 +++++++++++++++++++++
>  tools/perf/check-headers.sh                        |   1 -
>  tools/perf/util/symbol.c                           |   1 +
>  7 files changed, 470 insertions(+), 419 deletions(-)
>  delete mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
>  create mode 100644 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl

Pulled, thanks a lot Arnaldo!

	Ingo
