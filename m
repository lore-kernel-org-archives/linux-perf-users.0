From: David Ahern <dsahern@gmail.com>
Subject: Re: perf terminates immediately with segfault in dmesg
Date: Wed, 27 Feb 2013 09:17:07 -0700
Message-ID: <512E3183.6000007@gmail.com>
References: <CAP+Vy9d8Yd7HoxvixS6oT+wow+rV2PzriKBqOw17VVFwTc0iNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:60169 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3B0QRL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Feb 2013 11:17:11 -0500
Received: by mail-da0-f48.google.com with SMTP id w4so364007dam.35
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Feb 2013 08:17:11 -0800 (PST)
In-Reply-To: <CAP+Vy9d8Yd7HoxvixS6oT+wow+rV2PzriKBqOw17VVFwTc0iNg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 2/27/13 7:21 AM, Dongsoo Nathaniel Kim wrote:
> Hi,
>
> I'm trying to profile kvm guest and host as well.
> I checked out v3.8 vanilla kernel and built bundled perf tool.
> (commit 19f949f52599ba7c3f67a5897ac6be14bfcb1200)
>
> Here is my command line:
> sudo perf kvm --host --guest --guestmount=/tmp/guestmount record -o
> my.perf.data
> (I mounted guest instance on /tmp/guestmount using sshfs)
>
> and perf gets terminated immediately and no clue but segfault message in
> dmesg:
> [11618.130483] perf[39937]: segfault at 30 ip 00007fed26de1121 sp
> 00007fff0394c258 error 4 in libc-2.15.so[7fed26d58000+1b5000]
>
> Any idea? Can too many processor core cause this problem?

Does this solve the problem for you?

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ca3f80e..e55701d 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -973,7 +973,7 @@ __cmd_buildid_list(const char *file_name, int argc, 
const char **argv)

  int cmd_kvm(int argc, const char **argv, const char *prefix 
__maybe_unused)
  {
-   const char *file_name;
+   const char *file_name = NULL;

     const struct option kvm_options[] = {
         OPT_STRING('i', "input", &file_name, "file",
