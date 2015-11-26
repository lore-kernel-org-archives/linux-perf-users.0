From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH] perf probe: Adjust dso->long_name for offline module
Date: Thu, 26 Nov 2015 11:22:11 +0800
Message-ID: <56567AE3.9050205@huawei.com>
References: <1448451059-156220-1-git-send-email-wangnan0@huawei.com> <20151125193532.GC2945@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22586 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbKZDXs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 22:23:48 -0500
In-Reply-To: <20151125193532.GC2945@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Zefan Li <lizefan@huawei.com>, pi3orama@163.com



On 2015/11/26 3:35, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 25, 2015 at 11:30:59AM +0000, Wang Nan escreveu:
>> If libelf unable to open debuginfo for an offline module but the ko has
>> symtab, something unexpected may happen.
>>
>>   # rm -rf ~/.debug/
>>   # mv /usr/lib64/elfutils/libebl_x86_64.so{,.bak}
>>   # ./perf probe -m /home/wangnan/kmodule/mymodule.ko my_func
>>   [mymodule] with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
>>   Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
> Understood, since we are giving the path to that module, we can, if its
> build-id matches the one for the online module, use it, is that the
> case, i.e. do we check, int his scenario, that the build-id matches?

Please see my test result in v2 patch [1]. In symsrc__init() build-id
would be checked.

[1] 
http://lkml.kernel.org/r/1448507949-187812-1-git-send-email-wangnan0@huawei.com

  # ./perf probe -m ./mymodule.ko my_func
  Added new event:
    probe:my_func        (on my_func in /home/wangnan/kmodule/mymodule.ko)

  You can now use it in all perf tools, such as:

  	perf record -e probe:my_func -aR sleep 1

  # ./perf probe -d '*'
  Removed event: probe:my_func
  # mv ./mymodule.{ko,.bak}
  # mv ./moduleb.ko mymodule.ko
  # ./perf probe -m ./mymodule.ko my_func
  /home/wangnan/kmodule/mymodule.ko with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
  Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
    Error: Failed to add events.

  # ./perf probe -v -m ./mymodule.ko my_func
  probe-definition(0): my_func
  symbol:my_funcfile:(null)  line:0 offset:0 return:0 lazy:(null)
  0 arguments
  Could not open debuginfo. Try to use symbols.
  symsrc__init: build id mismatch for /home/wangnan/kmodule/mymodule.ko.
  /home/wangnan/kmodule/mymodule.ko with build id 326ab42550ef3d24944f53c817533728367effeb not found, continuing without symbols
  Failed to find symbol my_func in /home/wangnan/kmodule/mymodule.ko
    Error: Failed to add events. Reason: No such file or directory (Code: -2)
