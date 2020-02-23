From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/8] powerpc/perf/hv-24x7: Fix inconsistent output
 values incase multiple hv-24x7 events run
Date: Sat, 22 Feb 2020 18:51:19 -0800
Message-ID: <20200223025119.GA17174@us.ibm.com>
References: <20200221061022.3047-1-kjain@linux.ibm.com>
 <20200221061022.3047-2-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20200221061022.3047-2-kjain@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Kajol Jain <kjain@linux.ibm.com>
Cc: mark.rutland@arm.com, maddy@linux.vnet.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, mingo@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com, alexander.shishkin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, acme@kernel.org, jmario@redhat.com, namhyung@kernel.org, tglx@linutronix.de, mpetlan@redhat.com, gregkh@linuxfoundation.org, linux-perf-users@vger.kernel.org, jolsa@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

Kajol Jain [kjain@linux.ibm.com] wrote:
> Commit 2b206ee6b0df ("powerpc/perf/hv-24x7: Display change in counter
> values")' added to print _change_ in the counter value rather then raw
> value for 24x7 counters. Incase of transactions, the event count
> is set to 0 at the beginning of the transaction. It also sets
> the event's prev_count to the raw value at the time of initialization.
> Because of setting event count to 0, we are seeing some weird behaviour,
> whenever we run multiple 24x7 events at a time.

Interesting. Are we taking delta of a delta and ending up with large
negative values in the -I case?  However...

<snip>

> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 573e0b309c0c..6dbbf70232aa 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1409,7 +1409,7 @@ static void h_24x7_event_read(struct perf_event *event)
>  			 * that would require issuing a hcall, which would then
>  			 * defeat the purpose of using the txn interface.
>  			 */
> -			local64_set(&event->count, 0);
> +			local64_add(0, &event->count);

... not sure, how adding zero to the count helps. Should we just remove the
line (and the comment block above it)?  Or does it help to clear the event
count in ->start_txn() rather than on read()?

How does the change impact the counts when run without the -I?

Thanks for chasing this down.

Sukadev
