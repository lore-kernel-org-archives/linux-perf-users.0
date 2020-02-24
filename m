From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] powerpc/perf/hv-24x7: Fix inconsistent output
 values incase multiple hv-24x7 events run
Date: Mon, 24 Feb 2020 10:47:38 +0530
Message-ID: <699d0e3f-47a9-3ee6-7055-08509c635294@linux.ibm.com>
References: <20200221061022.3047-1-kjain@linux.ibm.com>
 <20200221061022.3047-2-kjain@linux.ibm.com>
 <20200223025119.GA17174@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200223025119.GA17174@us.ibm.com>
Content-Language: en-US
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
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mark.rutland@arm.com, maddy@linux.vnet.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, mingo@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com, alexander.shishkin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, acme@kernel.org, jmario@redhat.com, namhyung@kernel.org, tglx@linutronix.de, mpetlan@redhat.com, gregkh@linuxfoundation.org, linux-perf-users@vger.kernel.org, jolsa@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org



On 2/23/20 8:21 AM, Sukadev Bhattiprolu wrote:
> Kajol Jain [kjain@linux.ibm.com] wrote:
>> Commit 2b206ee6b0df ("powerpc/perf/hv-24x7: Display change in counter
>> values")' added to print _change_ in the counter value rather then raw
>> value for 24x7 counters. Incase of transactions, the event count
>> is set to 0 at the beginning of the transaction. It also sets
>> the event's prev_count to the raw value at the time of initialization.
>> Because of setting event count to 0, we are seeing some weird behaviour,
>> whenever we run multiple 24x7 events at a time.
> 
> Interesting. Are we taking delta of a delta and ending up with large
> negative values in the -I case?  However...
> 

Hi Sukadev,
       That's right, we are ending up in calculating delta of delta which may give us negative values
because of which we are getting these large values in -I case.

> <snip>
> 
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  arch/powerpc/perf/hv-24x7.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
>> index 573e0b309c0c..6dbbf70232aa 100644
>> --- a/arch/powerpc/perf/hv-24x7.c
>> +++ b/arch/powerpc/perf/hv-24x7.c
>> @@ -1409,7 +1409,7 @@ static void h_24x7_event_read(struct perf_event *event)
>>  			 * that would require issuing a hcall, which would then
>>  			 * defeat the purpose of using the txn interface.
>>  			 */
>> -			local64_set(&event->count, 0);
>> +			local64_add(0, &event->count);
> 
> ... not sure, how adding zero to the count helps. Should we just remove the
> line (and the comment block above it)?  Or does it help to clear the event
> count in ->start_txn() rather than on read()?

Its not impacting much as we are just adding and not setting event count.I think we can remove that line
with the comment added. Will it be ok if I remove that whole part?

> 
> How does the change impact the counts when run without the -I?

There won't be much impact because from my understanding you did add 
`(void)local64_xchg(&event->hw.prev_count, ct);`, to print change value in your
Commit 2b206ee6b0df in function 'h_24x7_event_init()'.
And we will go through this path in case of 'without -I'. Please let me know if my
understanding is correct.

Thanks,
Kajol

> 
> Thanks for chasing this down.
> 
> Sukadev
> 
