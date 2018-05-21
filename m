From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCHv2] drivers/perf: arm-ccn: don't log to dmesg in
 event_init
Date: Mon, 21 May 2018 13:58:07 -0500
Message-ID: <20180521135807.3b39d00979b7c416d4f65be2@arm.com>
References: <20180521171949.31412-1-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521171949.31412-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Pawel Moll <pawel.moll@arm.com>, linux-kernel@vger.kernel.org, perf group <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

[adding LKML, linux-perf-users.  Please do so from now on]

On Mon, 21 May 2018 18:19:49 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> The ARM CCN PMU driver uses dev_warn() to complain about parameters in
> the user-provided perf_event_attr. This means that under normal
> operation (e.g. a single invocation of the perf tool), a number of
> messages warnings may be logged to dmesg.
> 
> Tools may issue multiple syscalls to probe for feature support, and
> multiple applications (from multiple users) can attempt to open events
> simultaneously, so this is not very helpful, even if a user happens to
> have access to dmesg. Worse, this can push important information out of
> the dmesg ring buffer, and can significantly slow down syscall fuzzers,
> vastly increasing the time it takes to find critical bugs.
> 
> Demote the dev_warn() instances to dev_dbg(), as is the case for all
> other PMU drivers under drivers/perf/. Users who wish to debug PMU event
> initialisation can enable dynamic debug to receive these messages.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---

Care to address my comments to the rationale?:

https://marc.info/?l=linux-arm-kernel&m=152582291919277&w=2

Thanks,

Kim
