From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: Fix subtest number when showing results
Date: Tue, 24 Jul 2018 11:17:51 -0300
Message-ID: <20180724141751.GC13220@kernel.org>
References: <20180724134858.100644-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724134858.100644-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jul 24, 2018 at 03:48:58PM +0200, Thomas Richter escreveu:
> Perf test 40 for example has several subtests numbered 1-4 when
> displaying the start of the subtest. When the subtest results
> are displayed the subtests are numbered 0-3.
> 
> Use this command to generate trace output:
> [root@s35lp76 perf]# ./perf test -Fv 40 2>/tmp/bpf1
> 
> Fix this by adjusting the subtest number when show the
> subtest result.

Thanks, applied.

- Arnaldo
