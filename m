From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf buildid-cache -p <path> question
Date: Sun, 22 Oct 2017 00:17:03 +0900
Message-ID: <20171022001703.c56a77784dbc49b258d36bf7@kernel.org>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932099AbdJUPRG (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Oct 2017 11:17:06 -0400
In-Reply-To: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On Mon, 16 Oct 2017 14:24:11 +0200
Thomas-Mich Richter <tmricht@linux.vnet.ibm.com> wrote:

> Maybe its me misunderstanding the buildid cache completely, but I ran into the following issue:
> 
> I can add and remove files using the perf buildid-cache command. For example 
> perf buildid-cache -a /usr/bin/tar adds the tar executable to the buildid-cache directory
> .debug/usr/bin/tar 
> and creates the <buildid> subdirectory
> .debug/usr/bin/tar/e54c9946802bbbcb85760ffeb80700a5fd35ebe7/elf file.
> Also a symbolic link from the directory
> .debug/.buildid/e5/4c9946802bbbcb85760ffeb80700a5fd35ebe7 --> ../../usr/bin/tar/<buildid>/
> is created.
> 
> Command perf buildid-cache -a /usr/bin/tar
> removes these entries.
> 
> Now when I run ./perf buildid-cache -p /usr/bin
> nothing happens and success is reported:
> [root@s35lp76 perf]# ./perf buildid-cache -vp /usr/bin/
> Removing bash /usr/bin/: Ok
> Removing dbus-daemon /usr/bin/: Ok
> Removing ls /usr/bin/: Ok
> Removing readlink /usr/bin/: Ok
> Removing sleep /usr/bin/: Ok
> Removing tar /usr/bin/: Ok
> Removing time /usr/bin/: Ok
> Removing vim /usr/bin/: Ok
> Purging /usr/bin/: Ok

How did you do that? 

At first, perf buildid-cache -p only accept target binary path, not a directory. Because -p (--purge) is for removing all "histrical" caches of target binary, that should be compatible to -r (--remove) option.

Anyway, if I tries below, I got just an error.

[mhiramat@devbox perf]$ rm -rf ~/.debug/
[mhiramat@devbox perf]$ ./perf buildid-cache -a /usr/bin/tar
[mhiramat@devbox perf]$ ./perf buildid-cache -vp /usr/bin
Removing tar /usr/bin: FAIL
Purging /usr/bin: FAIL
/usr/bin wasn't in the cache

Because "/usr/bin" is a directory and not cached. Also, if I add /usr/bin as below, it's just refused.

[mhiramat@devbox perf]$ ./perf buildid-cache -a /usr/bin
Couldn't add /usr/bin: Is a directory

So, I wonder how did you do that.

Thank you,

> 
> I have done some more debugging and there is something wrong. 
> The function
> build_id_cache__purge_path() is called and 
> build_id_cache__list_build_ids() creates a list of file names located in /usr/bin of the buildid-cache.
> build_id_cache__remove_s() is called for each name in the list and tries to locate each file name
> 	in directory .buildid/YY/ZZZ..ZZZ which fails because 
> build_id_cache__linkname() expects a buildid and gets a file name.
> The file name bash is treated as .buildid/ba/sh which does not exist.
> 
> 
> This seems to be a simple mistake so I wonder if I do something wrong.
> 
> Thanks
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Masami Hiramatsu <mhiramat@kernel.org>
