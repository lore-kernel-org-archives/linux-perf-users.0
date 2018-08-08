From: mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390 auxiliary trace
Date: Wed, 08 Aug 2018 13:37:26 +1000
Message-ID: <87r2j9bkax.fsf@concordia.ellerman.id.au>
References: <20180802074622.13641-1-tmricht@linux.ibm.com> <20180802074622.13641-3-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802074622.13641-3-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Thomas Richter <tmricht@linux.ibm.com> writes:
> Add support for s390 auxiliary trace support.
> Use 'perf record -e rbd000' to create the perf.data file.
> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
...
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
>  2 files changed, 314 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h


I'm seeing a build break on ppc64le which seems to be caused by this
commit (I haven't bisected):

  util/s390-cpumsf.c: In function ‘trailer_timestamp’:
  util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
    return *((unsigned long long *) &te->timestamp[te->t]);
    ^


And on powerpc big endian:
  In file included from util/cpumap.h:10:0,
                   from util/s390-cpumsf.c:150:
  util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
  util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
     pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
            ^

cheers
