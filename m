From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf stat: Add transaction flag (-T) support for s390
Date: Thu, 21 Jun 2018 19:36:04 -0700
Message-ID: <87in6bsg2z.fsf@linux.intel.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
        <20180621080452.61012-4-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621080452.61012-4-tmricht@linux.ibm.com> (Thomas Richter's
        message of "Thu, 21 Jun 2018 10:04:52 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Thomas Richter <tmricht@linux.ibm.com> writes:
>  
> +		/* Handle -T as -M transaction. Once platform specific metrics
> +		 * support has been added to the json files, all archiectures
> +		 * will use this approach.
> +		 */
> +		if (!strcmp(perf_env__arch(NULL), "s390")) {

Use pmu_have_event() instead.

You may need to add support for wildcard pmus to it.

-Andi
