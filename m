From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf stat: Make function perf_stat_evsel_id_init static
Date: Mon, 12 Mar 2018 12:10:41 -0300
Message-ID: <20180312151041.GB23720@kernel.org>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 12, 2018 at 11:38:07AM +0100, Thomas Richter escreveu:
> Function perf_stat_evsel_id_init() has global linkage
> but is only used in util/stat.c. Make it static.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
