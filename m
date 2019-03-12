From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Misc improvements and bug fixes for perf
Date: Tue, 12 Mar 2019 11:31:33 +0100
Message-ID: <20190312103133.GC13071@krava>
References: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:36PM -0700, Andi Kleen wrote:
> Mostly unrelated to each other, so can be picked'n'chosed.
> 
> - Fix perf stat --no-scale
> - Support --reltime in perf script
> - Fix crashes with stat -r
> - Handle JITed code better in perf report
> - Allow to limit rotated perf.data files
> - Filter metrics in perf list
> - Show all sort keys in perf report help
> - Fix multiplexing formula
> 
> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/misc-fixes-4
> 

apart from the 2 comments it all looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
