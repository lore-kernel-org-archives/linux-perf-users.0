From: Jun Wang <junwang123@gmail.com>
Subject: access function parameters with DWARF-less perf probing
Date: Tue, 22 Apr 2014 10:31:34 -0700
Message-ID: <CANHDG4btxwQxGme+TwWYhPVEKSwyHA_C3fVxNuaFJOrzGYOyCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:45554 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933273AbaDVRbg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Apr 2014 13:31:36 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so4667845lab.32
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2014 10:31:34 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Jun Wang <junwang123@gmail.com>

Hi Everyone,

With systemTap, in the absence of debugging information (DWARF), one
can access function parameters using (positional) numbers. Can the
same be done with `perf`?
Why? I'm trying to capture variables in a kernel function but I don't
have an good perf with DWARF support and there is are significant
challenges to build one due to the relatively old distro.

Thanks,
Jun

Details on the SystemTap way of doing that can be referred to at
https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/5/html/SystemTap_Language_Reference/ch04s03.html
4.3. DWARF-less probing

In the absence of debugging information, you can still use the /kprobe/
family of probes to examine the entry and exit points of kernel and
module functions. You cannot look up the arguments or local variables of
a function using these probes. However, you can access the parameters by
following this procedure:
When you're stopped at the entry to a function, you can refer to the
function's arguments by number. For example, when probing the function
declared:

asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t
count)

You can obtain the values of |fd|, |buf|, and |count|, respectively, as
|uint_arg(1)|, |pointer_arg(2)|, and |ulong_arg(3)|. In this case, your
probe code must first call |asmlinkage()|, because on some architectures
the asmlinkage attribute affects how the function's arguments are passed.
When you're in a return probe, $|return| isn't supported without DWARF,
but you can call |returnval()| to get the value of the register in which
the function value is typically returned, or call |returnstr()| to get a
string version of that value.
