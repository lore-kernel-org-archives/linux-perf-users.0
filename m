From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 3/7] perf script python: add Python3 support to
 check-perf-trace.py
Date: Wed, 6 Mar 2019 18:11:37 -0300
Message-ID: <20190306211137.GO30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-4-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-4-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Tom Zanussi <tzanussi@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 01, 2019 at 05:18:59PM -0800, Tony Jones escreveu:
> Support both Python 2 and Python 3 in the check-perf-trace.py script.
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of from __future__ implies the minimum supported version of
> Python2 is now v2.6

Thanks, applied
