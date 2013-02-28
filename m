From: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>
Subject: Re: perf terminates immediately with segfault in dmesg
Date: Thu, 28 Feb 2013 10:22:16 +0900
Message-ID: <CAP+Vy9dFFqhchMiPEW0CAudoCkjDcyJY2HA5s6yvad+Q8kqVNQ@mail.gmail.com>
References: <CAP+Vy9d8Yd7HoxvixS6oT+wow+rV2PzriKBqOw17VVFwTc0iNg@mail.gmail.com>
 <512E3183.6000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:38155 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3B1BW5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Feb 2013 20:22:57 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so2650089oag.11
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Feb 2013 17:22:56 -0800 (PST)
In-Reply-To: <512E3183.6000007@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi David,

It seems to be solving the problem.

Cheers,

On Thu, Feb 28, 2013 at 1:17 AM, David Ahern <dsahern@gmail.com> wrote:
> On 2/27/13 7:21 AM, Dongsoo Nathaniel Kim wrote:
>>
>> Hi,
>>
>> I'm trying to profile kvm guest and host as well.
>> I checked out v3.8 vanilla kernel and built bundled perf tool.
>> (commit 19f949f52599ba7c3f67a5897ac6be14bfcb1200)
>>
>> Here is my command line:
>> sudo perf kvm --host --guest --guestmount=/tmp/guestmount record -o
>> my.perf.data
>> (I mounted guest instance on /tmp/guestmount using sshfs)
>>
>> and perf gets terminated immediately and no clue but segfault message in
>> dmesg:
>> [11618.130483] perf[39937]: segfault at 30 ip 00007fed26de1121 sp
>> 00007fff0394c258 error 4 in libc-2.15.so[7fed26d58000+1b5000]
>>
>> Any idea? Can too many processor core cause this problem?
>
>
> Does this solve the problem for you?
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index ca3f80e..e55701d 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -973,7 +973,7 @@ __cmd_buildid_list(const char *file_name, int argc,
> const char **argv)
>
>  int cmd_kvm(int argc, const char **argv, const char *prefix __maybe_unused)
>  {
> -   const char *file_name;
> +   const char *file_name = NULL;
>
>     const struct option kvm_options[] = {
>         OPT_STRING('i', "input", &file_name, "file",
>
>



--
=
Dongsoo Nathaniel Kim
Linux kernel, media device S/W engineer / Ph.D Student
Dept. of Computer Science, KAIST
Real-time & Embedded Systems Lab.
