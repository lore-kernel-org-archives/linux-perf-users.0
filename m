From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf probe an addr without debuginfo
Date: Tue, 30 Jun 2015 11:40:34 -0700
Message-ID: <CAE40pde_keAUGX7S1MN7ekYhM8E5my445nRKDJvYXRTOw-UPnQ@mail.gmail.com>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
 <20150628154651.GA3953@localhost> <20150629150038.GA1225@kernel.org> <55924725.5010504@hitachi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0122a2d0d18afe0519c08b88
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37977 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbbF3Sky (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 14:40:54 -0400
Received: by igrv9 with SMTP id v9so18870997igr.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2015 11:40:53 -0700 (PDT)
In-Reply-To: <55924725.5010504@hitachi.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin King <benjaminking@web.de>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, cti.systems-productivity-manager.ts@hitachi.com

--089e0122a2d0d18afe0519c08b88
Content-Type: text/plain; charset=UTF-8

G'Day Masami,

On Tue, Jun 30, 2015 at 12:37 AM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> On 2015/06/30 0:00, Arnaldo Carvalho de Melo wrote:
>> Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>>> Hi Brendan
>>>
>>>> Is there a trick to getting perf to probe a user-level address without
>>>> debuginfo? Eg (on Linux 4.0):
>>>> [...]
>>>> I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>>>> works. Thanks,
>>>
>>> Not quite what you have asked for, but you can add the probe via ftrace and
>>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>>> will show up in 'perf list' as well.
>>
>> Masami,
>>
>>       Is this already possible?
>
> Yes, it should be possible. However, I don't recommend you to
> probe the address inside a function without debuginfo. You must
> check the instruction boundary in that case.

Ah, because otherwise I could accidentally trace at a non-zero offsite
inside an instruction? That probably explains the only failure I saw
on uprobes on linux 4.0.

Here's the original use case:

# readelf -n /root/node/node
[...]
  stapsdt              0x00000082 NT_STAPSDT (SystemTap probe descriptors)
    Provider: node
    Name: http__client__request
    Location: 0x0000000000bf48ff, Base: 0x0000000000f22464, Semaphore:
0x0000000001243024
    Arguments: 8@%rax 8@%rdx 8@-136(%rbp) -4@-140(%rbp) 8@-72(%rbp)
8@-80(%rbp) -4@-144(%rbp)
[...]

These user SDT probes (or "USDT probes") can't currently be traced
using perf (although Hemant Kumar was working on a patch).

I can trace them via ftrace, and have already written a helper script.
But that's another story. I'm interested in doing this from perf as
well! (Without needing to create the probes via ftrace.)

I have their instruction offset above from readelf (and need to
subtract the base load address). Here's what doesn't work:

A) Tracing via the absolute address. Eg, "perf probe -x node '@+0x7f48ff'

B) Tracing via the offset from main. Eg, "perf probe -x node
'main+0x...", since perf complains I'm tracing at an offset bigger
than main.

C) Tracing via the offset from the function that contains the probe.
In this case, because the function name is too big! (Due to C++) Eg:

# ./perf probe -x /root/node/node --filter="*"
'_ZN4node26DTRACE_HTTP_CLIENT_REQUESTERKN2v820FunctionCallbackInfoINS0_5ValueEEE+0x42f'
Added new event:
  Error: Failed to add events.

I've attached a trivial patch for (C), it just increases the buffer
size in __add_probe_trace_events() from 64 to 128. It's still a bit of
a nuisance to resolve the containing function (addr2line) when I have
the absolute address...

Brendan

--089e0122a2d0d18afe0519c08b88
Content-Type: text/plain; charset=US-ASCII; name="perf_probename.diff"
Content-Disposition: attachment; filename="perf_probename.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibjoelfd0

IyBkaWZmIC11IGxpbnV4LTQuMC4wKy90b29scy9wZXJmL3V0aWwvcHJvYmUtZXZlbnQuYyBsaW51
eC00LjAuMCticmVuZGFuL3Rvb2xzL3BlcmYvdXRpbC9wcm9iZS1ldmVudC5jCi0tLSBsaW51eC00
LjAuMCsvdG9vbHMvcGVyZi91dGlsL3Byb2JlLWV2ZW50LmMJMjAxNS0wMy0zMSAxODoxMzozMC4w
MDEwMDk3NTQgKzAwMDAKKysrIGxpbnV4LTQuMC4wK2JyZW5kYW4vdG9vbHMvcGVyZi91dGlsL3By
b2JlLWV2ZW50LmMJMjAxNS0wNi0zMCAxODoyMDo1Ny45MTQzMDgwMjYgKzAwMDAKQEAgLTIzODMs
NyArMjM4Myw3IEBACiB7CiAJaW50IGksIGZkLCByZXQ7CiAJc3RydWN0IHByb2JlX3RyYWNlX2V2
ZW50ICp0ZXYgPSBOVUxMOwotCWNoYXIgYnVmWzY0XTsKKwljaGFyIGJ1ZlsxMjhdOwogCWNvbnN0
IGNoYXIgKmV2ZW50LCAqZ3JvdXA7CiAJc3RydWN0IHN0cmxpc3QgKm5hbWVsaXN0OwogCUxJU1Rf
SEVBRChibGFja2xpc3QpOwpAQCAtMjQzNyw3ICsyNDM3LDcgQEAKIAkJCWdyb3VwID0gUEVSRlBS
T0JFX0dST1VQOwogCiAJCS8qIEdldCBhbiB1bnVzZWQgbmV3IGV2ZW50IG5hbWUgKi8KLQkJcmV0
ID0gZ2V0X25ld19ldmVudF9uYW1lKGJ1ZiwgNjQsIGV2ZW50LAorCQlyZXQgPSBnZXRfbmV3X2V2
ZW50X25hbWUoYnVmLCAxMjgsIGV2ZW50LAogCQkJCQkgbmFtZWxpc3QsIGFsbG93X3N1ZmZpeCk7
CiAJCWlmIChyZXQgPCAwKQogCQkJYnJlYWs7Cg==
--089e0122a2d0d18afe0519c08b88--
