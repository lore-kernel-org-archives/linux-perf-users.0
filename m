From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 1/3] perf script: Fix --max-blocks man page description
Date: Tue, 16 Jul 2019 15:43:02 -0300
Message-ID: <20190716184302.GB3624@kernel.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711181922.18765-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jul 11, 2019 at 11:19:20AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The --max-blocks description was using the old name brstackasm.
> Use brstackinsn instead.

Thanks, applied.

- Arnaldo
