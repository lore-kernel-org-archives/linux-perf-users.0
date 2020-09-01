From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Date: Tue, 1 Sep 2020 12:02:25 -0300
Message-ID: <20200901150225.GA1424523@kernel.org>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Grant <al.grant@foss.arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Aug 26, 2020 at 03:33:35PM +0100, Al Grant escreveu:
> On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
> > > On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> > > > perf_event.h has macros that define the field offsets in the
> > > > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > > > were both 37. These are distinct fields, and the bitfield layout
> > > > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > > 
> > > Looks good.
> > > 
> > > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Probably should have a Fixes: header
> > 
> > Please do so, find the patch that introduced the error, add the Fixes
> > tag, will help me not having to do it myself :-)
> 
> Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info
> encodings")

Ok, I'll add that, thanks.

But you forgot to add your Signed-off-by:, can you please provide it?

There was also a minor problem in the patch, there was no separation of
--- from the patch comment section to the patch itself, I'll fix that as
well.

- Arnaldo
