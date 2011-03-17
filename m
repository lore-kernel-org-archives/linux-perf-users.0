From: john smith <whalajam@yahoo.com>
Subject: [kernel.kallsyms] with build id ... not found, continuing without symbols
Date: Thu, 17 Mar 2011 11:32:48 -0700 (PDT)
Message-ID: <957387.46563.qm@web161909.mail.bf1.yahoo.com>
References: <20110314191526.GA2388@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from web161909.mail.bf1.yahoo.com ([98.139.210.200]:30389 "HELO
	web161909.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755226Ab1CQSjb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Mar 2011 14:39:31 -0400
In-Reply-To: <20110314191526.GA2388@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm running on 2.6.37.1-1.2, using the following rpm's to build tools/perf:
(OpenSUSE 11.4)

elfutils-devel-0.149-1.x86_64.rpm
elfutils-libs-0.149-1.x86_64.rpm
elfutils-libelf-0.149-1.x86_64.rpm 
elfutils-libelf-devel-0.149-1.x86_64.rpm
xz-libs-4.999.9-0.2.beta.20100401git.x86_64.rpm

I' using my own scsi driver - my-driver.

I do:
# perf record -fg fio my_fio_script
# perf annotate -l -k /usr/src/linux/vmlinux -s __lock_acquire
I'm getting:

[my_scsi_driver] with build id bee3bbdcaacc61223b70db093de47efffa26dbc9 not found, continuing without symbols

I see annotated __lock_acquire but if I run:
# perf annotate -l -k /my_driver_path/my_driver.ko -s my_function

I'm getting:
[kernel.kallsyms] with build id 08ba9c1ec15cb50d359428cacb0b490dee51e1a5 not found, continuing without symbols Segmentation fault

However, when doing:
# cat /proc/kallsyms|grep my_function

I'm getting:
ffffffffa0606b90 t   my_function	[my_driver]

I also built & ran perf code copied from kernel version 2.6.38 (had to disable "attr->sample_id_all" field usage in builtin-record.c & util/header.c to build on 2.6.37 as, unfortunatelly my_driver doesn't work on 2.6.38) with the same results.

When doing:
# perf report --verbose --dso='[my_driver]'

I see:
+     85.05%  fio  0x368f6          K [k] 0x368f6
+     14.95%  fio  0x7fffb9fff614   ! [.] 0x7fffb9fff614

Expanding any of these two, I'm getting many '+' prefixed hex addresses  instead of function names (kernel entry names) and I don't see any of the driver's api.
If I select to expand/zoom-in an api that doesn't have '+' and select "Zoom into fio DSO" it "Segmentation fault"

What can I do to annotate/resolve symbols for my_functions?

thanks,
John


      
