From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 3/3] perf record: Fix s390 missing module symbol and
 warning for non-root users
Date: Wed, 22 May 2019 15:03:27 -0300
Message-ID: <20190522180327.GH30271@kernel.org>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
 <20190522144601.50763-4-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522144601.50763-4-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 22, 2019 at 04:46:01PM +0200, Thomas Richter escreveu:
> Command 'perf record' and 'perf report' on a system without kernel
> debuginfo packages uses /proc/kallsyms and /proc/modules to find
> addresses for kernel and module symbols. On x86 this works for root
> and non-root users.
> 
> On s390, when invoked as non-root user, many of the following warnings
> are shown and module symbols are missing:
> 
>     proc/{kallsyms,modules} inconsistency while looking for
>         "[sha1_s390]" module!
> 
> Command 'perf record' creates a list of module start addresses by
> parsing the output of /proc/modules and creates a PERF_RECORD_MMAP
> record for the kernel and each module. The following function call
> sequence is executed:
> 
>   machine__create_kernel_maps
>     machine__create_module
>       modules__parse
>         machine__create_module --> for each line in /proc/modules
>           arch__fix_module_text_start
> 
> Function arch__fix_module_text_start() is s390 specific. It opens
> file /sys/module/<name>/sections/.text to extract the module's .text
> section start address. On s390 the module loader prepends a header
> before the first section, whereas on x86 the module's text section
> address is identical the the module's load address.
> 
> However module section files are root readable only. For non-root the
> read operation fails and machine__create_module() returns an error.
> Command perf record does not generate any PERF_RECORD_MMAP record
> for loaded modules. Later command perf report complains about missing
> module maps.
> 
> To fix this function arch__fix_module_text_start() always returns
> success. For root users there is no change, for non-root users
> the module's load address is used as module's text start address
> (the prepended header then counts as part of the text section).

Thanks, applied.

- Arnaldo
