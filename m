From: Pavel Emelyanov <xemul@parallels.com>
Subject: Re: [CRIU] RFC: Workload Sampling Using Perf Events and CRIU
Date: Tue, 3 Sep 2013 22:46:56 +0400
Message-ID: <52262EA0.2050109@parallels.com>
References: <5225E25C.30506@codeaurora.org> <5225F078.90508@parallels.com> <5225FE0D.4010505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:50493 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab3ICSq6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Sep 2013 14:46:58 -0400
In-Reply-To: <5225FE0D.4010505@codeaurora.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: criu@openvz.org, linux-perf-users@vger.kernel.org

On 09/03/2013 07:19 PM, Christopher Covington wrote:
>>> My current prototype adds a new command to criu: "sample", requiring an
>>> intervals argument and a workload to execute. When given this command, criu
>>> fork's a child process which opens a perf event that is set up to signal the
>>> parent criu process when the first interval has elapsed (I'm measuring
>>> instructions, but it could be any perf event).
>>
>> I'm not familiar with internals of perf, can you shed more light on this, please.
>> What does "opens a perf event" occurs? Is it an eventfd descriptor with respective
>> setup or something else?
> 
> http://web.eece.maine.edu/~vweaver/projects/perf_events/perf_event_open.html
> 
> I'm passing initial settings as an argument to the perf event open system
> call, which returns a file descriptor. With the file descriptor in hand I can
> then use fcntl and ioctl to do the last part of the setup like setting the
> asynchronous flag and making the parent process the owner so that it gets the
> wakeup signal.

Why do you configure signal delivery for event notification? Isn't it more
convenient just to poll() the perf event descriptor? I'm reading the kernel's
sys_perf_event_open() stuff and see that it's perfectly poll-able.

>>> What do people think of this approach? Would it make more sense to add
>>> something that depends on CRIU to perf tools? Should I look more closely at a
>>> library-based approach? Could potential library users make use of this sort of
>>> fork+exec+signal approach instead of making function calls?
>>
>> For me the scenario you proposes fits naturally into the "service" thing being
>> developed. The part that is missing for your case is that for now "service" is
>> supposed to serve only one "dump-me" request per-connection.
>>
>> Can we somehow from one process configure perf events to come to another process?
>> If yes, then we can make your case look like
>>
>> 1. criu service starts
>> 2. a process with your workload starts and
>>   a) opens perf event
>>   b) connects to criu service
>>   c) delegates the perf event to service
>>   d) sends the "dump me request", with "use delegated event" flag set
>> 3. your workload starts
>>
>> After this once perf event occurs, it's caught by criu service, which in turn
>> dumps the process.
>>
>> So is it possible to make this "perf event delegation to other process"?
> 
> There are two things to be delegated. The first is who gets the wakeup signal.
> As long as the process identifier for the service is known, it should be
> trivial to make a file control ownership call on the perf event file
> descriptor before the workload is executed. The other resource is the file
> descriptor itself, which one must re-program and reset to capture multiple
> checkpoints. The service should have access to the file descriptor once the
> first dump is taken, which is the earliest it would need to perform any
> operations on it anyhow.

Ah, I see. Well, this fits fine into existing service API -- the "dump-me"
requester would have to pass and fd with a directory where to put image files
to, so we can just extend one and pass the fd with events.

> I think this still leaves the specifics of multiple checkpoint dumps in
> sequence somewhat unresolved.

The service is going to look like a "classical" server -- it listens for
connection, then spawns a child and lets one handle the request. After
doing so it's ready to listen for more requests.

> I think I'll try to switch over to the service workflow and play around with
> it a little to get a better idea of what the options might be.

That's great!

Thanks,
Pavel
