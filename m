From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Date: Wed, 3 Oct 2018 09:05:37 +0530
Message-ID: <f71ed02b-1234-db9c-6a48-1a399359b5e8@linux.ibm.com>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
 <20181002153236.GD3541@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002153236.GD3541@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On 10/02/2018 09:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 02, 2018 at 09:39:49AM +0200, Milian Wolff escreveu:
>> Only use the mapped IP to find inline frames, but keep
>> using the unmapped IP for the callchain cursor. This
>> ensures we properly show the unmapped IP when displaying
>> a frame we received via the dso__parse_addr_inlines API
>> for a module which does not contain sufficient debug symbols
>> to show the srcline.
> 
> So, the patch came mangled, I fixed it up, please check, I'm adding Ravi
> to the CC list, so that he can check as well and retest, right Ravi?
> 
> - Arnaldo
> 
> From d9ddee9653d5676130471de9bc688fc7ec7b4fc4 Mon Sep 17 00:00:00 2001
> From: Milian Wolff <milian.wolff@kdab.com>
> Date: Tue, 2 Oct 2018 09:39:49 +0200
> Subject: [PATCH 1/1] perf record: use unmapped IP for inline callchain cursors
> 
> Only use the mapped IP to find inline frames, but keep using the unmapped IP
> for the callchain cursor. This ensures we properly show the unmapped IP when
> displaying a frame we received via the dso__parse_addr_inlines API for a module
> which does not contain sufficient debug symbols to show the srcline.
> 
> Before:
> 
>   $ perf record -e cycles:u --call-graph ls
>   $ perf script
>   ...
>   ls 12853  2735.563911:      43354 cycles:u:
>                      17878 __GI___tunables_init+0xffff01d1d63a0118 (/usr/lib/ld-2.28.so)
>                      19ee9 _dl_sysdep_start+0xffff01d1d63a02e9 (/usr/lib/ld-2.28.so)
>                       3087 _dl_start+0xffff01d1d63a0287 (/usr/lib/ld-2.28.so)
>                       2007 _start+0xffff01d1d63a0007 (/usr/lib/ld-2.28.so)
> 
> After:
> 
>   $ perf script
>   ...
>   ls 12853  2735.563911:      43354 cycles:u:
>               7f1714e46878 __GI___tunables_init+0x118 (/usr/lib/ld-2.28.so)
>               7f1714e48ee9 _dl_sysdep_start+0x2e9 (/usr/lib/ld-2.28.so)
>               7f1714e32087 _dl_start+0x287 (/usr/lib/ld-2.28.so)
>               7f1714e31007 _start+0x7 (/usr/lib/ld-2.28.so)

With current perf/urgent:

  $ sudo ./perf record --call-graph=dwarf -e probe_libc:inet_pton -- ping -6 -c 1 ::1
  $ sudo ./perf script
  ping  4109 [011] 767269.031273: probe_libc:inet_pton: (7fff944cb458)
                  15b458 __inet_pton+0xffff0000d7920008 (inlined)
                  10feb3 gaih_inet.constprop.7+0xffff0000d7920f43 (/usr/lib64/libc-2.26.
                  110a13 __GI_getaddrinfo+0xffff0000d7920163 (inlined)
               13c752d6f _init+0xbfb (/usr/bin/ping)
                   2371f generic_start_main.isra.0+0xffff0000d792013f (/usr/lib64/libc-2
                   2391b __libc_start_main+0xffff0000d79200bb (/usr/lib64/libc-2.26.so)

With this patch:

  $ sudo ./perf script
  ping  4109 [011] 767269.031273: probe_libc:inet_pton: (7fff944cb458)
            7fff944cb458 __inet_pton+0x8 (inlined)
            7fff9447feb3 gaih_inet.constprop.7+0xf43 (/usr/lib64/libc-2.26.so)
            7fff94480a13 __GI_getaddrinfo+0x163 (inlined)
               13c752d6f _init+0xbfb (/usr/bin/ping)
            7fff9439371f generic_start_main.isra.0+0x13f (/usr/lib64/libc-2.26.so)
            7fff9439391b __libc_start_main+0xbb (/usr/lib64/libc-2.26.so)

LGTM.

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
