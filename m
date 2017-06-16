From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf test LLVM failure
Date: Fri, 16 Jun 2017 13:09:57 -0300
Message-ID: <20170616160957.GE3645@kernel.org>
References: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbdFPQKA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2017 12:10:00 -0400
Content-Disposition: inline
In-Reply-To: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>

Em Tue, Jun 13, 2017 at 10:40:37AM +0200, Thomas-Mich Richter escreveu:
> I have Fedora 25 with an 4.11 kernel and get this error
> 
> [root@s8360047 perf]# ./perf test   LLVM
> 35: LLVM search and compile                    :
> 35.1: Basic BPF llvm compile                    : Ok
> 35.2: kbuild searching                          : Ok
> 35.3: Compile source for BPF prologue generation: FAILED!
> 35.4: Compile source for BPF relocation         : Skip
> [root@s8360047 perf]#
> 
> The error message is
> libbpf: Program 'func=null_lseek file->f_mode offset orig'
> contains non-map related relo data pointing to section 5

Wang, can you please take a look at this?

- Arnaldo
 
> I have installed
> clang-3.8.1-1.fc25.s390x
> clang-libs-3.8.1-1.fc25.s390x
> libpfm-4.8.0-2.ibm.fc25.s390x
> compiler-rt-3.9.1-1.fc25.s390x
> llvm-libs-3.8.1-2.fc25.s390x
> 
> and when I compile the test/bpf-script-test-prologue.c manually
> the compile does not show any error message.
> 
> The error comes from file ../lib/bpf/libbpf.c
> function bpf_program__collect_reloc()
> 
> Any ideas what cauese this and how to fix it?
> 
> By the way Fedora 24 with the same kernel version as above runs fine.
> 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
