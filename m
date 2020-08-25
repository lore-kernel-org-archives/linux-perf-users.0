From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Tue, 25 Aug 2020 08:47:21 -0700
Message-ID: <20200825154721.GP1509399@tassilo.jf.intel.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, jolsa@redhat.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> This patch adds new structure called 'json_event' inside jevents.h
> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.

Looks good to me. Thanks.

I wouldn't consolidate with event_struct, these are logically
different layers.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
