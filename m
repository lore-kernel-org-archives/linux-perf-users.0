From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf annotate: Fix objdump comment parsing for Intel mov
 dissassembly
Date: Thu, 30 Nov 2017 16:20:08 -0300
Message-ID: <20171130192008.GS3298@kernel.org>
References: <20171128075632.72182-1-tmricht@linux.vnet.ibm.com>
 <69859e3b-cb22-a536-79ca-ffc44c3f86a8@linux.vnet.ibm.com>
 <d2e2818d-6d49-c208-68f5-8cd28034bbfc@linux.vnet.ibm.com>
 <9c33e7e2-9101-27fa-d1f4-cbdb4777fcc5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9c33e7e2-9101-27fa-d1f4-cbdb4777fcc5@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Nov 29, 2017 at 08:52:13PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 11/29/2017 08:33 PM, Thomas-Mich Richter wrote:
> > On 11/29/2017 02:24 PM, Ravi Bangoria wrote:
> >>
> >> On 11/28/2017 01:26 PM, Thomas Richter wrote:
> >>> The command 'perf annotate' parses the output of objdump and also
> >>> investigates the comments produced by objdump. For example the
> >>> output of objdump produces (on x86):
> >>>
> >>> 23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
> >>>                                 # 234008 <stderr@@GLIBC_2.2.5+0x9a8>
> >>>
> >>> and the function mov__parse() is called to investigate the complete
> >>> line. Mov__parse() breaks this line into several parts and finally
> >>> calls function comment__symbol() to parse the data after the comment
> >>> character '#'. Comment__symbol() expects a hexadecimal address followed
> >>> by a symbol in '<' and '>' brackets.
> >>>
> >>> However the 2nd parameter given to function comment__symbol()
> >>> always points to the comment character '#'. The address parsing
> >>> always returns 0 because the character '#' is not a digit and
> >>> strtoull() fails without being noticed.
> >>>
> >>> Fix this by advancing the second parameter to function comment__symbol()
> >>> by one byte before invocation and add an error check after strtoull()
> >>> has been called.
> >> Yeah, looks like it fails to get correct value in 'addrp'.
> >>
> >> Can you please show the difference in perf annotate output before
> >> and after patch.
> >>
> >> Thanks,
> >> Ravi
> >>
> >
> > There is no difference in output of --stdio. The adress value is not
> > read and remains 0x0 in ops->source.addr or ops->target.addr.
> > That is not visible because in function mov__scnprintf() that wrong
> > address is not printed:
> >
> > static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
> >                            struct ins_operands *ops)
> > {
> >         return scnprintf(bf, size, "%-6.6s %s,%s", ins->name,
> >                          ops->source.name ?: ops->source.raw,
> >                          ops->target.name ?: ops->target.raw);
> > }
> 
> Looks good.  Ack-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
