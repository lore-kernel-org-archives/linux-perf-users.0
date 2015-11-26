From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH] perf probe: Adjust dso->long_name for offline module
Date: Thu, 26 Nov 2015 09:29:32 +0800
Message-ID: <5656607C.40907@huawei.com>
References: <1448451059-156220-1-git-send-email-wangnan0@huawei.com> <50399556C9727B4D88A595C8584AAB3752631912@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:59225 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbKZB3z (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 20:29:55 -0500
In-Reply-To: <50399556C9727B4D88A595C8584AAB3752631912@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, "acme@kernel.org" <acme@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Zefan Li <lizefan@huawei.com>, "pi3orama@163.com" <pi3orama@163.com>



On 2015/11/26 9:10, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / HIRAMATU=EF=BC=
=8CMASAMI wrote:
> From: Wang Nan [mailto:wangnan0@huawei.com]
>> If libelf unable to open debuginfo for an offline module but the ko =
has
>> symtab, something unexpected may happen.
>>
>> # rm -rf ~/.debug/
>> # mv /usr/lib64/elfutils/libebl_x86_64.so{,.bak}
> Please do give more possible usecase. removing libebl is crazy,
> and broken environment.

It is a real problem we met, where perf itself is statically linked
and copied to target platform.

> If you'd like to use perf probe without debuginfo, make NO_DWARF=3D1 =
or
> strip the target binary.

Can't simply stripping the target binary because the symtab would
also be stipped out.

>> # ./perf probe -m /home/wangnan/kmodule/mymodule.ko my_func
>> [mymodule] with build id 326ab42550ef3d24944f53c817533728367effeb no=
t found, continuing without symbols
>> Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
>>    Error: Failed to add events
>> # ./perf buildid-cache -a ./mymodule.ko
>> # ./perf probe -m /home/wangnan/kmodule/mymodule.ko my_func
>> Added new event:
>>    probe:my_func        (on my_func in /home/wangnan/kmodule/mymodul=
e.ko)
>>
>> You can now use it in all perf tools, such as:
>>
>> 	 perf record -e probe:my_func -aR sleep 1
>>
>> In the above example, probe fails if it isn't in buildid-cache. Howe=
ver,
>> user would expect it success in both case because perf is able to fi=
nd
>> probe points actually.
>>
>> The problem is because perf won't utilize module's full path if it
>> failed to open debuginfo. In
>> convert_to_probe_trace_events ->
>> find_probe_trace_events_from_map ->
>> get_target_map ->
>> kernel_get_module_map ->
>> machine__findnew_module_map ->
>> map_groups__find_by_name
>>
>> map_groups__find_by_name() is able to find the map of that module, b=
ut
>> this information is found from /proc/modules before it knows the rea=
l
>> path of the offline module. Therefore, the map->dso->long_name is
>> set to something like '[mymodule]', which prevents dso__load() find
>> the real path of the module file.
> Hmm, if so, it should be fixed in map or machine, not in probe-event.=
c.

Will do in next version.

Thank you.
