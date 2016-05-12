From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 2/2] perf/core: change errno for sampling event not
 supported in hardware
Date: Thu, 12 May 2016 08:42:01 +0200
Message-ID: <20160512064201.GL3192@twins.programming.kicks-ass.net>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
 <1462786660-2900-3-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1605090923460.27332@macbook-air>
 <5730C79F.3060307@synopsys.com>
 <20160511193627.GH3190@twins.programming.kicks-ass.net>
 <5734229B.90706@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5734229B.90706@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, acme@redhat.com, linux-snps-arc@lists.infradead.org, mingo@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 12, 2016 at 11:58:43AM +0530, Vineet Gupta wrote:
> On Thursday 12 May 2016 01:06 AM, Peter Zijlstra wrote:
> > On Mon, May 09, 2016 at 10:53:43PM +0530, Vineet Gupta wrote:
> > 
> >> > Right thats what I feared. But hold on, I don't think we need to change the ABI to
> >> > achieve what we want. Gosh why did I even take that path.
> >> > 
> >> > Currently the errno switch case in perf_evsel__open_strerror() in doesn't handle
> >> > ENOTSUPP. So how about we add that - augmented with the same sample_period !0
> >> > check to barf for lack of sampling support.
> >> > 
> >> > Do you see anything wrong with that ?
> >
> > Should work I think.
> 
> Tried that and doesn't even compile. Reconfirms what Vince said, ENOTSUPP is not
> exposed to userspace (being in include/linux and not include/uapi/linux)

Durr, so what does userspace see?
