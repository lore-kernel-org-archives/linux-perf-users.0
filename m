From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Getting PEBS to work
Date: Thu, 19 May 2016 16:13:12 -0700
Message-ID: <CAE40pdft3O+5YmaX=KqvVnWo1Lne=VR41-zOdpYC4Q0P4i-Tfw@mail.gmail.com>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
 <CAPAnC4PsdkN=9NQ6D_n2p6NX64yB0ASXhTqQRsGw5N3Jvr3d2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33462 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbcESXNm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 19:13:42 -0400
Received: by mail-ig0-f193.google.com with SMTP id rc4so9065496igc.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2016 16:13:42 -0700 (PDT)
In-Reply-To: <CAPAnC4PsdkN=9NQ6D_n2p6NX64yB0ASXhTqQRsGw5N3Jvr3d2A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: jim mauro <jim.mauro@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day Jim,

Thanks, but no luck here:

# perf record -vv -e r412e:pp -c 10000 -a -- sleep 1
------------------------------------------------------------
perf_event_attr:
  type                4
  size                96
  config              0x412e
  sample_period       10000
  sample_freq         10000
  sample_type         0x87
  read_format         0
  disabled            1    inherit             1
  pinned              0    exclusive           0
  exclude_user        0    exclude_kernel      0
  exclude_hv          0    exclude_idle        0
  mmap                1    comm                1
  freq                0    inherit_stat        0
  enable_on_exec      0    task                0
  watermark           0    precise_ip          2
  mmap_data           0    sample_id_all       1
  exclude_host        0    exclude_guest       1
  excl.callchain_kern 0    excl.callchain_user 0
  mmap2               0
  wakeup_events       0
  wakeup_watermark    0
  bp_type             0
  bp_addr             0
  config1             0
  bp_len              0
  config2             0
  branch_sample_type  0
  sample_regs_user    0
  sample_stack_user   0
------------------------------------------------------------
perf_event_open: pid -1  cpu 0  group_fd -1  flags 0
perf_event_open failed, error -95
Error:
'precise' request may not be supported. Try removing 'p' modifier.
sleep: Terminated

It does have "precise_ip 2", so it parsed.

Oh, I should have said, r412e should be LLC misses. Pretty standard.
Manual says it is PEBS supported.

So you have PEBS working? What's your kernel version and CPU type? Thanks,

Brendan

On Thu, May 19, 2016 at 4:09 PM, jim mauro <jim.mauro@gmail.com> wrote:
> [resending without the link, as it was rejected because of the html]....
>
> Hey Brendan - Looks like you need to append "pp" to the event encoding.
>
> Does "perf record -vv -e r412e:pp -c 10000 -a -- sleep 1" work?
>
>
>
> On Thu, May 19, 2016 at 3:29 PM, Brendan Gregg <brendan.d.gregg@gmail.com>
> wrote:
>>
>> G'Day perf-users,
>>
>> Different Q than my previous email... This is a physical system (Linux
>> 3.13, Sandy Bridge) that's I think is supposed to have PEBS, but it
>> doesn't work. Eg:
>>
>> # perf record -e r412e:p -c 10000 -a -- sleep 1
>> Error:
>> 'precise' request may not be supported. Try removing 'p' modifier.
>> sleep: Terminated
>>
>> Maybe I'm doing it wrong? Here's -vv:
>>
>> # perf record -vv -e r412e:p -c 10000 -a -- sleep 1
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                4
>>   size                96
>>   config              0x412e
>>   sample_period       10000
>>   sample_freq         10000
>>   sample_type         0x87
>>   read_format         0
>>   disabled            1    inherit             1
>>   pinned              0    exclusive           0
>>   exclude_user        0    exclude_kernel      0
>>   exclude_hv          0    exclude_idle        0
>>   mmap                1    comm                1
>>   freq                0    inherit_stat        0
>>   enable_on_exec      0    task                0
>>   watermark           0    precise_ip          1
>>   mmap_data           0    sample_id_all       1
>>   exclude_host        0    exclude_guest       1
>>   excl.callchain_kern 0    excl.callchain_user 0
>>   mmap2               0
>>   wakeup_events       0
>>   wakeup_watermark    0
>>   bp_type             0
>>   bp_addr             0
>>   config1             0
>>   bp_len              0
>>   config2             0
>>   branch_sample_type  0
>>   sample_regs_user    0
>>   sample_stack_user   0
>> ------------------------------------------------------------
>> perf_event_open: pid -1  cpu 0  group_fd -1  flags 0
>> perf_event_open failed, error -95
>> Error:
>> 'precise' request may not be supported. Try removing 'p' modifier.
>> sleep: Terminated
>>
>> This CPU does have DS:
>>
>> # cpuid -1 | gerp 'debug store'
>>       debug store                            = true
>>       64-bit debug store                      = true
>>       CPL-qualified debug store               = true
>>
>> And bit 12 of IA32_MISC_ENABLE is 0, which should mean PEBS is supported:
>>
>> # rdmsr 0x1a0 -f 12:12
>> 0
>>
>> Any other way to debug?
>>
>> I see x86_pmu_hw_config() has been updated since 3.13, so maybe I
>> should upgrade the kernel... Thanks,
>>
>> Brendan
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
