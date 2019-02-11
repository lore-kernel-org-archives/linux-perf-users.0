From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf report: Add s390 diagnosic sampling descriptor size
Date: Mon, 11 Feb 2019 08:49:18 -0300
Message-ID: <20190211114918.GB3269@kernel.org>
References: <20190211100627.85714-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211100627.85714-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Feb 11, 2019 at 11:06:27AM +0100, Thomas Richter escreveu:
> On IBM z13 machine types 2964 and 2965 the descriptor
> sizes for sampling and diagnostic sampling entries
> might be missing in the trailer entry and are set to zero.
> 
> This leads to a perf report failure when processing diagnostic
> sampling entries.
> 
> This patch adds missing descriptor sizes when the trailer entry
> contains zero for these fields.

Thanks, applied.

- Arnaldo
