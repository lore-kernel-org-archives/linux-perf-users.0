From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: Php-fpm will crash when perf runs with call graph option
Date: Mon, 25 Dec 2017 15:06:20 +0800
Message-ID: <123f2413-ab2c-e312-19f0-702d15082fb5@huawei.com>
References: <1514185123-18136-1-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:2783 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750744AbdLYHHr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Dec 2017 02:07:47 -0500
In-Reply-To: <1514185123-18136-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: ufo19890607 <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

Have you tried updating your kernel to a recent version?


On 2017/12/25 14:58, ufo19890607 wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
>
> I use perf to analyze the performance overhead for the server.
> There are several dockers in the server. The php-fpm in the docker
> will crash as long as the perf collects samples for all the cpus with call graph option(perf record -ag). Below is the stack trace
> in the coredump.
>
> #0  0x00007f044ff447bd in re_compile_fastmap_iter (bufp=0x7f044ff447bd <re_compile_fastmap_iter+1165>,
> 		    fastmap=0x46 <Address 0x46 out of bounds>, init_state=<optimized out>, init_state=<optimized out>) at regcomp.c:407
> 407			      if (__wcrtomb (buf, towlower (cset->mbchars[i]), &state)
> 		(gdb) bt
> #0  0x00007f044ff447bd in re_compile_fastmap_iter (bufp=0x7f044ff447bd <re_compile_fastmap_iter+1165>,
> 	    fastmap=0x46 <Address 0x46 out of bounds>, init_state=<optimized out>, init_state=<optimized out>) at regcomp.c:407
> #1  0x0000000000831160 in virtual_file_ex (state=0x7fff9c1a4f70, path=<optimized out>, verify_path=0x0, use_realpath=1)
> 		    at /home/xiaoju/phpng/php-7.0.6/Zend/zend_virtual_cwd.c:1335
> #2  0x00000000007aacee in expand_filepath_with_mode (
> 	    filepath=0x7f044d6020d8 "/home/xiaoju/ep/as/store//toggles/beatles_api_discovery_is_open_by_app",
> 	        real_path=0x7fff9c1a4fc0 "\360X\032\234\377\177", relative_to=<optimized out>, relative_to_len=0, realpath_mode=1)
> 		        at /home/xiaoju/phpng/php-7.0.6/main/fopen_wrappers.c:812
> #3  0x00000000007c1536 in _php_stream_fopen (
> 	    filename=0x7f044d6020d8 "/home/xiaoju/ep/as/store//toggles/beatles_api_discovery_is_open_by_app", mode=0xdbb1f1 "rb",
> 	        opened_path=0x0, options=0) at /home/xiaoju/phpng/php-7.0.6/main/streams/plain_wrapper.c:970
> #4  0x00000000007bd084 in _php_stream_open_wrapper_ex (
> 	    path=0x7f044d6020d8 "/home/xiaoju/ep/as/store//toggles/beatles_api_discovery_is_open_by_app", mode=0xdbb1f1 "rb", options=8,
> 	        opened_path=0x0, context=0x7f044d65f4c0) at /home/xiaoju/phpng/php-7.0.6/main/streams/streams.c:2060
> #5  0x000000000071722b in zif_file_get_contents (execute_data=<optimized out>, return_value=0x7f044d615540)
> 			    at /home/xiaoju/phpng/php-7.0.6/ext/standard/file.c:544
> #6  0x000000000065387c in phar_file_get_contents (execute_data=0x7f044d615570, return_value=0x7f044d615540)
> 			        at /home/xiaoju/phpng/php-7.0.6/ext/phar/func_interceptors.c:224))
>
> I add some output info in the php source code, and found that virtual_file_ex functions's rbp value is really strange,etc 0x1, 0x31. I guess when the perf collects samples for all the cpus with -g option, it may destroy the php-fpm's stack. When the perf is running without -g option, the php-fpm is normal. Who have ever encountered similar problems?
>
> BTW, OS in the server: Centos7.3  , Kernel version: 3.10.0-514.16.1.el7.x86_64. php-fpm version: 7.0.6
> Processor info: Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
