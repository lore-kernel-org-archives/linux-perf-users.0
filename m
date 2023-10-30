Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150EE1C36;
	Mon, 30 Oct 2023 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C5BD;
	Mon, 30 Oct 2023 00:15:05 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 39U7Cl8k048592;
	Mon, 30 Oct 2023 15:12:47 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 30 Oct 2023 15:12:46 +0800
Date: Mon, 30 Oct 2023 15:12:46 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <dminus@andestech.com>,
        <evan@rivosinc.com>, <geert+renesas@glider.be>, <guoren@kernel.org>,
        <heiko@sntech.de>, <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>
Subject: Re: [RFC PATCH v3 RESEND 02/13] irqchip/riscv-intc: Allow large
 non-standard hwirq number
Message-ID: <ZT9XbuxE2vlvsfYG@APC323>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-3-peterlin@andestech.com>
 <87a5s44jyc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a5s44jyc.ffs@tglx>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 39U7Cl8k048592

Hi Thomas,

Thanks for the review.

On Fri, Oct 27, 2023 at 09:12:59AM +0200, Thomas Gleixner wrote:
> On Mon, Oct 23 2023 at 08:40, Yu Chien Peter Lin wrote:
> > Currently, the implementation of the RISC-V INTC driver uses the
> > interrupt cause as hwirq and has a limitation of supporting a
> > maximum of 64 hwirqs. However, according to the privileged spec,
> > interrupt causes >= 16 are defined for platform use.
> >
> > This limitation prevents us from fully utilizing the available
> > local interrupt sources. Additionally, the hwirqs used on RISC-V
> > are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
> > or T-Head's PMU irq) being currently used for supervisor mode.
> >
> > The patch switches to using irq_domain_create_tree() which
> 
> git grep "This patch" Documentation/process/

Sure, will fix.

> > creates the radix tree map, allowing us to handle a larger
> > number of hwirqs.
> 
> Who is 'us'? We are not part of the chip and please write out 'hardware
> interrupts'

OK!

> > @@ -24,10 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> >  {
> >  	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> >  
> > -	if (unlikely(cause >= BITS_PER_LONG))
> > -		panic("unexpected interrupt cause");
> > -
> > -	generic_handle_domain_irq(intc_domain, cause);
> > +	if (generic_handle_domain_irq(intc_domain, cause))
> > +		pr_warn("Failed to handle interrupt (cause: %ld)\n", cause);
> 
> pr_warn_once() or at least pr_warn_ratelimited().

OK!

> >  }
> >  
> >  /*
> > @@ -117,8 +115,8 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> >  {
> >  	int rc;
> >  
> > -	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> > -					       &riscv_intc_domain_ops, NULL);
> > +	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops,
> > +					     NULL);
> 
> Put it into one line. Linebreaking arguments is really only required
> when the line length is exceedingly long. This one is not.

OK! will fix.

Thanks,
Peter Lin
