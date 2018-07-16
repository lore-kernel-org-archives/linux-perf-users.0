From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf kvm: Fix subcommands on s390
Date: Mon, 16 Jul 2018 16:43:01 -0400
Message-ID: <20180716204301.GB13669@kernel.org>
References: <20180712070936.67547-1-tmricht@linux.ibm.com>
 <de10696f-0fc3-4e34-d6dc-f9e669adc568@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <de10696f-0fc3-4e34-d6dc-f9e669adc568@linux.ibm.com>
Sender: stable-owner@vger.kernel.org
To: Stefan Raspl <raspl@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jul 12, 2018 at 04:17:14PM +0200, Stefan Raspl escreveu:
> On 12.07.2018 09:09, Thomas Richter wrote:
> > With commit eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> > s390 platform provides detailed type/model/capacitiy information
> > in the CPU indentifier string instead of just "IBM/S390".

> > This breaks perf kvm support which uses hard coded string IBM/S390 to
> > compare with the CPU identifier string. Fix this by changing the comparison.

> > Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> > Cc: Stefan Raspl <raspl@linux.ibm.com>
> > Cc: <stable@vger.kernel.org> # 4.17

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
 
> Reported-and-tested-by: Stefan Raspl <raspl@linux.ibm.com>

Thanks, applied together with Christian's Acked-by,

- Arnaldo
