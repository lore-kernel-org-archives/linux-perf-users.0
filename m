From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf/list: Fix s390 counter long description for
 L1D_RO_EXCL_WRITES
Date: Fri, 29 Mar 2019 11:56:45 -0300
Message-ID: <20190329145645.GA32495@kernel.org>
References: <20190329133337.60255-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329133337.60255-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 29, 2019 at 02:33:37PM +0100, Thomas Richter escreveu:
> Command
>   # ./perf list --long-desc pmu
> lists the long description of the available counters. For counter
> named L1D_RO_EXCL_WRITES on machine types 3906 and 3907 the long
> description contains the counter number 'Counter:128 Name:'
> prefix. This is wrong.
> 
> The fix changes the description text and removes this prefix.

Thanks, applied.

- Arnaldo
