From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Ping [PATCH v3] perf report: Create auxiliary trace data files
 for s390
Date: Wed, 22 Aug 2018 10:14:38 -0300
Message-ID: <20180822131438.GC2880@kernel.org>
References: <20180822043739.100205-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180822043739.100205-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Aug 22, 2018 at 06:37:39AM +0200, Thomas Richter escreveu:
> Create auxiliary trace data log files when invoked with option
>  --itrace=d as in

Thanks, applied to my local perf/core branch, should appear online after
it goes thru testing together with the other changes I have queued up.

- Arnaldo
