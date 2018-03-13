From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 18/31] perf vendor events arm64: Add armv8-recommended.json
Date: Tue, 13 Mar 2018 12:22:04 -0300
Message-ID: <20180313152204.GC29837@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180313142618.36je6syqg6ppwhbp@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Clark Williams <williams@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.garry@huawei.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Namhyung Kim <namhyung@kernel.org>, William Cohen <wcohen@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Mar 13, 2018 at 03:26:18PM +0100, Ingo Molnar escreveu:
> 
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > From: John Garry <john.garry@huawei.com>
> > 
> > Add JSON for ARMv8 IMPLEMENTATION DEFINED recommended events.
> > 
> > The JSON is copied from ARMv8 architecture reference manual, available
> > here:
> > 
> > 	https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf
> > 
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: William Cohen <wcohen@redhat.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linuxarm@huawei.com
> > Link: http://lkml.kernel.org/r/1520506716-197429-9-git-send-email-john.garry@huawei.com
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> That's not a valid SOB chain, author != first-Signed-off-by.

Ok, I'll fix that.

- Arnaldo
