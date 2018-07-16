From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 4/4 v4] perf stat: Add transaction flag (-T) support for
 s390
Date: Mon, 16 Jul 2018 16:40:23 -0400
Message-ID: <20180716204023.GA13669@kernel.org>
References: <20180626071701.58190-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180626071701.58190-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ak@linux.intel.com, jolsa@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 26, 2018 at 09:17:01AM +0200, Thomas Richter escreveu:
> perf stat command line flag -T to display transaction counters is
> currently supported for x86 only.
> Add support for s390. It is based on the metrics flag -M transaction
> using the architecture dependend json files. This requires a metric
> named "transaction" in the json files for the platform.
> 
> Introduce new function metricgroup__has_metric() to check for
> the existance of a metric_name transaction.
> 
> As suggested by Andi Kleen, this is the new approach to support
> transactions counters. Other architectures will follow.

Applied the 4-part patch series,

- Arnaldo
