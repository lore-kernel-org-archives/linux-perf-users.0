From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Date: Tue, 1 Sep 2020 12:06:30 -0300
Message-ID: <20200901150630.GB1424523@kernel.org>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200901150225.GA1424523@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Al Grant <al.grant@foss.arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Sep 01, 2020 at 12:02:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 26, 2020 at 03:33:35PM +0100, Al Grant escreveu:
> > On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
> > > > On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> > > > > perf_event.h has macros that define the field offsets in the
> > > > > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > > > > were both 37. These are distinct fields, and the bitfield layout
> > > > > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > > > 
> > > > Looks good.
> > > > 
> > > > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > Probably should have a Fixes: header
> > > 
> > > Please do so, find the patch that introduced the error, add the Fixes
> > > tag, will help me not having to do it myself :-)
> > 
> > Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info
> > encodings")
> 
> Ok, I'll add that, thanks.
> 
> But you forgot to add your Signed-off-by:, can you please provide it?
> 
> There was also a minor problem in the patch, there was no separation of
> --- from the patch comment section to the patch itself, I'll fix that as
> well.

Also you mixed up tools/ with include/ things, the perf part of the
kernel is maintained by Ingo, PeterZ.

Peter, the patch is the one below, I'll collect the
tools/include/uapi/linux/perf_event.h bit as it fixes the tooling,
please consider taking the kernel part.

Thanks,

- Arnaldo

---

From:   Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf: correct SNOOPX field offset
Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Date:   Mon, 24 Aug 2020 10:28:34 +0100

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Signed-off-by: Al Grant <al.grant@arm.com>

---

  include/uapi/linux/perf_event.h       | 2 +-
  tools/include/uapi/linux/perf_event.h | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

---

diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
diff --git a/tools/include/uapi/linux/perf_event.h 
b/tools/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
