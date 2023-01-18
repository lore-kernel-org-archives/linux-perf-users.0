Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E480C32793
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Jan 2023 14:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjAROKf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Jan 2023 09:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjAROJ0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Jan 2023 09:09:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13832E44
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jan 2023 05:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B05B81D24
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jan 2023 13:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE7DC433EF;
        Wed, 18 Jan 2023 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674049839;
        bh=V8VFhaNJ/NT5u9Ys9MC86vH6O+WhcQnpGpBjEMUhMFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfexOwdp0Q9S42G3QdwytIV/q2G5qr2PSyhC9wljbdRaBdmZJpcjMiMAkjCnNHWWj
         MG6UynEN0pP78Ib1TRU3JesUASsALER7azPzGpipdFRi/hVYm7jNEqHeFO+xKCzAqi
         b/9AQAq7I972E09l9Q0mDOQXS5Ud8BepU2nO8Wjo+vF93FEXC+9+X2NqVVa1km/sd5
         1imXqbZgCgx0O2fzwFZN29mP/N8V/NmESwGE6CUiFYTWw6RXy5yRBiAvswAqMmvHxq
         wAQih70E1hRQoXUXl4Py61Jp3PK8DWaQWCK9j+GhT8a6W7ZIQgaEx3MGhweeSEvd8N
         dzI1CxAHmavfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C9C0A405BE; Wed, 18 Jan 2023 10:50:36 -0300 (-03)
Date:   Wed, 18 Jan 2023 10:50:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>
Cc:     jolsa@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.ibm.com
Subject: Re: [PATCH 1/2] tools/perf: Fix the file mode with copyfile while
 adding file to build-id cache
Message-ID: <Y8f5LNu2tmO/ceej@kernel.org>
References: <20230116050131.17221-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116050131.17221-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jan 16, 2023 at 10:31:30AM +0530, Athira Rajeev escreveu:
> The test "build id cache operations" fails on powerpc
> As below:
> 
> 	Adding 5a0fd882b53084224ba47b624c55a469 ./tests/shell/../pe-file.exe: Ok
> 	build id: 5a0fd882b53084224ba47b624c55a469
> 	link: /tmp/perf.debug.ZTu/.build-id/5a/0fd882b53084224ba47b624c55a469
> 	file: /tmp/perf.debug.ZTu/.build-id/5a/../../root/linux/tools/perf/tests/pe-file.exe/5a0fd882b53084224ba47b624c55a469/elf
> 	failed: file /tmp/perf.debug.ZTu/.build-id/5a/../../root/linux/tools/perf/tests/pe-file.exe/5a0fd882b53084224ba47b624c55a469/elf does not exist
> 	test child finished with -1
> 	---- end ----
> 	build id cache operations: FAILED!
> 
> The failing test is when trying to add pe-file.exe to
> build id cache.
> 
> Perf buildid-cache can be used to add/remove/manage
> files from the build-id cache. "-a" option is used to
> add a file to the build-id cache.
> 
> Simple command to do so for a PE exe file:
>  # ls -ltr tests/pe-file.exe
>  -rw-r--r--. 1 root root 75595 Jan 10 23:35 tests/pe-file.exe
>  The file is in home directory.
> 
>  # mkdir  /tmp/perf.debug.TeY1
>  # perf --buildid-dir /tmp/perf.debug.TeY1 buildid-cache -v
>    -a tests/pe-file.exe
> 
> The above will create ".build-id" folder in build id
> directory, which is /tmp/perf.debug.TeY1. Also adds file
> to this folder under build id. Example:
> 
>  # ls -ltr /tmp/perf.debug.TeY1/.build-id/5a/0fd882b53084224ba47b624c55a469/
>  total 76
>  -rw-r--r--. 1 root root     0 Jan 11 00:38 probes
>  -rwxr-xr-x. 1 root root 75595 Jan 11 00:38 elf
> 
> We can see in the results that file mode for original
> file and file in build id directory is different. ie,
> build id file has executable permission whereas original
> file doesn’t have.
> 
> The code path and function ( build_id_cache__add ) to
> add file to cache is in "util/build-id.c". In
> build_id_cache__add() function, it first attempts to link
> the original file to destination cache folder. If linking
> the file fails ( which can happen if the destination and
> source is on a different mount points ), it will copy the
> file to destination. Here copyfile() routine explicitly uses
> mode as "755" and hence file in the destination will have
> executable permission.
> 
> Code snippet:
> 
>  if (link(realname, filename) && errno != EEXIST &&
>                                copyfile(name, filename))
> 
> Strace logs:
> 
> 	172285 link("/home/<user_name>/linux/tools/perf/tests/pe-file.exe", "/tmp/perf.debug.TeY1/home/<user_name>/linux/tools/perf/tests/pe-file.exe/5a0fd882b53084224ba47b624c55a469/elf") = -1 EXDEV (Invalid cross-device link)
> 	172285 newfstatat(AT_FDCWD, "tests/pe-file.exe", {st_mode=S_IFREG|0644, st_size=75595, ...}, 0) = 0
> 	172285 openat(AT_FDCWD, "/tmp/perf.debug.TeY1/home/<user_name>/linux/tools/perf/tests/pe-file.exe/5a0fd882b53084224ba47b624c55a469/.elf.KbAnsl", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
> 	172285 fchmod(3, 0755)                  = 0
> 	172285 openat(AT_FDCWD, "tests/pe-file.exe", O_RDONLY) = 4
> 	172285 mmap(NULL, 75595, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7fffa5cd0000
> 	172285 pwrite64(3, "MZ\220\0\3\0\0\0\4\0\0\0\377\377\0\0\270\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 75595, 0) = 75595
> 
> Whereas if the link succeeds, it succeeds in the first
> attempt itself and the file in the build-id dir will
> have same permission as original file.
> 
> Example, above uses /tmp. Instead if we use
> "--buildid-dir /home/build", linking will work here
> since mount points are same. Hence the destination file
> will not have executable permission.
> 
> Since the testcase "tests/shell/buildid.sh" always looks
> for executable file, test fails in powerpc environment
> when test is run from /root.
> 
> The patch adds a change in build_id_cache__add to use
> copyfile_mode which also passes the file’s original mode as
> argument. This way the destination file mode also will
> be same as original file.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, applied both patches, IIRC there were an Acked-by from Ian for
this one? Or was that reference a cut'n'paste error with that other
series for the #/bin/bash changes?

- Arnaldo

> ---
>  tools/perf/util/build-id.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index a839b30c981b..ea9c083ab1e3 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -715,9 +715,13 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>  		} else if (nsi && nsinfo__need_setns(nsi)) {
>  			if (copyfile_ns(name, filename, nsi))
>  				goto out_free;
> -		} else if (link(realname, filename) && errno != EEXIST &&
> -				copyfile(name, filename))
> -			goto out_free;
> +		} else if (link(realname, filename) && errno != EEXIST) {
> +			struct stat f_stat;
> +
> +			if (!(stat(name, &f_stat) < 0) &&
> +					copyfile_mode(name, filename, f_stat.st_mode))
> +				goto out_free;
> +		}
>  	}
>  
>  	/* Some binaries are stripped, but have .debug files with their symbol
> -- 
> 2.31.1

-- 

- Arnaldo
