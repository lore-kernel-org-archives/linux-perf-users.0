From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Date: Thu, 9 Aug 2018 12:14:22 -0300
Message-ID: <20180809151422.GB5395@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
 <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org>
 <20180808161451.GD9543@kernel.org>
 <20180808164214.GE9543@kernel.org>
 <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Aug 09, 2018 at 06:35:58AM +0200, Thomas-Mich Richter escreveu:
> On 08/08/2018 06:42 PM, Arnaldo Carvalho de Melo wrote:
> > So for those I applied this, seems to pass the ones that were failing,
> > restarting tests...

> I just updated the perf/core branch, compiled it and all works fine.

Thanks for checking!
 
> Thanks for fixing these errors.

You're welcome,

- Arnaldo
