From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC V3 0/3] perf stat: improvements for handling of multiple PMUs
Date: Wed, 7 Mar 2018 11:04:08 +0100
Message-ID: <20180307100408.GA22848@krava>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, timur@codeaurora.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 06, 2018 at 09:04:41AM -0500, Agustin Vega-Frias wrote:
> This series of patches adds some simple improvements to the way perf stat
> handles PMUs that have multiple instances by:
> 
> 1. Adding glob-like matching in addition to the prefix-based matching
>    introduced previously (patch 1).
> 2. Adding the ability to recover the PMU names when printing the events
>    separately with the --no-merge option (patch 2).
> 3. Restoring auto-merge for events created by prefix or glob-like match
>    (patch 3). Note that this still keeps the behavior that disables
>    auto-merging of legacy symbolic events (e.g. cycles).
> 
> V3:
> 
> - Consolidated prefix and glob matching into a single glob match with a
>   trailing * to maintain prefix matching and have more consistent behavior.
>   E.g., all of these match all the uncore_imc PMUs: imc, imc*, *imc, *imc*

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
