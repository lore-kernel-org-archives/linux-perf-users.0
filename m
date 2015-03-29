From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Subject: kprobe registration fails.
Date: Sun, 29 Mar 2015 14:49:18 +0530
Message-ID: <CAGZFCEFRuDLsNdKxKD7uDm0RcugtYiCLXP=mKiYwPeKErEE4yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38061 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbC2JTT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 29 Mar 2015 05:19:19 -0400
Received: by igbqf9 with SMTP id qf9so50026783igb.1
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Mar 2015 02:19:18 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi list,

I am afraid whether i am posting to the right list. I could not find a
krpobe mailing list; so posting.

I took kprobe example from kernel documentation. There is an error
during insertion of module.

root@fox:/# uname -a
Linux fox 3.16.0-031600-generic #201408031935 SMP Sun Aug 3 23:36:11
UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
root@fox:/#
root@fox:/# insmod  ~fox/workspace/module/kprobe.ko
insmod: ERROR: could not insert module
/home/fox/workspace/module/kprobe.ko: Invalid parameters


Please find the code snippet below.

        kp.pre_handler = handler_pre;
        kp.post_handler = handler_post;
        kp.fault_handler = handler_fault;
        kp.addr = (kprobe_opcode_t*)
kallsyms_lookup_name("my_empty_call_back_enter");

        ret = register_kprobe(&kp);
        if (ret < 0) {
                printk(KERN_INFO "register_kprobe failed, returned %d \n", ret);
                return ret;
        }

-Ratheesh
