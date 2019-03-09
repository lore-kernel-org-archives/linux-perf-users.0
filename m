From: Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH RFC 0/3] btrfs: Performance profiler support
Date: Sat, 9 Mar 2019 08:21:22 +0200
Message-ID: <4040a77a-7e64-9667-3ede-d0750456c9f4@suse.com>
References: <20190306061907.29685-1-wqu@suse.com>
 <20190307140223.GH31119@twin.jikos.cz>
 <ccf67c41-752a-6812-0de7-34f39c37ecac@gmx.com>
 <20190307161203.GJ31119@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <20190307161203.GJ31119@twin.jikos.cz>
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On 7.03.19 г. 18:12 ч., David Sterba wrote:
> On Thu, Mar 07, 2019 at 10:18:49PM +0800, Qu Wenruo wrote:
>>> Well, most of that is answered by 'figure out how to use tracepoints and
>>> perf for that'.
>>>
>>> If there were not a whole substystem, actively maintained and
>>> documented, implementing something like that might help, but that's not
>>> the case.
>>>
>>> I see what you were able to understand from the results, but it's more
>>> like a custom analysis tool that should not merged as-is. It brings a
>>> whole new interface and that's always hard to get right with all the
>>> mistakes ahead that somebody has probably solved already.
>>>
>>> It would be good to have list of the limitations of perf you see, and we
>>> can find a solution ourselves or ask elsewhere.
>>
>> Add linux-perf-users mail list.
>>
>> I should mention the problem of ftrace (or my perf skill) in cover letter.
>>
>> The biggest problem is the conflicts between detailed function execution
>> duration and classification.
>>
>> For tree lock case, indeed we can use function graph to get execution
>> duration of btrfs_tree_read_lock() and btrfs_tree_lock().
>> But that's all. We can't really do much classification.
>>
>> If just use trace event, with trace event added, then we can't get the
>> execution duration.
> 
> I think you can save the start and end times and put the delta to the
> tracepoint output.
> 

Yes, this can be done and in fact JBD2 uses a similar approach. For
example check how journal->j_stats is being used in fs/jbd2/commit.c.
I.e stats are accumulated in a structure which is then printed by some
tracepoints. Concretely, rs_request_delayd calculates the delay between
transaction commit being requested and the transaction entering locked
(committing) state.
