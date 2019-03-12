From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v1 05/10] perf, report: Show all sort keys in help output
Date: Tue, 12 Mar 2019 11:30:27 +0100
Message-ID: <20190312103027.GB13071@krava>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-6-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-6-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:41PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Show all the supported sort keys in the command line help output,
> so that it's not needed to refer to the manpage.
> 
> The output is not line wrapped, so it can be fairly long.
> 
> Before:
> 
> % perf report -h
> ...
>      -s, --sort <key[,key2...]>
>                           sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ... Please refer the man page for the complete list.
> 
> After:
> 
> % perf report -h
> ...
>     -s, --sort <key[,key2...]>
>                           sort by key(s): overhead overhead_sys overhead_us overhead_guest_sys overhead_guest_us overhead_children sample period pid comm dso symbol parent cpu ...

that line goes forever now, please provide some formating
into multiple lines

jirka
