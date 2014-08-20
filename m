From: David Ahern <dsahern@gmail.com>
Subject: Re: perf cross compilation on yocto-linux for ARM fails
Date: Tue, 19 Aug 2014 20:35:45 -0600
Message-ID: <53F40981.6050707@gmail.com>
References: <loom.20140812T234636-955@post.gmane.org>	<53F3FFDC.8090007@gmail.com> <CACbZ9VKTbvfiWmmvhSx3Po4rOaGALNJwk9_Zi_seteCf3ac-Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39435 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaHTCgA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Aug 2014 22:36:00 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so10620809pdj.35
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2014 19:35:56 -0700 (PDT)
In-Reply-To: <CACbZ9VKTbvfiWmmvhSx3Po4rOaGALNJwk9_Zi_seteCf3ac-Cw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Suresh Nagarajan <sureshnagaraja@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 8/19/14, 8:17 PM, Suresh Nagarajan wrote:
> can you pls expand on "you should create a recipe to build perf within
> the yocto framework"
>
> there is perf.bb <http://perf.bb> in recipes-kernel/perf.

ok. We use my version of perf internally so I had to write my own. Was 
not aware that there was a perf.bb file.


   The issue I'm
> running into is
> that perf builds (is put under /works/perf/images/usr/bin)
>
> However, when run it complains that
> root@socfpga_cyclone5:~# ./perf
> .*/perf: error while loading shared libraries:
> /lib/libbfd-2.23.1.20121113.so <http://libbfd-2.23.1.20121113.so>:
> Unable to run arch-specific checks*
> *
> *
> *what does it mean? * Kernel boots fine with uImage...

hmmm... did not hit that problem building ppc images on x86.

Does that lib exist in the image? If not is it in the build env sysroot 
(should be)?

David
