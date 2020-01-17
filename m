From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 5/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Fri, 17 Jan 2020 08:28:07 -0800
Message-ID: <20200117162807.GL302770@tassilo.jf.intel.com>
References: <20200117124620.26094-1-kjain@linux.ibm.com>
 <20200117124620.26094-6-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200117124620.26094-6-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org
List-Id: linux-perf-users.vger.kernel.org

On Fri, Jan 17, 2020 at 06:16:19PM +0530, Kajol Jain wrote:
> Patch enhances current metric infrastructure to handle "?" in the metric
> expression. The "?" can be use for parameters whose value not known while
> creating metric events and which can be replace later at runtime to
> the proper value. It also add flexibility to create multiple events out
> of single metric event added in json file.

Please add a proper specification how this ? thing is supposed to work,
what the exact semantics are, how it is different from the existing
# mechanism etc.

The standard way to do similar things before was to define an explicit
# name and let the expr code take care of it. 

-Andi 
