From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [CRIU] RFC: Workload Sampling Using Perf Events and CRIU
Date: Tue, 03 Sep 2013 11:19:41 -0400
Message-ID: <5225FE0D.4010505@codeaurora.org>
References: <5225E25C.30506@codeaurora.org> <5225F078.90508@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:49089 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab3ICPTo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Sep 2013 11:19:44 -0400
In-Reply-To: <5225F078.90508@parallels.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Pavel Emelyanov <xemul@parallels.com>
Cc: criu@openvz.org, linux-perf-users@vger.kernel.org

On 09/03/2013 10:21 AM, Pavel Emelyanov wrote:
> On 09/03/2013 05:21 PM, Christopher Covington wrote:
>> Hi,
>>
>> Seeing some overlapping themes in the cr_service CRIU patches, I wanted to
>> bring up a use case that I've been working on--periodic sampling of a workload
>> using perf events and CRIU. My goal is to enable sampling of workload
>> (benchmark) execution on models that are too slow to run the whole thing in a
>> reasonable amount of time. The proposed workflow is to profile the workload on
>> a fast system, post-process the data with a tool like SimPoint to figure out
>> when to take checkpoints, dump checkpoints from the fast system, then restore
>> them on the slow model and get some representative results assuming everything
>> works as intended.
>>
>> Unfortunately I don't have code to share immediately. Should everything go
>> smoothly, I may be able to send stuff out in a few weeks. I was hoping it
>> might be useful to talk general architecture in the meantime.
>>
>> My current prototype adds a new command to criu: "sample", requiring an
>> intervals argument and a workload to execute. When given this command, criu
>> fork's a child process which opens a perf event that is set up to signal the
>> parent criu process when the first interval has elapsed (I'm measuring
>> instructions, but it could be any perf event).
> 
> I'm not familiar with internals of perf, can you shed more light on this, please.
> What does "opens a perf event" occurs? Is it an eventfd descriptor with respective
> setup or something else?

http://web.eece.maine.edu/~vweaver/projects/perf_events/perf_event_open.html

I'm passing initial settings as an argument to the perf event open system
call, which returns a file descriptor. With the file descriptor in hand I can
then use fcntl and ioctl to do the last part of the setup like setting the
asynchronous flag and making the parent process the owner so that it gets the
wakeup signal.

>> With the counter set up, the
>> child executes the workload. The criu parent process then waits for a SIGIO
>> signal from the perf event. When it comes, it dumps the child process, which
>> has modified logic to not dump the perf event file descriptor but instead
>> reset it to the next interval. I tried opening the perf event before the fork,
>> but the start-on-exec flag didn't seem to work in that configuration and I
>> don't really want to include criu's instructions anyway. There's a bit of skid
>> in this setup but I'm hoping it's not significant (the intervals I'm
>> interested in are on the order of hundreds of millions of instructions). If
>> exact precision was important, perhaps the kernel could stop the workload when
>> the count expires and criu could be augmented to be able to dump it, but I
>> figured I'd only try to tackle that if it's needed.
>>
>> The differences between this and the conventional dump are that criu knows the
>> PID from running fork rather than having it passed on the command line, there
>> are multiple dumps in a run, and there is some extra complexity around dumping
>> file descriptors. I had to use the close-on-exec flag when duplicating file
>> descriptors to keep the child process untainted by criu.
>>
>> What do people think of this approach? Would it make more sense to add
>> something that depends on CRIU to perf tools? Should I look more closely at a
>> library-based approach? Could potential library users make use of this sort of
>> fork+exec+signal approach instead of making function calls?
> 
> For me the scenario you proposes fits naturally into the "service" thing being
> developed. The part that is missing for your case is that for now "service" is
> supposed to serve only one "dump-me" request per-connection.
> 
> Can we somehow from one process configure perf events to come to another process?
> If yes, then we can make your case look like
> 
> 1. criu service starts
> 2. a process with your workload starts and
>   a) opens perf event
>   b) connects to criu service
>   c) delegates the perf event to service
>   d) sends the "dump me request", with "use delegated event" flag set
> 3. your workload starts
> 
> After this once perf event occurs, it's caught by criu service, which in turn
> dumps the process.
> 
> So is it possible to make this "perf event delegation to other process"?

There are two things to be delegated. The first is who gets the wakeup signal.
As long as the process identifier for the service is known, it should be
trivial to make a file control ownership call on the perf event file
descriptor before the workload is executed. The other resource is the file
descriptor itself, which one must re-program and reset to capture multiple
checkpoints. The service should have access to the file descriptor once the
first dump is taken, which is the earliest it would need to perform any
operations on it anyhow.

I think this still leaves the specifics of multiple checkpoint dumps in
sequence somewhat unresolved. I think I'll try to switch over to the service
workflow and play around with it a little to get a better idea of what the
options might be.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
