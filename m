From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: perf probe + uprobes missing events
Date: Mon, 6 Apr 2020 11:54:53 -0300
Message-ID: <20200406145453.GB32649@kernel.org>
References: <20200406145356.GA32649@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406145356.GA32649@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Apr 06, 2020 at 11:53:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Masami,

Sorry, details about the system:

[root@five ~]# uname -a
Linux five 5.5.10-200.fc31.x86_64 #1 SMP Wed Mar 18 14:21:38 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]# perf -vv
perf version 5.6.gea05cf482862
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
[root@five ~]# rpm -q elfutils
elfutils-0.178-7.fc31.x86_64
[root@five ~]#
 
> 	I'm trying to use 'perf probe' to debug 'perf test', but I'm not
> getting repeatable results, take a look:
> 
> I'm trying to figure out which expresssions are _really_ being tested
> byu the 'perf test expr' testcase, so I added a probe to the
> expr__parse() routine, asking for the expr string to be printed:
> 
> [root@five ~]# perf probe -x ~/bin/perf -L expr__parse
> <expr__parse@/home/acme/git/perf/tools/perf/util/expr.c:0>
>       0  int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime)
>       1  {
>       2         return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
>       3  }
> 
>          static bool
>          already_seen(const char *val, const char *one, const char **other,
> 
> [root@five ~]#
> 
> [root@five ~]# perf probe -x ~/bin/perf expr__parse expr:string
> Target program is compiled without optimization. Skipping prologue.
> Probe on address 0x5cb11b to force probing at the function entry.
> 
> Added new event:
>   probe_perf:expr__parse (on expr__parse in /home/acme/bin/perf with expr:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_perf:expr__parse -aR sleep 1
> 
> [root@five ~]#
> 
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.015 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.018 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.020 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.023 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.026 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.029 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.031 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.034 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.036 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.039 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.041 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.021 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.025 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.029 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.033 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.041 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.044 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.020 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.025 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.029 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.032 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.037 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.040 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.043 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.046 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.049 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.053 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.056 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.014 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.017 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.021 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.024 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.030 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.032 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.035 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.038 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.040 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.044 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.046 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]#
> 
> 
> Do you have any idea why that happens?
> 
> - Arnaldo

-- 

- Arnaldo
