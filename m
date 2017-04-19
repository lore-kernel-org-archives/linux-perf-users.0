From: Daniel John FitzGerald <daniel.j.fitzgerald@gmail.com>
Subject: perf_event sampling a multithreaded process - ioctl with
 PERF_EVENT_IOC_SET_OUTPUT fails
Date: Wed, 19 Apr 2017 11:15:20 -0400
Message-ID: <d7635c6e-1d12-52d7-6b9f-b7c08d3a451f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34409 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965015AbdDSPPX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2017 11:15:23 -0400
Received: by mail-qk0-f176.google.com with SMTP id p68so22715508qke.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2017 08:15:23 -0700 (PDT)
Received: from [9.56.117.164] (sinepix2gb.ny.us.ibm.com. [129.42.208.169])
        by smtp.googlemail.com with ESMTPSA id n128sm1793947qkf.12.2017.04.19.08.15.20
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 08:15:20 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I've been trying to prototype an application that would use perf_event
sampling (sample_period > 0 in *attr parameter passed on call to
perf_event_open()) to monitor multiple performance counters for a
potentially multi-threaded process.  After playing with
perf_event_open() for a while, the solution I've come up with works like
this:

 1. Use fork() to create a child process that we will use to execute the
    multi-threaded test after the parent gives it the go-ahead over an
    IPC pipe.  In my test program, the child simply calls a local
    function that runs the load, so no need to exec.
 2. In the *attr parameter passed to perf_event_open(), set inherit=1
    and disabled=1.
 3. For each logical CPU that could execute the program:
     1. For each event that we want to monitor:
         1. If this is the first event we've processed for this CPU:
             1. In the *attr parameter passed to perf_event_open(), set
                disabled = 1.
             2. Call perf_event_open() to open the event: leaderFD =
                perf_event_open(*attr, <child_process_id>,
                <this_cpu_id>, -1, 0);
             3. Call mmap() to allocate a ring buffer: ringBuffer=
                mmap(NULL, MMAPBUFFERSIZE, PROT_READ | PROT_WRITE,
                MAP_SHARED, leaderFD, 0);
         2. Else:
             1. In the *attr parameter passed to perf_event_open(), set
                disabled=0.
             2. Call perf_event_open() to open the event: followerFD =
                perf_event_open(*attr, <child_process_id>,
                <this_cpu_id>, leaderFD, 0);
             3. Issue an ioctl() with PERF_EVENT_IOC_SET_OUTPUT to tell
                perf_event to associate followerFD with leaderFD, which
                will cause perf_event to report this event's kernel
                notifications to the
                the mmap'd ring buffer at ringBuffer.
 4. Issue an ioctl() with PERF_EVENT_IOC_ENABLE on the first event on
    each CPU to enable all events
 5. Issue the IPC synchronization signal (in my case, close a shared
    pipe) to alert the child process to begin its' test.

The problem that I am running into is that whenever I attempt to call
ioctl() with PERF_EVENT_IOC_SET_OUTPUT, I get a -1 response with
errno==EINVAL.  After looking through the mail archives as well as at
similar code in the oprofile and PAPI projects, I can't figure out why
this would be.  I know that I can successfully call perf_event_open() on
all events for all CPUs.  Furthermore, I can create a stand-alone ring
buffer for multiple events on the same CPU (I haven't tried doing it for
all events on all CPUs but feel it would work).  Does anybody have an
idea about what I could be doing wrong here?

For reference, here is the contents *attr structure, event:

    memset(&event, 0, sizeof(event));             // Initialize all
    fields to zero
    event.type = PERF_TYPE_RAW;                   // We will use custom
    "raw" config values, defined in pwr8_hpm_MMCR_map[]
    event.size = sizeof(struct perf_event_attr);  // The size of the
    perf_event_attr structure
    assert(event.config == 0);                    // This will be set
    when we open our individual performance counters
    event.sample_period = 1048576;                // Generate a sample
    overflow notification every 1M events
    event.sample_type = PERF_SAMPLE_IP;           // Record the
    instruction pointer
    event.sample_type |= PERF_SAMPLE_TID;         // Record the process
    and thread IDs
    event.sample_type |= PERF_SAMPLE_TIME;        // Record a timestamp
    with each sample
    event.sample_type |= PERF_SAMPLE_READ;        // Record counter
    values for all events in the group
    event.sample_type |= PERF_SAMPLE_CPU;         // Record the CPU
    number associated with this event
    event.disabled = 1;                           // Disable this
    counter on initialization (only done for parent event)
    event.inherit = 1;                            // Sample for child
    threads as well
    event.exclude_kernel = 1;                     // Exclude events that
    happened in kernel space
    event.exclude_hv = 1;                         // Exclude events that
    happened in hypervisor space
    event.exclude_idle = 0;                       // Include events that
    happened when the CPU is idle
    event.precise_ip = 2;                         // Request a precise
    IP address whenever possible
    assert(event.watermark == 0);                 // Required to use
    wakeup_events
    assert(event.freq == 0);                      // Indicate that we're
    using counter-based sampling
    event.wakeup_events = 1;                      // Begin sending
    overflow notifications after x events
    event.bp_type = HW_BREAKPOINT_EMPTY;          // No breakpoint type
    assert(event.config1 == 0);                   // Not used
    assert(event.config2 == 0);                   // Not used

-- 
Regards,
Dan FitzGerald

An enlightenment painter would paint a grand house on a lawn;
A romantic painter would paint it on fire.
