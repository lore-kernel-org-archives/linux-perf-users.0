From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf test 39 (Session topology) dumps core on s390
Date: Mon, 28 May 2018 09:19:55 +0530
Message-ID: <610eac04-1e34-9032-0a95-2f9818a31a9b@linux.ibm.com>
References: <20180524135600.77128-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524135600.77128-1-tmricht@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Thomas,

On 05/24/2018 07:26 PM, Thomas Richter wrote:
> @@ -95,7 +98,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
>  {
>  	char path[PATH_MAX];
>  	struct cpu_map *map;
> -	int ret = -1;
> +	int ret;

This is failing for me:

tests/topology.c: In function ‘test__session_topology’:
tests/topology.c:101:6: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  int ret;
      ^
cc1: all warnings being treated as errors
  CC       util/intlist.o
mv: cannot stat 'tests/.topology.o.tmp': No such file or directory
/home/ravi/Workspace/linux/tools/build/Makefile.build:96: recipe for target 'tests/topology.o' failed
make[4]: *** [tests/topology.o] Error 1
make[4]: *** Waiting for unfinished jobs....


Thanks,
Ravi
