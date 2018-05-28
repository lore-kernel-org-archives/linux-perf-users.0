From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf docu: Update section on cpu description
Date: Mon, 28 May 2018 16:50:09 -0300
Message-ID: <20180528195009.GH25467@kernel.org>
References: <20180528074903.21781-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180528074903.21781-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, May 28, 2018 at 09:49:03AM +0200, Thomas Richter escreveu:
> Fix the section HEADER_CPUDESC so the documentation
> matches code.  Swap the two members of struct nr_cpus.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

I have this one already in my perf/core branch:

https://git.kernel.org/acme/c/ec6fb1a1642c2

- Arnaldo
