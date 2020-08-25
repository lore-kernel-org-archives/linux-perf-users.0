From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Date: Tue, 25 Aug 2020 10:40:43 -0700
Message-ID: <20200825174043.GQ1509399@tassilo.jf.intel.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Grant <al.grant@foss.arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> perf_event.h has macros that define the field offsets in the
> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> were both 37. These are distinct fields, and the bitfield layout
> in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Looks good.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

Probably should have a Fixes: header

-Andi
