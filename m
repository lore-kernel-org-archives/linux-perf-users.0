From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for eMAG
Date: Fri, 3 Aug 2018 12:48:46 -0300
Message-ID: <20180803154846.GG7996@kernel.org>
References: <20180803041811.17065-1-seanvk.dev@oregontracks.org>
 <d6d9db03-657e-005c-8aa2-d0b3b41acb47@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d6d9db03-657e-005c-8aa2-d0b3b41acb47@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Garry <john.garry@huawei.com>
Cc: skelley@amperecomputing.com, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Namhyung Kim <namhyung@kernel.org>, Sean V Kelley <seanvk.dev@oregontracks.org>, Jiri Olsa <jolsa@redhat.com>, William Cohen <wcohen@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Aug 03, 2018 at 03:41:06PM +0100, John Garry escreveu:
> On 03/08/2018 05:18, Sean V Kelley wrote:
> > This patch adds the Ampere Computing eMAG file.  This platform
> > follows the ARMv8 recommended IMPLEMENTATION DEFINED events, where
> > applicable.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > Cc: William Cohen <wcohen@redhat.com>
> > 
> > Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo
