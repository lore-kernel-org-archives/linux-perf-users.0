From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf test shell: Fix pathname arg in
 probe_vfs_getname.sh
Date: Tue, 12 Dec 2017 14:11:06 -0300
Message-ID: <20171212171106.GP3958@kernel.org>
References: <b6d31ae26f8615d6bd020f4392980950d4c70c96.1513095505.git.mpetlan@redhat.com>
 <1645592263.12835937.1513095752603.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbdLLRLL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Dec 2017 12:11:11 -0500
Content-Disposition: inline
In-Reply-To: <1645592263.12835937.1513095752603.JavaMail.zimbra@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com

Em Tue, Dec 12, 2017 at 11:22:32AM -0500, Michael Petlan escreveu:
> Having 'filename' variable there seems to be more stable, since
> 'result->name' has recently changed to 'result->uptr'.

Here it fails:

[root@jouet perf]# perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

[root@jouet perf]# perf trace -e open,openat touch /tmp/temporary_file.zbMD1
     0.042 ( 0.017 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
     0.096 ( 0.018 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
     0.679 ( 0.040 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
     0.817 ( 0.252 ms): touch/7761 open(filename: , flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
[root@jouet perf]#

And result->name is still there:

[root@jouet perf]# pahole -C filename ../build/v4.15.0-rc2+/fs/namei.o
struct filename {
	const char  *              name;                 /*     0     8 */
	const char  *              uptr;                 /*     8     8 */
	struct audit_names *       aname;                /*    16     8 */
	int                        refcnt;               /*    24     4 */
	const char const           iname;                /*    28     0 */

	/* size: 32, cachelines: 1, members: 5 */
	/* padding: 4 */
	/* last cacheline: 32 bytes */
};
[root@jouet perf]#

At getname_flags:72 result->name has it as expected, at least up to
v4.15.0-rc2+, where are you experiencing problems?

- Arnaldo
 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 30a950c..3759582 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,7 +13,7 @@ add_probe_vfs_getname() {
>  	local verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
> -		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>  	fi
>  }
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
