From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: test 60 fails on s390 inline missing on s390
Date: Tue, 8 May 2018 11:23:11 -0300
Message-ID: <20180508142311.GF13491@kernel.org>
References: <20180503065837.71043-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503065837.71043-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, May 03, 2018 at 08:58:37AM +0200, Thomas Richter escreveu:
> perf test 60: probe libc's inet_pton & backtrace it with ping
> fails on 4.17.0rc3. It turned out that function __inet_pton
> is reported as inline:
> 
> [root@s8360047 perf]# ./perf script -i /tmp/perf.data.111
> ping 12457 [000]  1584.478959: probe_libc:inet_pton: (3ffb5a347e8)
>                   1347e8 __inet_pton (inlined)
>                    f19d7 gaih_inet.constprop.5 (/usr/lib64/libc-2.24.so)
>                    f4c3f __GI_getaddrinfo (inlined)
>                     410b main (/usr/bin/ping)
> 
> Allow __inet_pton listed as inline.

Thanks, applied,

- Arnaldo
