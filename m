From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf list: Remove s390 specific strcmp_cpuid_cmp
 function
Date: Mon, 23 Apr 2018 11:03:52 -0300
Message-ID: <20180423140352.GD3254@kernel.org>
References: <20180423081745.3672-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180423081745.3672-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Apr 23, 2018 at 10:17:45AM +0200, Thomas Richter escreveu:
> Make the type field in pmu-events/arch/s390/mapfile.cvs
> more generic to match the created cpuid string for s390.
> The pattern also checks for the counter first version
> number and counter second version number ([13]\.[1-5])
> and the authorization field which follows. These numbers do
> not exist in the cpuid identification string when perf
> commands are executed on a z/VM environment (which does
> not support CPU counter measurement facility).
> CPUID string for LPAR:
>    cpuid : IBM,3906,704,M03,3.5,002f
> CPUID string for z/VM:
>    cpuid : IBM,2964,702,N96
> 
> This allows the removal of s390 specific cpuid compare code
> and uses the common compare function with its regular
> expression matching algorithm.

Thanks, applied.

- Arnaldo
